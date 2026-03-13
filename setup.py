# --------------------------------------------------
# -*- Python -*- Compatibility Header
#
# Copyright (C) 2023 Developer Jarvis (Pen Name)
#
# This file is part of the Log Pattern Detection Tool Library. This library is free
# software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the
# Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
#
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Log Pattern Detection Tool - Find patterns and anomalies in large log files
#                       Skills: streaming I/O, algorithms, regex
#
# Author: Developer Jarvis (Pen Name)
# Contact: https://github.com/DeveloperJarvis
#
# --------------------------------------------------

# --------------------------------------------------
# setup MODULE
# --------------------------------------------------

# --------------------------------------------------
# imports
# --------------------------------------------------
from setuptools import setup, find_packages


setup(
    name="web_based_ide",
    version="0.1.0",
    description="Web Based Code Editor and Executor",
    author="Developer Jarvis",
    url="https://github.com/DeveloperJarvis",
    packages=find_packages(),
    python_requires=">=3.9",
    install_requires=[
        "fastapi",
        "uvicorn",
        "pydantic",
    ],
    entry_points={
        "console_scripts": [
            "code-executor=main:main"
        ]
    },
    include_package_data=True,
    extras_require={
        "dev": [
            "pytest",
            "black",
            "flake8",
            "mypy",
        ]
    },
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: GNU General Public License v3 or later (GPLv3+)",
        "Operating System :: OS Independent",
    ],
)
