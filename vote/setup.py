from setuptools import setup, find_packages

with open("requirements.txt") as f:
        requirements = f.read().splitlines()

        setup(
                name="vote-python-frontend",
                version="1.0.0",
                author="ninocan",
                author_email="ninocangialosi@yahoo.it",
                description="This is a python Flask frontend for the app I'm realizing for the DevOps and SRE from the Linux Foundation",
                packages=find_packages(),
                install_requires=requirements,
        )

