from locust import HttpUser, task, between

class WebsiteUser(HttpUser):
    wait_time = between(1, 3)
    @task(1)
    def load_homepage(self):
       self.client.get("/")
    
    @task(2)
    def load_docs(self):
        self.client.get("/docs/")
    
    @task(3)
    def load_membros(self):
        self.client.get("/membros/")

    @task(4)
    def load_planos(self):
        self.client.get("/planos/")