#!/bin/bash

PORT=8000
HOST="0.0.0.0"
NGROK_WIN_PATH="C:\\ngrok\\ngrok.exe"  # مسار ngrok ويندوز
NGROK_WSL_PATH="/mnt/c/ngrok/ngrok.exe" # مسار ngrok في WSL

echo "🧠 Checking Redis..."
if ! pgrep redis-server > /dev/null; then
    echo "🚀 Starting Redis..."
    redis-server --daemonize yes
else
    echo "✅ Redis already running"
fi

echo "🧹 Clearing Laravel cache..."
php artisan config:clear
php artisan cache:clear
php artisan view:clear

echo "🌐 Starting Laravel server at $HOST:$PORT..."
php artisan serve --host=$HOST --port=$PORT > storage/logs/serve.log 2>&1 &
LARAVEL_PID=$!

echo "🚀 Starting Laravel Horizon..."
php artisan horizon > storage/logs/horizon.log 2>&1 &
HORIZON_PID=$!

echo "🔗 Starting ngrok from Windows..."

# جرب نستخدم cmd.exe مع start
cmd.exe /c start "" "$NGROK_WIN_PATH" http $PORT

echo "⏳ Waiting for ngrok to initialize..."
sleep 3

NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels \
    | grep -oE 'https://[a-z0-9\-]+\.ngrok-free\.app' \
    | head -n 1)

if [[ -n "$NGROK_URL" ]]; then
    echo "🌍 ngrok Public URL: $NGROK_URL"
else
    echo "❌ لم يتم العثور على رابط ngrok. هل ngrok يعمل؟"
fi

trap cleanup INT

cleanup() {
    echo ""
    echo "🛑 Shutting down services..."
    kill $LARAVEL_PID
    kill $HORIZON_PID
    echo "✅ Done!"
    exit 0
}

echo ""
echo "🧭 Horizon logs: tail -f storage/logs/horizon.log"
echo "🧭 Serve logs  : tail -f storage/logs/serve.log"
echo "🟢 Press Ctrl+C to stop all services."

wait
