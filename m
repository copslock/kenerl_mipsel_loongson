Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA48299 for <linux-archive@neteng.engr.sgi.com>; Tue, 12 Jan 1999 07:45:49 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA21345
	for linux-list;
	Tue, 12 Jan 1999 07:45:10 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgidal.dallas.sgi.com (sgidal.dallas.sgi.com [169.238.80.130])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id HAA80838
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 12 Jan 1999 07:45:07 -0800 (PST)
	mail_from (chad@roctane.dallas.sgi.com)
Received: from roctane.dallas.sgi.com by sgidal.dallas.sgi.com via ESMTP (950413.SGI.8.6.12/911001.SGI)
	 id JAA02758; Tue, 12 Jan 1999 09:43:27 -0600
Received: from roctane.dallas.sgi.com (localhost [127.0.0.1]) by roctane.dallas.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA05847; Tue, 12 Jan 1999 07:45:03 -0800 (PST)
Message-ID: <369B6DFE.81E756D5@roctane.dallas.sgi.com>
Date: Tue, 12 Jan 1999 09:45:03 -0600
From: Chad Carlin <chad@roctane.dallas.sgi.com>
Reply-To: chad@sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: Mozilla 4.5C-SGI [en] (X11; I; IRIX64 6.5 IP30)
X-Accept-Language: en
MIME-Version: 1.0
To: Robin Humble <rjh@pixel.maths.monash.edu.au>,
        linux <linux@cthulhu.engr.sgi.com>
Subject: Re: same boot vmlinux trouble
References: <199901120848.TAA18136@pixel.maths.monash.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi Robin,

You are correct. That sort of copying would be very tedious indeed. I have the console port (serial port 1) of argo(linux Indy)
connected to serial port 1 on my bootp/nfs server (marvin2). You probably already know how to set this up but in the interest
of time (if I was patient I would work for a company that made slower computers) I'll include instructions anyway.

This  describes how to setup an Indy-to-Indy serial cable.

  1.Get a cable marked Indy to Indy (If you need help with this let me know)
  2.Plug one end in the master's serial port #2 (or whichever is available)
  3.Plug the other end in the slave's serial port #1 (or whichever is available)
  4.Be sure the master has eoe.sw.uucp installed
  5.Edit the master's ~uucp/Devices file so this line is uncommented:
     Direct ttyd2 - 9600 direct
  6.Verify the slave's /etc/inittab file has this line with respawn instead of off:
     t1:23:respawn:/sbin/getty ttyd1 co_9600 # alt console (mine is actually off)
  7.Verify the master's /dev/ttyd2 file is owned by uucp (check permissions too)
  8.As root on the slave machine type nvram console d. This tells the machine to output its
     console information through the duart (port 1) instead of to the graphics screen.
  9.To initiate the connection type cu -l ttyd2 on the master machine. NOTE: That's a letter el,
     not a number one.
 10.When you encounter problems, start rebooting things. :-)

Mine is a little different from this example. My inittab file has this entry (note; I use ttyd1 on my host). Mine is off as
opposed to respawn.

t1:23:off:/sbin/suattr -C CAP_FOWNER,CAP_DEVICE_MGT,CAP_DAC_WRITE+ip -c "exec /sbin/getty ttyd1 console"                # alt
console


BTW Setting this up is nice if your Indy's are close together. It lets you log into you IRIX Indy and work in prom or single
user on the linux Indy. Also nice for cut and paste of boot info. Even does floors. No Windoze though. ;-)

Apologies, if this is remedial reading for you. I guess I'm used to working with rocket scientist that don't understand some of
the things I think are simple. And vice a versa I'm sure.

Many thanks.

Regards,
Chad


Robin Humble wrote:

> Hi Chad,
>
> Sorry to hear it's still not working.
>
> How do I get a printout like the one below so I can see exactly what
> mine prints? I'm presuming you didn't copy it line by line from the Indy
> monitor.
>
> robin
>
> >Option? 5
> >Command Monitor.  Type "exit" to return to the menu.
> >>> boot bootp()169.238.83.43:vmlinux nfsroot=169.238.83.43:/dist/linux/mipseb nfsaddrs=:169.238.83.43::0xffffff80:marvin2::
> >130768+22320+3184+341792+48560d+4604+6816 entry: 0x8bfa60d0
> >Obtaining vmlinux from server 169.238.83.43
> >PROMLIB: SGI ARCS firmware Version 1 Revision 10
> >PROMLIB: Total free ram 65814528 bytes (64272K,62MB)
> >ARCH: SGI-IP22
> >CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE
> >Loading R4000 MMU routines.
> >CPU revision is: 00000460
> >Primary instruction cache 16kb, linesize 16 bytes)
> >Primary data cache 16kb, linesize 16 bytes)
> >Secondary cache sized at 1024K linesize 128
> >Linux version 2.1.100 (root@alex3.med.iacnet.com) (gcc version 2.7.2)
> >#29 Thu Jul 9 22:19:39 EDT 1998
> >MC: SGI memory controller Revision 3
> >calculating r4koff... 000f43c2(1000386)
> >zs0: console input
> >zs0: console I/O
> >Calibrating delay loop... 99.94 BogoMIPS
> >Memory: 60364k/196116k available (1216k kernel code, 2684k data)
> >Swansea University Computer Society NET3.039 for Linux 2.1
> >NET3: Unix domain sockets 0.16 for Linux NET3.038.
> >Swansea University Computer Society TCP/IP for NET3.037
> >IP Protocols: ICMP, UDP, TCP
> >Checking for 'wait' instruction...  unavailable.
> >POSIX conformance testing by UNIFIX
> >Starting kswapd v 1.5
> >Adv: about to run setup()
> >SGI Zilog8530 serial driver version 1.00
> >tty00 at 0xbfbd9838 (irq = 21) is a Zilog8530
> >tty01 at 0xbfbd9830 (irq = 21) is a Zilog8530
> >Ramdisk driver initialized : 16 ramdisks of 4096K size
> >loop: registered device at major 7
> >WD93: Driver version 1.25 compiled on Jul  7 1998 at 16:59:57
> > debug_flags=0x00
> >wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0scsi0 : SGI WD93
> >scsi : 1 host.
> > sending SDTR 0103013f0csync_xfer=2c  Vendor: IBM       Model:
> >DCAS-32160        Rev: S65A
> >  Type:   Direct-Access                      ANSI SCSI revision: 02
> >Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
> > sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: SEAGATE
> >ST31200N  Rev: 9278
> >  Type:   Direct-Access                      ANSI SCSI revision: 02
> >Detected scsi disk sdb at scsi0, channel 0, id 3, lun 0
> >scsi : detected 2 SCSI disks total.
> >SCSI device sda: hdwr sector= 512 bytes. Sectors= 4226725 [2063 MB] [2.1
> >GB]
> >SCSI device sdb: hdwr sector= 512 bytes. Sectors= 2077833 [1014 MB] [1.0
> >GB]
> >sgiseeq.c: David S. Miller (dm@engr.sgi.com)
> >eth0: SGI Seeq8003 08:00:69:07:9b:35
> >Sending BOOTP requests.... OK
> >IP-Config: Got BOOTP answer from 169.238.83.43, my address is
> >169.238.83.19
> >IP-Config: Gateway not on directly connected network.
> >Partition check:
> > sda: sda1 sda2 sda3 sda4
> > sdb: sdb1 sdb2 sdb3 sdb4
> >Looking up port of RPC 100003/2 on 169.238.83.43
> >Looking up port of RPC 100005/1 on 169.238.83.43
> >VFS: Mounted root (nfs filesystem).
> >Adv: done running setup()
> >Freeing unused kernel memory: 44k freed
> >Warning: unable to open an initial console.
> >page fault from irq handler: 0000
> >$0 : 00000000 88180000 0000062d 00000000
> >$4 : 00000000 1004fc00 00000000 00000000
> >$8 : 00000000 00000000 00000000 abf33822
> >$12: 000a0000 8bf31070 8bf31000 00000000
> >$16: 8bf41000 8bf2c0e0 0000062d 881523c8
> >$20: abf41040 bfb94000 00000000 bfbd4000
> >$24: 00000000 8bf5fb58
> >$28: 88008000 88009dd8 0000000e 880e3f38
> >epc   : 880e3e74
> >Status: 1004fc02
> >Cause : 00000008
> >Aiee, killing interrupt handler
> >Kernel panic: Attempted to kill the idle task!
> >In swapper task - not syncing

--
           -----------------------------------------------------
            Chad Carlin                          Special Systems
            Silicon Graphics Inc.                   972.205.5911
            Pager 888.754.1597          VMail 800.414.7994 X5344
            chad@sgi.com             http://reality.sgi.com/chad
           -----------------------------------------------------
             Bumper Sticker: "Happiness is a belt fed weapon."
