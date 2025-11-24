# node-red-r700-data-transform

A Node-RED based application for transforming and processing data from R700 RFID readers.

## Project Structure

```
node-red-r700-data-transform/
│
├── docker-compose.yml    # Docker Compose configuration
├── Dockerfile           # Node-RED Docker image configuration
├── data/
│   └── flows.json      # Node-RED flow definitions
└── README.md           # This file
```

## Prerequisites

- Docker
- Docker Compose

## Quick Start

1. Clone the repository:
```bash
git clone https://github.com/suporterfid/node-red-r700-data-transform.git
cd node-red-r700-data-transform
```

2. Start the application using Docker Compose:
```bash
docker-compose up -d
```

3. Access Node-RED UI at: http://localhost:1880

## Usage

### Starting the Application

```bash
docker-compose up -d
```

### Stopping the Application

```bash
docker-compose down
```

### Viewing Logs

```bash
docker-compose logs -f node-red
```

### Rebuilding After Changes

```bash
docker-compose up -d --build
```

## API Endpoints

### POST /r700/data

Accepts R700 RFID reader data and transforms it.

**Request Body Example:**
```json
{
  "reader_id": "R700-001",
  "tags": [
    {
      "epc": "E2801190200050247A4A8C5D",
      "rssi": -45,
      "antenna": 1,
      "read_count": 5,
      "first_seen": "2025-11-24T17:45:00Z",
      "last_seen": "2025-11-24T17:45:05Z"
    }
  ]
}
```

**Response Example:**
```json
{
  "timestamp": "2025-11-24T17:45:28.748Z",
  "reader_id": "R700-001",
  "tags": [
    {
      "epc": "E2801190200050247A4A8C5D",
      "rssi": -45,
      "antenna": 1,
      "read_count": 5,
      "first_seen": "2025-11-24T17:45:00Z",
      "last_seen": "2025-11-24T17:45:05Z"
    }
  ]
}
```

## Configuration

### Environment Variables

You can customize the application by modifying environment variables in `docker-compose.yml`:

- `TZ`: Timezone (default: UTC)

### Volumes

The `data` directory is mounted as a volume, allowing you to:
- Modify flows.json and restart the container
- Persist Node-RED configuration
- Add custom nodes or libraries

**Note on Permissions:** The container runs as the `node-red` user (UID 1000). If you encounter permission issues on Linux/macOS, ensure the `data` directory is readable by the container:

```bash
chmod -R 755 data/
```

For more restrictive environments, you may need to adjust ownership:

```bash
chown -R 1000:1000 data/
```

## Customization

### Adding Additional Node-RED Nodes

Edit the `Dockerfile` and uncomment/add the npm install lines:

```dockerfile
RUN npm install node-red-contrib-your-package
```

Then rebuild:
```bash
docker-compose up -d --build
```

### Modifying the Flow

1. Edit `data/flows.json` directly, or
2. Use the Node-RED UI at http://localhost:1880 and deploy changes

## Troubleshooting

### Container won't start

```bash
docker-compose logs node-red
```

### Reset Everything

```bash
docker-compose down -v
docker-compose up -d --build
```

## License

MIT