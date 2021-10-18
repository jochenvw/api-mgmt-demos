import graphene
from payments.entities import CreditCardObject
from payments.repo import CreditCardRepoSQLImpl
from payments.orm import Session

class Query(graphene.ObjectType):
    all_creditcards = graphene.List(CreditCardObject)
    creditcard = graphene.Field(CreditCardObject, card_id=graphene.String())

    def resolve_all_creditcards(parent, info):
        return CreditCardRepoSQLImpl(session=Session).get_all()

    def resolve_creditcard(parent, info, card_id):
        return CreditCardRepoSQLImpl(session=Session).get(card_id)