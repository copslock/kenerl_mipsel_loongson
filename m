Received:  by oss.sgi.com id <S553796AbRCJRu0>;
	Sat, 10 Mar 2001 09:50:26 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:19720 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553651AbRCJRuJ>;
	Sat, 10 Mar 2001 09:50:09 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 6CAE57D9; Sat, 10 Mar 2001 18:49:57 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 2E04BEFA8; Sat, 10 Mar 2001 20:47:00 +0100 (CET)
Date:   Sat, 10 Mar 2001 20:47:00 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: Success Kernel 2.4.2 (20010310) on SGI I2
Message-ID: <20010310204700.A16121@paradigm.rfc822.org>
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
success for booting current cvs 2.4.2 on the I2

>> bootp():vmlinux-ip22 console=ttyS0 root=/dev/sda1
Setting $netaddr to 195.71.99.220 (from server watchdog)
Obtaining vmlinux-ip22 from server watchdog
ARCH: SGI-IP22
PROMLIB: ARC firmware Version 1 Revision 10
CPU: MIPS-R4400 FPU<MIPS-R4400FPC> ICACHE DCACHE SCACHE 
Loading R4000 MMU routines.
CPU revision is: 00000460
Primary instruction cache 16kb, linesize 16 bytes.
Primary data cache 16kb, linesize 16 bytes.
Secondary cache sized at 2048K linesize 128 bytes.
Linux version 2.4.2 (flo@paradigm) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #2 Sat Mar 10 20:37:49 CET 2001
MC: SGI memory controller Revision 3
Determined physical RAM map:
 memory: 00001000 @ 00000000 (reserved)
 memory: 00001000 @ 00001000 (reserved)
 memory: 0019e000 @ 08002000 (reserved)
 memory: 005a0000 @ 081a0000 (usable)
 memory: 000c0000 @ 08740000 (ROM data)
 memory: 07800000 @ 08800000 (usable)
On node 0 totalpages: 65536
zone(0): 65536 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0 root=/dev/sda1
Calibrating system timer... 1250000 [250.00 MHz CPU]
Console: colour dummy device 80x25
zs0: console input
Console: ttyS0 (Zilog8530)
Calibrating delay loop... 124.51 BogoMIPS
Memory: 124232k/128640k available (1354k kernel code, 4408k reserved, 79k data, 64k init)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Checking for 'wait' instruction...  unavailable.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
initialize_kbd: Keyboard failed self test
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
DS1286 Real Time Clock Driver v1.0
streamable misc devices registered (keyb:150, gfx:148)
block: queued sectors max/low 82264kB/27421kB, 256 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: enabling 8 loop devices
sgiseeq.c: David S. Miller (dm@engr.sgi.com)
eth0: SGI Seeq8003 08:00:69:0a:04:b9 
SCSI subsystem driver Revision: 1.00
wd33c93-0: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Mar 10 2001 at 20:35:32
wd33c93-1: chip=WD33c93B/13 no_sync=0xff no_dma=0 debug_flags=0x00
           setup_args=,,,,,,,,,
           Version 1.25 - 09/Jul/1997, Compiled Mar 10 2001 at 20:35:32
scsi0 : SGI WD93
scsi1 : SGI WD93
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SGI       Model: QUANTUM XP32150   Rev: S89C
  Type:   Direct-Access                      ANSI SCSI revision: 02
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
 sending SDTR 0103013f0csync_xfer=2c  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 1, lun 0
Detected scsi disk sdb at scsi1, channel 0, id 1, lun 0
Detected scsi disk sdc at scsi1, channel 0, id 2, lun 0
Detected scsi disk sdd at scsi1, channel 0, id 3, lun 0
Detected scsi disk sde at scsi1, channel 0, id 4, lun 0
Detected scsi disk sdf at scsi1, channel 0, id 5, lun 0
Detected scsi disk sdg at scsi1, channel 0, id 6, lun 0
SCSI device sda: 4404489 512-byte hdwr sectors (2255 MB)
Partition check:
 sda: sda1 sda2 sda3 sda4
SCSI device sdb: 8386733 512-byte hdwr sectors (4294 MB)
 sdb: sdb1 sdb2 sdb3 sdb4
SCSI device sdc: 8386733 512-byte hdwr sectors (4294 MB)
 sdc: sdc1 sdc2 sdc3 sdc4
SCSI device sdd: 8386733 512-byte hdwr sectors (4294 MB)
 sdd: sdd1 sdd2 sdd3 sdd4
SCSI device sde: 8386733 512-byte hdwr sectors (4294 MB)
 sde: sde1 sde2 sde3 sde4
SCSI device sdf: 8386733 512-byte hdwr sectors (4294 MB)
 sdf: sdf1
SCSI device sdg: 8386733 512-byte hdwr sectors (4294 MB)
 sdg: sdg1
SGI Zilog8530 serial driver version 1.00
tty00 at 0xbfbd9830 (irq = 21) is a Zilog8530
tty01 at 0xbfbd9838 (irq = 21) is a Zilog8530
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 195.71.99.222, my address is 195.71.99.220
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing prom memory: 768kb freed
Freeing unused kernel memory: 64k freed

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
