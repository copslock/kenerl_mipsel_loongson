Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA28867
	for <pstadt@stud.fh-heilbronn.de>; Fri, 9 Jul 1999 23:24:32 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA00210; Fri, 9 Jul 1999 14:18:11 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA91212
	for linux-list;
	Fri, 9 Jul 1999 14:14:34 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA02871
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 9 Jul 1999 14:14:31 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: from calvin.tor.onramp.ca (calvin.tor.onramp.ca [204.225.88.15]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id OAA01600
	for <linux@cthulhu.engr.sgi.com>; Fri, 9 Jul 1999 14:14:29 -0700 (PDT)
	mail_from (mikehill@hgeng.com)
Received: (qmail 22234 invoked from network); 9 Jul 1999 21:14:24 -0000
Received: from imail.hgeng.com (HELO bart.hgeng.com) (199.246.72.233)
  by mail.onramp.ca with SMTP; 9 Jul 1999 21:14:24 -0000
Received: by BART with Internet Mail Service (5.5.2232.9)
	id <3F12RBQ3>; Fri, 9 Jul 1999 17:16:03 -0400
Message-ID: <E138DB347D10D3119C630008C79F5DEC07EABC@BART>
From: Mike Hill <mikehill@hgeng.com>
To: "'Andrew R. Baker'" <andrewb@uab.edu>,
        Linux SGI
	 <linux@cthulhu.engr.sgi.com>
Subject: RE: Latest Indigo2 SCSI patch
Date: Fri, 9 Jul 1999 17:15:56 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2232.9)
Content-Type: text/plain
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Here's my latest result.  With nfs correctly configured on the server, the
procedure gets stuck on my external hard drive, which is not well-liked by
IRIX either.

PROMLIB: Total free ram 65839104 bytes (64296K,62MB)
CPU: MIPS-R4000 FPU<MIPS-R4000FPC> ICACHE DCACHE SCACHE 
Loading R4000 MMU routines.
CPU revision is: 00000430
Primary instruction cache 8kb, linesize 16 bytes)
Primary data cache 8kb, linesize 16 bytes)
Secondary cache sized at 1024K linesize 128
Linux version 2.2.1 (root@binkley) (gcc version egcs-2.90.27 980315
(egcs-1.0.2 release)) #13 Sun Jul 4 06:41:48 EDT 1999
MC: SGI memory controller Revision 3
calculating r4koff... 0007a205(500229)
Console: colour dummy device 80x25
zs0: console input
Console: ttyS0 (Zilog8530)
Calibrating delay loop... 49.87 BogoMIPS
Memory: 60952k/196140k available (1120k kernel code, 2188k data)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
Starting kswapd v 1.5 
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9830 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9838 (irq = 21) is a Zilog8530
DS1286 Real Time Clock Driver v1.0
streamable misc devices registered (keyb:150, gfx:148)
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Jul  4 1999 at 06:43:17
wd33c93-1: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Jul  4 1999 at 06:43:17
scsi0 : SGI WD93
scsi1 : SGI WD93
scsi : 2 hosts.
 sending SDTR 0103013f0c sync_xfer=2c
  Vendor: SGI       Model: SEAGATE ST31200N  Rev: 9278
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
scsi : aborting command due to timeout : pid 13, scsi1, channel 0, id 4, lun
0 Inquiry 00 00 00 ff 00 


I'll see about scrounging up another drive to test.  This one was a Quantum
ProDrive, similar to one I once discussed with Dave Olson.

Mike



> -----Original Message-----
> From:	Andrew R. Baker [SMTP:andrewb@uab.edu]
> Sent:	July 1, 1999 10:48 AM
> To:	Linux SGI
> Subject:	Latest Indigo2 SCSI patch
> 
> 
> Could Indigo2 and Indy users try this patch out?  It gets the second SCSI
> controller up and running on the Indigo2.  If there are no complaints, I
> am going to put it into the CVS tree.
> 
> -Andrew
