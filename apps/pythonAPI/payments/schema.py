import graphene

from payments.repo import CreditCardRepoSQLImpl
from payments.orm import Session
from payments.creditcard import PaymentsSystem, Payment
from payments.entities import CreditCardObject


class CreateCreditCard(graphene.Mutation):
    # specify inputs
    class Arguments:
        initial_budget = graphene.Int()
        card_id = graphene.String()

    # specify outputs
    creditcard = graphene.Field(CreditCardObject)

    def mutate(root, info, initial_budget, card_id):
        repo = CreditCardRepoSQLImpl(session=Session)
        creditcard = CreditCardObject(budget=initial_budget, card_id=card_id)
        creditcard = repo.add(
            card=creditcard
        ) 
        return CreateCreditCard(creditcard=creditcard)

class MakePayment(graphene.Mutation):
    # specify inputs
    class Arguments:
        amount = graphene.Int()
        receiver_id = graphene.String()
        sender_id = graphene.String()

    # specify outputs
    sender_card = graphene.Field(CreditCardObject)
    receiver_card = graphene.Field(CreditCardObject)


    def mutate(root, info, receiver_id, sender_id, amount):
        repo = CreditCardRepoSQLImpl(session=Session)
        payment_usecase = PaymentsSystem(repo=repo)
        payment = Payment(receiver_id, sender_id, amount)
        payment_usecase.make_payment(payment)
        sender_card = repo.get(id=sender_id)
        receiver_card = repo.get(id=receiver_id)
        return MakePayment(sender_card=sender_card, receiver_card=receiver_card)

        