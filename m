Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0AIkkI18825
	for linux-mips-outgoing; Thu, 10 Jan 2002 10:46:46 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0AIkag18821
	for <linux-mips@oss.sgi.com>; Thu, 10 Jan 2002 10:46:36 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0AHjSB28708;
	Thu, 10 Jan 2002 09:45:28 -0800
Subject: Re: usb-problems with Au1000
From: Pete Popov <ppopov@mvista.com>
To: Wolfgang Heidrich <wolfgang.heidrich@esk.fhg.de>
Cc: linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <3C3DD208.45B5BC29@esk.fhg.de>
References: <3B7DA3A3.8010000@pacbell.net>  <3C3DD208.45B5BC29@esk.fhg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 10 Jan 2002 09:49:06 -0800
Message-Id: <1010684946.29315.82.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 2002-01-10 at 09:40, Wolfgang Heidrich wrote:
> Hello,
> 
> I have following configuration:
> 
> - mips-Au1000-processor (PB1000-board from Alchemy-Semiconductor)
> -  _no_  USB-devices connected
> - linux from the Montavista-Tree (downloaded in December from
>      www.alchemysemi.com)(Kernel "2.4.2_hhl20") 
> - prebuilt crosscompiler from Montavista (downloaded in December from
>      www.alchemysemi.com)
> 
> During booting the kernel initalizes the usb-device-driver and 
> a little later prints "USB device not accepting new address...":

Which LSP version do you have? Do an "rpm -qa | grep hhl- | grep lsp".

There was a hardware errata in the usb controller, but a software fix is
already in the kernel (assuming you have a late enough kernel).  Also,
the usb switches, S4, should be set to:

1-4 off
5-6 on
7-8 off

Pete
 
> >>>>
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb-ohci.c: USB OHCI at membase 0xb0100000, IRQ 26
> usb-ohci.c: usb-builtin, non-PCI OHCI
> usb.c: new USB bus registered, assigned bus number 1
> Product: USB OHCI Root Hub
> SerialNumber: b0100000
> hub.c: USB hub found
> hub.c: 2 ports detected
> usb-ohci.c: v5.2 Roman Weissgaerber <weissg@vienna.at>, David Brownell
> usb-ohci.c: USB OHCI Host Controller Driver
> usb.c: registered new driver hid
> mice: PS/2 mouse device common for all mice
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 4096 bind 4096)
> Sending BOOTP requests.... OK
> IP-Config: Got BOOTP answer from 192.168.65.17, my address is
> 192.168.65.240
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Serial driver version 1.01 (2001-02-08) with no serial options enabled
> ttyS00 at 0xb1100000 (irq = 0) is a 16550
> ttyS01 at 0xb1200000 (irq = 1) is a 16550
> ttyS02 at 0xb1300000 (irq = 2) is a 16550
> ttyS03 at 0xb1400000 (irq = 3) is a 16550
> Looking up port of RPC 100003/2 on 192.168.65.17
> Looking up port of RPC 100005/2 on 192.168.65.17
> hub.c: USB new device connect on bus1/1, assigned device number 2
> usb.c: USB device not accepting new address=2 (error=-145)  
> <---------????
> VFS: Mounted root (nfs filesystem) readonly.
> Freeing unused kernel memory: 64k freed
> Algorithmics/MIPS FPU Emulator v1.5a
> hub.c: USB new device connect on bus1/1, assigned device number 3
> usb.c: USB device not accepting new address=3 (error=-145)
> <---------????
> <<<<
> 
> I wonder what I could have done wrong. The switches on the board
> are set accordingly the Montavista-faq.txt. I could verify these
> settings
> with the schematics of the board.
> After booting, when I plug in an USB-device, the same error messages
> are repeated.
> 
> As far as I know USB should work with this kernel. So maybe this
> is a hardware failure ? I reduced the CPU-frequency from 396MHz to
> 120MHz,
> but this didn't help, too. The same messages appear, when I plug the
> device
> in the other USB-connector on the board. It's no problem with the power,
> because I could verify that there are 5Volt on the USB-connector.
> 
> Probably someone already knows the solution, because this is not a
> special
> configuration.
> 
> Thanks in advance
> 
> -- 
> Wolfgang
