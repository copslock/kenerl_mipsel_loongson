Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA22278; Tue, 8 Apr 1997 15:27:32 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA20209 for linux-list; Tue, 8 Apr 1997 15:26:54 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA20191 for <linux@engr.sgi.com>; Tue, 8 Apr 1997 15:26:50 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id PAA16922 for <linux@engr.sgi.com>; Tue, 8 Apr 1997 15:26:48 -0700
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id SAA03675; Tue, 8 Apr 1997 18:23:32 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199704082223.SAA03675@neon.ingenia.ca>
Subject: It booooooooooots!
To: linux@cthulhu.engr.sgi.com
Date: Tue, 8 Apr 1997 18:23:31 -0400 (EDT)
Cc: kneedham@ottawa.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>> boot -f bootp()neon.ingenia.ca:/vmlinux
Setting $netaddr to 205.207.220.72 (from server neon.ingenia.ca)
Obtaining /vmlinux from server neon.ingenia.ca
PROMLIB: SGI ARCS firmware Version 1 Revision 10
PROMLIB: Total free ram 65208320 bytes (63680K,62MB)
Loading R4000 MMU routines.
CPU REVISION IS: 00002310
Primary ICACHE 32K (linesize 32 bytes)
Primary DCACHE 32K (linesize 32 bytes)
R4600/R5000 SCACHE size 512K linesize 128 bytes
ARCH: SGI-IP22
CPU: MIPS-R5000 FPU<MIPS-R5000FPC> ICACHE DCACHE SCACHE
MC: SGI memory controller Revision 3
calculating r4koff... 000bd678(775800)
zs0: console input
zs0: console I/O
Calibrating delay loop.. ok - 154.83 BogoMIPS
Memory: 60564k/196604k available (792k kernel code, 2988k data)
Swansea University Computer Society NET3.035 for Linux 2.0
NET3: Unix domain sockets 0.12 for Linux NET3.035.
Swansea University Computer Society TCP/IP for NET3.034
IP Protocols: ICMP, UDP, TCP
Checking for 'wait' instruction...  unavailable.
Linux version 2.0.12 (dm@neteng) (gcc version 2.7.2) #2 Mon Aug 12 04:43:30 PDT6
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9838 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9830 (irq = 21) is a Zilog8530
PS/2 auxiliary pointing device detected -- driver installed.
WD93: Driver version 1.21 compiled on Aug 12 1996 at 04:20:18
wd33c93-0: chip=WD33c93B microcode=0d
scsi0 : SGI WD93
scsi : 1 host.
Started kswapd v 1.3
  Vendor: SGI       Model: IBM DORS-32160    Rev: W80D
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
  Vendor: CONNER    Model: CFP2107S  2.14GB  Rev: 172B
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 6, lun 0
scsi : detected 2 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 4197405 [2049 MB] [2.0 GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 4194304 [2048 MB] [2.0 GB]
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:0a:2a:9b
Partition check:
 sda: sda1 sda2 sda3 sda4
 sdb: sdb1 sdb2 sdb3 sdb4
Sending BOOTP and RARP requests............

Doesn't seem to want to find the server again for the NFS root thing,
but that's probably a config problem.

_Now_ we're ready to rock...

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>       Chief System Architect -- Head geek -- System exorcist        
#>                                                                     
#>   "Have you considered a life?  I hear they're quite affordable     
#>          these days." --- shields@tembel.org                        
