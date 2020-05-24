# Cert-Manager & Let's Encrypt

What follows, is my attempt to get get Cert-Manager and Let's Encrypt working on a single node Kubernetes cluster.

And by working, I mean ACME certificates being issued and the site https://example.morsley.io being considered secure by the browser.

## Cert-Manager



## Let's Encrypt



## Debugging...

When certificates aren't issued correctly there are plenty of things we can check:

- Ingress
- Issuer
- Certificate
- Certificate Request
- Order
- Challenge

First, run the ``kubectl_kubeconfig_command`` supplied in the output:

```
kubectl get nodes --kubeconfig=k8s/kube-config.yaml
```

Note: Please refer to the following: https://cert-manager.io/docs/faq/acme/

### Ingress

Here's the Ingress:

```
kubectl get ingress --namespace example
```

Should yield:

```
NAME      HOSTS                ADDRESS          PORTS     AGE
ingress   example.morsley.io   18.130.237.255   80, 443   15m
```

Check the status of the Ingress:

```
kubectl describe ingress --namespace example
```

Should yield:

```
Name:             ingress
Namespace:        example
Address:          18.130.237.255
Default backend:  default-http-backend:80 (<error: endpoints "default-http-backend" not found>)
TLS:
  tls-ingress terminates example.morsley.io
Rules:
  Host                Path  Backends
  ----                ----  --------
  example.morsley.io  
                         nginx-service:80 (10.42.0.6:80,10.42.0.7:80,10.42.0.8:80)
Annotations:          cert-manager.io/issuer: lets-encrypt-real
Events:
  Type    Reason             Age   From                      Message
  ----    ------             ----  ----                      -------
  Normal  CREATE             17m   nginx-ingress-controller  Ingress example/ingress
  Normal  CreateCertificate  16m   cert-manager              Successfully created Certificate "tls-ingress"
  Normal  UpdateCertificate  16m   cert-manager              Successfully updated Certificate "tls-ingress"
  Normal  UPDATE             16m   nginx-ingress-controller  Ingress example/ingress
```

### Issuer

Here's the Issuer:

```
kubectl get issuer --namespace example
```

Should yield:

```
NAME                READY   AGE
lets-encrypt-real   True    21m
lets-encrypt-test   True    21m
```

Check the status of the Issuer:

```
kubectl describe issuer --namespace example
```

Should yield:

```
Name:         lets-encrypt-real
Namespace:    example
Labels:       <none>
Annotations:  API Version:  cert-manager.io/v1alpha3
Kind:         Issuer
Metadata:
  Creation Timestamp:  2020-05-24T16:10:49Z
  Generation:          1
  Resource Version:    1107
  Self Link:           /apis/cert-manager.io/v1alpha3/namespaces/example/issuers/lets-encrypt-real
  UID:                 38e9bd34-c4f9-401c-a641-31f94dafaab4
Spec:
  Acme:
    Email:  admin@morsley.uk
    Private Key Secret Ref:
      Name:  lets-encrypt-real
    Server:  https://acme-v02.api.letsencrypt.org/directory
    Solvers:
      http01:
        Ingress:
          Class:  nginx
Status:
  Acme:
    Last Registered Email:  admin@morsley.uk
    Uri:                    https://acme-v02.api.letsencrypt.org/acme/acct/87000244
  Conditions:
    Last Transition Time:  2020-05-24T16:10:50Z
    Message:               The ACME account was registered with the ACME server
    Reason:                ACMEAccountRegistered
    Status:                True
    Type:                  Ready
Events:                    <none>


Name:         lets-encrypt-test
Namespace:    example
Labels:       <none>
Annotations:  API Version:  cert-manager.io/v1alpha3
Kind:         Issuer
Metadata:
  Creation Timestamp:  2020-05-24T16:10:49Z
  Generation:          1
  Resource Version:    1111
  Self Link:           /apis/cert-manager.io/v1alpha3/namespaces/example/issuers/lets-encrypt-test
  UID:                 ca00899e-b19c-4da8-85f9-723eb45f410d
Spec:
  Acme:
    Email:  admin@morsley.uk
    Private Key Secret Ref:
      Name:  lets-encrypt-test
    Server:  https://acme-staging-v02.api.letsencrypt.org/directory
    Solvers:
      http01:
        Ingress:
          Class:  nginx
Status:
  Acme:
    Last Registered Email:  admin@morsley.uk
    Uri:                    https://acme-staging-v02.api.letsencrypt.org/acme/acct/13839800
  Conditions:
    Last Transition Time:  2020-05-24T16:10:50Z
    Message:               The ACME account was registered with the ACME server
    Reason:                ACMEAccountRegistered
    Status:                True
    Type:                  Ready
Events:                    <none>
```

### Certificate & Certificate Request

Here's the Certificate:

```
kubectl get certificate --namespace example
```

Should yield:

```
NAME          READY   SECRET        AGE
tls-ingress   True    tls-ingress   18m
```

Check the status of the Certificate:

```
kubectl describe certificate --namespace example
```

Should yield:

```
Name:         tls-ingress
Namespace:    example
Labels:       <none>
Annotations:  API Version:  cert-manager.io/v1alpha3
Kind:         Certificate
Metadata:
  Creation Timestamp:  2020-05-24T16:10:43Z
  Generation:          3
  Owner References:
    API Version:           extensions/v1beta1
    Block Owner Deletion:  true
    Controller:            true
    Kind:                  Ingress
    Name:                  ingress
    UID:                   d72755bb-9098-42fb-aff1-a5b091dc4830
  Resource Version:        1256
  Self Link:               /apis/cert-manager.io/v1alpha3/namespaces/example/certificates/tls-ingress
  UID:                     d1ca5e99-cf9c-4d9f-a36e-9afe111e1140
Spec:
  Dns Names:
    example.morsley.io
  Issuer Ref:
    Group:      cert-manager.io
    Kind:       Issuer
    Name:       lets-encrypt-real
  Secret Name:  tls-ingress
Status:
  Conditions:
    Last Transition Time:  2020-05-24T16:11:18Z
    Message:               Certificate is up to date and has not expired
    Reason:                Ready
    Status:                True
    Type:                  Ready
  Not After:               2020-08-22T15:11:18Z
Events:
  Type    Reason        Age                From          Message
  ----    ------        ----               ----          -------
  Normal  GeneratedKey  19m                cert-manager  Generated a new private key
  Normal  Requested     19m (x2 over 19m)  cert-manager  Created new CertificateRequest resource "tls-ingress-1293266717"
  Normal  Requested     19m                cert-manager  Created new CertificateRequest resource "tls-ingress-524786323"
  Normal  Issued        19m                cert-manager  Certificate issued successfully

```

Here's the Certificate Request:

```
kubectl get certificaterequest --namespace example
```

Should yield:

```
NAME                     READY   AGE
tls-ingress-1293266717   True    33m
```

Check the status of the Certificate Request:

```
kubectl describe certificaterequest --namespace example
```

Should yield:

```
Name:         tls-ingress-1293266717
Namespace:    example
Labels:       <none>
Annotations:  cert-manager.io/certificate-name: tls-ingress
              cert-manager.io/private-key-secret-name: tls-ingress
API Version:  cert-manager.io/v1alpha3
Kind:         CertificateRequest
Metadata:
  Creation Timestamp:  2020-05-24T16:10:49Z
  Generation:          1
  Owner References:
    API Version:           cert-manager.io/v1alpha2
    Block Owner Deletion:  true
    Controller:            true
    Kind:                  Certificate
    Name:                  tls-ingress
    UID:                   d1ca5e99-cf9c-4d9f-a36e-9afe111e1140
  Resource Version:        1253
  Self Link:               /apis/cert-manager.io/v1alpha3/namespaces/example/certificaterequests/tls-ingress-1293266717
  UID:                     e812cdc9-7f22-410f-8b9b-12580c33baf5
Spec:
  Csr:  [REDACTED]
  Issuer Ref:
    Group:  cert-manager.io
    Kind:   Issuer
    Name:   lets-encrypt-real
Status:
  Certificate:  [REDACTED]
  Conditions:
    Last Transition Time:  2020-05-24T16:11:18Z
    Message:               Certificate fetched from issuer successfully
    Reason:                Issued
    Status:                True
    Type:                  Ready
Events:
  Type    Reason             Age   From          Message
  ----    ------             ----  ----          -------
  Normal  IssuerNotReady     34m   cert-manager  Referenced issuer does not have a Ready status condition
  Normal  CertificateIssued  34m   cert-manager  Certificate fetched from issuer successfully
``` 

### Order

Here's the Order:

```
kubectl get order --namespace example
```

Should yield:

```
NAME                                STATE   AGE
tls-ingress-1293266717-3195849162   valid   27m
```

Check the status of the Order:

```
kubectl describe order --namespace example
```

Should yield:

```
Name:         tls-ingress-1293266717-3195849162
Namespace:    example
Labels:       <none>
Annotations:  cert-manager.io/certificate-name: tls-ingress
              cert-manager.io/private-key-secret-name: tls-ingress
API Version:  acme.cert-manager.io/v1alpha3
Kind:         Order
Metadata:
  Creation Timestamp:  2020-05-24T16:10:50Z
  Generation:          1
  Owner References:
    API Version:           cert-manager.io/v1alpha2
    Block Owner Deletion:  true
    Controller:            true
    Kind:                  CertificateRequest
    Name:                  tls-ingress-1293266717
    UID:                   e812cdc9-7f22-410f-8b9b-12580c33baf5
  Resource Version:        1250
  Self Link:               /apis/acme.cert-manager.io/v1alpha3/namespaces/example/orders/tls-ingress-1293266717-3195849162
  UID:                     6f81f741-8393-4baa-86b0-47e5a623410c
Spec:
  Csr: [REDACTED]
  Dns Names:
    example.morsley.io
  Issuer Ref:
    Group:  cert-manager.io
    Kind:   Issuer
    Name:   lets-encrypt-real
Status:
  Authorizations:
    Challenges:
      Token:        Qk6mBCf7CTxONOVxKP55jimhL8VYU32vmKeGGz_-6bs
      Type:         http-01
      URL:          https://acme-v02.api.letsencrypt.org/acme/chall-v3/4785888411/ajyZOg
      Token:        Qk6mBCf7CTxONOVxKP55jimhL8VYU32vmKeGGz_-6bs
      Type:         dns-01
      URL:          https://acme-v02.api.letsencrypt.org/acme/chall-v3/4785888411/_vz6QQ
      Token:        Qk6mBCf7CTxONOVxKP55jimhL8VYU32vmKeGGz_-6bs
      Type:         tls-alpn-01
      URL:          https://acme-v02.api.letsencrypt.org/acme/chall-v3/4785888411/2GtThw
    Identifier:     example.morsley.io
    Initial State:  pending
    URL:            https://acme-v02.api.letsencrypt.org/acme/authz-v3/4785888411
    Wildcard:       false
  Certificate:      [REDACTED]
  Finalize URL:     https://acme-v02.api.letsencrypt.org/acme/finalize/87000244/3487697736
  State:            valid
  URL:              https://acme-v02.api.letsencrypt.org/acme/order/87000244/3487697736
Events:
  Type    Reason    Age   From          Message
  ----    ------    ----  ----          -------
  Normal  Created   27m   cert-manager  Created Challenge resource "tls-ingress-1293266717-3195849162-1778914268" for domain "example.morsley.io"
  Normal  Complete  27m   cert-manager  Order completed successfully
```

### Challenge

If the order is not completing successfully, we can debug the challenges for the order, by:  

```
kubectl get challenge --namespace example
```

Check the status of the Challenge:

```
kubectl describe challenge --namespace example
```