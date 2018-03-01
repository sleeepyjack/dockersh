import docker

prog = 'dockersh'

cli = docker.APIClient()
containers = cli.containers(all=True, filters={'label': "group="+prog})
print(containers)
for c in containers:
    cli.commit(c['Id'])
