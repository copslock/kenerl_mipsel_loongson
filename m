Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jun 2010 11:41:26 +0200 (CEST)
Received: from anti.mobis.co.kr ([211.217.52.67]:55596 "HELO
        sniper.mobis.co.kr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with SMTP id S1492001Ab0FCJlX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Jun 2010 11:41:23 +0200
Received: (snipe 28071 invoked by uid 0); 3 Jun 2010 18:41:09 +0900
Received: from gurumurthy.gowdar@gmobis.com with  Spamsniper 2.94.22 (Processed in 0.011195 secs);
Received: from unknown (HELO msmobiweb.mobis.co.kr) (10.240.100.165)
  by unknown with SMTP; 3 Jun 2010 18:41:09 +0900
X-RCPTTO: linux-mips@linux-mips.org
Received: from mkegmal01.global.mobis.co.kr ([10.240.200.82]) by msmobiweb.mobis.co.kr with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 3 Jun 2010 18:49:06 +0900
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Linux kernel hangs in panic , not able to mount RFS
Date:   Thu, 3 Jun 2010 18:46:57 +0900
Message-ID: <5858DE952C53A441BDA3408A0524130104CCE0D5@mkegmal01>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux kernel hangs in panic , not able to mount RFS
Thread-Index: AcsDAbUc9tP7ZxlLSPSukUac3icAKw==
From:   =?iso-8859-1?Q?=A0Gurumurthy_G_M?= <Gurumurthy.Gowdar@gmobis.com>
To:     <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 03 Jun 2010 09:49:06.0000 (UTC) FILETIME=[017D5500:01CB0302]
X-archive-position: 27038
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Gurumurthy.Gowdar@gmobis.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 2245


Dear All,
         I am using MIPS32 AU1350 processor board with 2MB of NOR Flash, I have programmed u-boot and Linux kernel in NOR Flash. U-boot is working able to boot linux kernel but not able to mount root filesystem from SDRAM.

I have created uRamdisk and also passed boot arguments.

Below is the error log. let me know whether I am missing something.

U-Boot 2010.03 (May 28 2010 - 21:01:02)

Linux Advanced AVN Platform
CPU: Au1350 660MHz, id: 0x80, rev: 0x01
DRAM:  256 MB
Flash:  2 MB
*** Warning - bad CRC, using default environment

In:    serial
Out:   serial
Err:   serial
LinuxAVN=> loadb 0x81000000
## Ready for binary (kermit) download to 0x81000000 at 0 bps...

(Back at localhost)
----------------------------------------------------
(/home/gurumurthy/Downloads/kermit/) C-Kermit>send /tftpboot/rdImage
(/home/gurumurthy/Downloads/kermit/) C-Kermit>\c
Connecting to /dev/ttyS0, speed 115200
 Escape character: Ctrl-\ (ASCII 28, FS): enabled
Type the escape character followed by C to get back,
or followed by ? to see other options.
----------------------------------------------------
## Total Size      = 0x002ed937 = 3070263 Bytes
## Start Addr      = 0x81000000
LinuxAVN=> imls
Legacy Image at BFC50000:
   Image Name:   Linux-2.6.28.1
   Created:      2010-06-02  11:38:32 UTC
   Image Type:   MIPS Linux Kernel Image (gzip compressed)
   Data Size:    1134559 Bytes =  1.1 MB
   Load Address: 80100000
   Entry Point:  80104730
   Verifying Checksum ... OK
LinuxAVN=> iminfo 0x81000000

## Checking Image at 81000000 ...
   Legacy image found
   Image Name:  
   Created:      2010-06-02  11:11:16 UTC
   Image Type:   MIPS Linux RAMDisk Image (gzip compressed)
   Data Size:    3070199 Bytes =  2.9 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
LinuxAVN=> setenv bootargs console=ttyS0,115200 root=/dev/ram0 rw
LinuxAVN=> printenv
baudrate=115200
stdin=serial
stdout=serial
stderr=serial
filesize=2ED937
bootargs=console=ttyS0,115200 root=/dev/ram0 rw

Environment size: 121/65532 bytes
LinuxAVN=> 
baudrate=115200
stdin=serial
stdout=serial
stderr=serial
filesize=2ED937
bootargs=console=ttyS0,115200 root=/dev/ram0 rw

Environment size: 121/65532 bytes
LinuxAVN=>
baudrate=115200
stdin=serial
stdout=serial
stderr=serial
filesize=2ED937
bootargs=console=ttyS0,115200 root=/dev/ram0 rw

Environment size: 121/65532 bytes
LinuxAVN=>
baudrate=115200
stdin=serial
stdout=serial
stderr=serial
filesize=2ED937
bootargs=console=ttyS0,115200 root=/dev/ram0 rw

Environment size: 121/65532 bytes
LinuxAVN=> bootm
## Booting kernel from Legacy Image at 81000000 ...
   Image Name:  
   Created:      2010-06-02  11:11:16 UTC
   Image Type:   MIPS Linux RAMDisk Image (gzip compressed)
   Data Size:    3070199 Bytes =  2.9 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
Wrong Image Type for bootm command
ERROR: can't get kernel image!
LinuxAVN=>
LinuxAVN=>
LinuxAVN=> bootm 0xbfc50000 0x81000000
## Booting kernel from Legacy Image at bfc50000 ...
   Image Name:   Linux-2.6.28.1
   Created:      2010-06-02  11:38:32 UTC
   Image Type:   MIPS Linux Kernel Image (gzip compressed)
   Data Size:    1134559 Bytes =  1.1 MB
   Load Address: 80100000
   Entry Point:  80104730
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at 81000000 ...
   Image Name:  
   Created:      2010-06-02  11:11:16 UTC
   Image Type:   MIPS Linux RAMDisk Image (gzip compressed)
   Data Size:    3070199 Bytes =  2.9 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Starting kernel ...

Linux version 2.6.29.4-rmi-126-DB1350 (root@gurumurthy) (gcc version 4.2.4) #31 Wed Jun 2 17:05:36 IST 2010
console [early0] enabled
CPU revision is: 800c8001 (Au13xx)
(PRId 800c8001) @ 660.00 MHz
RMI DBAu1300 Development Board
Determined physical RAM map:
 memory: 01800000 @ 00000000 (usable)
 memory: 0c800000 @ 01800000 (reserved)
 memory: 02000000 @ 0e000000 (usable)
Initrd not found or empty - disabling initrd
Zone PFN ranges:
  Normal   0x00000000 -> 0x00010000
  HighMem  0x00010000 -> 0x00010000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00010000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: console=ttyS0,115200 root=/dev/ram0 rw video=au1200fb:panel:bs
Primary instruction cache 16kB, VIPT, 4-way, linesize 32 bytes.
Primary data cache 16kB, 4-way, VIPT, no aliases, linesize 32 bytes
PID hash table entries: 1024 (order: 10, 4096 bytes)
Alchemy clocksource installed
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 51012k/57344k available (1899k kernel code, 5988k reserved, 490k data, 152k init, 0k highmem)
Calibrating delay loop... 658.63 BogoMIPS (lpj=3293184)
Mount-cache hash table entries: 512
Hooking cpu_wait
bio: create slab <bio-0> at 0
SCSI subsystem initialized
Creating sysfs entry for board
Alchemy MEMPOOL initializing
Alchemy MEMPOOL registered at major 235
Available memory pools:
            LCD:  40 MB @ phys 0x01800000, free
            BSA:  64 MB @ phys 0x04000000, free
            MPE:  32 MB @ phys 0x08000000, free
            OGL:  64 MB @ phys 0x0a000000, free
squashfs: version 4.0 (2009/01/31) Phillip Lougher
msgmni has been set to 100
alg: No test for stdrng (krng)
io scheduler noop registered (default)
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
)console handover: boot [early0] -> real [ttyS0]) is a 8250
brd: module loaded
Driver 'sd' needs updating - please use bus_type methods
Driver 'sr' needs updating - please use bus_type methods
List of all partitions:
No filesystem could mount root, tried:  ext3 ext2 cramfs squashfs vfat msdos
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)


With Regards,
Gurumurthy
