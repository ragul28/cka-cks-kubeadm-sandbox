# CKS Domains

- **Cluster setup**
    * **Network policy:** Implement policies to control traffic between pods and clusters.
      - [Kubernetes Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
    * **Ingress TLS:** Secure your ingress using TLS.
      - [Ingress TLS](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls)
    * **Verify binary:** Ensure the integrity of the Kubernetes binaries.
    * **Kube-Bench[external tool]:** Tool to check the security configuration of Kubernetes clusters.
      - [Kube-Bench](https://github.com/aquasecurity/kube-bench)

- **Cluster Hardening**
    * **RBAC:** Use Role-Based Access Control to restrict access to resources.
      - [RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
      - [CSR](https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/#normal-user)
    * **Api-server security:** Secure the Kubernetes API server.
    * **Kube upgrade:** Regularly upgrade Kubernetes to the latest stable version.

- **System Hardening**
    * **Apparmor[external tool]:** Linux security module for mandatory access control.
      - [AppArmor](https://kubernetes.io/docs/tutorials/security/apparmor/)
      - [AppArmor Wiki](https://gitlab.com/apparmor/apparmor/-/wikis/Documentation)
    * **Seccomp[external tool]:** Secure computing mode for restricting system calls.
      - [Seccomp](https://kubernetes.io/docs/tutorials/security/seccomp/)
    * **Pod security (namespace):** Enforce security policies at the namespace level.
      - [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)

- **Microservice Vulnerabilities**
    * **RuntimeClass:** Define different runtimes for different classes of workloads.
      - [RuntimeClass](https://kubernetes.io/docs/concepts/containers/runtime-class/)
      - [gViosr](https://gvisor.dev/docs/user_guide/install/)
    * **Secrets:** Manage sensitive information securely.
      - [Secrets](https://kubernetes.io/docs/concepts/configuration/secret/)

- **Supply chain security**
    * **Static analysis files:** Analyze code and configurations for security issues.
    * **ImagePolicyWebhook:** Control which container images are allowed to run in your cluster.
      - [ImagePolicyWebhook](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#imagepolicywebhook)
    * **OPA[external tool]** Use Open Policy Agent for policy enforcement.
      - [OPA](https://www.openpolicyagent.org/docs/latest/kubernetes-primer/)
    * **Trivy[external tool]:** A vulnerability scanner for container images.
      - [Trivy](https://github.com/aquasecurity/trivy)

- **Monitoring, Logging & Runtime Security**
    * **Audit:** Enable Kubernetes auditing for tracking changes and access.
      - [Audit](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/)
    * **Security context:** Define security settings at the container level.
      - [Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
    * **Falco [external tool]**: Runtime security tool for detecting anomalous activity.
      - [Falco Examples](https://falco.org/docs/reference/rules/examples/)
      - [Falco Supported Fields](https://falco.org/docs/reference/rules/supported-fields/)