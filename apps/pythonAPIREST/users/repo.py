from users.models import User

class BasicRepo:

    def __init__(self):
        self._items = []
        self._counter = 0

        
        for firstname, lastname in [("Stef", "Ruinard"), ("Jochen", "Van Wylick")]:
            self.add(firstname, lastname)

    def add(self, firstname, lastname):
        self._counter += 1
        user = User(self._counter, firstname, lastname)
        self._items.append(user)
        return user

    def get(self, user_id):
        return [user for user in self._items if user.user_id == int(user_id)]

    def get_users(self):
        return self._items

Repo = BasicRepo()