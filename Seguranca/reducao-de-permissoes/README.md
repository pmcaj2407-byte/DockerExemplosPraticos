
# Restrição de permissões com Docker (Capabilities)

# OBJETIVO

Demonstrar como remover permissões administrativas desnecessárias de um container e adicionar permissões específicas conforme a necessidade da aplicação.

# ARQUIVOS

Este exemplo não utiliza arquivos próprios. O comando para criar o container e configurar suas permissões é executado diretamente no terminal:

```bash
docker run -d --name exemplo-capabilities --cap-drop=ALL --cap-add=NET_ADMIN ubuntu:24.04 sleep infinity
```

# FUNCIONAMENTO

O Linux utiliza Capabilities para dividir os privilégios administrativos em permissões menores e específicas. O Docker permite controlar quais dessas permissões ficam disponíveis para cada container.

No comando apresentado:

- `--cap-drop=ALL`: remove todas as capabilities que seriam concedidas por padrão ao container.
- `--cap-add=NET_ADMIN`: adiciona a permissão de administração de rede, permitindo realizar determinadas operações de configuração e gerenciamento de rede.

Podemos adicionar outras capabilities conforme a necessidade da aplicação. Entretanto, devemos conceder somente as permissões realmente necessárias, seguindo o princípio do menor privilégio.

# COMO EXECUTAR

Criar e executar o container:

```bash
docker run -d --name exemplo-capabilities --cap-drop=ALL --cap-add=NET_ADMIN ubuntu:24.04 sleep infinity
```

Remover o container após o teste:

```bash
docker rm -f exemplo-capabilities
```

# RESULTADO ESPERADO

O container será iniciado com todas as capabilities padrão removidas, recebendo apenas a permissão `NET_ADMIN`.
-------------------------------------
Dessa forma, demonstramos como restringir e conceder permissões específicas aos containers.