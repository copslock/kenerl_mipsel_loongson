Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6HIPnRw029024
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Jul 2002 11:25:49 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6HIPnbe029023
	for linux-mips-outgoing; Wed, 17 Jul 2002 11:25:49 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from pandora.research.kpn.com (IDENT:root@pandora.research.kpn.com [139.63.192.11])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6HIPTRw029014
	for <linux-mips@oss.sgi.com>; Wed, 17 Jul 2002 11:25:30 -0700
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by pandora.research.kpn.com (8.11.6/8.11.6) with ESMTP id g6HIUQW14989;
	Wed, 17 Jul 2002 20:30:26 +0200
Received: from sparta.research.kpn.com (sparta.research.kpn.com [139.63.192.6])
	by sparta.research.kpn.com (8.8.8+Sun/8.8.8) with ESMTP id UAA04138;
	Wed, 17 Jul 2002 20:30:25 +0200 (MET DST)
Message-Id: <200207171830.UAA04138@sparta.research.kpn.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: "Houten K.H.C. van (Karel)" <vhouten@kpn.com>, linux-mips@oss.sgi.com,
   karel@sparta.research.kpn.com
Subject: Re: DECStation: Support for PMAZ-AA TC SCSI card? 
In-reply-to: Your message of "Wed, 17 Jul 2002 15:35:04 +0200."
             <Pine.GSO.3.96.1020717141827.13355G-100000@delta.ds2.pg.gda.pl> 
Reply-to: vhouten@kpn.com
X-Face: ";:TzQQC{mTp~$W,'m4@Lu1Lu$rtG_~5kvYO~F:C'KExk9o1X"iRz[0%{bq?6Aj#>VhSD?v
 1W9`.Qsf+P&*iQEL8&y,RDj&U.]!(R-?c-h5h%Iw%r$|%6+Jc>GTJe!_1&A0o'lC[`I#={2BzOXT1P
 q366I$WL=;[+SDo1RoIT+a}_y68Y:jQ^xp4=*4-ryiymi>hy
Date: Wed, 17 Jul 2002 20:30:25 +0200
From: "Houten K.H.C. van (Karel)" <karel@kpn.com>
X-Spam-Status: No, hits=-4.5 required=5.0 tests=IN_REP_TO,SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi Maciej,

"Maciej W. Rozycki" writes:
> ...
> Just in case I am right, please check if the following hack helps with
>your PMAZ-A in your /260. 

Sorry, same result. See attached log.

Regards,
Karel.

>>boot 3/rz0 1/new
delo V0.7 Copyright 2000 Florian Lohoff <flo@rfc822.org>
Loading /etc/delo.conf .. ok
Loading /boot/vmlinux-2.4.18-test ....... ok
This DECstation is a DS5000/2x0
CPU revision is: 00000440
FPU revision is: 00000500
Primary instruction cache 16kb, linesize 16 bytes.
Primary data cache 16kb, linesize 16 bytes.
Secondary cache sized at 1024K linesize 32 bytes.
Linux version 2.4.18 (root@elrond) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110.1)) #13 Wed Jul 17 16:58:38 MEST 2002
Determined physical RAM map:
 memory: 10000000 @ 00000000 (usable)
On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda1 console=ttyS2 ro
Calibrating delay loop... 59.86 BogoMIPS
Memory: 255564k/262144k available (1813k kernel code, 6580k reserved, 108k data, 76k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
TURBOchannel rev. 1 at 25.0 MHz (without parity)
    slot 1: DEC      PMAZ-AA  V5.3d
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
lk201: DECstation LK keyboard driver v0.05.
pty: 256 Unix98 ptys configured
DECstation Z8530 serial driver version 0.07
ttyS00 at 0xbf900001 (irq = 14) is a Z85C30 SCC
ttyS01 at 0xbf900009 (irq = 14) is a Z85C30 SCC
ttyS02 at 0xbf980001 (irq = 15) is a Z85C30 SCC
rtc: Digital DECstation epoch (2000) detected
Real Time Clock Driver v1.10e
block: 128 slots per queue, batch=32
declance.c: v0.009 by Linux MIPS DECstation task force
eth0: IOASIC onboard LANCE, addr = 08:00:2b:37:63:76, irq = 16
SCSI subsystem driver Revision: 1.00
SCSI ID 7 Clk 25MHz CCF=5 TOut 167 NCR53C9x(esp236)
SCSI ID 7 Clk 25MHz CCF=5 TOut 167 NCR53C9x(esp236)
ESP: Total of 2 ESP hosts found, 2 actually in use.
scsi0 : ESP236 (NCR53C9x)
scsi1 : ESP236 (NCR53C9x)
esp0: AIEEE wide msg received
esp0: hoping for msgout
  Vendor: IBM       Model: DCHS04U           Rev: 6464
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: C2490A            Rev: 5193
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: C2490A            Rev: 5193
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: C2490A            Rev: 5193
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: C2490A            Rev: 5193
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: C2490A            Rev: 5193
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SONY      Model: CD-ROM CDU-55S    Rev: 1.0t
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: COMPAQ    Model: C2490A            Rev: 5193
  Type:   Direct-Access                      ANSI SCSI revision: 02
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0
Attached scsi disk sde at scsi0, channel 0, id 4, lun 0
Attached scsi disk sdf at scsi0, channel 0, id 5, lun 0
Attached scsi disk sdg at scsi1, channel 0, id 1, lun 0
SCSI device sda: 8813870 512-byte hdwr sectors (4513 MB)
Partition check:
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
esp0: target 1 [period 200ns offset 8 5.00MHz synchronous SCSI]
SCSI device sdb: 4110000 512-byte hdwr sectors (2104 MB)
 /dev/scsi/host0/bus0/target1/lun0: p1
esp0: target 2 [period 200ns offset 8 5.00MHz synchronous SCSI]
SCSI device sdc: 4110000 512-byte hdwr sectors (2104 MB)
 /dev/scsi/host0/bus0/target2/lun0: p1
esp0: target 3 [period 200ns offset 8 5.00MHz synchronous SCSI]
SCSI device sdd: 4110000 512-byte hdwr sectors (2104 MB)
 /dev/scsi/host0/bus0/target3/lun0: p1
esp0: target 4 [period 200ns offset 8 5.00MHz synchronous SCSI]
SCSI device sde: 4110000 512-byte hdwr sectors (2104 MB)
 /dev/scsi/host0/bus0/target4/lun0: p1
esp0: target 5 [period 200ns offset 8 5.00MHz synchronous SCSI]
SCSI device sdf: 4110000 512-byte hdwr sectors (2104 MB)
 /dev/scsi/host0/bus0/target5/lun0: p1
scsi : aborting command due to timeout : pid 52, scsi1, channel 0, id 1, lun 0 Request Sense 00 00 00 40 00
esp1: Aborting command
esp1: dumping state
esp1: SW [sreg<00> sstep<04> ireg<20>]
esp1: HW reread [sreg<06> sstep<c1> ireg<00>]
esp1: current command [tgt<01> lun<00> pphase<UNISSUED> cphase<SLCTMSG>]
esp1: disconnected
SCSI host 1 abort (pid 52) timed out - resetting
SCSI bus is being reset for host 1 channel 0.
esp1: Resetting scsi bus
esp1: Gross error sreg=40
esp1: SCSI bus reset interrupt
esp1: Warning, live target 1 not responding to selection.
esp1: Warning, live target 1 not responding to selection.
SCSI device sdg: 4110000 512-byte hdwr sectors (2104 MB)
 /dev/scsi/host1/bus0/target1/lun0: p1 p2
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 6, lun 0
esp0: target 6 [period 248ns offset 15 4.03MHz synchronous SCSI]
sr0: scsi-1 drive
