Return-Path: <SRS0=bwn4=QC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B35C282C7
	for <linux-mips@archiver.kernel.org>; Sat, 26 Jan 2019 18:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC53F2184B
	for <linux-mips@archiver.kernel.org>; Sat, 26 Jan 2019 18:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfAZSoK (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 26 Jan 2019 13:44:10 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:59196 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfAZSoK (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 26 Jan 2019 13:44:10 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-101-7-nat.elisa-mobile.fi [85.76.101.7])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id C6057400ED;
        Sat, 26 Jan 2019 20:43:51 +0200 (EET)
Date:   Sat, 26 Jan 2019 20:43:51 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-mips@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org
Subject: Re: Loongson 2F IDE/ATA broken with lemote2f_defconfig
Message-ID: <20190126184351.GE2792@darkstar.musicnaut.iki.fi>
References: <20190106124607.GK27785@darkstar.musicnaut.iki.fi>
 <CGME20190112152659epcas5p3953165de5118dba017c94b164dd725a2@epcas5p3.samsung.com>
 <20190112152609.GE22416@darkstar.musicnaut.iki.fi>
 <08c48218-2bc5-a100-4b01-edb08b4225c4@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08c48218-2bc5-a100-4b01-edb08b4225c4@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

On Mon, Jan 14, 2019 at 02:16:42PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On 01/12/2019 04:26 PM, Aaro Koskinen wrote:
> > Hi,
> > 
> > On Sun, Jan 06, 2019 at 02:46:07PM +0200, Aaro Koskinen wrote:
> >> Commit 7ff7a5b1bfff ("MIPS: lemote2f_defconfig: Convert to use libata
> >> PATA drivers") switched from IDE to libata PATA on Loongson 2F, but
> >> neither PATA_AMD or PATA_CS5536 work well on this platform compared
> >> to the AMD74XX IDE driver.
> 
> Sorry about that.
> 
> >> During the ATA init/probe there is interrupt storm from irq 14, and
> >> majority of system boots end up with "nobody cared... IRQ disabled".
> >> So the result is a very slow disk access.
> >>
> >> It seems that the interrupt gets crazy after the port freeze done early
> >> during the init, and for whatever reason it cannot be cleared.
> >>
> >> With the below workaround I was able to boot the system normally. I
> >> guess that rather than going back to old IDE driver, we should just try
> >> to make pata_cs5536 work (and forget PATA AMD on this board)...?
> > 
> > Hmm, even with this hack I get ~500 spurious IRQs during the boot.
> > 
> > Also compared to old IDE, there's 33 vs 100 speed difference:
> > 
> > [    3.324000] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x4ce0 irq 14
> > [    3.584000] ata1.00: ATA-8: WDC WD1600BEVS-00VAT0, 11.01A11, max UDMA/133
> > [    3.588000] ata1.00: 312581808 sectors, multi 16: LBA48
> > [    3.592000] ata1.00: limited to UDMA/33 due to 40-wire cable
> > 
> > [    4.540000] Probing IDE interface ide0...
> > [    4.992000] hda: WDC WD1600BEVS-00VAT0, ATA DISK drive
> > [    5.716000] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
> > [    5.716000] hda: UDMA/100 mode selected
> 
> Can you try booting with "libata.force=1:80c" (and if that doesn't work with
> "libata.force=1:short40c")

(Sorry for delay, this machine is in use so I couldn't reboot it randomly...)

OK, the speed issue can be fixed with command line. So "libata.force=1:80c"
works with cs5536 libata driver.

> and also provide full dmesg-s for working (ide) and not working
> (libata) kernels.

Logs are below:

1) working IDE (no spurious IRQs)
2) working PATA AMD (around ~90k spurious IRQs, so it's just a matter of luck)
3) failing PATA AMD (100k spurious IRQs reached)
4) working PATA CS5536 (same as with PATA AMD)
5) failing PATA CS5536 (same as with PATA AMD)

-----

1) Working IDE with amd74xx.

[    0.000000] Linux version 4.20.0-lemote-los_919f1 (aaro@amd-fx-6350) (gcc version 7.4.0 (GCC)) #1 Sat Jan 26 17:11:52 EET 2019
[    0.000000] memsize=256, highmemsize=256
[    0.000000] CpuClock = 797780000
[    0.000000] printk: bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 00006303 (ICT Loongson-2)
[    0.000000] FPU revision is: 00000501
[    0.000000] Checking for the multiply/shift bug... no.
[    0.000000] Checking for the daddiu bug... no.
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 0000000010000000 @ 0000000000000000 (usable)
[    0.000000]  memory: 0000000030000000 @ 0000000010000000 (reserved)
[    0.000000]  memory: 0000000010000000 @ 0000000090000000 (usable)
[    0.000000]  memory: 0000000010000000 @ 0000000080000000 (reserved)
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Primary instruction cache 64kB, VIPT, direct mapped, linesize 32 bytes.
[    0.000000] Primary data cache 64kB, 4-way, VIPT, no aliases, linesize 32 bytes
[    0.000000] Unified secondary cache 512kB 4-way, linesize 32 bytes.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000009fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000009fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000009fffffff]
[    0.000000] On node 0 totalpages: 98304
[    0.000000]   Normal zone: 336 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 98304 pages, LIFO batch:15
[    0.000000] random: get_random_bytes called from start_kernel+0xa0/0x580 with crng_init=0
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 97968
[    0.000000] Kernel command line: console=tty console=ttyS0,115200
[    0.000000] Dentry cache hash table entries: 262144 (order: 7, 2097152 bytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 6, 1048576 bytes)
[    0.000000] Memory: 491728K/1572864K available (4731K kernel code, 475K rwdata, 856K rodata, 2048K init, 16616K bss, 1081136K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS: 128
[    0.000000] Console: colour dummy device 80x25
[    0.000000] printk: console [tty0] enabled
[    0.000000] sched_clock: 64 bits at 250 Hz, resolution 4000000ns, wraps every 9007199254000000ns
[    0.004000] Calibrating delay loop... 528.38 BogoMIPS (lpj=1056768)
[    0.040000] pid_max: default: 32768 minimum: 301
[    0.044000] Mount-cache hash table entries: 4096 (order: 1, 32768 bytes)
[    0.048000] Mountpoint-cache hash table entries: 4096 (order: 1, 32768 bytes)
[    0.052000] Checking for the daddi bug... no.
[    0.060000] devtmpfs: initialized
[    0.064000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.068000] futex hash table entries: 256 (order: -2, 6144 bytes)
[    0.072000] NET: Registered protocol family 16
[    0.076000] clocksource: mfgpt: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133486551712 ns
[    0.120000] SCSI subsystem initialized
[    0.124000] usbcore: registered new interface driver usbfs
[    0.128000] usbcore: registered new interface driver hub
[    0.132000] usbcore: registered new device driver usb
[    0.140000] PCI host bridge to bus 0000:00
[    0.144000] pci_bus 0000:00: root bus resource [mem 0x40000000-0x7fffffff]
[    0.148000] pci_bus 0000:00: root bus resource [io  0x4000-0xffff]
[    0.152000] pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0x0]
[    0.156000] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.160000] pci 0000:00:06.0: [10ec:8169] type 00 class 0x020000
[    0.160000] pci 0000:00:06.0: reg 0x10: [io  0xb100-0xb1ff]
[    0.160000] pci 0000:00:06.0: reg 0x14: [mem 0x04075000-0x040750ff]
[    0.160000] pci 0000:00:06.0: reg 0x30: [mem 0x04040000-0x0405ffff pref]
[    0.160000] pci 0000:00:06.0: supports D1 D2
[    0.160000] pci 0000:00:06.0: PME# supported from D1 D2 D3hot
[    0.160000] pci 0000:00:08.0: [1039:0325] type 00 class 0x030000
[    0.160000] pci 0000:00:08.0: reg 0x10: [mem 0x40000000-0x4fffffff pref]
[    0.160000] pci 0000:00:08.0: reg 0x14: [mem 0x04000000-0x0403ffff]
[    0.160000] pci 0000:00:08.0: reg 0x18: [io  0xb300-0xb37f]
[    0.160000] pci 0000:00:08.0: reg 0x30: [mem 0x04060000-0x0406ffff pref]
[    0.160000] pci 0000:00:08.0: supports D1 D2
[    0.160000] pci 0000:00:0e.0: [1022:2090] type 00 class 0x060100
[    0.160000] pci 0000:00:0e.0: reg 0x10: [io  0xb410-0xb417]
[    0.160000] pci 0000:00:0e.0: reg 0x14: [io  0xb000-0xb0ff]
[    0.160000] pci 0000:00:0e.0: reg 0x18: [io  0xb380-0xb3bf]
[    0.160000] pci 0000:00:0e.0: reg 0x20: [io  0xb280-0xb2ff]
[    0.160000] pci 0000:00:0e.0: reg 0x24: [io  0xb3c0-0xb3df]
[    0.160000] pci 0000:00:0e.2: [1022:209a] type 00 class 0x010180
[    0.160000] pci 0000:00:0e.2: reg 0x20: [io  0xb400-0xb40f]
[    0.160000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.164000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.168000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.172000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.176000] pci 0000:00:0e.3: [1022:2093] type 00 class 0x040100
[    0.176000] pci 0000:00:0e.3: reg 0x10: [io  0xb200-0xb27f]
[    0.176000] pci 0000:00:0e.4: [1022:2094] type 00 class 0x0c0310
[    0.176000] pci 0000:00:0e.4: reg 0x10: [mem 0x04074000-0x04074fff]
[    0.180000] pci 0000:00:0e.5: [1022:2095] type 00 class 0x0c0320
[    0.180000] pci 0000:00:0e.5: reg 0x10: [mem 0x04073000-0x04073fff]
[    0.180000] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    0.180000] pci 0000:00:08.0: BAR 0: assigned [mem 0x40000000-0x4fffffff pref]
[    0.184000] pci 0000:00:08.0: BAR 1: assigned [mem 0x50000000-0x5003ffff]
[    0.188000] pci 0000:00:06.0: BAR 6: assigned [mem 0x50040000-0x5005ffff pref]
[    0.192000] pci 0000:00:08.0: BAR 6: assigned [mem 0x50060000-0x5006ffff pref]
[    0.196000] pci 0000:00:0e.4: BAR 0: assigned [mem 0x50070000-0x50070fff]
[    0.200000] pci 0000:00:0e.5: BAR 0: assigned [mem 0x50071000-0x50071fff]
[    0.204000] pci 0000:00:06.0: BAR 0: assigned [io  0x4000-0x40ff]
[    0.208000] pci 0000:00:06.0: BAR 1: assigned [mem 0x50072000-0x500720ff]
[    0.212000] pci 0000:00:0e.0: BAR 1: assigned [io  0x4400-0x44ff]
[    0.216000] pci 0000:00:08.0: BAR 2: assigned [io  0x4800-0x487f]
[    0.220000] pci 0000:00:0e.0: BAR 4: assigned [io  0x4880-0x48ff]
[    0.224000] pci 0000:00:0e.3: BAR 0: assigned [io  0x4c00-0x4c7f]
[    0.228000] pci 0000:00:0e.0: BAR 2: assigned [io  0x4c80-0x4cbf]
[    0.232000] pci 0000:00:0e.0: BAR 5: assigned [io  0x4cc0-0x4cdf]
[    0.236000] pci 0000:00:0e.2: BAR 4: assigned [io  0x4ce0-0x4cef]
[    0.240000] pci 0000:00:0e.0: BAR 0: assigned [io  0x4cf0-0x4cf7]
[    0.248000] clocksource: Switched to clocksource mfgpt
[    0.276000] NET: Registered protocol family 2
[    0.280000] tcp_listen_portaddr_hash hash table entries: 1024 (order: 0, 16384 bytes)
[    0.284000] TCP established hash table entries: 16384 (order: 3, 131072 bytes)
[    0.288000] TCP bind hash table entries: 16384 (order: 3, 131072 bytes)
[    0.292000] TCP: Hash tables configured (established 16384 bind 16384)
[    0.296000] UDP hash table entries: 1024 (order: 1, 32768 bytes)
[    0.300000] UDP-Lite hash table entries: 1024 (order: 1, 32768 bytes)
[    0.304000] NET: Registered protocol family 1
[    0.308000] pci 0000:00:0e.4: enabling device (0000 -> 0002)
[    0.312000] PCI: CLS 32 bytes, default 32
[    0.892000] random: fast init done
[    1.740000] workingset: timestamp_bits=62 max_order=15 bucket_order=0
[    2.172000] NET: Registered protocol family 38
[    2.176000] io scheduler noop registered
[    2.180000] io scheduler cfq registered (default)
[    2.184000] slot: 8, pin: 1, irq: 38
[    2.188000] sisfb 0000:00:08.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x3030
[    2.192000] sisfb: Video ROM not found
[    2.196000] sisfb: Video RAM at 0x40000000, mapped to 0x9000000040000000, size 32768k
[    2.200000] sisfb: MMIO at 0x50000000, mapped to 0x9000000050000000, size 256k
[    2.204000] sisfb: Memory heap starting at 32160K, size 32K
[    3.492000] sisfb: Detected SiS301C video bridge
[    3.576000] sisfb: Detected 1280x1024 flat panel
[    3.656000] sisfb: CRT2 DDC supported
[    3.660000] sisfb: CRT2 DDC level: 2 
[    3.868000] sisfb: Monitor range H 30-81KHz, V 56-76Hz, Max. dotclock 140MHz
[    3.872000] sisfb: Default mode is 1280x1024x8 (60Hz)
[    3.876000] sisfb: Initial vbflags 0x10000022
[    3.948000] Console: switching to colour frame buffer device 160x64
[    4.004000] sisfb: 2D acceleration is enabled, y-panning enabled (auto-max)
[    4.008000] fb0: SiS 315PRO frame buffer device version 1.8.9
[    4.012000] sisfb: Copyright (C) 2001-2005 Thomas Winischhofer
[    4.068000] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    4.212000] printk: console [ttyS0] disabled
[    4.220000] serial8250.0: ttyS0 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    4.224000] printk: console [ttyS0] enabled
[    4.228000] printk: bootconsole [early0] disabled
[    4.848000] brd: module loaded
[    5.000000] loop: module loaded
[    5.000000] Uniform Multi-Platform E-IDE driver
[    5.004000] amd74xx 0000:00:0e.2: UDMA100 controller
[    5.008000] amd74xx 0000:00:0e.2: IDE controller (0x1022:0x209a rev 0x01)
[    5.012000] amd74xx 0000:00:0e.2: IDE port disabled
[    5.016000] amd74xx 0000:00:0e.2: not 100% native mode: will probe irqs later
[    5.020000]     ide0: BM-DMA at 0x4ce0-0x4ce7
[    5.024000] Probing IDE interface ide0...
[    5.412000] hda: WDC WD1600BEVS-00VAT0, ATA DISK drive
[    6.136000] hda: host max PIO5 wanted PIO255(auto-tune) selected PIO4
[    6.136000] hda: UDMA/100 mode selected
[    6.140000] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[    6.144000] ide-gd driver 1.18
[    6.148000] hda: max request size: 1024KiB
[    6.228000] hda: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63
[    6.232000] hda: cache flushes supported
[    6.252000]  hda: hda1
[    6.256000] slot: 6, pin: 1, irq: 36
[    6.260000] r8169 0000:00:06.0: not PCI Express
[    6.264000] libphy: r8169: probed
[    6.268000] r8169 0000:00:06.0 eth0: RTL8169sc/8110sc, 00:23:9e:00:0f:54, XID 98000000, IRQ 36
[    6.272000] r8169 0000:00:06.0 eth0: jumbo features [frames: 7152 bytes, tx checksumming: ok]
[    6.276000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    6.280000] ehci-pci: EHCI PCI platform driver
[    6.284000] ehci-pci 0000:00:0e.5: EHCI Host Controller
[    6.288000] ehci-pci 0000:00:0e.5: new USB bus registered, assigned bus number 1
[    6.292000] ehci-pci 0000:00:0e.5: irq 11, io mem 0x50071000
[    6.432000] ehci-pci 0000:00:0e.5: USB 0.0 started, EHCI 1.00
[    6.436000] hub 1-0:1.0: USB hub found
[    6.448000] hub 1-0:1.0: 4 ports detected
[    6.456000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    6.460000] ohci-pci: OHCI PCI platform driver
[    6.464000] ohci-pci 0000:00:0e.4: OHCI PCI host controller
[    6.468000] ohci-pci 0000:00:0e.4: new USB bus registered, assigned bus number 2
[    6.472000] ohci-pci 0000:00:0e.4: irq 11, io mem 0x50070000
[    6.568000] hub 2-0:1.0: USB hub found
[    6.580000] hub 2-0:1.0: 4 ports detected
[    6.588000] usbcore: registered new interface driver usb-storage
[    6.592000] loongson2_cpufreq: Loongson-2F CPU frequency driver
[    6.596000] usbcore: registered new interface driver usbhid
[    6.600000] usbhid: USB HID core driver
[    6.608000] NET: Registered protocol family 17
[    6.680000] Freeing unused kernel memory: 2048K
[    6.684000] This architecture does not have kernel memory protection.
[    6.688000] Run /init as init process
[   10.872000] EXT4-fs (hda1): mounting ext3 file system using the ext4 subsystem
[   10.940000] EXT4-fs (hda1): mounted filesystem with ordered data mode. Opts: (null)
[   11.984000] random: crng init done
[   13.752000] Adding 524256k swap on /SWAP.  Priority:-2 extents:13 across:145760016k 
[   13.868000] RTL8211B Gigabit Ethernet r8169-30:00: attached PHY driver [RTL8211B Gigabit Ethernet] (mii_bus:phy_addr=r8169-30:00, irq=IGNORE)
[   16.604000] r8169 0000:00:06.0 eth0: Link is Up - 1Gbps/Full - flow control rx/tx

-----

2) Working PATA AMD.

[    0.000000] Linux version 4.20.0-lemote-los_42599 (aaro@amd-fx-6350) (gcc version 7.4.0 (GCC)) #1 Sat Jan 26 19:29:46 EET 2019
[    0.000000] memsize=256, highmemsize=256
[    0.000000] CpuClock = 797800000
[    0.000000] printk: bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 00006303 (ICT Loongson-2)
[    0.000000] FPU revision is: 00000501
[    0.000000] Checking for the multiply/shift bug... no.
[    0.000000] Checking for the daddiu bug... no.
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 0000000010000000 @ 0000000000000000 (usable)
[    0.000000]  memory: 0000000030000000 @ 0000000010000000 (reserved)
[    0.000000]  memory: 0000000010000000 @ 0000000090000000 (usable)
[    0.000000]  memory: 0000000010000000 @ 0000000080000000 (reserved)
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Primary instruction cache 64kB, VIPT, direct mapped, linesize 32 bytes.
[    0.000000] Primary data cache 64kB, 4-way, VIPT, no aliases, linesize 32 bytes
[    0.000000] Unified secondary cache 512kB 4-way, linesize 32 bytes.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000009fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000009fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000009fffffff]
[    0.000000] On node 0 totalpages: 98304
[    0.000000]   Normal zone: 336 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 98304 pages, LIFO batch:15
[    0.000000] random: get_random_bytes called from start_kernel+0xa0/0x580 with crng_init=0
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 97968
[    0.000000] Kernel command line: console=tty console=ttyS0,115200
[    0.000000] Dentry cache hash table entries: 262144 (order: 7, 2097152 bytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 6, 1048576 bytes)
[    0.000000] Memory: 491728K/1572864K available (4784K kernel code, 465K rwdata, 876K rodata, 2048K init, 16620K bss, 1081136K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS: 128
[    0.000000] Console: colour dummy device 80x25
[    0.000000] printk: console [tty0] enabled
[    0.000000] sched_clock: 64 bits at 250 Hz, resolution 4000000ns, wraps every 9007199254000000ns
[    0.004000] Calibrating delay loop... 528.38 BogoMIPS (lpj=1056768)
[    0.040000] pid_max: default: 32768 minimum: 301
[    0.044000] Mount-cache hash table entries: 4096 (order: 1, 32768 bytes)
[    0.048000] Mountpoint-cache hash table entries: 4096 (order: 1, 32768 bytes)
[    0.052000] Checking for the daddi bug... no.
[    0.060000] devtmpfs: initialized
[    0.064000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.068000] futex hash table entries: 256 (order: -2, 6144 bytes)
[    0.072000] NET: Registered protocol family 16
[    0.076000] clocksource: mfgpt: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133486551712 ns
[    0.124000] SCSI subsystem initialized
[    0.128000] libata version 3.00 loaded.
[    0.128000] usbcore: registered new interface driver usbfs
[    0.132000] usbcore: registered new interface driver hub
[    0.136000] usbcore: registered new device driver usb
[    0.144000] PCI host bridge to bus 0000:00
[    0.148000] pci_bus 0000:00: root bus resource [mem 0x40000000-0x7fffffff]
[    0.152000] pci_bus 0000:00: root bus resource [io  0x4000-0xffff]
[    0.156000] pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0x0]
[    0.160000] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.164000] pci 0000:00:06.0: [10ec:8169] type 00 class 0x020000
[    0.164000] pci 0000:00:06.0: reg 0x10: [io  0xb100-0xb1ff]
[    0.164000] pci 0000:00:06.0: reg 0x14: [mem 0x04075000-0x040750ff]
[    0.164000] pci 0000:00:06.0: reg 0x30: [mem 0x04040000-0x0405ffff pref]
[    0.164000] pci 0000:00:06.0: supports D1 D2
[    0.164000] pci 0000:00:06.0: PME# supported from D1 D2 D3hot
[    0.164000] pci 0000:00:08.0: [1039:0325] type 00 class 0x030000
[    0.164000] pci 0000:00:08.0: reg 0x10: [mem 0x40000000-0x4fffffff pref]
[    0.164000] pci 0000:00:08.0: reg 0x14: [mem 0x04000000-0x0403ffff]
[    0.164000] pci 0000:00:08.0: reg 0x18: [io  0xb300-0xb37f]
[    0.164000] pci 0000:00:08.0: reg 0x30: [mem 0x04060000-0x0406ffff pref]
[    0.164000] pci 0000:00:08.0: supports D1 D2
[    0.164000] pci 0000:00:0e.0: [1022:2090] type 00 class 0x060100
[    0.164000] pci 0000:00:0e.0: reg 0x10: [io  0xb410-0xb417]
[    0.164000] pci 0000:00:0e.0: reg 0x14: [io  0xb000-0xb0ff]
[    0.164000] pci 0000:00:0e.0: reg 0x18: [io  0xb380-0xb3bf]
[    0.164000] pci 0000:00:0e.0: reg 0x20: [io  0xb280-0xb2ff]
[    0.164000] pci 0000:00:0e.0: reg 0x24: [io  0xb3c0-0xb3df]
[    0.164000] pci 0000:00:0e.2: [1022:209a] type 00 class 0x010180
[    0.164000] pci 0000:00:0e.2: reg 0x20: [io  0xb400-0xb40f]
[    0.164000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.168000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.172000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.176000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.180000] pci 0000:00:0e.3: [1022:2093] type 00 class 0x040100
[    0.180000] pci 0000:00:0e.3: reg 0x10: [io  0xb200-0xb27f]
[    0.180000] pci 0000:00:0e.4: [1022:2094] type 00 class 0x0c0310
[    0.180000] pci 0000:00:0e.4: reg 0x10: [mem 0x04074000-0x04074fff]
[    0.180000] pci 0000:00:0e.5: [1022:2095] type 00 class 0x0c0320
[    0.180000] pci 0000:00:0e.5: reg 0x10: [mem 0x04073000-0x04073fff]
[    0.180000] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    0.180000] pci 0000:00:08.0: BAR 0: assigned [mem 0x40000000-0x4fffffff pref]
[    0.184000] pci 0000:00:08.0: BAR 1: assigned [mem 0x50000000-0x5003ffff]
[    0.188000] pci 0000:00:06.0: BAR 6: assigned [mem 0x50040000-0x5005ffff pref]
[    0.192000] pci 0000:00:08.0: BAR 6: assigned [mem 0x50060000-0x5006ffff pref]
[    0.196000] pci 0000:00:0e.4: BAR 0: assigned [mem 0x50070000-0x50070fff]
[    0.200000] pci 0000:00:0e.5: BAR 0: assigned [mem 0x50071000-0x50071fff]
[    0.204000] pci 0000:00:06.0: BAR 0: assigned [io  0x4000-0x40ff]
[    0.208000] pci 0000:00:06.0: BAR 1: assigned [mem 0x50072000-0x500720ff]
[    0.212000] pci 0000:00:0e.0: BAR 1: assigned [io  0x4400-0x44ff]
[    0.216000] pci 0000:00:08.0: BAR 2: assigned [io  0x4800-0x487f]
[    0.220000] pci 0000:00:0e.0: BAR 4: assigned [io  0x4880-0x48ff]
[    0.224000] pci 0000:00:0e.3: BAR 0: assigned [io  0x4c00-0x4c7f]
[    0.228000] pci 0000:00:0e.0: BAR 2: assigned [io  0x4c80-0x4cbf]
[    0.232000] pci 0000:00:0e.0: BAR 5: assigned [io  0x4cc0-0x4cdf]
[    0.236000] pci 0000:00:0e.2: BAR 4: assigned [io  0x4ce0-0x4cef]
[    0.240000] pci 0000:00:0e.0: BAR 0: assigned [io  0x4cf0-0x4cf7]
[    0.244000] clocksource: Switched to clocksource mfgpt
[    0.268000] NET: Registered protocol family 2
[    0.276000] tcp_listen_portaddr_hash hash table entries: 1024 (order: 0, 16384 bytes)
[    0.284000] TCP established hash table entries: 16384 (order: 3, 131072 bytes)
[    0.288000] TCP bind hash table entries: 16384 (order: 3, 131072 bytes)
[    0.292000] TCP: Hash tables configured (established 16384 bind 16384)
[    0.296000] UDP hash table entries: 1024 (order: 1, 32768 bytes)
[    0.300000] UDP-Lite hash table entries: 1024 (order: 1, 32768 bytes)
[    0.304000] NET: Registered protocol family 1
[    0.308000] pci 0000:00:0e.4: enabling device (0000 -> 0002)
[    0.312000] PCI: CLS 32 bytes, default 32
[    0.892000] random: fast init done
[    1.736000] workingset: timestamp_bits=62 max_order=15 bucket_order=0
[    2.164000] NET: Registered protocol family 38
[    2.168000] io scheduler noop registered
[    2.172000] io scheduler cfq registered (default)
[    2.176000] slot: 8, pin: 1, irq: 38
[    2.180000] sisfb 0000:00:08.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x3030
[    2.184000] sisfb: Video ROM not found
[    2.188000] sisfb: Video RAM at 0x40000000, mapped to 0x9000000040000000, size 32768k
[    2.192000] sisfb: MMIO at 0x50000000, mapped to 0x9000000050000000, size 256k
[    2.196000] sisfb: Memory heap starting at 32160K, size 32K
[    3.488000] sisfb: Detected SiS301C video bridge
[    3.572000] sisfb: Detected 1280x1024 flat panel
[    3.652000] sisfb: CRT1 DDC probing failed
[    3.656000] sisfb: Default mode is 1280x1024x8 (60Hz)
[    3.660000] sisfb: Initial vbflags 0x10000022
[    3.732000] Console: switching to colour frame buffer device 160x64
[    3.788000] sisfb: 2D acceleration is enabled, y-panning enabled (auto-max)
[    3.792000] fb0: SiS 315PRO frame buffer device version 1.8.9
[    3.796000] sisfb: Copyright (C) 2001-2005 Thomas Winischhofer
[    3.808000] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.956000] printk: console [ttyS0] disabled
[    3.964000] serial8250.0: ttyS0 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    3.968000] printk: console [ttyS0] enabled
[    3.972000] printk: bootconsole [early0] disabled
[    4.692000] brd: module loaded
[    4.792000] loop: module loaded
[    4.796000] pata_amd 0000:00:0e.2: version 0.4.1
[    4.912000] random: crng init done
[    5.148000] scsi host0: pata_amd
[    5.384000] scsi host1: pata_amd
[    5.392000] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x4ce0 irq 14
[    5.396000] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x4ce8 irq 15
[    5.404000] slot: 6, pin: 1, irq: 36
[    5.408000] r8169 0000:00:06.0: not PCI Express
[    5.416000] libphy: r8169: probed
[    5.428000] r8169 0000:00:06.0 eth0: RTL8169sc/8110sc, 00:23:9e:00:0f:54, XID 98000000, IRQ 36
[    5.432000] r8169 0000:00:06.0 eth0: jumbo features [frames: 7152 bytes, tx checksumming: ok]
[    5.440000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.444000] ehci-pci: EHCI PCI platform driver
[    5.452000] ehci-pci 0000:00:0e.5: EHCI Host Controller
[    5.456000] ehci-pci 0000:00:0e.5: new USB bus registered, assigned bus number 1
[    5.464000] ehci-pci 0000:00:0e.5: irq 11, io mem 0x50071000
[    5.676000] ata1.00: ATA-8: WDC WD1600BEVS-00VAT0, 11.01A11, max UDMA/133
[    5.680000] ata1.00: 312581808 sectors, multi 16: LBA48 
[    5.808000] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600BEVS-0 1A11 PQ: 0 ANSI: 5
[    5.816000] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    5.820000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    5.828000] ata2: port disabled--ignoring
[    5.852000] sd 0:0:0:0: [sda] Write Protect is off
[    5.856000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.880000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.900000] ehci-pci 0000:00:0e.5: USB 0.0 started, EHCI 1.00
[    5.904000]  sda: sda1
[    5.908000] hub 1-0:1.0: USB hub found
[    5.932000] hub 1-0:1.0: 4 ports detected
[    5.936000] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.952000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    5.956000] ohci-pci: OHCI PCI platform driver
[    5.960000] ohci-pci 0000:00:0e.4: OHCI PCI host controller
[    5.964000] ohci-pci 0000:00:0e.4: new USB bus registered, assigned bus number 2
[    5.968000] ohci-pci 0000:00:0e.4: irq 11, io mem 0x50070000
[    6.064000] hub 2-0:1.0: USB hub found
[    6.076000] hub 2-0:1.0: 4 ports detected
[    6.084000] usbcore: registered new interface driver usb-storage
[    6.088000] loongson2_cpufreq: Loongson-2F CPU frequency driver
[    6.092000] usbcore: registered new interface driver usbhid
[    6.096000] usbhid: USB HID core driver
[    6.100000] NET: Registered protocol family 17
[    6.172000] Freeing unused kernel memory: 2048K
[    6.176000] This architecture does not have kernel memory protection.
[    6.180000] Run /init as init process
[   10.396000] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[   10.452000] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[   13.004000] Adding 524256k swap on /SWAP.  Priority:-2 extents:13 across:145760016k 
[   13.304000] RTL8211B Gigabit Ethernet r8169-30:00: attached PHY driver [RTL8211B Gigabit Ethernet] (mii_bus:phy_addr=r8169-30:00, irq=IGNORE)
[   15.812000] r8169 0000:00:06.0 eth0: Link is Up - 1Gbps/Full - flow control rx/tx

-----

3) Failing PATA AMD.

[    0.000000] Linux version 4.20.0-lemote-los_42599 (aaro@amd-fx-6350) (gcc version 7.4.0 (GCC)) #1 Sat Jan 26 19:29:46 EET 2019
[    0.000000] memsize=256, highmemsize=256
[    0.000000] CpuClock = 797800000
[    0.000000] printk: bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 00006303 (ICT Loongson-2)
[    0.000000] FPU revision is: 00000501
[    0.000000] Checking for the multiply/shift bug... no.
[    0.000000] Checking for the daddiu bug... no.
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 0000000010000000 @ 0000000000000000 (usable)
[    0.000000]  memory: 0000000030000000 @ 0000000010000000 (reserved)
[    0.000000]  memory: 0000000010000000 @ 0000000090000000 (usable)
[    0.000000]  memory: 0000000010000000 @ 0000000080000000 (reserved)
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Primary instruction cache 64kB, VIPT, direct mapped, linesize 32 bytes.
[    0.000000] Primary data cache 64kB, 4-way, VIPT, no aliases, linesize 32 bytes
[    0.000000] Unified secondary cache 512kB 4-way, linesize 32 bytes.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000009fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000009fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000009fffffff]
[    0.000000] On node 0 totalpages: 98304
[    0.000000]   Normal zone: 336 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 98304 pages, LIFO batch:15
[    0.000000] random: get_random_bytes called from start_kernel+0xa0/0x580 with crng_init=0
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 97968
[    0.000000] Kernel command line: console=tty console=ttyS0,115200
[    0.000000] Dentry cache hash table entries: 262144 (order: 7, 2097152 bytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 6, 1048576 bytes)
[    0.000000] Memory: 491728K/1572864K available (4784K kernel code, 465K rwdata, 876K rodata, 2048K init, 16620K bss, 1081136K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS: 128
[    0.000000] Console: colour dummy device 80x25
[    0.000000] printk: console [tty0] enabled
[    0.000000] sched_clock: 64 bits at 250 Hz, resolution 4000000ns, wraps every 9007199254000000ns
[    0.004000] Calibrating delay loop... 528.38 BogoMIPS (lpj=1056768)
[    0.040000] pid_max: default: 32768 minimum: 301
[    0.044000] Mount-cache hash table entries: 4096 (order: 1, 32768 bytes)
[    0.048000] Mountpoint-cache hash table entries: 4096 (order: 1, 32768 bytes)
[    0.052000] Checking for the daddi bug... no.
[    0.060000] devtmpfs: initialized
[    0.064000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.068000] futex hash table entries: 256 (order: -2, 6144 bytes)
[    0.072000] NET: Registered protocol family 16
[    0.076000] clocksource: mfgpt: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133486551712 ns
[    0.124000] SCSI subsystem initialized
[    0.128000] libata version 3.00 loaded.
[    0.128000] usbcore: registered new interface driver usbfs
[    0.132000] usbcore: registered new interface driver hub
[    0.136000] usbcore: registered new device driver usb
[    0.144000] PCI host bridge to bus 0000:00
[    0.148000] pci_bus 0000:00: root bus resource [mem 0x40000000-0x7fffffff]
[    0.152000] pci_bus 0000:00: root bus resource [io  0x4000-0xffff]
[    0.156000] pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0x0]
[    0.160000] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.164000] pci 0000:00:06.0: [10ec:8169] type 00 class 0x020000
[    0.164000] pci 0000:00:06.0: reg 0x10: [io  0xb100-0xb1ff]
[    0.164000] pci 0000:00:06.0: reg 0x14: [mem 0x04075000-0x040750ff]
[    0.164000] pci 0000:00:06.0: reg 0x30: [mem 0x04040000-0x0405ffff pref]
[    0.164000] pci 0000:00:06.0: supports D1 D2
[    0.164000] pci 0000:00:06.0: PME# supported from D1 D2 D3hot
[    0.164000] pci 0000:00:08.0: [1039:0325] type 00 class 0x030000
[    0.164000] pci 0000:00:08.0: reg 0x10: [mem 0x40000000-0x4fffffff pref]
[    0.164000] pci 0000:00:08.0: reg 0x14: [mem 0x04000000-0x0403ffff]
[    0.164000] pci 0000:00:08.0: reg 0x18: [io  0xb300-0xb37f]
[    0.164000] pci 0000:00:08.0: reg 0x30: [mem 0x04060000-0x0406ffff pref]
[    0.164000] pci 0000:00:08.0: supports D1 D2
[    0.164000] pci 0000:00:0e.0: [1022:2090] type 00 class 0x060100
[    0.164000] pci 0000:00:0e.0: reg 0x10: [io  0xb410-0xb417]
[    0.164000] pci 0000:00:0e.0: reg 0x14: [io  0xb000-0xb0ff]
[    0.164000] pci 0000:00:0e.0: reg 0x18: [io  0xb380-0xb3bf]
[    0.164000] pci 0000:00:0e.0: reg 0x20: [io  0xb280-0xb2ff]
[    0.164000] pci 0000:00:0e.0: reg 0x24: [io  0xb3c0-0xb3df]
[    0.164000] pci 0000:00:0e.2: [1022:209a] type 00 class 0x010180
[    0.164000] pci 0000:00:0e.2: reg 0x20: [io  0xb400-0xb40f]
[    0.164000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.168000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.172000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.176000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.180000] pci 0000:00:0e.3: [1022:2093] type 00 class 0x040100
[    0.180000] pci 0000:00:0e.3: reg 0x10: [io  0xb200-0xb27f]
[    0.180000] pci 0000:00:0e.4: [1022:2094] type 00 class 0x0c0310
[    0.180000] pci 0000:00:0e.4: reg 0x10: [mem 0x04074000-0x04074fff]
[    0.180000] pci 0000:00:0e.5: [1022:2095] type 00 class 0x0c0320
[    0.180000] pci 0000:00:0e.5: reg 0x10: [mem 0x04073000-0x04073fff]
[    0.180000] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    0.180000] pci 0000:00:08.0: BAR 0: assigned [mem 0x40000000-0x4fffffff pref]
[    0.184000] pci 0000:00:08.0: BAR 1: assigned [mem 0x50000000-0x5003ffff]
[    0.188000] pci 0000:00:06.0: BAR 6: assigned [mem 0x50040000-0x5005ffff pref]
[    0.192000] pci 0000:00:08.0: BAR 6: assigned [mem 0x50060000-0x5006ffff pref]
[    0.196000] pci 0000:00:0e.4: BAR 0: assigned [mem 0x50070000-0x50070fff]
[    0.200000] pci 0000:00:0e.5: BAR 0: assigned [mem 0x50071000-0x50071fff]
[    0.204000] pci 0000:00:06.0: BAR 0: assigned [io  0x4000-0x40ff]
[    0.208000] pci 0000:00:06.0: BAR 1: assigned [mem 0x50072000-0x500720ff]
[    0.212000] pci 0000:00:0e.0: BAR 1: assigned [io  0x4400-0x44ff]
[    0.216000] pci 0000:00:08.0: BAR 2: assigned [io  0x4800-0x487f]
[    0.220000] pci 0000:00:0e.0: BAR 4: assigned [io  0x4880-0x48ff]
[    0.224000] pci 0000:00:0e.3: BAR 0: assigned [io  0x4c00-0x4c7f]
[    0.228000] pci 0000:00:0e.0: BAR 2: assigned [io  0x4c80-0x4cbf]
[    0.232000] pci 0000:00:0e.0: BAR 5: assigned [io  0x4cc0-0x4cdf]
[    0.236000] pci 0000:00:0e.2: BAR 4: assigned [io  0x4ce0-0x4cef]
[    0.240000] pci 0000:00:0e.0: BAR 0: assigned [io  0x4cf0-0x4cf7]
[    0.244000] clocksource: Switched to clocksource mfgpt
[    0.272000] NET: Registered protocol family 2
[    0.276000] tcp_listen_portaddr_hash hash table entries: 1024 (order: 0, 16384 bytes)
[    0.280000] TCP established hash table entries: 16384 (order: 3, 131072 bytes)
[    0.284000] TCP bind hash table entries: 16384 (order: 3, 131072 bytes)
[    0.288000] TCP: Hash tables configured (established 16384 bind 16384)
[    0.292000] UDP hash table entries: 1024 (order: 1, 32768 bytes)
[    0.296000] UDP-Lite hash table entries: 1024 (order: 1, 32768 bytes)
[    0.300000] NET: Registered protocol family 1
[    0.304000] pci 0000:00:0e.4: enabling device (0000 -> 0002)
[    0.308000] PCI: CLS 32 bytes, default 32
[    0.892000] random: fast init done
[    1.736000] workingset: timestamp_bits=62 max_order=15 bucket_order=0
[    2.168000] NET: Registered protocol family 38
[    2.172000] io scheduler noop registered
[    2.176000] io scheduler cfq registered (default)
[    2.180000] slot: 8, pin: 1, irq: 38
[    2.184000] sisfb 0000:00:08.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x3030
[    2.188000] sisfb: Video ROM not found
[    2.192000] sisfb: Video RAM at 0x40000000, mapped to 0x9000000040000000, size 32768k
[    2.196000] sisfb: MMIO at 0x50000000, mapped to 0x9000000050000000, size 256k
[    2.200000] sisfb: Memory heap starting at 32160K, size 32K
[    3.488000] sisfb: Detected SiS301C video bridge
[    3.572000] sisfb: Detected 1280x1024 flat panel
[    3.652000] sisfb: CRT1 DDC probing failed
[    3.656000] sisfb: Default mode is 1280x1024x8 (60Hz)
[    3.660000] sisfb: Initial vbflags 0x10000022
[    3.736000] Console: switching to colour frame buffer device 160x64
[    3.796000] sisfb: 2D acceleration is enabled, y-panning enabled (auto-max)
[    3.800000] fb0: SiS 315PRO frame buffer device version 1.8.9
[    3.804000] sisfb: Copyright (C) 2001-2005 Thomas Winischhofer
[    3.812000] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.960000] printk: console [ttyS0] disabled
[    3.968000] serial8250.0: ttyS0 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    3.972000] printk: console [ttyS0] enabled
[    3.976000] printk: bootconsole [early0] disabled
[    4.628000] brd: module loaded
[    4.740000] loop: module loaded
[    4.744000] pata_amd 0000:00:0e.2: version 0.4.1
[    4.860000] random: crng init done
[    5.320000] scsi host0: pata_amd
[    5.608000] scsi host1: pata_amd
[    5.612000] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x4ce0 irq 14
[    5.616000] ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x4ce8 irq 15
[    5.624000] slot: 6, pin: 1, irq: 36
[    5.628000] r8169 0000:00:06.0: not PCI Express
[    5.636000] libphy: r8169: probed
[    5.648000] r8169 0000:00:06.0 eth0: RTL8169sc/8110sc, 00:23:9e:00:0f:54, XID 98000000, IRQ 36
[    5.652000] r8169 0000:00:06.0 eth0: jumbo features [frames: 7152 bytes, tx checksumming: ok]
[    5.656000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.660000] ehci-pci: EHCI PCI platform driver
[    5.664000] ehci-pci 0000:00:0e.5: EHCI Host Controller
[    5.668000] ehci-pci 0000:00:0e.5: new USB bus registered, assigned bus number 1
[    5.676000] ehci-pci 0000:00:0e.5: irq 11, io mem 0x50071000
[    5.736000] irq 14: nobody cared (try booting with the "irqpoll" option)
[    5.736000] CPU: 0 PID: 551 Comm: block_add.sh Not tainted 4.20.0-lemote-los_42599 #1
[    5.736000] Stack : 00000000000000a3 00000000000000a4 ffffffffcfffffff 980000009f023d78
[    5.736000]         82327644e4724700 0000000000000000 0000000000000000 ffffffff81a40000
[    5.736000]         00000000000000a4 0000000000000007 0000000000000000 ffffffff806d7388
[    5.736000]         0000000000000000 0000000000000004 0000000000000002 980000009fb533d0
[    5.736000]         9000000040121b08 ffffffff80790000 ffffff0000000000 000000000000000e
[    5.736000]         0000000077b3f306 0000000077b2f930 0000000077b41aac 0000000000000000
[    5.736000]         0000000000000003 ffffffffffffffff 9000000040121b0c 0000000000000000
[    5.736000]         ffffffff80a10000 980000009f490000 980000009f023d70 000000007fc763f0
[    5.736000]         ffffffff80262a38 0000000000000000 0000000000000000 0000000000000000
[    5.736000]         0000000000000000 82327644e4724700 ffffffff8020f504 82327644e4724700
[    5.736000]         ...
[    5.736000] Call Trace:
[    5.736000] [<ffffffff8020f504>] show_stack+0x90/0x140
[    5.736000] [<ffffffff80262a38>] __report_bad_irq+0x44/0xf4
[    5.736000] [<ffffffff80262ddc>] note_interrupt+0x274/0x318
[    5.736000] [<ffffffff8025fec4>] handle_irq_event_percpu+0x60/0x9c
[    5.736000] [<ffffffff8025ff3c>] handle_irq_event+0x3c/0x70
[    5.736000] [<ffffffff80263f78>] handle_level_irq+0x10c/0x148
[    5.736000] [<ffffffff8025f498>] generic_handle_irq+0x34/0x50
[    5.736000] [<ffffffff806aa298>] do_IRQ+0x18/0x24
[    5.736000] [<ffffffff80208ec4>] handle_int+0x17c/0x188
[    5.736000] handlers:
[    5.736000] [<0000000059069b40>] ata_bmdma_interrupt
[    5.736000] Disabling IRQ #14
[    5.944000] ata1.00: ATA-8: WDC WD1600BEVS-00VAT0, 11.01A11, max UDMA/133
[    5.948000] ata1.00: 312581808 sectors, multi 16: LBA48 
[    5.980000] ehci-pci 0000:00:0e.5: USB 0.0 started, EHCI 1.00
[    5.984000] hub 1-0:1.0: USB hub found
[    5.996000] hub 1-0:1.0: 4 ports detected
[    6.004000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    6.008000] ohci-pci: OHCI PCI platform driver
[    6.012000] ohci-pci 0000:00:0e.4: OHCI PCI host controller
[    6.016000] ohci-pci 0000:00:0e.4: new USB bus registered, assigned bus number 2
[    6.020000] ohci-pci 0000:00:0e.4: irq 11, io mem 0x50070000
[    6.048000] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600BEVS-0 1A11 PQ: 0 ANSI: 5
[    6.052000] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    6.056000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    6.060000] ata2: port disabled--ignoring
[    6.076000] sd 0:0:0:0: [sda] Write Protect is off
[    6.080000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.092000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.136000] hub 2-0:1.0: USB hub found
[    6.148000] hub 2-0:1.0: 4 ports detected
[    6.152000] usbcore: registered new interface driver usb-storage
[    6.156000] loongson2_cpufreq: Loongson-2F CPU frequency driver
[    6.160000] usbcore: registered new interface driver usbhid
[    6.164000] usbhid: USB HID core driver
[    6.172000] NET: Registered protocol family 17
[    6.360000]  sda: sda1
[    6.376000] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.388000] Freeing unused kernel memory: 2048K
[    6.392000] This architecture does not have kernel memory protection.
[    6.396000] Run /init as init process
[   36.728000] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[   37.876000] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[   65.500000] RTL8211B Gigabit Ethernet r8169-30:00: attached PHY driver [RTL8211B Gigabit Ethernet] (mii_bus:phy_addr=r8169-30:00, irq=IGNORE)
[   69.920000] r8169 0000:00:06.0 eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[   76.456000] Adding 524256k swap on /SWAP.  Priority:-2 extents:13 across:145760016k 

4) Working PATA CS5536.

[    0.000000] Linux version 4.20.0-lemote-los_42599+ (aaro@amd-fx-6350) (gcc version 7.4.0 (GCC)) #1 Sat Jan 26 19:42:09 EET 2019
[    0.000000] memsize=256, highmemsize=256
[    0.000000] CpuClock = 797780000
[    0.000000] printk: bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 00006303 (ICT Loongson-2)
[    0.000000] FPU revision is: 00000501
[    0.000000] Checking for the multiply/shift bug... no.
[    0.000000] Checking for the daddiu bug... no.
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 0000000010000000 @ 0000000000000000 (usable)
[    0.000000]  memory: 0000000030000000 @ 0000000010000000 (reserved)
[    0.000000]  memory: 0000000010000000 @ 0000000090000000 (usable)
[    0.000000]  memory: 0000000010000000 @ 0000000080000000 (reserved)
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Primary instruction cache 64kB, VIPT, direct mapped, linesize 32 bytes.
[    0.000000] Primary data cache 64kB, 4-way, VIPT, no aliases, linesize 32 bytes
[    0.000000] Unified secondary cache 512kB 4-way, linesize 32 bytes.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000009fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000009fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000009fffffff]
[    0.000000] On node 0 totalpages: 98304
[    0.000000]   Normal zone: 336 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 98304 pages, LIFO batch:15
[    0.000000] random: get_random_bytes called from start_kernel+0xa0/0x580 with crng_init=0
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 97968
[    0.000000] Kernel command line: console=tty console=ttyS0,115200
[    0.000000] Dentry cache hash table entries: 262144 (order: 7, 2097152 bytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 6, 1048576 bytes)
[    0.000000] Memory: 491728K/1572864K available (4782K kernel code, 471K rwdata, 872K rodata, 2048K init, 16620K bss, 1081136K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS: 128
[    0.000000] Console: colour dummy device 80x25
[    0.000000] printk: console [tty0] enabled
[    0.000000] sched_clock: 64 bits at 250 Hz, resolution 4000000ns, wraps every 9007199254000000ns
[    0.004000] Calibrating delay loop... 528.38 BogoMIPS (lpj=1056768)
[    0.040000] pid_max: default: 32768 minimum: 301
[    0.044000] Mount-cache hash table entries: 4096 (order: 1, 32768 bytes)
[    0.048000] Mountpoint-cache hash table entries: 4096 (order: 1, 32768 bytes)
[    0.052000] Checking for the daddi bug... no.
[    0.060000] devtmpfs: initialized
[    0.064000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.068000] futex hash table entries: 256 (order: -2, 6144 bytes)
[    0.072000] NET: Registered protocol family 16
[    0.076000] clocksource: mfgpt: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133486551712 ns
[    0.124000] SCSI subsystem initialized
[    0.128000] libata version 3.00 loaded.
[    0.128000] usbcore: registered new interface driver usbfs
[    0.132000] usbcore: registered new interface driver hub
[    0.136000] usbcore: registered new device driver usb
[    0.140000] PCI host bridge to bus 0000:00
[    0.144000] pci_bus 0000:00: root bus resource [mem 0x40000000-0x7fffffff]
[    0.148000] pci_bus 0000:00: root bus resource [io  0x4000-0xffff]
[    0.152000] pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0x0]
[    0.156000] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.160000] pci 0000:00:06.0: [10ec:8169] type 00 class 0x020000
[    0.160000] pci 0000:00:06.0: reg 0x10: [io  0xb100-0xb1ff]
[    0.160000] pci 0000:00:06.0: reg 0x14: [mem 0x04075000-0x040750ff]
[    0.160000] pci 0000:00:06.0: reg 0x30: [mem 0x04040000-0x0405ffff pref]
[    0.164000] pci 0000:00:06.0: supports D1 D2
[    0.164000] pci 0000:00:06.0: PME# supported from D1 D2 D3hot
[    0.164000] pci 0000:00:08.0: [1039:0325] type 00 class 0x030000
[    0.164000] pci 0000:00:08.0: reg 0x10: [mem 0x40000000-0x4fffffff pref]
[    0.164000] pci 0000:00:08.0: reg 0x14: [mem 0x04000000-0x0403ffff]
[    0.164000] pci 0000:00:08.0: reg 0x18: [io  0xb300-0xb37f]
[    0.164000] pci 0000:00:08.0: reg 0x30: [mem 0x04060000-0x0406ffff pref]
[    0.164000] pci 0000:00:08.0: supports D1 D2
[    0.164000] pci 0000:00:0e.0: [1022:2090] type 00 class 0x060100
[    0.164000] pci 0000:00:0e.0: reg 0x10: [io  0xb410-0xb417]
[    0.164000] pci 0000:00:0e.0: reg 0x14: [io  0xb000-0xb0ff]
[    0.164000] pci 0000:00:0e.0: reg 0x18: [io  0xb380-0xb3bf]
[    0.164000] pci 0000:00:0e.0: reg 0x20: [io  0xb280-0xb2ff]
[    0.164000] pci 0000:00:0e.0: reg 0x24: [io  0xb3c0-0xb3df]
[    0.164000] pci 0000:00:0e.2: [1022:209a] type 00 class 0x010180
[    0.164000] pci 0000:00:0e.2: reg 0x20: [io  0xb400-0xb40f]
[    0.164000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.168000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.172000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.176000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.180000] pci 0000:00:0e.3: [1022:2093] type 00 class 0x040100
[    0.180000] pci 0000:00:0e.3: reg 0x10: [io  0xb200-0xb27f]
[    0.180000] pci 0000:00:0e.4: [1022:2094] type 00 class 0x0c0310
[    0.180000] pci 0000:00:0e.4: reg 0x10: [mem 0x04074000-0x04074fff]
[    0.180000] pci 0000:00:0e.5: [1022:2095] type 00 class 0x0c0320
[    0.180000] pci 0000:00:0e.5: reg 0x10: [mem 0x04073000-0x04073fff]
[    0.180000] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    0.180000] pci 0000:00:08.0: BAR 0: assigned [mem 0x40000000-0x4fffffff pref]
[    0.184000] pci 0000:00:08.0: BAR 1: assigned [mem 0x50000000-0x5003ffff]
[    0.188000] pci 0000:00:06.0: BAR 6: assigned [mem 0x50040000-0x5005ffff pref]
[    0.192000] pci 0000:00:08.0: BAR 6: assigned [mem 0x50060000-0x5006ffff pref]
[    0.196000] pci 0000:00:0e.4: BAR 0: assigned [mem 0x50070000-0x50070fff]
[    0.200000] pci 0000:00:0e.5: BAR 0: assigned [mem 0x50071000-0x50071fff]
[    0.204000] pci 0000:00:06.0: BAR 0: assigned [io  0x4000-0x40ff]
[    0.208000] pci 0000:00:06.0: BAR 1: assigned [mem 0x50072000-0x500720ff]
[    0.212000] pci 0000:00:0e.0: BAR 1: assigned [io  0x4400-0x44ff]
[    0.216000] pci 0000:00:08.0: BAR 2: assigned [io  0x4800-0x487f]
[    0.220000] pci 0000:00:0e.0: BAR 4: assigned [io  0x4880-0x48ff]
[    0.224000] pci 0000:00:0e.3: BAR 0: assigned [io  0x4c00-0x4c7f]
[    0.228000] pci 0000:00:0e.0: BAR 2: assigned [io  0x4c80-0x4cbf]
[    0.232000] pci 0000:00:0e.0: BAR 5: assigned [io  0x4cc0-0x4cdf]
[    0.236000] pci 0000:00:0e.2: BAR 4: assigned [io  0x4ce0-0x4cef]
[    0.240000] pci 0000:00:0e.0: BAR 0: assigned [io  0x4cf0-0x4cf7]
[    0.244000] clocksource: Switched to clocksource mfgpt
[    0.272000] NET: Registered protocol family 2
[    0.276000] tcp_listen_portaddr_hash hash table entries: 1024 (order: 0, 16384 bytes)
[    0.280000] TCP established hash table entries: 16384 (order: 3, 131072 bytes)
[    0.288000] TCP bind hash table entries: 16384 (order: 3, 131072 bytes)
[    0.292000] TCP: Hash tables configured (established 16384 bind 16384)
[    0.296000] UDP hash table entries: 1024 (order: 1, 32768 bytes)
[    0.300000] UDP-Lite hash table entries: 1024 (order: 1, 32768 bytes)
[    0.304000] NET: Registered protocol family 1
[    0.308000] pci 0000:00:0e.4: enabling device (0000 -> 0002)
[    0.312000] PCI: CLS 32 bytes, default 32
[    0.896000] random: fast init done
[    1.724000] workingset: timestamp_bits=62 max_order=15 bucket_order=0
[    2.164000] NET: Registered protocol family 38
[    2.168000] io scheduler noop registered
[    2.172000] io scheduler cfq registered (default)
[    2.180000] slot: 8, pin: 1, irq: 38
[    2.184000] sisfb 0000:00:08.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x3030
[    2.188000] sisfb: Video ROM not found
[    2.192000] sisfb: Video RAM at 0x40000000, mapped to 0x9000000040000000, size 32768k
[    2.196000] sisfb: MMIO at 0x50000000, mapped to 0x9000000050000000, size 256k
[    2.200000] sisfb: Memory heap starting at 32160K, size 32K
[    3.484000] sisfb: Detected SiS301C video bridge
[    3.564000] sisfb: Detected 1280x1024 flat panel
[    3.648000] sisfb: CRT1 DDC probing failed
[    3.652000] sisfb: Default mode is 1280x1024x8 (60Hz)
[    3.656000] sisfb: Initial vbflags 0x10000022
[    3.728000] Console: switching to colour frame buffer device 160x64
[    3.784000] sisfb: 2D acceleration is enabled, y-panning enabled (auto-max)
[    3.788000] fb0: SiS 315PRO frame buffer device version 1.8.9
[    3.792000] sisfb: Copyright (C) 2001-2005 Thomas Winischhofer
[    3.808000] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    3.952000] printk: console [ttyS0] disabled
[    3.960000] serial8250.0: ttyS0 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    3.964000] printk: console [ttyS0] enabled
[    3.968000] printk: bootconsole [early0] disabled
[    4.592000] brd: module loaded
[    4.764000] loop: module loaded
[    4.880000] random: crng init done
[    5.108000] scsi host0: pata_cs5536
[    5.444000] scsi host1: pata_cs5536
[    5.448000] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x4ce0 irq 14
[    5.452000] ata2: DUMMY
[    5.460000] slot: 6, pin: 1, irq: 36
[    5.464000] r8169 0000:00:06.0: not PCI Express
[    5.472000] libphy: r8169: probed
[    5.484000] r8169 0000:00:06.0 eth0: RTL8169sc/8110sc, 00:23:9e:00:0f:54, XID 98000000, IRQ 36
[    5.488000] r8169 0000:00:06.0 eth0: jumbo features [frames: 7152 bytes, tx checksumming: ok]
[    5.492000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.496000] ehci-pci: EHCI PCI platform driver
[    5.500000] ehci-pci 0000:00:0e.5: EHCI Host Controller
[    5.504000] ehci-pci 0000:00:0e.5: new USB bus registered, assigned bus number 1
[    5.512000] ehci-pci 0000:00:0e.5: irq 11, io mem 0x50071000
[    5.732000] ata1.00: ATA-8: WDC WD1600BEVS-00VAT0, 11.01A11, max UDMA/133
[    5.736000] ata1.00: 312581808 sectors, multi 16: LBA48 
[    5.740000] ata1.00: limited to UDMA/33 due to 40-wire cable
[    5.884000] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600BEVS-0 1A11 PQ: 0 ANSI: 5
[    5.888000] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    5.892000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    5.920000] sd 0:0:0:0: [sda] Write Protect is off
[    5.924000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.936000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.952000] ehci-pci 0000:00:0e.5: USB 0.0 started, EHCI 1.00
[    5.960000]  sda: sda1
[    5.964000] hub 1-0:1.0: USB hub found
[    5.988000] hub 1-0:1.0: 4 ports detected
[    5.992000] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.004000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    6.008000] ohci-pci: OHCI PCI platform driver
[    6.012000] ohci-pci 0000:00:0e.4: OHCI PCI host controller
[    6.016000] ohci-pci 0000:00:0e.4: new USB bus registered, assigned bus number 2
[    6.024000] ohci-pci 0000:00:0e.4: irq 11, io mem 0x50070000
[    6.120000] hub 2-0:1.0: USB hub found
[    6.132000] hub 2-0:1.0: 4 ports detected
[    6.140000] usbcore: registered new interface driver usb-storage
[    6.144000] loongson2_cpufreq: Loongson-2F CPU frequency driver
[    6.148000] usbcore: registered new interface driver usbhid
[    6.152000] usbhid: USB HID core driver
[    6.156000] NET: Registered protocol family 17
[    6.228000] Freeing unused kernel memory: 2048K
[    6.232000] This architecture does not have kernel memory protection.
[    6.236000] Run /init as init process
[   10.512000] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[   10.576000] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[   13.196000] Adding 524256k swap on /SWAP.  Priority:-2 extents:13 across:145760016k 
[   13.488000] RTL8211B Gigabit Ethernet r8169-30:00: attached PHY driver [RTL8211B Gigabit Ethernet] (mii_bus:phy_addr=r8169-30:00, irq=IGNORE)
[   16.260000] r8169 0000:00:06.0 eth0: Link is Up - 1Gbps/Full - flow control rx/tx

-----

5) Failing PATA CS5536.

[    0.000000] Linux version 4.20.0-lemote-los_42599+ (aaro@amd-fx-6350) (gcc version 7.4.0 (GCC)) #1 Sat Jan 26 19:42:09 EET 2019
[    0.000000] memsize=256, highmemsize=256
[    0.000000] CpuClock = 797800000
[    0.000000] printk: bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 00006303 (ICT Loongson-2)
[    0.000000] FPU revision is: 00000501
[    0.000000] Checking for the multiply/shift bug... no.
[    0.000000] Checking for the daddiu bug... no.
[    0.000000] Determined physical RAM map:
[    0.000000]  memory: 0000000010000000 @ 0000000000000000 (usable)
[    0.000000]  memory: 0000000030000000 @ 0000000010000000 (reserved)
[    0.000000]  memory: 0000000010000000 @ 0000000090000000 (usable)
[    0.000000]  memory: 0000000010000000 @ 0000000080000000 (reserved)
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Primary instruction cache 64kB, VIPT, direct mapped, linesize 32 bytes.
[    0.000000] Primary data cache 64kB, 4-way, VIPT, no aliases, linesize 32 bytes
[    0.000000] Unified secondary cache 512kB 4-way, linesize 32 bytes.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x000000009fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x000000003fffffff]
[    0.000000]   node   0: [mem 0x0000000080000000-0x000000009fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000009fffffff]
[    0.000000] On node 0 totalpages: 98304
[    0.000000]   Normal zone: 336 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 98304 pages, LIFO batch:15
[    0.000000] random: get_random_bytes called from start_kernel+0xa0/0x580 with crng_init=0
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 97968
[    0.000000] Kernel command line: console=tty console=ttyS0,115200
[    0.000000] Dentry cache hash table entries: 262144 (order: 7, 2097152 bytes)
[    0.000000] Inode-cache hash table entries: 131072 (order: 6, 1048576 bytes)
[    0.000000] Memory: 491728K/1572864K available (4782K kernel code, 471K rwdata, 872K rodata, 2048K init, 16620K bss, 1081136K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS: 128
[    0.000000] Console: colour dummy device 80x25
[    0.000000] printk: console [tty0] enabled
[    0.000000] sched_clock: 64 bits at 250 Hz, resolution 4000000ns, wraps every 9007199254000000ns
[    0.004000] Calibrating delay loop... 528.38 BogoMIPS (lpj=1056768)
[    0.040000] pid_max: default: 32768 minimum: 301
[    0.044000] Mount-cache hash table entries: 4096 (order: 1, 32768 bytes)
[    0.048000] Mountpoint-cache hash table entries: 4096 (order: 1, 32768 bytes)
[    0.052000] Checking for the daddi bug... no.
[    0.060000] devtmpfs: initialized
[    0.064000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.068000] futex hash table entries: 256 (order: -2, 6144 bytes)
[    0.072000] NET: Registered protocol family 16
[    0.076000] clocksource: mfgpt: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133486551712 ns
[    0.124000] SCSI subsystem initialized
[    0.128000] libata version 3.00 loaded.
[    0.128000] usbcore: registered new interface driver usbfs
[    0.132000] usbcore: registered new interface driver hub
[    0.136000] usbcore: registered new device driver usb
[    0.140000] PCI host bridge to bus 0000:00
[    0.144000] pci_bus 0000:00: root bus resource [mem 0x40000000-0x7fffffff]
[    0.148000] pci_bus 0000:00: root bus resource [io  0x4000-0xffff]
[    0.152000] pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0x0]
[    0.156000] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.160000] pci 0000:00:06.0: [10ec:8169] type 00 class 0x020000
[    0.160000] pci 0000:00:06.0: reg 0x10: [io  0xb100-0xb1ff]
[    0.160000] pci 0000:00:06.0: reg 0x14: [mem 0x04075000-0x040750ff]
[    0.160000] pci 0000:00:06.0: reg 0x30: [mem 0x04040000-0x0405ffff pref]
[    0.164000] pci 0000:00:06.0: supports D1 D2
[    0.164000] pci 0000:00:06.0: PME# supported from D1 D2 D3hot
[    0.164000] pci 0000:00:08.0: [1039:0325] type 00 class 0x030000
[    0.164000] pci 0000:00:08.0: reg 0x10: [mem 0x40000000-0x4fffffff pref]
[    0.164000] pci 0000:00:08.0: reg 0x14: [mem 0x04000000-0x0403ffff]
[    0.164000] pci 0000:00:08.0: reg 0x18: [io  0xb300-0xb37f]
[    0.164000] pci 0000:00:08.0: reg 0x30: [mem 0x04060000-0x0406ffff pref]
[    0.164000] pci 0000:00:08.0: supports D1 D2
[    0.164000] pci 0000:00:0e.0: [1022:2090] type 00 class 0x060100
[    0.164000] pci 0000:00:0e.0: reg 0x10: [io  0xb410-0xb417]
[    0.164000] pci 0000:00:0e.0: reg 0x14: [io  0xb000-0xb0ff]
[    0.164000] pci 0000:00:0e.0: reg 0x18: [io  0xb380-0xb3bf]
[    0.164000] pci 0000:00:0e.0: reg 0x20: [io  0xb280-0xb2ff]
[    0.164000] pci 0000:00:0e.0: reg 0x24: [io  0xb3c0-0xb3df]
[    0.164000] pci 0000:00:0e.2: [1022:209a] type 00 class 0x010180
[    0.164000] pci 0000:00:0e.2: reg 0x20: [io  0xb400-0xb40f]
[    0.164000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.168000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.172000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.176000] pci 0000:00:0e.2: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.180000] pci 0000:00:0e.3: [1022:2093] type 00 class 0x040100
[    0.180000] pci 0000:00:0e.3: reg 0x10: [io  0xb200-0xb27f]
[    0.180000] pci 0000:00:0e.4: [1022:2094] type 00 class 0x0c0310
[    0.180000] pci 0000:00:0e.4: reg 0x10: [mem 0x04074000-0x04074fff]
[    0.180000] pci 0000:00:0e.5: [1022:2095] type 00 class 0x0c0320
[    0.180000] pci 0000:00:0e.5: reg 0x10: [mem 0x04073000-0x04073fff]
[    0.180000] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    0.180000] pci 0000:00:08.0: BAR 0: assigned [mem 0x40000000-0x4fffffff pref]
[    0.184000] pci 0000:00:08.0: BAR 1: assigned [mem 0x50000000-0x5003ffff]
[    0.188000] pci 0000:00:06.0: BAR 6: assigned [mem 0x50040000-0x5005ffff pref]
[    0.192000] pci 0000:00:08.0: BAR 6: assigned [mem 0x50060000-0x5006ffff pref]
[    0.196000] pci 0000:00:0e.4: BAR 0: assigned [mem 0x50070000-0x50070fff]
[    0.200000] pci 0000:00:0e.5: BAR 0: assigned [mem 0x50071000-0x50071fff]
[    0.204000] pci 0000:00:06.0: BAR 0: assigned [io  0x4000-0x40ff]
[    0.208000] pci 0000:00:06.0: BAR 1: assigned [mem 0x50072000-0x500720ff]
[    0.212000] pci 0000:00:0e.0: BAR 1: assigned [io  0x4400-0x44ff]
[    0.216000] pci 0000:00:08.0: BAR 2: assigned [io  0x4800-0x487f]
[    0.220000] pci 0000:00:0e.0: BAR 4: assigned [io  0x4880-0x48ff]
[    0.224000] pci 0000:00:0e.3: BAR 0: assigned [io  0x4c00-0x4c7f]
[    0.228000] pci 0000:00:0e.0: BAR 2: assigned [io  0x4c80-0x4cbf]
[    0.232000] pci 0000:00:0e.0: BAR 5: assigned [io  0x4cc0-0x4cdf]
[    0.236000] pci 0000:00:0e.2: BAR 4: assigned [io  0x4ce0-0x4cef]
[    0.240000] pci 0000:00:0e.0: BAR 0: assigned [io  0x4cf0-0x4cf7]
[    0.244000] clocksource: Switched to clocksource mfgpt
[    0.272000] NET: Registered protocol family 2
[    0.276000] tcp_listen_portaddr_hash hash table entries: 1024 (order: 0, 16384 bytes)
[    0.280000] TCP established hash table entries: 16384 (order: 3, 131072 bytes)
[    0.284000] TCP bind hash table entries: 16384 (order: 3, 131072 bytes)
[    0.288000] TCP: Hash tables configured (established 16384 bind 16384)
[    0.292000] UDP hash table entries: 1024 (order: 1, 32768 bytes)
[    0.296000] UDP-Lite hash table entries: 1024 (order: 1, 32768 bytes)
[    0.300000] NET: Registered protocol family 1
[    0.304000] pci 0000:00:0e.4: enabling device (0000 -> 0002)
[    0.308000] PCI: CLS 32 bytes, default 32
[    0.896000] random: fast init done
[    1.732000] workingset: timestamp_bits=62 max_order=15 bucket_order=0
[    2.160000] NET: Registered protocol family 38
[    2.164000] io scheduler noop registered
[    2.168000] io scheduler cfq registered (default)
[    2.176000] slot: 8, pin: 1, irq: 38
[    2.176000] sisfb 0000:00:08.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x3030
[    2.180000] sisfb: Video ROM not found
[    2.184000] sisfb: Video RAM at 0x40000000, mapped to 0x9000000040000000, size 32768k
[    2.188000] sisfb: MMIO at 0x50000000, mapped to 0x9000000050000000, size 256k
[    2.192000] sisfb: Memory heap starting at 32160K, size 32K
[    3.472000] sisfb: Detected SiS301C video bridge
[    3.556000] sisfb: Detected 1280x1024 flat panel
[    3.636000] sisfb: CRT2 DDC supported
[    3.640000] sisfb: CRT2 DDC level: 2 
[    3.848000] sisfb: Monitor range H 30-81KHz, V 56-76Hz, Max. dotclock 140MHz
[    3.852000] sisfb: Default mode is 1280x1024x8 (60Hz)
[    3.856000] sisfb: Initial vbflags 0x10000022
[    3.928000] Console: switching to colour frame buffer device 160x64
[    3.984000] sisfb: 2D acceleration is enabled, y-panning enabled (auto-max)
[    3.988000] fb0: SiS 315PRO frame buffer device version 1.8.9
[    3.992000] sisfb: Copyright (C) 2001-2005 Thomas Winischhofer
[    4.048000] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    4.192000] printk: console [ttyS0] disabled
[    4.200000] serial8250.0: ttyS0 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
[    4.204000] printk: console [ttyS0] enabled
[    4.208000] printk: bootconsole [early0] disabled
[    4.820000] brd: module loaded
[    4.932000] loop: module loaded
[    5.052000] random: crng init done
[    5.372000] scsi host0: pata_cs5536
[    5.664000] scsi host1: pata_cs5536
[    5.672000] ata1: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0x4ce0 irq 14
[    5.680000] ata2: DUMMY
[    5.684000] slot: 6, pin: 1, irq: 36
[    5.688000] r8169 0000:00:06.0: not PCI Express
[    5.696000] libphy: r8169: probed
[    5.704000] r8169 0000:00:06.0 eth0: RTL8169sc/8110sc, 00:23:9e:00:0f:54, XID 98000000, IRQ 36
[    5.708000] r8169 0000:00:06.0 eth0: jumbo features [frames: 7152 bytes, tx checksumming: ok]
[    5.712000] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.716000] ehci-pci: EHCI PCI platform driver
[    5.720000] ehci-pci 0000:00:0e.5: EHCI Host Controller
[    5.724000] ehci-pci 0000:00:0e.5: new USB bus registered, assigned bus number 1
[    5.728000] ehci-pci 0000:00:0e.5: irq 11, io mem 0x50071000
[    5.920000] irq 14: nobody cared (try booting with the "irqpoll" option)
[    5.920000] CPU: 0 PID: 568 Comm: hotplug Not tainted 4.20.0-lemote-los_42599+ #1
[    5.920000] Stack : 00000000000000a4 00000000000000a5 ffffffffcfffffff 980000009f023d78
[    5.920000]         576a98c906c11500 0000000000000000 0000000000000000 ffffffff81a40000
[    5.920000]         00000000000000a5 0000000000000007 0000000000000000 ffffffff806d7388
[    5.920000]         0000000000000000 0000000000000004 0000000000000002 980000009fb42e50
[    5.920000]         9000000040121b08 ffffffff80790000 ffffff0000000000 000000000000000e
[    5.920000]         0000000000000003 0000000000000000 0000000000000000 0000000000000000
[    5.920000]         0000000000000000 ffffffffffffffff 9000000040121b0c 0000000000000000
[    5.920000]         ffffffff80a10000 980000009fc30000 980000009f023d70 0000000000000000
[    5.920000]         ffffffff80262a38 0000000000000000 0000000000000000 0000000000000000
[    5.920000]         0000000000000000 576a98c906c11500 ffffffff8020f504 576a98c906c11500
[    5.920000]         ...
[    5.920000] Call Trace:
[    5.920000] [<ffffffff8020f504>] show_stack+0x90/0x140
[    5.920000] [<ffffffff80262a38>] __report_bad_irq+0x44/0xf4
[    5.920000] [<ffffffff80262ddc>] note_interrupt+0x274/0x318
[    5.920000] [<ffffffff8025fec4>] handle_irq_event_percpu+0x60/0x9c
[    5.920000] [<ffffffff8025ff3c>] handle_irq_event+0x3c/0x70
[    5.920000] [<ffffffff80263f78>] handle_level_irq+0x10c/0x148
[    5.920000] [<ffffffff8025f498>] generic_handle_irq+0x34/0x50
[    5.920000] [<ffffffff806a9ab8>] do_IRQ+0x18/0x24
[    5.920000] [<ffffffff80208ec4>] handle_int+0x17c/0x188
[    5.920000] handlers:
[    5.920000] [<000000004cce36f4>] ata_bmdma_interrupt
[    5.920000] Disabling IRQ #14
[    6.144000] ehci-pci 0000:00:0e.5: USB 0.0 started, EHCI 1.00
[    6.148000] hub 1-0:1.0: USB hub found
[    6.160000] hub 1-0:1.0: 4 ports detected
[    6.168000] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    6.172000] ohci-pci: OHCI PCI platform driver
[    6.176000] ohci-pci 0000:00:0e.4: OHCI PCI host controller
[    6.180000] ohci-pci 0000:00:0e.4: new USB bus registered, assigned bus number 2
[    6.184000] ohci-pci 0000:00:0e.4: irq 11, io mem 0x50070000
[    6.280000] ata1.00: ATA-8: WDC WD1600BEVS-00VAT0, 11.01A11, max UDMA/133
[    6.284000] ata1.00: 312581808 sectors, multi 16: LBA48 
[    6.288000] ata1.00: limited to UDMA/33 due to 40-wire cable
[    6.292000] hub 2-0:1.0: USB hub found
[    6.304000] hub 2-0:1.0: 4 ports detected
[    6.312000] usbcore: registered new interface driver usb-storage
[    6.316000] loongson2_cpufreq: Loongson-2F CPU frequency driver
[    6.320000] usbcore: registered new interface driver usbhid
[    6.324000] usbhid: USB HID core driver
[    6.328000] NET: Registered protocol family 17
[    6.356000] scsi 0:0:0:0: Direct-Access     ATA      WDC WD1600BEVS-0 1A11 PQ: 0 ANSI: 5
[    6.404000] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    6.432000] sd 0:0:0:0: [sda] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    6.444000] sd 0:0:0:0: [sda] Write Protect is off
[    6.448000] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.448000] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.668000]  sda: sda1
[    6.676000] sd 0:0:0:0: [sda] Attached SCSI disk
[    6.688000] Freeing unused kernel memory: 2048K
[    6.692000] This architecture does not have kernel memory protection.
[    6.696000] Run /init as init process
[   37.036000] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[   38.184000] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[   65.600000] RTL8211B Gigabit Ethernet r8169-30:00: attached PHY driver [RTL8211B Gigabit Ethernet] (mii_bus:phy_addr=r8169-30:00, irq=IGNORE)
[   68.280000] r8169 0000:00:06.0 eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[   76.244000] Adding 524256k swap on /SWAP.  Priority:-2 extents:13 across:145760016k 

-----

A.
