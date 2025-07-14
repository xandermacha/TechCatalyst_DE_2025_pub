# A Student's Guide to Python Virtual Environments

Welcome! This guide will walk you through the essential skill of creating and managing Python virtual environments.

> **Note for GitHub Codespaces Users:** You're in luck! Codespaces provides a standardized Linux terminal, so you don't need to worry about Windows-specific commands. The instructions below have been tailored for your environment.

### Why Use Virtual Environments?

Imagine you're working on two different Python projects. Project A needs version 1.0 of a library, but Project B needs version 2.0 of the *same* library. If you install these system-wide, you'll run into conflicts.

A **virtual environment** is an isolated directory that contains a specific version of Python plus all the libraries required for a particular project. This solves the conflict problem and keeps your projects organized and reproducible.

- **Environment Management:** This is the process of creating, activating, and deleting these isolated environments (e.g., with `conda` or `venv`).
- **Package Management:** This is the process of installing, updating, and removing libraries (packages) within an activated environment (e.g., with `conda`, `pip`, or `uv`).

Let's explore three popular ways to do this.

## Method 1: Conda for Environment & Package Management

**Conda** is a powerful open-source system that manages both environments and packages. It's very popular in the data science community. (Note: This requires your Codespace to be configured with a Conda installation).

### Step 1: Install `nb_conda_kernels` (One-Time Setup)

To make your Conda environments easily accessible in tools like Jupyter Notebook, it's a great idea to install `nb_conda_kernels` into your main "base" Conda installation.

Open the terminal in your Codespace and run:

```
conda install -n base nb_conda_kernels
```

### Step 2: Create a New Conda Environment

Let's create an environment named `my-conda-env` with Python 3.9.

```
conda create --name my-conda-env python=3.9
```

Conda will show you what it plans to install and ask for confirmation. Type `y` and press Enter.

### Step 3: Activate the Environment

To use the environment, you must "activate" it.

```
conda activate my-conda-env
```

Your terminal prompt should now change to show the name of the active environment, like `(my-conda-env)`.

### Step 4: Install Libraries with Conda

With the environment active, let's install some popular data science libraries.

```
conda install numpy pandas matplotlib
```

Again, Conda will solve the dependencies and ask for confirmation. Type `y` and press Enter.

### Step 5: Deactivate and Delete the Environment

When you're finished working, you can deactivate the environment.

```
conda deactivate
```

To delete it completely, run:

```
conda env remove --name my-conda-env
```

## Method 2: `venv` for Environments and `pip` for Packages

**`venv`** is the standard module for creating virtual environments that comes bundled with Python. **`pip`** is Python's standard package installer.

### Step 1: Create a `venv` Environment

Navigate to your project folder. It's common practice to create the environment inside the project directory in a folder named `venv`.

```
python3 -m venv venv
```

This creates a `venv` folder containing the Python interpreter and supporting files.

### Step 2: Activate the Environment

In the Codespaces terminal, run:

```
source venv/bin/activate
```

Your terminal prompt will change to `(venv)` to show it's active.

### Step 3: Install Libraries with `pip`

Now, use `pip` to install packages. Let's install the web framework `Flask` and the `requests` library.

```
pip install flask requests
```

### Step 4: Deactivate and Delete the Environment

To deactivate, simply type:

```
deactivate
```

To delete a `venv` environment, you just delete its folder.

```
rm -rf venv
```

## Method 3: `venv` for Environments and `uv` for Packages

**`uv`** is a modern, extremely fast Python package installer. It's a drop-in replacement for `pip` that can significantly speed up package installation.

### Step 1: Install `uv`

First, you need to install `uv` in your Codespace.

```
pip install uv
```

### Step 2: Create and Activate a `venv` Environment

This process is identical to the `pip` method.

```
# Create the environment
python3 -m venv venv

# Activate it
source venv/bin/activate
```

### Step 3: Install Libraries with `uv`

Once the environment is active, use `uv` instead of `pip`. The syntax is very similar.

```
uv pip install Django beautifulsoup4
```

You'll notice it's much faster, especially for projects with many dependencies!

### Step 4: Deactivate and Delete

This is also identical to the standard `venv` method.

```
# Deactivate
deactivate

# Delete the folder
rm -rf venv
```

## Summary

- **Conda:** Excellent all-in-one tool, great for scientific computing.
- **`venv` + `pip`:** The standard, built-in way. Reliable and available in any Codespace with Python.
- **`venv` + `uv`:** The modern, high-speed approach. Supercharges package installation.

By practicing with all three, you'll be well-prepared to manage any Python project you encounter!