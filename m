Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2009 21:23:07 +0100 (BST)
Received: from apfelkorn.psychaos.be ([195.144.77.38]:38194 "EHLO
	apfelkorn.psychaos.be" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024994AbZEMUXB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 May 2009 21:23:01 +0100
Received: from p2 by apfelkorn.psychaos.be with local (Exim 4.69)
	(envelope-from <p2@psychaos.be>)
	id 1M4Kyh-0001HH-8K; Wed, 13 May 2009 23:22:59 +0300
Date:	Wed, 13 May 2009 23:22:59 +0300
From:	Peter 'p2' De Schrijver <p2@debian.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: sb1250 ethernet driver problem
Message-ID: <20090513202259.GO1835@apfelkorn>
References: <20090513191557.GN1835@apfelkorn> <20090513192549.GS2999@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <20090513192549.GS2999@deprecation.cyrius.com>
X-Unexpected-Header: The spanish inquisition !
X-mate:	Mate, mann gewohnt sich an alles
X-Paddo: Munch, Munch
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <p2@psychaos.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p2@debian.org
Precedence: bulk
X-list: linux-mips


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2009-05-13 21:25:49 (+0200), Martin Michlmayr <tbm@cyrius.com> wrote:
> * Peter 'p2' De Schrijver <p2@debian.org> [2009-05-13 22:15]:
> > There seems to be a bug in the mdio part of the sb1250 ethernet
> > driver in 2.6.30-rc5. See attached log file.
> 
> I believe this is a generic problem with CONFIG_FIXED_PHY,
> see http://markmail.org/message/yhaorue23uuiqgal

Ok. Thanks. That seems to solve the problem. I still get other errors though.
None of them fatal however.

1) [17179589.164000] kobject (a80000000fa00c80): tried to init an initialized objec
t, something is seriously wrong
2) Various complaints about attempts to set irq affinity to multiple CPUs
(eg 'attempted to set irq affinity for irq 19 to multiple CPUs). This happens for 
irq 8,9 (which is unused ??), 19 and 20.

cat /proc/interrupts gives :

           CPU0       CPU1       
  2:       5750          0      SB1250-IMR  sb1250-counter-0
  3:          0       5610      SB1250-IMR  sb1250-counter-1
  8:      51816          0      SB1250-IMR  sb1250-duart
 19:        149          0      SB1250-IMR  eth0
 20:          0          0      SB1250-IMR  eth1
 58:       2417          0      SB1250-IMR  pata_sil680

ERR:          2

see kernel log in attachement.

Cheers,

Peter. 

--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="log-2.6.30-rc5-sb1-bcm91250a-net-2"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.30-rc5-sb1-bcm91250a (Debian 2.6.30~rc5-1~experimental.1) (maks@debian.org) (gcc version 4.1.3 20080420 (prerelease) (Debian 4.1.2-22)) #1 SMP Wed May 13 19:43:04 UTC 2009
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
[    0.000000] free_area_init_node: node 0, pgdat ffffffff805bb980, node_mem_map a800000001000000
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
[17179569.232000] Memory: 249540k/260380k available (3676k kernel code, 10680k reserved, 1201k data, 220k init, 0k highmem)
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
[17179569.632000] IP route cache hash table entries: 2048 (order: 2, 16384 bytes)
[17179569.640000] TCP established hash table entries: 8192 (order: 5, 131072 bytes)
[17179569.644000] TCP bind hash table entries: 8192 (order: 5, 131072 bytes)
[17179569.652000] TCP: Hash tables configured (established 8192 bind 8192)
[17179569.660000] TCP reno registered
[17179569.676000] NET: Registered protocol family 1
[17179569.680000] pata-swarm: PATA interface at GenBus slot 4
[17179569.684000] audit: initializing netlink socket (disabled)
[17179569.692000] type=2000 audit(1242161022.508:1): initialized
[17179569.696000] VFS: Disk quotas dquot_6.5.2
[17179569.700000] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[17179569.708000] msgmni has been set to 487
[17179569.712000] alg: No test for stdrng (krng)
[17179569.720000] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[17179569.724000] io scheduler noop registered
[17179569.728000] io scheduler anticipatory registered
[17179569.736000] io scheduler deadline registered
[17179569.740000] io scheduler cfq registered (default)
[17179569.756000] duart0 at MMIO 0x10060100 (irq = 8) is a SB1250 DUART
[17179569.760000] duart1 at MMIO 0x10060200 (irq = 9) is a SB1250 DUART
[17179569.772000] brd: module loaded
[17179569.776000] Driver 'sd' needs updating - please use bus_type methods
[17179569.784000] pata_sil680 0000:03:0a.0: version 0.4.9
[17179569.784000] sil680: 133MHz clock.
[17179569.788000] attempted to set irq affinity for irq 58 to multiple CPUs
[17179569.792000] scsi0 : pata_sil680
[17179569.796000] scsi1 : pata_sil680
[17179569.800000] ata1: PATA max UDMA/133 cmd 0x8098 ctl 0x80a0 bmdma 0x8080 irq 58
[17179569.808000] ata2: PATA max UDMA/133 cmd 0x8090 ctl 0x80a4 bmdma 0x8088 irq 58
[17179569.816000] eth0 (sb1250-mac): not using net_device_ops yet
[17179569.824000] sb1250-mac.0: registered as eth0
[17179569.828000] eth0: enabling TCP rcv checksum
[17179569.832000] eth0: SiByte Ethernet at 0x10064000, address: 00:02:4c:fe:0d:72
[17179569.840000] eth1 (sb1250-mac): not using net_device_ops yet
[17179569.844000] sb1250-mac.1: registered as eth1
[17179569.852000] eth1: enabling TCP rcv checksum
[17179569.856000] eth1: SiByte Ethernet at 0x10065000, address: 00:02:4c:fe:0d:73
[17179569.864000] mice: PS/2 mouse device common for all mice
[17179569.868000] TCP cubic registered
[17179569.872000] NET: Registered protocol family 17
[17179569.876000] RPC: Registered udp transport module.
[17179569.884000] RPC: Registered tcp transport module.
[17179569.888000] registered taskstats version 1
[17179569.892000] /home/tbm/kernel/linux-2.6-2.6.30~rc5/debian/build/source_mips_none/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[17179570.144000] ata2.00: ATA-6: WDC WD2000JB-00GVA0, 08.02D08, max UDMA/100
[17179570.152000] ata2.00: 390721968 sectors, multi 0: LBA48 
[17179570.172000] ata2.00: configured for UDMA/100
[17179570.176000] scsi 1:0:0:0: Direct-Access     ATA      WDC WD2000JB-00G 08.0 PQ: 0 ANSI: 5
[17179570.184000] sd 1:0:0:0: [sda] 390721968 512-byte hardware sectors: (200 GB/186 GiB)
[17179570.192000] sd 1:0:0:0: [sda] Write Protect is off
[17179570.196000] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[17179570.196000] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[17179570.208000]  sda: sda1 sda2 sda3 sda4
[17179570.224000] sd 1:0:0:0: [sda] Attached SCSI disk
[17179570.232000] kjournald starting.  Commit interval 5 seconds
[17179570.232000] EXT3-fs: mounted filesystem with writeback data mode.
[17179570.232000] VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
[17179570.232000] Freeing unused kernel memory: 220k freed
[17179570.256000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179570.480000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179570.496000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179570.512000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179570.524000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179570.544000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179571.688000] Adding 506036k swap on /dev/sda2.  Priority:-1 extents:1 across:506036k 
[17179571.896000] EXT3 FS on sda1, internal journal
[17179572.940000] kjournald starting.  Commit interval 5 seconds
[17179572.940000] EXT3 FS on sda3, internal journal
[17179572.940000] EXT3-fs: mounted filesystem with writeback data mode.
[17179572.972000] kjournald starting.  Commit interval 5 seconds
[17179572.972000] EXT3 FS on sda4, internal journal
[17179572.972000] EXT3-fs: mounted filesystem with writeback data mode.
[17179587.940000] attempted to set irq affinity for irq 19 to multiple CPUs
[17179587.976000] sb1250-mac-mdio: probed
[17179587.980000] eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=0:01, irq=-1)
[17179589.156000] attempted to set irq affinity for irq 19 to multiple CPUs
[17179589.164000] kobject (a80000000fa00c80): tried to init an initialized object, something is seriously wrong.
[17179589.172000] Call Trace:
[17179589.176000] [<ffffffff801148f8>] dump_stack+0x8/0x38
[17179589.180000] [<ffffffff8031fe98>] kobject_init+0x70/0xc8
[17179589.188000] [<ffffffff8037a0dc>] device_initialize+0x2c/0x90
[17179589.192000] [<ffffffff8037ab34>] device_register+0x14/0x28
[17179589.196000] [<ffffffff803b3a40>] mdiobus_register+0xe0/0x1f8
[17179589.204000] [<ffffffff803b5540>] sbmac_open+0x90/0x258
[17179589.208000] [<ffffffff803e3318>] dev_open+0xc0/0x130
[17179589.216000] [<ffffffff803e1770>] dev_change_flags+0x158/0x1c8
[17179589.220000] [<ffffffff8043fce4>] devinet_ioctl+0x63c/0x7c8
[17179589.224000] [<ffffffff803cf284>] sock_ioctl+0x134/0x300
[17179589.232000] [<ffffffff801ed188>] vfs_ioctl+0x40/0xd0
[17179589.236000] [<ffffffff801ed4c0>] do_vfs_ioctl+0x2a8/0x640
[17179589.240000] [<ffffffff801ed908>] SyS_ioctl+0xb0/0xc8
[17179589.248000] [<ffffffff80225c60>] dev_ifsioc+0x88/0x338
[17179589.252000] [<ffffffff802255d4>] compat_sys_ioctl+0x1a4/0x460
[17179589.260000] [<ffffffff80103a14>] handle_sys+0x114/0x130
[17179589.264000] 
[17179589.288000] sb1250-mac-mdio: probed
[17179589.292000] eth0: attached PHY driver [Generic PHY] (mii_bus:phy_addr=0:01, irq=-1)
[17179591.292000] eth0: link available: 100base-FD
[17179591.664000] attempted to set irq affinity for irq 20 to multiple CPUs
[17179591.680000] sb1250-mac-mdio: probed
[17179591.680000] eth1: attached PHY driver [Generic PHY] (mii_bus:phy_addr=1:01, irq=-1)
[17179593.536000] attempted to set irq affinity for irq 9 to multiple CPUs
[17179593.548000] attempted to set irq affinity for irq 9 to multiple CPUs
[17179594.592000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179594.604000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179594.616000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179594.628000] attempted to set irq affinity for irq 8 to multiple CPUs
[17179599.548000] warning: `ntpd' uses 32-bit capabilities (legacy support in use)
[17179603.112000] attempted to set irq affinity for irq 8 to multiple CPUs

--T7mxYSe680VjQnyC--
