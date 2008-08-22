Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2008 12:38:06 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.189]:4284 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20033465AbYHVLh7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 Aug 2008 12:37:59 +0100
Received: by fk-out-0910.google.com with SMTP id b27so229241fka.0
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2008 04:37:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=V5gNAt/zLFddgIF1sG2wbvEl4YriUip6pArafuGU5rU=;
        b=QLemcG1NTo6P0fLYn56shWyiVQspIrunae/mvT+Bjxt18NCApG1UG0/Hb4rNywzQQR
         ZAEZtfrCmx0sMbcKtExCZtZ3dGhReNATzJ7pbHlqK+v97PugkpvkH8m8NcafsgIPdog1
         Uo8rs0RrrzCcE2m8kOT0TSB4uq0ZndtuIKNjM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=JIT/t6E4dNMtLlszTQ1zjxv2wrW/ihXoKAu7JzWPbAP14ZQ0dp3mCz8LbPHLO/4W1d
         eTDkyKwFtBpa2wQ7Ntlb5j7LLNEvO/+hId7FqoESOeGrkNbFIozf9nQQKbQFywkIN/VF
         l74ZqGuZ1U+IpHqfq7Lre6iTnjuckW662UD4w=
Received: by 10.181.30.10 with SMTP id h10mr526119bkj.41.1219405077634;
        Fri, 22 Aug 2008 04:37:57 -0700 (PDT)
Received: by 10.180.206.16 with HTTP; Fri, 22 Aug 2008 04:37:57 -0700 (PDT)
Message-ID: <c58a7a270808220437x7735fb49qfd75ad7e15432ca2@mail.gmail.com>
Date:	Fri, 22 Aug 2008 12:37:57 +0100
From:	"Alex Gonzalez" <langabe@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: Bus/cache error on partition check
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <langabe@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: langabe@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I am trying to debug a bus/cache error hit by a 2.6.21 kernel on am
RMI XLR cpu. It only happens occasionally and could be temperature
related. I am trying to get some understanding of what the kernel is
trying to do at the point of the exception and I hope someone can shed
some light on it.

The problem appears when trying to access a SATA drive connected to
the CPU through a point to point PCI bus. The PCIX interface maps two
areas of memory, an IO area, and a memory space. Accessing the IO area
works OK always, but on the first access to the memory mapped area I
sometimes see this exception, after a pause of around 4 seconds. I
tried different drives, cables etc. to no avail.

I enclose the whole trace, messed up a bit by my own printks,
apologies for that. The cache trace epc is phoenix_wait, the xlr
cpu_wait, and the errorepc is  ioread8, to the physical address
0xf0000088 which is part of the PCIX memory space mapping.

This seems to indicate an exception on a PCI access, but I am missing
the path between the read_dev_sector() and the exception, I would have
expected to see a call to phoenix_pcibios_read() before the crash.

I am basically trying to understand what is the kernel waiting for
after the call to io_schedule, why the 4 seconds pause, and how can
that cause a cache exception error.

It's the first time I look at this part of the kernel,and I'd really
appreciate an expert opinion on what might be going on.

Regards,
Alex

-------------------------------------------------------------------------------------

0:<5>0:Linux version 2.6.21.7-37:155M (alex@alex-laptop) (gcc version
4.1.2) #17 SMP PREEMPT Fri Aug 22 10:31:31 BST 2008
0:Using default Mac address
0:Passed argv is 8c205c5c envp is 8c206164
0:Enabling XLR Linux Loader support
0:Physical Address Map of XLR:
0:      0000000000 --> 00000fffff ( Memory )
0:      0000100000 --> 000c0fffff ( Memory )
0:      000c100000 --> 000fffffff ( Memory )
0:      0010000000 --> 0013ffffff ( PCIX IO Space )
0:      0014000000 --> 0017ffffff (  *** HOLE *** )
0:      0018000000 --> 0019ffffff ( PCIX CFG Space )
0:      001a000000 --> 001bffffff (  *** HOLE *** )
0:      001c000000 --> 001dffffff ( Flash Controller Space )
0:      001e000000 --> 001eefffff (  *** HOLE *** )
0:      001ef00000 --> 001effffff ( Phoenix IO Space )
0:      001f000000 --> 001fffffff (  *** HOLE *** )
0:      0020000000 --> 003fffffff ( Memory )
0:      0040000000 --> 007fffffff ( Memory )
0:      0080000000 --> 00bfffffff ( Memory )
0:      00c0000000 --> 00dfffffff ( Memory )
0:      00e0000000 --> 00efffffff ( Memory )
0:      00f0000000 --> 00ffffffff ( PCIX Memory Space )
0:      0100000000 --> 01ffffffff ( Memory )
0:      0200000000 --> fffffffffe (  *** HOLE *** )
0:Using 0x0000000f as linux cpu mask
0:Using 0xfffffff0 as loader cpu mask
0:No KSEG args passed. Using defaults
0:Using 0x20800000 as KUSEG start and 0x5f7fffff as KUSEG size
0:phnx_loader: RMIOS-APP shared memory size=0x00200000
0:Adding 0x8400000 @ 0x3400000
0:Adding 0x800000 @ 0x20000000
0:Adding 0x1 @ 0x7fffffff
0:Adding 0x40000000 @ 0xb0000000
0:Adding 0x100000000 @ 0x100000000
0:Using bootloader passed physical memory map
0:
Callin prom_init_xlr_loader
0:argc=6, argv=8c205c5c, envp=8c206164, prom_info=8384def8
0:argv[1] = [xlr_loader]
0:arcs_cmdline=[xlr_loader ]
0:argv[2] = [root=/dev/sda1]
0:arcs_cmdline=[xlr_loader root=/dev/sda1 ]
0:argv[3] = [kuseg_start_lo=20800000]
0:arcs_cmdline=[xlr_loader root=/dev/sda1 kuseg_start_lo=20800000 ]
0:argv[4] = [kuseg_size_lo=5F7FFFFF]
0:arcs_cmdline=[xlr_loader root=/dev/sda1 kuseg_start_lo=20800000
kuseg_size_lo=5F7FFFFF ]
0:argv[5] = [linux_cpu_mask=0000000f]
0:arcs_cmdline=[xlr_loader root=/dev/sda1 kuseg_start_lo=20800000
kuseg_size_lo=5F7FFFFF linux_cpu_mask=0000000f ]
0:prom_init: envp[0] = [BOARD=ARIZONA]
0:prom_init: envp[1] = [ttyS0]
0:arcs_cmdline=[xlr_loader root=/dev/sda1 kuseg_start_lo=20800000
kuseg_size_lo=5F7FFFFF linux_cpu_mask=0000000f  console=ttyS0,38400
rdinit=/sbin/init  ]
0:MAC ADDR BASE: 00:1c:69:20:00:26
0:Master CPU Thread: 0 of 0 running on Phoenix 0
0:Initializing PIC...
0:Initializing message ring for cpu_0
0:&phnx_counters = 0x837ff000, sizeof(phnx_counters) = 0x1400
0:on_chip init done
0:CPU revision is: 000c0809
0:Determined physical RAM map:
0: memory: 08400000 @ 03400000 0:(usable)
0: memory: 00800000 @ 20000000 0:(usable)
0: memory: 00000001 @ 7fffffff 0:(usable)
0: memory: 40000000 @ b0000000 0:(usable)
0: memory: 100000000 @ 100000000 0:(usable)
0:<6>Wasting 425984 bytes for tracking 13312 unused pages
0:<7>On node 0 totalpages: 2097152
0:<7>  DMA zone: 1024 pages used for memmap
0:<7>  DMA zone: 0 pages reserved
0:<7>  DMA zone: 130048 pages, LIFO batch:31
0:<7>  Normal zone: 0 pages used for memmap
0:<7>  HighMem zone: 15360 pages used for memmap
0:<7>  HighMem zone: 1950720 pages, LIFO batch:31
0:(PROM) CPU present map: f
0:Phys CPU present map: f, possible map f
0:Detected 3 Slave CPU(s)
0:Built 1 zonelists.  Total pages: 2080768
0:<5>Kernel command line: xlr_loader root=/dev/sda1
kuseg_start_lo=20800000 kuseg_size_lo=5F7FFFFF linux_cpu_mask=0000000f
 console=ttyS0,38400  rdinit=/sbi
0:Primary instruction cache 32kB, 8-way, linesize 32 bytes.
0:Primary data cache 32kB 8-way, linesize 32 bytes.
0:PID hash table entries: 2048 (order: 11, 8192 bytes)
0:mips_hpt_frequency = 66666666
0:Using 66.667 MHz high precision timer. cycles_per_jiffy=1200000
0:phoenix_timer_setup: phoenix_timer_stats = 8382c100,
phoenix_timer_diff = 8382c180, phoenix_timer_count = 8382c200,
phoenix_timer_epc = 8382c280, phoenix_0
0:Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
0:Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
0:<6>Memory: 5314664k/135168k available (3431k kernel code, 70796k
reserved, 679k data, 156k init, 5251072k highmem)
0:<7>Calibrating delay loop... 0:266.24 BogoMIPS (lpj=133120)
0:<6>Security Framework v1.0.0 initialized
0:<6>Capability LSM initialized
0:Mount-cache hash table entries: 512
0:(PROM): waking up phys cpu# 1, bucket_1, gp = 87972000
0:(PROM): sent a wakeup message to bucket 1
1:Initializing CPU:1 (1), current=87960440, gp = 87972000
1:CPU revision is: 000c0809
1:<7>Calibrating delay loop... 1:277.50 BogoMIPS (lpj=138752)
1:<7>Calibrating delay loop... 1:276.48 BogoMIPS (lpj=138240)
0:(PROM): waking up phys cpu# 2, bucket_2, gp = 87980000
0:(PROM): sent a wakeup message to bucket 2
2:Initializing CPU:2 (2), current=8797b480, gp = 87980000
2:CPU revision is: 000c0809
2:<7>Calibrating delay loop... 2:393.21 BogoMIPS (lpj=196608)
2:<7>Calibrating delay loop... 2:394.24 BogoMIPS (lpj=197120)
0:(PROM): waking up phys cpu# 3, bucket_3, gp = 8798a000
0:(PROM): sent a wakeup message to bucket 3
3:Initializing CPU:3 (3), current=8797a868, gp = 8798a000
3:CPU revision is: 000c0809
3:<7>Calibrating delay loop... 3:595.96 BogoMIPS (lpj=297984)
3:<7>Calibrating delay loop... 3:595.96 BogoMIPS (lpj=297984)
0:<6>Brought up 4 CPUs
1:migration_cost=1:10001:
0:<6>NET: Registered protocol family 16
0:Registering XLR/XLS PCIX/PCIE Controller.
0:<4>registering PCI controller with io_map_base unset
0:Packet Vision's CMD driver version 1.1
0:<5>SCSI subsystem initialized
0:<7>libata version 2.20 loaded.
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_write
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_write
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_write
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:<6>NET: Registered protocol family 2
0:<6>Time: MIPS clocksource has been installed.
0:IP route cache hash table entries: 16384 (order: 4, 65536 bytes)
0:TCP established hash table entries: 65536 (order: 8, 1048576 bytes)
0:TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
0:<6>TCP: Hash tables configured (established 65536 bind 65536)
0:<6>TCP reno registered
0:highmem bounce pool size: 64 pages
0:<6>Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
0:<6>io scheduler noop registered
0:<6>io scheduler anticipatory registered (default)
0:<6>io scheduler deadline registered
0:<6>io scheduler cfq registered
0:Registered phoenix msgring driver: major=0
0:Registered phoenix app loader driver: phnx_loader_major=245
0:<6>XLR RNG detected
0:Registered XLR tracebuffer driver with Major No. [0]
0:rmisec_init: BEGIN INIT
0: PHXSEC: rmisec_init_device
 0:Registering PHOENIX_SEC
0:PHXSEC:  Init  mmio=bef0b000   *mmio=0x0
0:phxsec_init_device: Phoenix SecEng at 0xbef0b000 (descriptors=20)
0:RMISEC:  register_chrdev() = 0
0:<6>Serial: 8250/16550 driver $Revision: 1.1.1.7.2.10 $ 2 ports, IRQ
sharing disabled
0:<6>serial8250: ttyS0 at MMIO 0x0 (irq = 17) is a 16550A
0:<6>serial8250: ttyS1 at MMIO 0x0 (irq = 18) is a 16550A
0:<6>nbd: registered device at major 43
0:sbull_open() called
0:rescan_partitions
0:check_partition1
0:check_partition2
0:<6> sbulla:0:check_partition2
0:Calling 834de1e0 with state=8b625000 and bdev=87946b80
0:msdos_partition
0:msdos_partition: Reading from bdev 87946b80
0:read_dev_sector: address_space=87946cac
0:read_cache_page: mapping=87946cac index=0 filler=834c4b7c data=00000000
0:read_cache_page1
0:read_dev_sector: page=83a15540
0:check_partition: res=0
0:check_partition3
0: unknown partition table
0:Initializing spi4 ethernet driver
0:This board does not support spi4
0:[setup_mac_spill_sizes]: max_num_desc = 512
max_frin_spill = 2048
max_frout_spill = 2048
max_class_0_spill = 512
max_class_1_spill = 512
max_class_2_spill = 512
max_class_3_spill = 512
0:Initializing gmac 0 in hybrid mode:
0:gmac_0, aux control/status reg = ffff
0:phy reported unknown mac speed, defaulting to 1000Mbps
0:configuring gmac_0 in 1000Mbps mode
0:GMAC_0 initialized as eth0
0:Initializing gmac 1 in hybrid mode:
0:gmac_1, aux control/status reg = ffff
0:phy reported unknown mac speed, defaulting to 1000Mbps
0:configuring gmac_1 in 1000Mbps mode
0:GMAC_1 initialized as eth1
0:Initializing gmac 2 in hybrid mode:
0:gmac_2, aux control/status reg = 2005
0:configuring gmac_2 in 10Mbps mode
0:GMAC_2 initialized as eth2
0:Initializing gmac 3 in hybrid mode:
0:gmac_3, aux control/status reg = 5
0:configuring gmac_3 in 10Mbps mode
0:GMAC_3 initialized as eth3
0:[user_mac_init]: user_mac_data=0x534d28, psb_shm_size=0x800000
0:Registered phoenix user_mac driver: major=0
0:<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
0:<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
0:Initializing Phoenix PCMCIA IDE...
0:Phoenix PCMCIA configured as IDE interface = 0
0:<7>Probing IDE interface ide0...
0:hda: TOSHIBA THNCF1G02QG, 0:CFA DISK drive
0:ide0 at 0xbd0001f1-0xbd0001f8,0xbd0003f7 on irq 210:
0:<6>hda: max request size: 128KiB
0:<6>hda: 2000880 sectors (1024 MB)0: w/2KiB Cache0:, CHS=1985/16/630:
0:rescan_partitions
0:check_partition1
0:check_partition2
0:<6> hda:0:check_partition2
0:Calling 834de1e0 with state=8b625000 and bdev=87946b80
0:msdos_partition
0:msdos_partition: Reading from bdev 87946b80
0:read_dev_sector: address_space=87946cac
0:read_cache_page: mapping=87946cac index=0 filler=834c4b7c data=00000000
0:read_cache_page1
0:read_cache_page2
0:lock_page
0:lock_page1
0:sync_page: word=83a15560
0:About to call 834b9f88
0:Before io_schedule()
0:sync_page: END
0:read_cache_page2.1
0:read_cache_page3
0:read_dev_sector: page=83a15560
0:msdos_partition1
0:msdos_partition2
0:msdos_partition3
0: hda10:msdos_partition4
0:
0:msdos_partition: END
0:check_partition: res=1
0:check_partition3
0:rescan_partitions1
0:<7>sata_sil 0000:00:01.0: version 2.1
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:phoenix_pcibios_write
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:<6>sata_sil 0000:00:01.0: Applying R_ERR on DMA activate FIS errata fix
0:phoenix_pcibios_read
0:phoenix_pcibios_read
0:<6>ata1: SATA max UDMA/100 cmd 0xc0000080 ctl 0xc000008a bmdma
0xc0000000 irq 24
0:<6>ata2: SATA max UDMA/100 cmd 0xc00000c0 ctl 0xc00000ca bmdma
0xc0000008 irq 24
0:<6>scsi0 : sata_sil
3:<6>ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
3:<6>ata1.00: ATA-7: ST3160815AS, 4.AAB, max UDMA/133
3:<6>ata1.00: 312581808 sectors, multi 0: LBA48 NCQ (depth 0/32)
3:<6>ata1.00: configured for UDMA/100
0:<6>scsi1 : sata_sil
3:<6>ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
3:<6>ata2.00: ATA-6: Super Talent Tech, NCC-0830, max UDMA/133
3:<6>ata2.00: 31977472 sectors, multi 1: LBA
3:<6>ata2.00: applying bridge limits
3:<6>ata2.00: configured for UDMA/100
0:<5>scsi 0:0:0:0: Direct-Access     ATA      ST3160815AS      4.AA
PQ: 0 ANSI: 5
0:sd_probe
0:READ_CAPACITY
0:<5>SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
0:<5>sda: Write Protect is off
0:<7>sda: Mode Sense: 00 3a 00 00
0:<5>SCSI device sda: write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
0:rescan_partitions
0:READ_CAPACITY
0:<5>SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
0:<5>sda: Write Protect is off
0:<7>sda: Mode Sense: 00 3a 00 00
0:<5>SCSI device sda: write cache: enabled, read cache: enabled,
doesn't support DPO or FUA
0:check_partition1
0:check_partition2
0:<6> sda:0:check_partition2
0:Calling 834de1e0 with state=8b625000 and bdev=87946b80
0:msdos_partition
0:msdos_partition: Reading from bdev 87946b80
0:read_dev_sector: address_space=87946cac
0:read_cache_page: mapping=87946cac index=0 filler=834c4b7c data=00000000
0:read_cache_page1
0:read_cache_page2
0:lock_page
0:lock_page1
0:sync_page: word=83a15580
0:About to call 834b9f88
0:Before io_schedule()


( ~4secs pause )


*********************************************
cpu_0 received a bus/cache error
*********************************************
Bridge: Phys Addr = 0x0000000000, Device_AERR = 0x00000000
Bridge: The devices reporting AERR are:
CPU: (XLR specific) Cache Error log = 0x0000007800004601, Phy Addr =
0x00f0000088
CPU: epc = 0x8340e324, errorepc = 0x835bed34, cacheerr = 0x00000000
Can not handle bus/cache error - Halting cpu
