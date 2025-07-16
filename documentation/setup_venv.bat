@echo off
REM ============================================================================
REM   Script Windows : setup_venv.bat
REM   Objectif : Vérifier l'existence ou créer un environnement virtuel Python,
REM              puis l'activer et installer les dépendances.
REM ============================================================================

REM Nom du dossier d'environnement virtuel
set ENV_DIR=venv

REM Vérifie si le dossier d'environnement existe déjà
if exist "%ENV_DIR%\Scripts\activate.bat" (
    echo Environnement virtuel deja existant : %ENV_DIR%
) else (
    echo Creation de l environnement virtuel : %ENV_DIR%
    python -m venv %ENV_DIR%
)

REM Active l'environnement virtuel
call "%ENV_DIR%\Scripts\activate.bat"

REM (Optionnel) Installation des dépendances
IF EXIST requirements.txt (
    echo Installation des dependances depuis requirements.txt
    pip install -r requirements.txt
) else (
    echo Pas de requirements.txt detecte, rien à installer.
)