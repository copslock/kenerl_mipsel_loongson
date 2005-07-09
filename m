Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Jul 2005 10:33:46 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:60623 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8226381AbVGIJd3>;
	Sat, 9 Jul 2005 10:33:29 +0100
Received: from port-195-158-170-192.dynamic.qsc.de ([195.158.170.192] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1DrBim-0000Sf-00
	for linux-mips@linux-mips.org; Sat, 09 Jul 2005 11:34:04 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1DrBim-0006rO-8c
	for linux-mips@linux-mips.org; Sat, 09 Jul 2005 11:34:04 +0200
Date:	Sat, 9 Jul 2005 11:34:04 +0200
To:	linux-mips@linux-mips.org
Subject: Current SGI Octane status
Message-ID: <20050709093403.GB1586@hattusa.textio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

I tried current CVS HEAD plus the patches from
ftp://ftp.linux-mips.org/pub/linux/mips/people/skylark/
on an SMP Octane with 2x195 MHz R10000 and ESI graphics.

Results:

- Local console works.
- IOC3 networking works, with 2MB/s maximum for a 30MB http transfer
- Serial console works, but start of output is delayed. The driver
  probably lacks transfer bootstrap, and starts transmisssion only when
  the first buffer is full.
- Rebooting for SMP works, but this patch apparently broke arcload (hangs
  after "Entering Kernel").
- Serial console and framebuffer initializations seem to be mutually
  exclusive, that's impractical if you plan to route console (debug)
  output over serial while working on the graphics console.
- 'echo "foo" >/dev/fb0' kills the machine.

The dmesg for a serial boot is appended.


Thiemo


[4294667.296000] Linux version 2.6.12-ip30 (ths@hattusa) (gcc version 4.0.1 20050701 (prerelease) (Debian 4.0.0-12)) #21 SMP Sat Jul 9 10:41:57 CEST 2005
[4294667.296000] ARCH: SGI-IP30
[4294667.296000] PROMLIB: ARC firmware Version 64 Revision 0
[4294667.296000] CPU revision is: 00000927
[4294667.296000] FPU revision is: 00000900
[4294667.296000] Silicon Graphics Octane (IP30) support: (c) 2004, 2005 Stanislaw Skowronek.
[4294667.296000] xtalk: Detected XBow (revision 1.2) at 0.
[4294667.296000] xtalk: Detected Heart (revision E) at 8.
[4294667.296000] xtalk: Detected HQ4 / ImpactSR (revision B) at 12.
[4294667.296000] xtalk: Detected Bridge (revision C) at 15.
[4294667.296000] BRIDGE chip at xtalk:15, initializing...
[4294667.296000] Determined physical RAM map:
[4294667.296000]  memory: 0000000000004000 @ 0000000000000000 (reserved)
[4294667.296000]  memory: 00000000004c6000 @ 0000000020004000 (reserved)
[4294667.296000]  memory: 0000000000a36000 @ 00000000204ca000 (usable)
[4294667.296000]  memory: 0000000000100000 @ 0000000020f00000 (ROM data)
[4294667.296000]  memory: 000000003f000000 @ 0000000021000000 (usable)
[4294667.296000] On node 0 totalpages: 393216
[4294667.296000]   DMA zone: 393216 pages, LIFO batch:31
[4294667.296000]   Normal zone: 0 pages, LIFO batch:1
[4294667.296000]   HighMem zone: 0 pages, LIFO batch:1
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: root=xio(0)pci(15)scsi(0)disk(1)rdisk(0)partition(0) root=/dev/sda1 console=ttyS0
[4294667.296000] Primary instruction cache 32kB, physically tagged, 2-way, linesize 64 bytes.
[4294667.296000] Primary data cache 32kB, 2-way, linesize 32 bytes.
[4294667.296000] Unified secondary cache 1024kB 2-way, linesize 128 bytes.
[4294667.296000] Synthesized TLB refill handler (41 instructions).
[4294667.296000] Synthesized TLB load handler fastpath (55 instructions).
[4294667.296000] Synthesized TLB store handler fastpath (55 instructions).
[4294667.296000] Synthesized TLB modify handler fastpath (54 instructions).
[4294667.296000] IP30: interrupt controller initialized.
[4294667.296000] PID hash table entries: 4096 (order: 12, 131072 bytes)
[4294667.296000] IP30: initializing timer.
[4294667.296000] 194 MHz CPU detected
[4294667.296000] Using 97.492 MHz high precision timer.
[4294667.296000] Console: colour dummy device 80x25
[4294667.306000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[4294667.325000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[4294667.560000] Memory: 1017476k/1042648k available (3180k kernel code, 24828k reserved, 1222k data, 248k init, 0k highmem)
[4294667.561000] Calibrating delay loop... 193.53 BogoMIPS (lpj=96768)
[4294667.578000] Mount-cache hash table entries: 256
[4294667.579000] Checking for 'wait' instruction...  unavailable.
[4294667.579000] Checking for the multiply/shift bug... no.
[4294667.579000] Checking for the daddi bug... no.
[4294667.579000] Checking for the daddiu bug... no.
[4294667.580000] CPU revision is: 00000927
[4294667.580000] FPU revision is: 00000900
[4294667.580000] Primary instruction cache 32kB, physically tagged, 2-way, linesize 64 bytes.
[4294667.580000] Primary data cache 32kB, 2-way, linesize 32 bytes.
[4294667.580000] Unified secondary cache 1024kB 2-way, linesize 128 bytes.
[4294667.582000] Synthesized TLB refill handler (41 instructions).
[4294667.582000] Calibrating delay loop... 194.56 BogoMIPS (lpj=97280)
[4294667.599000] Brought up 2 CPUs
[4294667.599000] CPU0 attaching sched-domain:
[4294667.599000]  domain 0: span 3
[4294667.599000]   groups: 1 2
[4294667.599000] CPU1 attaching sched-domain:
[4294667.599000]  domain 0: span 3
[4294667.599000]   groups: 2 1
[4294667.603000] NET: Registered protocol family 16
[4294667.609000] SCSI subsystem initialized
[4294667.610000] IP30: HEART ATTACK! Caught errors: 0x1040!
[4294667.610000]     interrupt #63
[4294667.610000]     interrupt #57
[4294667.622000] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[4294667.623000] Initializing Cryptographic API
[4294667.623000] PCI: Fixing ioc3 in [bus:slot.fn] 0000:00:02.0
[4294667.623000] PCI: Fixing rad1 in [bus:slot.fn] 0000:00:03.0
[4294667.711000] Console: switching to colour frame buffer device 160x64
[4294667.711000] fb0: ImpactSR 1RSS frame buffer device
[4294667.848000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[4294667.850000] io scheduler noop registered
[4294667.850000] io scheduler anticipatory registered
[4294667.850000] io scheduler deadline registered
[4294667.850000] io scheduler cfq registered
[4294667.854000] RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
[4294667.856000] loop: loaded (max 8 devices)
[4294667.856000] tun: Universal TUN/TAP device driver, 1.6
[4294667.856000] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[4294667.857000] qla1280: QLA1040 found on PCI bus 0, dev 0
[4294667.857000] PCI: Enabling device 0000:00:00.0 (0006 -> 0007)
[4294668.577000] scsi(0:0): Resetting SCSI BUS
[4294668.579000] scsi0 : QLogic QLA1040 PCI to SCSI Host Adapter
[4294668.579000]        Firmware version:  7.65.00, Driver version 3.25
[4294670.747000]   Vendor: SEAGATE   Model: ST318275LC        Rev: 0001
[4294670.747000]   Type:   Direct-Access                      ANSI SCSI revision: 02
[4294670.748000] scsi(0:0:1:0): Sync: period 10, offset 12, Wide
[4294672.921000] qla1280: QLA1040 found on PCI bus 0, dev 1
[4294672.921000] PCI: Enabling device 0000:00:01.0 (0006 -> 0007)
[4294673.653000] scsi(1:0): Resetting SCSI BUS
[4294673.656000] scsi1 : QLogic QLA1040 PCI to SCSI Host Adapter
[4294673.656000]        Firmware version:  7.65.00, Driver version 3.25
[4294678.158000] SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
[4294678.160000] SCSI device sda: drive cache: write back
[4294678.162000] SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
[4294678.164000] SCSI device sda: drive cache: write back
[4294678.164000]  sda: sda1 sda2 sda9 sda11
[4294678.182000] Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
[4294678.183000] mice: PS/2 mouse device common for all mice
[4294678.183000] md: raid0 personality registered as nr 2
[4294678.183000] md: raid1 personality registered as nr 3
[4294678.183000] md: raid5 personality registered as nr 4
[4294678.183000] raid5: measuring checksumming speed
[4294678.188000]    8regs     :   500.000 MB/sec
[4294678.193000]    8regs_prefetch:   476.000 MB/sec
[4294678.198000]    32regs    :   496.000 MB/sec
[4294678.203000]    32regs_prefetch:   476.000 MB/sec
[4294678.203000] raid5: using function: 8regs (500.000 MB/sec)
[4294678.203000] md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
[4294678.203000] Advanced Linux Sound Architecture Driver Version 1.0.9rc2  (Thu Mar 24 10:33:39 2005 UTC).
[4294678.208000] ALSA device list:
[4294678.208000]   #0: SGI RAD Pro Audio at 0x1fa00000
[4294679.420000] IOC3 part: [030-0891-003], serial: [DJK972] => class IP30 system
[4294679.421000] ttyS0 at IOC3 0x1f620178 (irq = 64) is a 16550A
[4294679.423000] ttyS1 at IOC3 0x1f620170 (irq = 64) is a 16550A
[4294679.428000] Ethernet address is 08:00:69:0a:fc:0f.
[4294679.441000] eth0: link up, 100Mbps, half-duplex, lpa 0x00A1
[4294679.442000] eth0: Using PHY 1, vendor 0x15f42, model 2, rev 3.
[4294679.443000] eth0: IOC3 SSRAM has 128 kbyte.
[4294679.444000] IOC3 Master Driver loaded for 0000:00:02.0
[4294679.445000] NET: Registered protocol family 2
[4294679.548000] atkbd.c: keyboard reset failed on ioc3/serio0kbd
[4294680.035000] atkbd.c: keyboard reset failed on ioc3/serio0aux
[4294680.429000] IP: routing cache hash table of 8192 buckets, 128Kbytes
[4294680.431000] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[4294680.463000] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[4294680.471000] TCP: Hash tables configured (established 262144 bind 65536)
[4294680.472000] NET: Registered protocol family 1
[4294680.473000] NET: Registered protocol family 17
[4294680.474000] NET: Registered protocol family 15
[4294680.476000] md: Autodetecting RAID arrays.
[4294680.477000] md: autorun ...
[4294680.478000] md: ... autorun DONE.
[4294680.506000] kjournald starting.  Commit interval 5 seconds
[4294680.581000] EXT3-fs: mounted filesystem with ordered data mode.
[4294680.662000] VFS: Mounted root (ext3 filesystem) readonly.
[4294680.736000] Freeing prom memory: 1024kb freed
[4294680.796000] Freeing unused kernel memory: 1272k freed
[4294683.050000] Adding 907664k swap on /dev/sda2.  Priority:-1 extents:1
[4294683.389000] EXT3 FS on sda1, internal journal
