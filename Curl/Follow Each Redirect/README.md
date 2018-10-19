# Follow Each Redirect

This script will follow each redirect that a domain does, while outputting the headers to show you exactly what is going on.

# How to Run

`] ./script.sh`

The script will ask you to write a domain. If no domain is provided the default will be used (https://demo.0x4447.com).

# What to expect

The script then will print the following information:

1. Hierarchy of all re-directs.
1. HEAD information (curl -I) for each redirect.
