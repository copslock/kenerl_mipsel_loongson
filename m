Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0AIfmR18703
	for linux-mips-outgoing; Thu, 10 Jan 2002 10:41:48 -0800
Received: from scan1.fhg.de (scan1.fhg.de [153.96.1.35])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0AIfbg18697
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 10:41:37 -0800
Received: from scan1.fhg.de (localhost [127.0.0.1])
	by scan1.fhg.de (8.11.1/8.11.1) with ESMTP id g0AHfWk10368;
	Thu, 10 Jan 2002 18:41:32 +0100 (MET)
Received: from esk.esk.fhg.de (esk.esk.fhg.de [153.96.161.2])
	by scan1.fhg.de (8.11.1/8.11.1) with ESMTP id g0AHfV210364;
	Thu, 10 Jan 2002 18:41:32 +0100 (MET)
Received: from esk.fhg.de (host4-40 [192.168.4.40])
	by esk.esk.fhg.de (8.9.3/8.9.3) with ESMTP id SAA06303;
	Thu, 10 Jan 2002 18:41:30 +0100 (MET)
Message-ID: <3C3DD208.45B5BC29@esk.fhg.de>
Date: Thu, 10 Jan 2002 18:40:24 +0100
From: Wolfgang Heidrich <wolfgang.heidrich@esk.fhg.de>
Organization: FhG - ESK
X-Mailer: Mozilla 4.7 [de] (WinNT; I)
X-Accept-Language: de
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
CC: ppopov@pacbell.net
Subject: usb-problems with Au1000
References: <3B7DA3A3.8010000@pacbell.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hello,

I have following configuration:

- mips-Au1000-processor (PB1000-board from Alchemy-Semiconductor)
-  _no_  USB-devices connected
- linux from the Montavista-Tree (downloaded in December from
     www.alchemysemi.com)(Kernel "2.4.2_hhl20") 
- prebuilt crosscompiler from Montavista (downloaded in December from
     www.alchemysemi.com)

During booting the kernel initalizes the usb-device-driver and 
a little later prints "USB device not accepting new address...":

>>>>
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-ohci.c: USB OHCI at membase 0xb0100000, IRQ 26
usb-ohci.c: usb-builtin, non-PCI OHCI
usb.c: new USB bus registered, assigned bus number 1
Product: USB OHCI Root Hub
SerialNumber: b0100000
hub.c: USB hub found
hub.c: 2 ports detected
usb-ohci.c: v5.2 Roman Weissgaerber <weissg@vienna.at>, David Brownell
usb-ohci.c: USB OHCI Host Controller Driver
usb.c: registered new driver hid
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 192.168.65.17, my address is
192.168.65.240
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Serial driver version 1.01 (2001-02-08) with no serial options enabled
ttyS00 at 0xb1100000 (irq = 0) is a 16550
ttyS01 at 0xb1200000 (irq = 1) is a 16550
ttyS02 at 0xb1300000 (irq = 2) is a 16550
ttyS03 at 0xb1400000 (irq = 3) is a 16550
Looking up port of RPC 100003/2 on 192.168.65.17
Looking up port of RPC 100005/2 on 192.168.65.17
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: USB device not accepting new address=2 (error=-145)  
<---------????
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 64k freed
Algorithmics/MIPS FPU Emulator v1.5a
hub.c: USB new device connect on bus1/1, assigned device number 3
usb.c: USB device not accepting new address=3 (error=-145)
<---------????
<<<<

I wonder what I could have done wrong. The switches on the board
are set accordingly the Montavista-faq.txt. I could verify these
settings
with the schematics of the board.
After booting, when I plug in an USB-device, the same error messages
are repeated.

As far as I know USB should work with this kernel. So maybe this
is a hardware failure ? I reduced the CPU-frequency from 396MHz to
120MHz,
but this didn't help, too. The same messages appear, when I plug the
device
in the other USB-connector on the board. It's no problem with the power,
because I could verify that there are 5Volt on the USB-connector.

Probably someone already knows the solution, because this is not a
special
configuration.

Thanks in advance

-- 
Wolfgang
