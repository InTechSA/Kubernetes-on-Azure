# Backend application

## run

```bash
docker build -t poc-kubernetes/backend .
docker run -it --rm -p 3000:3000 poc-kubernetes/backend
```

And then head to http://localhost:3000/.
It will return the generated log lines that was output in the console.