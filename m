Received:  by oss.sgi.com id <S553842AbQLCQFJ>;
	Sun, 3 Dec 2000 08:05:09 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:49668 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553830AbQLCQEt>;
	Sun, 3 Dec 2000 08:04:49 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 1A5647F3; Sun,  3 Dec 2000 17:04:47 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id A84458F74; Sun,  3 Dec 2000 17:04:30 +0100 (CET)
Date:   Sun, 3 Dec 2000 17:04:30 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: [SUCCESS] 2.4.0-test11 on Decstation 5000/150 (R4000)
Message-ID: <20001203170430.A1504@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Hi,
here is the short output - We needed to change ethernet, scsi
initialization and the vmalloc bug ...


--------------------------------schnipp------------------------------
KN04 V2.1k    (PC: 0x8005faf4, SP: 0x839bfde8)
delo V0.7 Copyright 2000 Florian Lohoff <flo@rfc822.org>
Loading /etc/delo.conf .. ok
Loading /boot/vmlinux .................... ok
This DECstation is a DS5000/1xx
Loading R4000 MMU routines.
CPU revision is: 00000430
Primary instruction cache 8kb, linesize 16 bytes.
Primary data cache 8kb, linesize 16 bytes.
Secondary cache sized at 1024K linesize 32 bytes.
Linux version 2.4.0-test11 (flo@slimer.rfc822.org) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #15 Sun Dec 3 16:27:18 CET 2000
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda2 console=ttyS2
Calibrating delay loop... 49.68 BogoMIPS
Memory: 62596k/65536k available (1277k kernel code, 2940k reserved, 69k data, 56k init)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
TURBOchannel rev. 1 at 12.5 MHz (no parity)
    slot 0: DEC      PMAZ-AA  V5.3d   
    slot 1: DEC      PMAZ-AA  V5.3b   
    slot 2: DEC      PMAF-FA  V1.1    
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
DECstation Z8530 serial driver version 0.03
ttyS00 at 0xbc100001 (irq = 4) is a Z85C30 SCC
ttyS01 at 0xbc100009 (irq = 4) is a Z85C30 SCC
ttyS02 at 0xbc180001 (irq = 4) is a Z85C30 SCC
ttyS03 at 0xbc180009 (irq = 4) is a Z85C30 SCC
rtc: Digital DECstation epoch (2000) detected
Real Time Clock Driver v1.10e
declance.c: v0.008 by Linux Mips DECstation task force
eth0: IOASIC onboard LANCE, addr = 08:00:2b:28:f0:a3, irq = 3
SCSI subsystem driver Revision: 1.00
SCSI ID 7 Clk 25MHz CCF=5 TOut 167 NCR53C9x(esp236)
SCSI ID 7 Clk 12MHz CCF=3 TOut 139 NCR53C9x(esp236)
SCSI ID 7 Clk 12MHz CCF=3 TOut 139 NCR53C9x(esp236)
ESP: Total of 3 ESP hosts found, 3 actually in use.
scsi0 : ESP236 (NCR53C9x)
scsi1 : ESP236 (NCR53C9x)
scsi2 : ESP236 (NCR53C9x)
  Vendor: QUANTUM   Model: FIREBALL_TM2110S  Rev: 300X
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
Detected scsi disk sdc at scsi0, channel 0, id 2, lun 0
Detected scsi disk sdd at scsi0, channel 0, id 3, lun 0
Detected scsi disk sde at scsi0, channel 0, id 4, lun 0
Detected scsi disk sdf at scsi0, channel 0, id 5, lun 0
Detected scsi disk sdg at scsi0, channel 0, id 6, lun 0
esp0: target 0 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sda: 4124736 512-byte hdwr sectors (2112 MB)
Partition check:
 sda: sda1 sda2
esp0: target 1 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sdb: 8386733 512-byte hdwr sectors (4294 MB)
 sdb: sdb1
esp0: target 2 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sdc: 8386733 512-byte hdwr sectors (4294 MB)
 sdc: sdc1
esp0: target 3 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sdd: 8386733 512-byte hdwr sectors (4294 MB)
 sdd: sdd1
esp0: target 4 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sde: 8386733 512-byte hdwr sectors (4294 MB)
 sde: sde1
esp0: target 5 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sdf: 8386733 512-byte hdwr sectors (4294 MB)
 sdf: sdf1
esp0: target 6 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sdg: 8386733 512-byte hdwr sectors (4294 MB)
 sdg: sdg1
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 195.71.97.226, my address is 195.71.97.229
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kmem_create: Forcing size word alignment - nfs_fh
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused PROM memory: 124k freed
Freeing unused kernel memory: 56k freed

INIT: version 2.78 booting
Activating swap...
Adding Swap: 130748k swap-space (priority -1)
Checking root file system...
Parallelizing fsck version 1.19 (13-Jul-2000)
/dev/sda2: clean, 51555/483328 files, 786244/1927296 blocks
Checking all file systems...
Parallelizing fsck version 1.19 (13-Jul-2000)
/dev/sdc1: clean, 4311/524288 files, 164329/1048265 blocks
/dev/sdd1: clean, 62204/524288 files, 379848/1048316 blocks
Setting kernel variables.
Mounting local filesystems...
/dev/sdc1 on /ftp.rfc822.org type ext2 (rw)
/dev/sdd1 on /home type ext2 (rw)
shm on /var/shm type shm (rw)
Starting portmap daemon: portmap.

Setting the System Clock using the Hardware Clock as reference...
System Clock set. Local time: Sun Dec  3 16:34:18 MET 2000

Cleaning: /tmp /var/lock /var/run.
Initializing random number generator... done.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd klogd.
Starting internet superserver: inetd.
Starting kernel module cleaner: modclean.
postfix-script: starting the Postfix mail system
Starting OpenBSD Secure Shell server: sshd.
Running ntpdate to synchronize clock.
Starting NTP server: ntpd.
Starting periodic command scheduler: cron.

Debian GNU/Linux woody repeat.rfc822.org console

repeat.rfc822.org login: 
--------------------------------schnapp------------------------------

So long ...
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
