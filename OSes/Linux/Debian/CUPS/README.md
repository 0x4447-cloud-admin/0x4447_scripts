CUPS

A collection of commands to manage and work with a print server under linux

Add
lpadmin -p HP1020 -m lsb/usr/hplip/HP/hp-laserjet_1020-hpijs.ppd
lpadmin -p HP1020 -v socket://localhost -m lsb/usr/hplip/HP/hp-laserjet_1020-hpijs.ppd
lpadmin -p HP_DESKJET_940C -E -v "usb://Hewlett-Packard/HP%20LaserJet%201020?serial=FN0JW5E" -m drv:///HP/hp-deskjet_940c.ppd.gz
lpadmin -p SHARED_PRINTER -m raw    # Raw queue; no PPD or filter

Remove
lpadmin -x PRINTER_NAME


Status
lpstat -a PRINTER_NAME


Enable printer
cupsenable PRINTER_NAME


Accept jobs
cupsaccept PRINTER_NAME


List all the drivers
lpinfo -m


List all ports and protocols that the printer can be accessed
lpinfo -v
