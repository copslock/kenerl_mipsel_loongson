Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Jul 2005 21:53:46 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:32180 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8226406AbVGIUx2>;
	Sat, 9 Jul 2005 21:53:28 +0100
Received: from port-195-158-170-192.dynamic.qsc.de ([195.158.170.192] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1DrMKt-0002Cq-00
	for linux-mips@linux-mips.org; Sat, 09 Jul 2005 22:54:07 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1DrMKs-00017h-Rm
	for linux-mips@linux-mips.org; Sat, 09 Jul 2005 22:54:06 +0200
Date:	Sat, 9 Jul 2005 22:54:06 +0200
To:	linux-mips@linux-mips.org
Subject: Origin 200 Status
Message-ID: <20050709205406.GF1586@hattusa.textio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8421
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Hello All,

testing a single-node O200 SMP with current CVS and the patches from
ftp://ftp.linux-mips.org/pub/linux/mips/people/skylark/ , plus the
icache flush cache patch from Ralf, plus the PCI detection workaround
for ip27 gave

- working serial console
- working RTC
- ethernet with ~2.5 MB throughput

and a stable system. The IOC3 detection shows some weirdness:

[4294678.019000] IOC3 part: [], serial: [] => class IP27 BaseIO
[4294678.020000] ioc3_probe : request_irq fails for IRQ 0x4
[4294678.020000]  ttyS0 at IOC3 0x8620178 (irq = 0) is a 16550A
[4294678.027000] ttyS1 at IOC3 0x8620170 (irq = 0) is a 16550A

but this doesn't seem to have consequences for the serial console.


Thiemo


[4294667.296000] Linux version 2.6.12-ip30 (ths@hattusa) (gcc version 4.0.1 20050701 (prerelease) (Debian 4.0.0-12)) #220 SMP Sat Jul 9 22:39:47 CEST 2005
[4294667.296000] ARCH: SGI-IP27
[4294667.296000] PROMLIB: ARC firmware Version 64 Revision 0
[4294667.296000] Discovered 2 cpus on 1 nodes
[4294667.296000] node_distance: router_a NULL
[4294667.296000] ************** Topology ********************
[4294667.296000]     00 
[4294667.296000] 00  255 
[4294667.296000] CPU revision is: 00000e23
[4294667.296000] FPU revision is: 00000900
[4294667.296000] IP27: Running on node 0.
[4294667.296000] Node 0 has a primary CPU, CPU is running.
[4294667.296000] Node 0 has a secondary CPU, CPU is running.
[4294667.296000] Machine is in M mode.
[4294667.296000] Cpu 0, Nasid 0x0: partnum 0xc002 is a bridge
[4294667.296000] CPU 0 clock is 270MHz.
[4294667.296000] Determined physical RAM map:
[4294667.296000] On node 0 totalpages: 262144
[4294667.296000]   DMA zone: 262144 pages, LIFO batch:31
[4294667.296000]   Normal zone: 0 pages, LIFO batch:1
[4294667.296000]   HighMem zone: 0 pages, LIFO batch:1
[4294667.296000] Built 1 zonelists
[4294667.296000] Kernel command line: root=dksc(0,1,0) root=/dev/sda1
[4294667.296000] Primary instruction cache 32kB, physically tagged, 2-way, linesize 64 bytes.
[4294667.296000] Primary data cache 32kB, 2-way, linesize 32 bytes.
[4294667.296000] Unified secondary cache 4096kB 2-way, linesize 128 bytes.
[4294667.296000] Synthesized TLB refill handler (41 instructions).
[4294667.296000] Synthesized TLB load handler fastpath (55 instructions).
[4294667.296000] Synthesized TLB store handler fastpath (55 instructions).
[4294667.296000] Synthesized TLB modify handler fastpath (54 instructions).
[4294667.296000] PID hash table entries: 4096 (order: 12, 131072 bytes)
[4294667.330000] Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
[4294667.352000] Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[4294667.895000] Memory: 1023476k/1048576k available (2893k kernel code, 25100k reserved, 1244k data, 232k init, 0k highmem)
[4294667.898000] Calibrating delay loop... 402.43 BogoMIPS (lpj=201216)
[4294667.919000] Mount-cache hash table entries: 256
[4294667.922000] Checking for 'wait' instruction...  unavailable.
[4294667.924000] Checking for the multiply/shift bug... no.
[4294667.926000] Checking for the daddi bug... no.
[4294667.928000] Checking for the daddiu bug... no.
[4294667.930000] REPLICATION: ON nasid 0, ktext from nasid 0, kdata from nasid 0
[4294667.932000] CPU revision is: 00000e23
[4294667.932000] FPU revision is: 00000900
[4294667.932000] Primary instruction cache 32kB, physically tagged, 2-way, linesize 64 bytes.
[4294667.932000] Primary data cache 32kB, 2-way, linesize 32 bytes.
[4294667.933000] Unified secondary cache 4096kB 2-way, linesize 128 bytes.
[4294667.935000] Synthesized TLB refill handler (41 instructions).
[4294667.935000] CPU 1 clock is 270MHz.
[4294667.936000] Calibrating delay loop... 400.38 BogoMIPS (lpj=200192)
[4294667.956000] Brought up 2 CPUs
[4294667.957000] CPU0 attaching sched-domain:
[4294667.957000]  domain 0: span 00000000,00000003
[4294667.957000]   groups: 00000000,00000001 00000000,00000002
[4294667.957000] CPU1 attaching sched-domain:
[4294667.957000]  domain 0: span 00000000,00000003
[4294667.957000]   groups: 00000000,00000002 00000000,00000001
[4294667.960000] NET: Registered protocol family 16
[4294667.966000] SCSI subsystem initialized
[4294667.976000] devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
[4294667.977000] devfs: boot_options: 0x0
[4294667.979000] Initializing Cryptographic API
[4294668.099000] Real Time Clock Driver v1.09b
[4294668.100000] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
[4294668.103000] io scheduler noop registered
[4294668.105000] io scheduler anticipatory registered
[4294668.108000] io scheduler deadline registered
[4294668.110000] io scheduler cfq registered
[4294668.114000] loop: loaded (max 8 devices)
[4294668.116000] qla1280: QLA1040 found on PCI bus 0, dev 0
[4294668.117000] PCI: Enabling device 0000:00:00.0 (0006 -> 0007)
[4294668.732000] scsi(0:0): Resetting SCSI BUS
[4294668.736000] scsi0 : QLogic QLA1040 PCI to SCSI Host Adapter
[4294668.736000]        Firmware version:  7.65.00, Driver version 3.25
[4294671.026000]   Vendor: SEAGATE   Model: ST318275LC        Rev: 0001
[4294671.058000]   Type:   Direct-Access                      ANSI SCSI revision: 02
[4294671.061000] scsi(0:0:3:0): Sync: period 10, offset 12, Wide
[4294671.073000]   Vendor: SEAGATE   Model: ST318275LC        Rev: 0001
[4294671.105000]   Type:   Direct-Access                      ANSI SCSI revision: 02
[4294671.109000] scsi(0:0:4:0): Sync: period 10, offset 12, Wide
[4294671.121000]   Vendor: SEAGATE   Model: ST318275LC        Rev: 0001
[4294671.153000]   Type:   Direct-Access                      ANSI SCSI revision: 02
[4294671.157000] scsi(0:0:5:0): Sync: period 10, offset 12, Wide
[4294671.168000]   Vendor: SEAGATE   Model: ST318275LC        Rev: 0001
[4294671.200000]   Type:   Direct-Access                      ANSI SCSI revision: 02
[4294671.204000] scsi(0:0:6:0): Sync: period 10, offset 12, Wide
[4294672.542000] qla1280: QLA1040 found on PCI bus 0, dev 1
[4294672.543000] PCI: Enabling device 0000:00:01.0 (0006 -> 0007)
[4294673.159000] scsi(1:0): Resetting SCSI BUS
[4294673.163000] scsi1 : QLogic QLA1040 PCI to SCSI Host Adapter
[4294673.163000]        Firmware version:  7.65.00, Driver version 3.25
[4294677.449000] SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
[4294677.453000] SCSI device sda: drive cache: write back
[4294677.456000] SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
[4294677.459000] SCSI device sda: drive cache: write back
[4294677.460000]  /dev/scsi/host0/bus0/target3/lun0: p1 p2 p3 p9 p11
[4294677.484000] Attached scsi disk sda at scsi0, channel 0, id 3, lun 0
[4294677.490000] SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
[4294677.493000] SCSI device sdb: drive cache: write back
[4294677.496000] SCSI device sdb: 35566480 512-byte hdwr sectors (18210 MB)
[4294677.499000] SCSI device sdb: drive cache: write back
[4294677.500000]  /dev/scsi/host0/bus0/target4/lun0: p1 p2 p3 p9 p11
[4294677.523000] Attached scsi disk sdb at scsi0, channel 0, id 4, lun 0
[4294677.529000] SCSI device sdc: 35566480 512-byte hdwr sectors (18210 MB)
[4294677.532000] SCSI device sdc: drive cache: write back
[4294677.534000] SCSI device sdc: 35566480 512-byte hdwr sectors (18210 MB)
[4294677.537000] SCSI device sdc: drive cache: write back
[4294677.538000]  /dev/scsi/host0/bus0/target5/lun0: p1 p2 p3 p9 p11
[4294677.564000] Attached scsi disk sdc at scsi0, channel 0, id 5, lun 0
[4294677.570000] SCSI device sdd: 35566480 512-byte hdwr sectors (18210 MB)
[4294677.573000] SCSI device sdd: drive cache: write back
[4294677.575000] SCSI device sdd: 35566480 512-byte hdwr sectors (18210 MB)
[4294677.578000] SCSI device sdd: drive cache: write back
[4294677.579000]  /dev/scsi/host0/bus0/target6/lun0: p1 p2 p3 p9 p11
[4294677.603000] Attached scsi disk sdd at scsi0, channel 0, id 6, lun 0
[4294677.604000] Attached scsi generic sg0 at scsi0, channel 0, id 3, lun 0,  type 0
[4294677.606000] Attached scsi generic sg1 at scsi0, channel 0, id 4, lun 0,  type 0
[4294677.607000] Attached scsi generic sg2 at scsi0, channel 0, id 5, lun 0,  type 0
[4294677.608000] Attached scsi generic sg3 at scsi0, channel 0, id 6, lun 0,  type 0
[4294677.609000] md: linear personality registered as nr 1
[4294677.610000] md: raid0 personality registered as nr 2
[4294677.611000] md: raid1 personality registered as nr 3
[4294677.612000] md: raid10 personality registered as nr 9
[4294677.613000] md: raid5 personality registered as nr 4
[4294677.614000] raid5: measuring checksumming speed
[4294677.620000]    8regs     :   688.000 MB/sec
[4294677.626000]    8regs_prefetch:   656.000 MB/sec
[4294677.632000]    32regs    :   684.000 MB/sec
[4294677.638000]    32regs_prefetch:   656.000 MB/sec
[4294677.639000] raid5: using function: 8regs (688.000 MB/sec)
[4294677.657000] raid6: int64x1    179 MB/s
[4294677.675000] raid6: int64x2    246 MB/s
[4294677.693000] raid6: int64x4    312 MB/s
[4294677.711000] raid6: int64x8    199 MB/s
[4294677.712000] raid6: using algorithm int64x4 (312 MB/s)
[4294677.713000] md: raid6 personality registered as nr 8
[4294677.714000] md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
[4294677.728000] device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
[4294678.019000] IOC3 part: [], serial: [] => class IP27 BaseIO
[4294678.020000] ioc3_probe : request_irq fails for IRQ 0x4
[4294678.020000]  ttyS0 at IOC3 0x8620178 (irq = 0) is a 16550A
[4294678.027000] ttyS1 at IOC3 0x8620170 (irq = 0) is a 16550A
[4294678.033000] Ethernet address is 08:00:69:0d:52:e7.
[4294678.047000] eth0: link up, 100Mbps, half-duplex, lpa 0x40A1
[4294678.048000] eth0: Using PHY 31, vendor 0x20005c0, model 0, rev 1.
[4294678.049000] eth0: IOC3 SSRAM has 128 kbyte.
[4294678.050000] IOC3 Master Driver loaded for 0000:00:02.0
[4294678.051000] NET: Registered protocol family 2
[4294678.065000] IP: routing cache hash table of 4096 buckets, 64Kbytes
[4294678.068000] TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
[4294678.094000] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[4294678.102000] TCP: Hash tables configured (established 262144 bind 65536)
[4294678.103000] NET: Registered protocol family 1
[4294678.104000] NET: Registered protocol family 17
[4294678.105000] NET: Registered protocol family 15
[4294678.109000] devfs_mk_dev: could not append to parent for md/0
[4294678.110000] md: Autodetecting RAID arrays.
[4294678.213000] md: autorun ...
[4294678.214000] md: considering sdd3 ...
[4294678.215000] md:  adding sdd3 ...
[4294678.216000] md: sdd1 has different UUID to sdd3
[4294678.217000] md:  adding sdc3 ...
[4294678.218000] md: sdc1 has different UUID to sdd3
[4294678.219000] md:  adding sdb3 ...
[4294678.220000] md: sdb1 has different UUID to sdd3
[4294678.221000] md: created md0
[4294678.222000] md: bind<sdb3>
[4294678.223000] md: bind<sdc3>
[4294678.224000] md: bind<sdd3>
[4294678.225000] md: running: <sdd3><sdc3><sdb3>
[4294678.231000] raid5: device sdd3 operational as raid disk 2
[4294678.232000] raid5: device sdc3 operational as raid disk 1
[4294678.233000] raid5: device sdb3 operational as raid disk 0
[4294678.237000] raid5: allocated 3218kB for md0
[4294678.238000] raid5: raid level 5 set md0 active with 3 out of 3 devices, algorithm 2
[4294678.239000] RAID5 conf printout:
[4294678.240000]  --- rd:3 wd:3 fd:0
[4294678.241000]  disk 0, o:1, dev:sdb3
[4294678.242000]  disk 1, o:1, dev:sdc3
[4294678.243000]  disk 2, o:1, dev:sdd3
[4294678.244000] md: considering sdd1 ...
[4294678.245000] md:  adding sdd1 ...
[4294678.246000] md:  adding sdc1 ...
[4294678.247000] md:  adding sdb1 ...
[4294678.249000] devfs_mk_dev: could not append to parent for md/1
[4294678.250000] md: created md1
[4294678.251000] md: bind<sdb1>
[4294678.252000] md: bind<sdc1>
[4294678.253000] md: bind<sdd1>
[4294678.255000] md: running: <sdd1><sdc1><sdb1>
[4294678.260000] raid5: device sdd1 operational as raid disk 2
[4294678.261000] raid5: device sdc1 operational as raid disk 1
[4294678.262000] raid5: device sdb1 operational as raid disk 0
[4294678.266000] raid5: allocated 3218kB for md1
[4294678.267000] raid5: raid level 5 set md1 active with 3 out of 3 devices, algorithm 2
[4294678.268000] RAID5 conf printout:
[4294678.269000]  --- rd:3 wd:3 fd:0
[4294678.270000]  disk 0, o:1, dev:sdb1
[4294678.271000]  disk 1, o:1, dev:sdc1
[4294678.272000]  disk 2, o:1, dev:sdd1
[4294678.273000] md: ... autorun DONE.
[4294678.297000] kjournald starting.  Commit interval 5 seconds
[4294678.299000] EXT3-fs: mounted filesystem with ordered data mode.
[4294678.300000] VFS: Mounted root (ext3 filesystem) readonly.
[4294678.301000] Freeing unused kernel memory: 232k freed
[4294681.162000] Adding 506036k swap on /dev/sda2.  Priority:-1 extents:1
[4294681.183000] Adding 506036k swap on /dev/sdb2.  Priority:-2 extents:1
[4294681.205000] Adding 506036k swap on /dev/sdc2.  Priority:-3 extents:1
[4294681.225000] Adding 506036k swap on /dev/sdd2.  Priority:-4 extents:1
[4294681.465000] EXT3 FS on sda1, internal journal
[4294687.981000] kjournald starting.  Commit interval 5 seconds
[4294688.013000] EXT3 FS on md0, internal journal
[4294688.016000] EXT3-fs: mounted filesystem with ordered data mode.
