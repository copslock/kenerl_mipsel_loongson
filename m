Received:  by oss.sgi.com id <S42346AbQJDS7D>;
	Wed, 4 Oct 2000 11:59:03 -0700
Received: from noose.gt.owl.de ([62.52.19.4]:21000 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S42310AbQJDS6j>;
	Wed, 4 Oct 2000 11:58:39 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 893E97F4; Wed,  4 Oct 2000 20:57:55 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 6015A9014; Wed,  4 Oct 2000 20:56:54 +0200 (CEST)
Date:   Wed, 4 Oct 2000 20:56:54 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     linux-mips@oss.sgi.com
Subject: 2.4.0-test8-pre1 on Decstation 5000/150
Message-ID: <20001004205654.C8870@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Success:

KN04 V2.1k    (PC: 0xbfc0073c, SP: 0x839b7de8)

-tftp boot(3), bootp 195.71.99.222:/data/tftp/vmlinux-dec 
-tftp load 1367072+0+141328
This DECstation is a DS5000/1xx
Loading R4000 MMU routines.
CPU revision is: 00000430
Primary instruction cache 8kb, linesize 16 bytes.
Primary data cache 8kb, linesize 16 bytes.
Secondary cache sized at 1024K linesize 32 bytes.
Linux version 2.4.0-test8-pre1 (flo@ping.mediaways.net) (gcc version egcs-2.90.29 980515 (egcs-1.0.3 release)) #2 Wed Oct 4 20:44:58 CEST 2000
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/sda2 console=ttyS2
Calibrating delay loop... 49.68 BogoMIPS
Memory: 62740k/65536k available (1196k kernel code, 2796k reserved, 78k data, 56k init)
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
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
Starting kswapd v1.7
pty: 256 Unix98 ptys configured
SCSI ID 7 Clk 25MHz CCF=5 TOut 167 NCR53C9x(esp236)
SCSI ID 7 Clk 12MHz CCF=3 TOut 139 NCR53C9x(esp236)
SCSI ID 7 Clk 12MHz CCF=3 TOut 139 NCR53C9x(esp236)
ESP: Total of 3 ESP hosts found, 3 actually in use.
scsi0 : ESP236 (NCR53C9x)
scsi1 : ESP236 (NCR53C9x)
scsi2 : ESP236 (NCR53C9x)
scsi : 3 hosts.
  Vendor: QUANTUM   Model: FIREBALL_TM2110S  Rev: 300X
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdc at scsi0, channel 0, id 2, lun 0
  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdd at scsi0, channel 0, id 3, lun 0
  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sde at scsi0, channel 0, id 4, lun 0
  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdf at scsi0, channel 0, id 5, lun 0
  Vendor: SEAGATE   Model: ST15230W SUN4.2G  Rev: 0738
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdg at scsi0, channel 0, id 6, lun 0
scsi : detected 7 SCSI disks total.
esp0: target 0 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sda: hdwr sector= 512 bytes. Sectors= 4124736 [2014 MB] [2.0 GB]
Partition check:
 sda: sda1 sda2
esp0: target 1 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 8386733 [4095 MB] [4.1 GB]
 sdb: sdb1
esp0: target 2 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sdc: hdwr sector= 512 bytes. Sectors= 8386733 [4095 MB] [4.1 GB]
 sdc: sdc1
esp0: target 3 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sdd: hdwr sector= 512 bytes. Sectors= 8386733 [4095 MB] [4.1 GB]
 sdd: sdd1
esp0: target 4 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sde: hdwr sector= 512 bytes. Sectors= 8386733 [4095 MB] [4.1 GB]
 sde: sde1
esp0: target 5 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sdf: hdwr sector= 512 bytes. Sectors= 8386733 [4095 MB] [4.1 GB]
 sdf: sdf1
esp0: target 6 [period 200ns offset 15 5.00MHz synchronous SCSI]
SCSI device sdg: hdwr sector= 512 bytes. Sectors= 8386733 [4095 MB] [4.1 GB]
 sdg: sdg1
DECstation Z8530 serial driver version 0.03
ttyS00 at 0xbc100001 (irq = 4) is a Z85C30 SCC
ttyS01 at 0xbc100009 (irq = 4) is a Z85C30 SCC
ttyS02 at 0xbc180001 (irq = 4) is a Z85C30 SCC
ttyS03 at 0xbc180009 (irq = 4) is a Z85C30 SCC
rtc: Digital DECstation epoch (2000) detected
Real Time Clock Driver v1.10d
declance.c: v0.008 by Linux Mips DECstation task force
eth0: IOASIC onboard LANCE, addr = 08:00:2b:28:f0:a3, irq = 3
Sending BOOTP requests.... OK
IP-Config: Got BOOTP answer from 195.71.99.222, my address is 195.71.99.221
kmem_create: Forcing size word alignment - nfs_fh
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused PROM memory: 124k freed
Freeing unused kernel memory: 56k freed
INIT: version 2.78 booting

-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
      "Write only memory - Oops. Time for my medication again ..."
