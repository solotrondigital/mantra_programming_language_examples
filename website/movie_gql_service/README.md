# movie_gql_service

Mantra GraphQL API backend application: movie_gql_service

A modular GraphQL API backend application built with the **Mantra Programming Language**.

## Architecture (GraphQL)
```text
movie_gql_service/
├── mantra.toml
├── README.md
├── .gitignore
├── src/
│   ├── main.mantra       # GraphQL server entry point
│   ├── config/           # Server configuration
│   ├── graphql/
│   │   ├── schema/       # GraphQL schema definitions
│   │   ├── resolvers/    # Query and Mutation field resolvers
│   │   ├── types/        # GraphQL object type definitions
│   │   ├── queries/      # Query execution operations
│   │   ├── mutations/    # Mutation execution operations
│   │   └── scalars/      # Custom scalar types (DateTime)
│   ├── services/         # Reusable business logic
│   ├── models/           # Domain entities
│   ├── repositories/     # Data access layer
│   ├── middleware/       # Auth and logging context middleware
│   └── utils/            # GraphQL response formatters
├── tests/
│   ├── unit/             # Resolver unit tests
│   └── integration/      # GraphQL execution integration tests
└── docs/
    └── schema.graphql    # GraphQL SDL schema
```

## Schema Operations
- **Query**: `health: String!`, `users: [User!]!`, `user(id: ID!): User`
- **Mutation**: `createUser(name: String!, email: String!): User!`

## Getting Started

### Running the Server
```bash
mantra run
```

### Running Tests
```bash
mantra test
```
