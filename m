Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA10976; Thu, 11 Jul 1996 02:30:10 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA09205 for linux-list; Thu, 11 Jul 1996 09:30:06 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA09199 for <linux@cthulhu.engr.sgi.com>; Thu, 11 Jul 1996 02:30:04 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id CAA10970; Thu, 11 Jul 1996 02:30:04 -0700
Date: Thu, 11 Jul 1996 02:30:04 -0700
Message-Id: <199607110930.CAA10970@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: wheeee...
Reply-to: dm@sgi.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


>> bootp()tanya:vmlinux
Obtaining vmlinux from server tanya
PROMLIB: SGI ARCS firmware Version 1 Revision 10
PROMLIB: Total free ram 65269760 bytes (63740K,62MB)
Primary ICACHE 16K (linesize 32 bytes)
Primary DCACHE 16K (linesize 32 bytes)
R4600/R5000 SCACHE size 512K linesize 32 bytes
ARCH: SGI-IP22
CPU: MIPS-R4600 FPU<MIPS-R4600FPC> ICACHE DCACHE SCACHE 
MC: SGI memory controller Revision 3
calculating r4koff... 000a87b4(690100)
get_zs: Returning bfbd9830
zs0: console input
zs0: console I/O
Calibrating delay loop.. ok - 137.63 BogoMIPS
Memory: 60624k/196604k available (740k kernel code, 2980k data)
Swansea University Computer Society NET3.035 for Linux 2.0
NET3: Unix domain sockets 0.12 for Linux NET3.035.
Swansea University Computer Society TCP/IP for NET3.034
IP Protocols: ICMP, UDP, TCP
Checking for 'wait' instruction...  available.
Linux version 2.0.4 (dm@neteng) (gcc version 2.7.2) #37 Thu Jul 11 02:16:15 PDT 1996
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9838 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9830 (irq = 21) is a Zilog8530
PS/2 auxiliary pointing device detected -- driver installed.
wd33c93-0: chip=WD33c93B microcode=0d  driver version 1.21 - 20/Apr/1996  compiled on Jul 11 1996 at 02:16:20
scsi0 : SGI WD93
scsi : 1 host.
Started kswapd v 1.2 
  Vendor: SGI       Model: SEAGATE ST32430N  Rev: 0240
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
scsi : detected 1 SCSI disk total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 4197405 [2049 MB] [2.0 GB]
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:08:8a:18 
Partition check:
 sda: sda1 sda2 sda3 sda4
Sending BOOTP and RARP requests.... OK
Root-NFS: Got RARP answer from 150.166.75.7, my address is 150.166.75.5
Root-NFS: Got file handle for /tftpboot/150.166.75.5 via RPC
VFS: Mounted root (nfs filesystem).
bash# 
