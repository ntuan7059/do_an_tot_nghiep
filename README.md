Quick prerequisites (Windows)

Python 3.9+ installed (add to PATH).

Git for Windows (to clone).

Optional: Visual C++ Build Tools if pip install tries to compile wheels (common for Pillow, etc.).
(Repo README lists Python 3.9+ as requirement). 
GitHub

1) Clone the repo

Open PowerShell (press Win + X → Windows PowerShell) and run:

cd C:\Users\%USERNAME%\Projects
git clone https://github.com/ntuan7059/do_an_tot_nghiep.git
cd do_an_tot_nghiep

2) Create & activate a virtual environment

PowerShell:

python -m venv env
# If ExecutionPolicy blocks script running, run as admin once:
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\env\Scripts\Activate.ps1


Or CMD:

python -m venv env
env\Scripts\activate.bat

3) Upgrade pip & install Python deps
python -m pip install --upgrade pip setuptools wheel
pip install -r requirements.txt


Notes / common issues

If a package fails to build (e.g., Pillow), install the Visual C++ Build Tools (search “Build Tools for Visual Studio”) or use prebuilt wheels.

If pip is slow, try python -m pip install -r requirements.txt --use-deprecated=legacy-resolver (rare).

(Requirements are in the repo’s requirements.txt). 
GitHub

4) Decide whether to use the included demo DB or create a new DB

The repository includes a db.sqlite3 file (demo). If you want to see the demo data immediately, keep that file and skip migrations (or run migrations carefully). The README shows a hosted demo and demo credentials, so the repo contains demo content you can inspect. 
GitHub

If you prefer a fresh DB (recommended for production or to avoid conflicts), run migrations (next step) and create a superuser.

5) Copy the env file and set simple dev values
copy .env.example .env


Open .env in VS Code / Notepad and set:

DEBUG=True

ALLOWED_HOSTS=127.0.0.1,localhost (or add your machine name)

If there’s a SECRET_KEY field, paste a random string (you can quickly generate one in Python: python - <<'PY'\nimport secrets; print(secrets.token_urlsafe())\nPY).

Many Django projects will fall back to SQLite if no DB env is configured. If you want MySQL, update DB fields accordingly as shown in .env.example. 
GitHub


7) (Optional) Collect static (dev usually serves static automatically)

If you prefer to serve static from one place:

python manage.py collectstatic --noinput


In development Django serves static automatically when DEBUG=True, so collectstatic is usually optional for local dev.

8) Run the dev server
python manage.py runserver
# or bind to all interfaces if you need: python manage.py runserver 0.0.0.0:8000