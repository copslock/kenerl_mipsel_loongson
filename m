Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2009 20:16:08 +0100 (BST)
Received: from apfelkorn.psychaos.be ([195.144.77.38]:34811 "EHLO
	apfelkorn.psychaos.be" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024349AbZEMTQA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2009 20:16:00 +0100
Received: from p2 by apfelkorn.psychaos.be with local (Exim 4.69)
	(envelope-from <p2@psychaos.be>)
	id 1M4Jvp-0001Bf-My
	for linux-mips@linux-mips.org; Wed, 13 May 2009 22:15:57 +0300
Date:	Wed, 13 May 2009 22:15:57 +0300
From:	Peter 'p2' De Schrijver <p2@debian.org>
To:	linux-mips@linux-mips.org
Subject: sb1250 ethernet driver problem
Message-ID: <20090513191557.GN1835@apfelkorn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
X-Unexpected-Header: The spanish inquisition !
X-mate:	Mate, mann gewohnt sich an alles
X-Paddo: Munch, Munch
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <p2@psychaos.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p2@debian.org
Precedence: bulk
X-list: linux-mips


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

There seems to be a bug in the mdio part of the sb1250 ethernet driver in 
2.6.30-rc5. See attached log file.

Cheers,

Peter.

--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="log-2.6.30-rc5-sb1-bcm91250a-net"

dmesg
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.30-rc5-sb1-bcm91250a (Debian 2.6.30~rc5-1~experimental.1) (maks@debian.org) (gcc version 4.1.3 20080420 (prerelease) (Debian 4.1.2-22)) #1 SMP Tue May 12 22:18:34 UTC 2009
[    0.000000] console [early0] enabled
[    0.000000] CPU revision is: 01040102 (SiByte SB1)
[    0.000000] FPU revision is: 000f0102
[    0.000000] Checking for the multiply/shift bug... no.
[    0.000000] Checking for the daddiu bug... no.
[    0.000000] Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)
[    0.000000] Board type: SiByte BCM91250A (SWARM)
[    0.000000] This kernel optimized for board runs with CFE
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 000000000fe47e00 @ 0000000000000000 (usable)
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA32    0x00000000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x00100000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0000fe47
[    0.000000] On node 0 totalpages: 65095
[    0.000000] free_area_init_node: node 0, pgdat ffffffff805bba20, node_mem_map a800000001000000
[    0.000000]   DMA32 zone: 890 pages used for memmap
[    0.000000]   DMA32 zone: 0 pages reserved
[    0.000000]   DMA32 zone: 64205 pages, LIFO batch:15
[    0.000000] Detected 1 available secondary CPU(s)
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64205
[    0.000000] Kernel command line: root=/dev/sda1 console=duart0
[    0.000000] Primary instruction cache 32kB, VIVT, 4-way, linesize 32 bytes.
[    0.000000] Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes
[    0.000000] NR_IRQS:128
[    0.000000] PID hash table entries: 1024 (order: 10, 8192 bytes)
[17179569.184000] Console: colour dummy device 80x25
[17179569.184000] console handover: boot [early0] -> real [duart0]
[17179569.192000] Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
[17179569.196000] Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
[17179569.232000] Memory: 249540k/260380k available (3678k kernel code, 10680k reserved, 1200k data, 220k init, 0k highmem)
[17179569.236000] Calibrating delay loop... 532.48 BogoMIPS (lpj=1064960)
[17179569.340000] Security Framework initialized
[17179569.344000] SELinux:  Disabled at boot.
[17179569.348000] Mount-cache hash table entries: 256
[17179569.356000] Initializing cgroup subsys ns
[17179569.360000] Initializing cgroup subsys cpuacct
[17179569.364000] Initializing cgroup subsys devices
[17179569.368000] Initializing cgroup subsys freezer
[17179569.372000] Initializing cgroup subsys net_cls
[17179569.376000] Checking for the daddi bug... no.
[17179569.384000] CPU revision is: 03040102 (SiByte SB1)
[17179569.384000] FPU revision is: 000f0102
[17179569.384000] Primary instruction cache 32kB, VIVT, 4-way, linesize 32 bytes.
[17179569.384000] Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes
[17179569.384000] Calibrating delay loop... 532.48 BogoMIPS (lpj=1064960)
[17179569.484000] Brought up 2 CPUs
[17179569.488000] CPU0 attaching sched-domain:
[17179569.488000]  domain 0: span 0-1 level CPU
[17179569.488000]   groups: 0 1
[17179569.488000] CPU1 attaching sched-domain:
[17179569.488000]  domain 0: span 0-1 level CPU
[17179569.488000]   groups: 1 0
[17179569.488000] net_namespace: 1936 bytes
[17179569.492000] regulator: core version 0.5
[17179569.496000] NET: Registered protocol family 16
[17179569.512000] bio: create slab <bio-0> at 0
[17179569.516000] SCSI subsystem initialized
[17179569.520000] libata version 3.00 loaded.
[17179569.520000] pci 0000:00:00.0: reg 10 32bit mmio: [0x60000000-0x7fffffff]
[17179569.520000] pci 0000:00:00.0: reg 18 32bit mmio: [0x70000000-0x7fffffff]
[17179569.520000] pci 0000:00:00.0: reg 1c 32bit mmio: [0x71000000-0x71ffffff]
[17179569.520000] pci 0000:00:00.0: reg 24 32bit mmio: [0x80000000-0xffffffff]
[17179569.520000] pci 0000:00:01.0: ignoring class 600 (doesn't match header type 01)
[17179569.524000] pci 0000:00:05.0: supports D1 D2
[17179569.524000] pci 0000:00:05.0: PME# supported from D0 D1 D2 D3hot
[17179569.528000] pci 0000:00:05.0: PME# disabled
[17179569.532000] pci 0000:00:07.0: reg 10 32bit mmio: [0x41000000-0x41000fff]
[17179569.532000] pci 0000:03:08.0: reg 10 32bit mmio: [0x41181000-0x41181fff]
[17179569.532000] pci 0000:03:08.0: supports D1 D2
[17179569.532000] pci 0000:03:08.0: PME# supported from D0 D1 D2 D3hot
[17179569.536000] pci 0000:03:08.0: PME# disabled
[17179569.540000] pci 0000:03:08.1: reg 10 32bit mmio: [0x41180000-0x41180fff]
[17179569.540000] pci 0000:03:08.1: supports D1 D2
[17179569.540000] pci 0000:03:08.1: PME# supported from D0 D1 D2 D3hot
[17179569.544000] pci 0000:03:08.1: PME# disabled
[17179569.548000] pci 0000:03:08.2: reg 10 32bit mmio: [0x41182800-0x411828ff]
[17179569.548000] pci 0000:03:08.2: supports D1 D2
[17179569.548000] pci 0000:03:08.2: PME# supported from D0 D1 D2 D3hot
[17179569.552000] pci 0000:03:08.2: PME# disabled
[17179569.556000] pci 0000:03:09.0: reg 10 32bit mmio: [0x41182000-0x411827ff]
[17179569.556000] pci 0000:03:09.0: reg 14 io port: [0x8000-0x807f]
[17179569.556000] pci 0000:03:09.0: supports D2
[17179569.556000] pci 0000:03:09.0: PME# supported from D2 D3hot D3cold
[17179569.560000] pci 0000:03:09.0: PME# disabled
[17179569.564000] pci 0000:03:0a.0: reg 10 io port: [0x8098-0x809f]
[17179569.564000] pci 0000:03:0a.0: reg 14 io port: [0x80a0-0x80a3]
[17179569.564000] pci 0000:03:0a.0: reg 18 io port: [0x8090-0x8097]
[17179569.564000] pci 0000:03:0a.0: reg 1c io port: [0x80a4-0x80a7]
[17179569.564000] pci 0000:03:0a.0: reg 20 io port: [0x8080-0x808f]
[17179569.564000] pci 0000:03:0a.0: reg 24 32bit mmio: [0x41182900-0x411829ff]
[17179569.564000] pci 0000:03:0a.0: reg 30 32bit mmio: [0x41100000-0x4117ffff]
[17179569.564000] pci 0000:03:0a.0: supports D1 D2
[17179569.564000] pci 0000:00:05.0: bridge io port: [0x8000-0x8fff]
[17179569.564000] pci 0000:00:05.0: bridge 32bit mmio: [0x41100000-0x411fffff]
[17179569.580000] NET: Registered protocol family 2
[17179569.584000] Switched to high resolution mode on CPU 0
[17179569.584000] Switched to high resolution mode on CPU 1
[17179569.636000] IP route cache hash table entries: 2048 (order: 2, 16384 bytes)
[17179569.644000] TCP established hash table entries: 8192 (order: 5, 131072 bytes)
[17179569.648000] TCP bind hash table entries: 8192 (order: 5, 131072 bytes)
[17179569.656000] TCP: Hash tables configured (established 8192 bind 8192)
[17179569.664000] TCP reno registered
[17179569.680000] NET: Registered protocol family 1
[17179569.684000] pata-swarm: PATA interface at GenBus slot 4
[17179569.688000] audit: initializing netlink socket (disabled)
[17179569.696000] type=2000 audit(1242160329.512:1): initialized
[17179569.700000] VFS: Disk quotas dquot_6.5.2
[17179569.704000] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[17179569.712000] msgmni has been set to 487
[17179569.716000] alg: No test for stdrng (krng)
[17179569.724000] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[17179569.728000] io scheduler noop registered
[17179569.732000] io scheduler anticipatory registered
[17179569.740000] io scheduler deadline registered
[17179569.744000] io scheduler cfq registered (default)
[17179569.760000] duart0 at MMIO 0x10060100 (irq = 8) is a SB1250 DUART
[17179569.764000] duart1 at MMIO 0x10060200 (irq = 9) is a SB1250 DUART
[17179569.776000] brd: module loaded
[17179569.780000] Driver 'sd' needs updating - please use bus_type methods
[17179569.788000] pata_sil680 0000:03:0a.0: version 0.4.9
[17179569.788000] sil680: 133MHz clock.
[17179569.792000] attempted to set irq affinity for irq 58 to multiple CPUs
[17179569.796000] scsi0 : pata_sil680
[17179569.800000] scsi1 : pata_sil680
[17179569.804000] ata1: PATA max UDMA/133 cmd 0x8098 ctl 0x80a0 bmdma 0x8080 irq 58
[17179569.812000] ata2: PATA max UDMA/133 cmd 0x8090 ctl 0x80a4 bmdma 0x8088 irq 58
[17179569.820000] Fixed MDIO Bus: probed
[17179569.824000] eth0 (sb1250-mac): not using net_device_ops yet
[17179569.832000] sb1250-mac.0: registered as eth0
[17179569.836000] eth0: enabling TCP rcv checksum
[17179569.840000] eth0: SiByte Ethernet at 0x10064000, address: 00:02:4c:fe:0d:72
[17179569.848000] eth1 (sb1250-mac): not using net_device_ops yet
[17179569.852000] sb1250-mac.1: registered as eth1
[17179569.856000] eth1: enabling TCP rcv checksum
[17179569.864000] eth1: SiByte Ethernet at 0x10065000, address: 00:02:4c:fe:0d:73
[17179569.868000] mice: PS/2 mouse device common for all mice
[17179569.876000] TCP cubic registered
[17179569.880000] NET: Registered protocol family 17
[17179569.884000] RPC: Registered udp transport module.
[17179569.892000] RPC: Registered tcp transport module.
[17179569.896000] registered taskstats version 1
[17179569.900000] /home/tbm/kernel/linux-2.6-2.6.30~rc5/debian/build/source_mips_none/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[17179570.148000] ata2.00: ATA-6: WDC WD2000JB-00GVA0, 08.02D08, max UDMA/100
[17179570.156000] ata2.00: 390721968 sectors, multi 0: LBA48 
[17179570.176000] ata2.00: configured for UDMA/100
[17179570.180000] scsi 1:0:0:0: Direct-Access     ATA      WDC WD2000JB-00G 08.0 PQ: 0 ANSI: 5
[17179570.188000] sd 1:0:0:0: [sda] 390721968 512-byte hardware sectors: (200 GB/186 GiB)
[17179570.196000] sd 1:0:0:0: [sda] Write Protect is off
[17179570.200000] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[17179570.200000] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[17179570.212000]  sda: sda1 sda2 sda3 sda4
[17179570.240000] sd 1:0:0:0: [sda] Attached SCSI disk
[17179570.244000] kjournald starting.  Commit interval 5 seconds
[17179570.244000] EXT3-fs: mounted filesystem with writeback data mode.
[17179570.244000] VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
[17179570.244000] Freeing unused kernel memory: 220k freed
[17179570.272000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179570.504000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179570.520000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179570.536000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179570.548000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179570.568000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179571.712000] Adding 506036k swap on /dev/sda2.  Priority:-1 extents:1 across:506036k 
[17179571.920000] EXT3 FS on sda1, internal journal
[17179572.964000] kjournald starting.  Commit interval 5 seconds
[17179572.964000] EXT3 FS on sda3, internal journal
[17179572.964000] EXT3-fs: mounted filesystem with writeback data mode.
[17179572.996000] kjournald starting.  Commit interval 5 seconds
[17179572.996000] EXT3 FS on sda4, internal journal
[17179572.996000] EXT3-fs: mounted filesystem with writeback data mode.
[17179587.948000] attempted to set irq affinity for irq 19 to multiple CPUs
[17179587.956000] ------------[ cut here ]------------
[17179587.960000] WARNING: at /home/tbm/kernel/linux-2.6-2.6.30~rc5/debian/build/source_mips_none/fs/sysfs/dir.c:487 sysfs_add_one+0xd4/0x158()
[17179587.972000] sysfs: cannot create duplicate filename '/class/mdio_bus/0'
[17179587.980000] Modules linked in:
[17179587.980000] Call Trace:
[17179587.984000] [<ffffffff801148f8>] dump_stack+0x8/0x38
[17179587.988000] [<ffffffff80142260>] warn_slowpath_fmt+0x98/0xc8
[17179587.996000] [<ffffffff802447fc>] sysfs_add_one+0xd4/0x158
[17179588.000000] [<ffffffff80245e00>] sysfs_do_create_link+0xd8/0x238
[17179588.008000] [<ffffffff8037a9c4>] device_add+0x41c/0x578
[17179588.012000] [<ffffffff803b3a40>] mdiobus_register+0xe0/0x1f8
[17179588.020000] [<ffffffff803b59b0>] sbmac_open+0x90/0x258
[17179588.024000] [<ffffffff803e3788>] dev_open+0xc0/0x130
[17179588.028000] [<ffffffff803e1be0>] dev_change_flags+0x158/0x1c8
[17179588.036000] [<ffffffff80440154>] devinet_ioctl+0x63c/0x7c8
[17179588.040000] [<ffffffff803cf6f4>] sock_ioctl+0x134/0x300
[17179588.048000] [<ffffffff801ed188>] vfs_ioctl+0x40/0xd0
[17179588.052000] [<ffffffff801ed4c0>] do_vfs_ioctl+0x2a8/0x640
[17179588.056000] [<ffffffff801ed908>] SyS_ioctl+0xb0/0xc8
[17179588.064000] [<ffffffff80225c60>] dev_ifsioc+0x88/0x338
[17179588.068000] [<ffffffff802255d4>] compat_sys_ioctl+0x1a4/0x460
[17179588.072000] [<ffffffff80103a14>] handle_sys+0x114/0x130
[17179588.080000] 
[17179588.080000] ---[ end trace 44fdd99f50e56b8b ]---
[17179588.096000] mii_bus 0 failed to register
[17179588.100000] eth0: unable to register MDIO bus
[17179589.216000] attempted to set irq affinity for irq 19 to multiple CPUs
[17179589.224000] kobject (a80000000fb0d880): tried to init an initialized object, something is seriously wrong.
[17179589.232000] Call Trace:
[17179589.236000] [<ffffffff801148f8>] dump_stack+0x8/0x38
[17179589.240000] [<ffffffff8031fe98>] kobject_init+0x70/0xc8
[17179589.244000] [<ffffffff8037a0dc>] device_initialize+0x2c/0x90
[17179589.252000] [<ffffffff8037ab34>] device_register+0x14/0x28
[17179589.256000] [<ffffffff803b3a40>] mdiobus_register+0xe0/0x1f8
[17179589.264000] [<ffffffff803b59b0>] sbmac_open+0x90/0x258
[17179589.268000] [<ffffffff803e3788>] dev_open+0xc0/0x130
[17179589.272000] [<ffffffff803e1be0>] dev_change_flags+0x158/0x1c8
[17179589.280000] [<ffffffff80440154>] devinet_ioctl+0x63c/0x7c8
[17179589.284000] [<ffffffff803cf6f4>] sock_ioctl+0x134/0x300
[17179589.292000] [<ffffffff801ed188>] vfs_ioctl+0x40/0xd0
[17179589.296000] [<ffffffff801ed4c0>] do_vfs_ioctl+0x2a8/0x640
[17179589.300000] [<ffffffff801ed908>] SyS_ioctl+0xb0/0xc8
[17179589.308000] [<ffffffff80225c60>] dev_ifsioc+0x88/0x338
[17179589.312000] [<ffffffff802255d4>] compat_sys_ioctl+0x1a4/0x460
[17179589.316000] [<ffffffff80103a14>] handle_sys+0x114/0x130
[17179589.324000] 
[17179589.324000] ------------[ cut here ]------------
[17179589.328000] WARNING: at /home/tbm/kernel/linux-2.6-2.6.30~rc5/debian/build/source_mips_none/fs/sysfs/dir.c:487 sysfs_add_one+0xd4/0x158()
[17179589.344000] sysfs: cannot create duplicate filename '/class/mdio_bus/0'
[17179589.348000] Modules linked in:
[17179589.352000] Call Trace:
[17179589.356000] [<ffffffff801148f8>] dump_stack+0x8/0x38
[17179589.360000] [<ffffffff80142260>] warn_slowpath_fmt+0x98/0xc8
[17179589.364000] [<ffffffff802447fc>] sysfs_add_one+0xd4/0x158
[17179589.372000] [<ffffffff80245e00>] sysfs_do_create_link+0xd8/0x238
[17179589.376000] [<ffffffff8037a9c4>] device_add+0x41c/0x578
[17179589.384000] [<ffffffff803b3a40>] mdiobus_register+0xe0/0x1f8
[17179589.388000] [<ffffffff803b59b0>] sbmac_open+0x90/0x258
[17179589.396000] [<ffffffff803e3788>] dev_open+0xc0/0x130
[17179589.400000] [<ffffffff803e1be0>] dev_change_flags+0x158/0x1c8
[17179589.404000] [<ffffffff80440154>] devinet_ioctl+0x63c/0x7c8
[17179589.412000] [<ffffffff803cf6f4>] sock_ioctl+0x134/0x300
[17179589.416000] [<ffffffff801ed188>] vfs_ioctl+0x40/0xd0
[17179589.420000] [<ffffffff801ed4c0>] do_vfs_ioctl+0x2a8/0x640
[17179589.428000] [<ffffffff801ed908>] SyS_ioctl+0xb0/0xc8
[17179589.432000] [<ffffffff80225c60>] dev_ifsioc+0x88/0x338
[17179589.436000] [<ffffffff802255d4>] compat_sys_ioctl+0x1a4/0x460
[17179589.444000] [<ffffffff80103a14>] handle_sys+0x114/0x130
[17179589.448000] 
[17179589.452000] ---[ end trace 44fdd99f50e56b8c ]---
[17179589.468000] mii_bus 0 failed to register
[17179589.472000] eth0: unable to register MDIO bus
[17179648.620000] attempted to set irq affinity for irq 20 to multiple CPUs
[17179648.632000] sb1250-mac-mdio: probed
[17179648.636000] eth1: attached PHY driver [Generic PHY] (mii_bus:phy_addr=1:01, irq=-1)
[17179650.592000] attempted to set irq affinity for irq 9 to multiple CPUs
[17179650.600000] attempted to set irq affinity for irq 9 to multiple CPUs
[17179651.624000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179651.640000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179651.656000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179651.668000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179655.052000] warning: `ntpd' uses 32-bit capabilities (legacy support in use)
[17179657.880000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179671.096000] attempted to set irq affinity for irq 19 to multiple CPUs
[17179671.104000] kobject (a80000000fb0d880): tried to init an initialized object, something is seriously wrong.
[17179671.112000] Call Trace:
[17179671.116000] [<ffffffff801148f8>] dump_stack+0x8/0x38
[17179671.120000] [<ffffffff8031fe98>] kobject_init+0x70/0xc8
[17179671.124000] [<ffffffff8037a0dc>] device_initialize+0x2c/0x90
[17179671.132000] [<ffffffff8037ab34>] device_register+0x14/0x28
[17179671.136000] [<ffffffff803b3a40>] mdiobus_register+0xe0/0x1f8
[17179671.144000] [<ffffffff803b59b0>] sbmac_open+0x90/0x258
[17179671.148000] [<ffffffff803e3788>] dev_open+0xc0/0x130
[17179671.152000] [<ffffffff803e1be0>] dev_change_flags+0x158/0x1c8
[17179671.160000] [<ffffffff80440154>] devinet_ioctl+0x63c/0x7c8
[17179671.164000] [<ffffffff803cf6f4>] sock_ioctl+0x134/0x300
[17179671.172000] [<ffffffff801ed188>] vfs_ioctl+0x40/0xd0
[17179671.176000] [<ffffffff801ed4c0>] do_vfs_ioctl+0x2a8/0x640
[17179671.180000] [<ffffffff801ed908>] SyS_ioctl+0xb0/0xc8
[17179671.188000] [<ffffffff80225c60>] dev_ifsioc+0x88/0x338
[17179671.192000] [<ffffffff802255d4>] compat_sys_ioctl+0x1a4/0x460
[17179671.196000] [<ffffffff80103a14>] handle_sys+0x114/0x130
[17179671.204000] 
[17179671.204000] ------------[ cut here ]------------
[17179671.208000] WARNING: at /home/tbm/kernel/linux-2.6-2.6.30~rc5/debian/build/source_mips_none/fs/sysfs/dir.c:487 sysfs_add_one+0xd4/0x158()
[17179671.220000] sysfs: cannot create duplicate filename '/class/mdio_bus/0'
[17179671.228000] Modules linked in:
[17179671.232000] Call Trace:
[17179671.236000] [<ffffffff801148f8>] dump_stack+0x8/0x38
[17179671.240000] [<ffffffff80142260>] warn_slowpath_fmt+0x98/0xc8
[17179671.244000] [<ffffffff802447fc>] sysfs_add_one+0xd4/0x158
[17179671.252000] [<ffffffff80245e00>] sysfs_do_create_link+0xd8/0x238
[17179671.256000] [<ffffffff8037a9c4>] device_add+0x41c/0x578
[17179671.264000] [<ffffffff803b3a40>] mdiobus_register+0xe0/0x1f8
[17179671.268000] [<ffffffff803b59b0>] sbmac_open+0x90/0x258
[17179671.272000] [<ffffffff803e3788>] dev_open+0xc0/0x130
[17179671.280000] [<ffffffff803e1be0>] dev_change_flags+0x158/0x1c8
[17179671.284000] [<ffffffff80440154>] devinet_ioctl+0x63c/0x7c8
[17179671.292000] [<ffffffff803cf6f4>] sock_ioctl+0x134/0x300
[17179671.296000] [<ffffffff801ed188>] vfs_ioctl+0x40/0xd0
[17179671.300000] [<ffffffff801ed4c0>] do_vfs_ioctl+0x2a8/0x640
[17179671.308000] [<ffffffff801ed908>] SyS_ioctl+0xb0/0xc8
[17179671.312000] [<ffffffff80225c60>] dev_ifsioc+0x88/0x338
[17179671.316000] [<ffffffff802255d4>] compat_sys_ioctl+0x1a4/0x460
[17179671.324000] [<ffffffff80103a14>] handle_sys+0x114/0x130
[17179671.328000] 
[17179671.332000] ---[ end trace 44fdd99f50e56b8d ]---
[17179671.348000] mii_bus 0 failed to register
[17179671.352000] eth0: unable to register MDIO bus
[17179672.468000] attempted to set irq affinity for irq 19 to multiple CPUs
[17179672.476000] kobject (a80000000fb0d880): tried to init an initialized object, something is seriously wrong.
[17179672.484000] Call Trace:
[17179672.488000] [<ffffffff801148f8>] dump_stack+0x8/0x38
[17179672.492000] [<ffffffff8031fe98>] kobject_init+0x70/0xc8
[17179672.496000] [<ffffffff8037a0dc>] device_initialize+0x2c/0x90
[17179672.504000] [<ffffffff8037ab34>] device_register+0x14/0x28
[17179672.508000] [<ffffffff803b3a40>] mdiobus_register+0xe0/0x1f8
[17179672.516000] [<ffffffff803b59b0>] sbmac_open+0x90/0x258
[17179672.520000] [<ffffffff803e3788>] dev_open+0xc0/0x130
[17179672.524000] [<ffffffff803e1be0>] dev_change_flags+0x158/0x1c8
[17179672.532000] [<ffffffff80440154>] devinet_ioctl+0x63c/0x7c8
[17179672.536000] [<ffffffff803cf6f4>] sock_ioctl+0x134/0x300
[17179672.544000] [<ffffffff801ed188>] vfs_ioctl+0x40/0xd0
[17179672.548000] [<ffffffff801ed4c0>] do_vfs_ioctl+0x2a8/0x640
[17179672.552000] [<ffffffff801ed908>] SyS_ioctl+0xb0/0xc8
[17179672.560000] [<ffffffff80225c60>] dev_ifsioc+0x88/0x338
[17179672.564000] [<ffffffff802255d4>] compat_sys_ioctl+0x1a4/0x460
[17179672.568000] [<ffffffff80103a14>] handle_sys+0x114/0x130
[17179672.576000] 
[17179672.576000] ------------[ cut here ]------------
[17179672.580000] WARNING: at /home/tbm/kernel/linux-2.6-2.6.30~rc5/debian/build/source_mips_none/fs/sysfs/dir.c:487 sysfs_add_one+0xd4/0x158()
[17179672.592000] sysfs: cannot create duplicate filename '/class/mdio_bus/0'
[17179672.600000] Modules linked in:
[17179672.604000] Call Trace:
[17179672.608000] [<ffffffff801148f8>] dump_stack+0x8/0x38
[17179672.612000] [<ffffffff80142260>] warn_slowpath_fmt+0x98/0xc8
[17179672.616000] [<ffffffff802447fc>] sysfs_add_one+0xd4/0x158
[17179672.624000] [<ffffffff80245e00>] sysfs_do_create_link+0xd8/0x238
[17179672.628000] [<ffffffff8037a9c4>] device_add+0x41c/0x578
[17179672.636000] [<ffffffff803b3a40>] mdiobus_register+0xe0/0x1f8
[17179672.640000] [<ffffffff803b59b0>] sbmac_open+0x90/0x258
[17179672.648000] [<ffffffff803e3788>] dev_open+0xc0/0x130
[17179672.652000] [<ffffffff803e1be0>] dev_change_flags+0x158/0x1c8
[17179672.656000] [<ffffffff80440154>] devinet_ioctl+0x63c/0x7c8
[17179672.664000] [<ffffffff803cf6f4>] sock_ioctl+0x134/0x300
[17179672.668000] [<ffffffff801ed188>] vfs_ioctl+0x40/0xd0
[17179672.672000] [<ffffffff801ed4c0>] do_vfs_ioctl+0x2a8/0x640
[17179672.680000] [<ffffffff801ed908>] SyS_ioctl+0xb0/0xc8
[17179672.684000] [<ffffffff80225c60>] dev_ifsioc+0x88/0x338
[17179672.688000] [<ffffffff802255d4>] compat_sys_ioctl+0x1a4/0x460
[17179672.696000] [<ffffffff80103a14>] handle_sys+0x114/0x130
[17179672.700000] 
[17179672.704000] ---[ end trace 44fdd99f50e56b8e ]---
[17179672.728000] mii_bus 0 failed to register
[17179672.732000] eth0: unable to register MDIO bus
mate:~# 
--z4+8/lEcDcG5Ke9S--
