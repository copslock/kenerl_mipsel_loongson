Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 15:59:23 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:58884 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3686579AbWATP6z (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jan 2006 15:58:55 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 93EFB64D3F; Fri, 20 Jan 2006 16:01:44 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id CC52B8ECE; Fri, 20 Jan 2006 16:00:39 +0000 (GMT)
Date:	Fri, 20 Jan 2006 16:00:39 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Fix a CPU definition for Cobalt
Message-ID: <20060120160039.GA24575@deprecation.cyrius.com>
References: <20060119192414.GA26798@deprecation.cyrius.com> <20060119210440.GE3398@linux-mips.org> <20060119214546.GB10040@deprecation.cyrius.com> <20060120150126.GB30415@linux-mips.org> <20060120151005.GH4343@deprecation.cyrius.com> <20060120151958.GC30415@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060120151958.GC30415@linux-mips.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10021
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Ralf Baechle <ralf@linux-mips.org> [2006-01-20 16:19]:
> > You attached the SERIO patch. ;-)
> Just checking your attention ;-)

This one gives me a really interesting set of error messages:

> execute console=ttyS0,{console-speed} root=/dev/hda2 
elf64: 00080000 - 0039b01f (ffffffff.80348000) (ffffffff.80000000) 
elf64: ffffffff.80080000 (80080000) 3084422t + 171930t 
net: interface down 
Linux version 2.6.15 (tbm@deprecation) (gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)) #8 Fri Jan 20 15:57:27 GMT 2006
 CPU revision is: 000028a0
 FPU revision is: 000028a0
 Cobalt board ID: 5
 Determined physical RAM map:
  memory: 0000000008000000 @ 0000000000000000 (usable)
 Built 1 zonelists
 Kernel command line: console=ttyS0,115200 root=/dev/hda2
 Primary instruction cache 32kB, physically tagged, 2-way, linesize 32 bytes.
 Primary data cache 32kB, 2-way, linesize 32 bytes.
 Synthesized TLB refill handler (32 instructions).
 Synthesized TLB load handler fastpath (46 instructions).
 Synthesized TLB store handler fastpath (46 instructions).
 Synthesized TLB modify handler fastpath (45 instructions).
 PID hash table entries: 1024 (order: 10, 32768 bytes)
 Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
 Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
 Memory: 125012k/131072k available (2265k kernel code, 5912k reserved, 578k data, 168k init, 0k highmem)
 Mount-cache hash table entries: 256
 Checking for 'wait' instruction...  available.
 Checking for the multiply/shift bug... no.
 Checking for the daddi bug... no.
 Checking for the daddiu bug... no.
 NET: Registered protocol family 16
 usbcore: registered new driver usbfs
 usbcore: registered new driver hub
 Galileo: fixed bridge class
 Galileo: revision 17
 Initializing Cryptographic API
 io scheduler noop registered
 io scheduler anticipatory registered
 io scheduler deadline registered
 io scheduler cfq registered
 Activating ISA DMA hang workarounds.
 rtc: Digital UNIX epoch (1952) detected
 Real Time Clock Driver v1.12a
 Cobalt LCD Driver v2.10
 Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
 ÿserial8250: ttyS0 at I/O 0xc800000 (irq = 21) is a ST16650V2
 RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 VP_IDE: IDE controller at PCI slot 0000:00:09.1
 VP_IDE: chipset revision 6
 VP_IDE: not 100% native mode: will probe irqs later
 VP_IDE: VIA vt82c586a (rev 27) IDE UDMA33 controller on pci0000:00:09.1
     ide0: BM-DMA at 0x1460-0x1467, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0x1468-0x146f, BIOS settings: hdc:pio, hdd:pio
 hda: QUANTUM FIREBALLlct08 04, ATA DISK drive
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 hda: max request size: 128KiB
 hda: 8421840 sectors (4311 MB) w/418KiB Cache, CHS=8912/15/63
 hda: cache flushes not supported
  hda: hda1 hda2 hda3 < hda5 hda6 >
 usbmon: debugfs is not available
 NET: Registered protocol family 2
 IP route cache hash table entries: 2048 (order: 2, 16384 bytes)
 TCP established hash table entries: 8192 (order: 4, 65536 bytes)
 TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
 TCP: Hash tables configured (established 8192 bind 8192)
 TCP reno registered
 TCP bic registered
 NET: Registered protocol family 1
 NET: Registered protocol family 17
 EXT3-fs: INFO: recovery required on readonly filesystem.
 EXT3-fs: write access will be enabled during recovery.
 kjournald starting.  Commit interval 5 seconds
 EXT3-fs: recovery complete.
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
 Freeing unused kernel memory: 168k freed
 modprobe: FATAL: Could not load /lib/modules/2.6.15/modules.dep: No such file or directory
 
modprobe: FATAL: Could not load /lib/modules/2.6.15/modules.dep: No such file or directory 
 
 INIT: version 2.86 booting
CPU 0 Unable to handle kernel paging request at virtual address 0000000000000000, epc == 0000000000000000, ra == ffffffff800a36dc
 Oops[#1]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffffb00064e0 ffffffff80370000 0000000000000000
 $ 4   : ffffffff80005000 0000000000008000 ffffffff80006000 0000000000000001
 $ 8   : 0000000000004000 0000000000008000 ffffffff80370000 ffffffff80370000
 $12   : ffffffff80370000 ffffffff80370000 ffffffff80094e80 0000000000000000
 $16   : ffffffff80005000 0000000000000004 000000007f885ec8 98000000011a9668
 $20   : 980000000797a348 980000000797d428 0000000007918613 9800000000363620
 $24   : 0000000000000000 ffffffff80370000                                  
 $28   : 9800000007970000 9800000007973cc0 ffffffff80380000 ffffffff800a36dc
 Hi    : 0000000000016c77
 Lo    : 000000000000797d
 epc   : 0000000000000000 _stext+0x7ff7fc00/0x40     Not tainted
 ra    : ffffffff800a36dc r4k_flush_cache_page+0x13c/0x208
 Status: b00064e3    KX SX UX KERNEL EXL IE 
 Cause : 00808008
 BadVA : 0000000000000000
 PrId  : 000028a0
 Modules linked in:
 Process rcS (pid: 600, threadinfo=9800000007970000, task=980000000796f848)
 Stack : 980000000797a348 000000007f885ec8 980000000798b000 98000000011a7d40
         ffffffff800fc748 ffffffff80374400 980000000797cfe0 ffffffff900064e1
         6800000000000000 0000000007918613 980000000797d428 000000007f885ec8
         980000000797cfe0 980000000797a348 9800000000363620 6db6db6db6db6db7
         0000000000000001 ffffffff800fce88 0000000000000002 00000000100189c8
         000000000045c000 0000000000000001 0000000000000000 0000000000000000
         0000000000000428 ffffffff80380000 9800000007973eb0 980000000797a348
         000000007f885ec8 9800000000363678 980000000796f848 9800000000363620
         0000000000030000 0000000000000001 0000000000000000 ffffffff8009f640
         0003000207973eb0 0000000000000012 9800000007973df0 9800000007973df0
         ...
 Call Trace:
  [<ffffffff800fc748>] do_wp_page+0x310/0x740
  [<ffffffff800fce88>] __handle_mm_fault+0x310/0xe50
  [<ffffffff8009f640>] do_page_fault+0x2a0/0x470
  [<ffffffff800c8b14>] do_sigaction+0x1dc/0x258
  [<ffffffff8010ef8c>] filp_close+0x64/0xc0
  [<ffffffff8010ef80>] filp_close+0x58/0xc0
  [<ffffffff800a0228>] tlb_do_page_fault_1+0x110/0x118
  [<ffffffff800829b8>] handle_cpu_int+0x20/0x28
  [<ffffffff80094e80>] sys32_rt_sigprocmask+0x0/0x180
 
 
 Code: (Bad address in epc)
 
 CPU 0 Unable to handle kernel paging request at virtual address 0000000000000000, epc == 0000000000000000, ra == ffffffff800a36dc
 Oops[#2]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffffb00064e0 ffffffff80370000 0000000000000000
 $ 4   : ffffffff80005000 0000000000008000 ffffffff80006000 0000000000000001
 $ 8   : 0000000000004000 0000000000008000 0000000007918613 ffffffff80370000
 $12   : ffffffff80370000 ffffffff80370000 ffffffff80094e80 0000000000000000
 $16   : ffffffff80005000 0000000000000004 000000007f885ca8 9800000007987428
 $20   : 980000000797a348 980000000797a348 0000000007918613 9800000000363060
 $24   : 0000000000000000 0000000000416a00                                  
 $28   : 9800000007970000 9800000007973cc0 0000000000000001 ffffffff800a36dc
 Hi    : 0000000000016c95
 Lo    : 0000000000007987
 epc   : 0000000000000000 _stext+0x7ff7fc00/0x40     Not tainted
 ra    : ffffffff800a36dc r4k_flush_cache_page+0x13c/0x208
 Status: b00064e3    KX SX UX KERNEL EXL IE 
 Cause : 00808008
 BadVA : 0000000000000000
 PrId  : 000028a0
 Modules linked in:
 Process rcS (pid: 602, threadinfo=9800000007970000, task=980000000796f848)
 Stack : 980000000797a348 000000007f885ca8 0000000000000001 98000000011a7d40
         ffffffff800fc908 ffffffff800fc8dc 980000000798ffe0 fffffffffffffdee
         6800000000000000 0000000007918613 9800000007987428 000000007f885ca8
         980000000798ffe0 980000000797a348 9800000000363060 6db6db6db6db6db7
         0000000000000001 ffffffff800fce88 0000000000000002 ffffffff00000001
         0000000000416000 0000000000000000 0000000000000000 0000000000000000
         0000000000000428 ffffffff80000010 9800000007973eb0 980000000797a348
         000000007f885ca8 98000000003630b8 980000000796f848 9800000000363060
         0000000000030000 0000000000000001 0000000000000000 ffffffff8009f640
         00030002800d6a80 9800000007973de8 9800000007973de8 ffffffff80100de4
         ...
 Call Trace:
  [<ffffffff800fc908>] do_wp_page+0x4d0/0x740
  [<ffffffff800fc8dc>] do_wp_page+0x4a4/0x740
  [<ffffffff800fce88>] __handle_mm_fault+0x310/0xe50
  [<ffffffff8009f640>] do_page_fault+0x2a0/0x470
  [<ffffffff80100de4>] do_brk+0x1dc/0x358
  [<ffffffff800a0228>] tlb_do_page_fault_1+0x110/0x118
  [<ffffffff800829b8>] handle_cpu_int+0x20/0x28
  [<ffffffff80094e80>] sys32_rt_sigprocmask+0x0/0x180
 
 
 Code: (Bad address in epc)
 
 /etc/init.d/rcS: line 59:   602 Segmentation fault      ( trap - INT QUIT TSTP; set start; . $i )
CPU 0 Unable to handle kernel paging request at virtual address 0000000000000000, epc == 0000000000000000, ra == ffffffff800a36dc
 Oops[#3]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffffb00064e0 ffffffff80370000 0000000000000000
 $ 4   : ffffffff80005000 0000000000008000 ffffffff80006000 0000000000000001
 $ 8   : 0000000000004000 0000000000008000 0000000007918613 ffffffff80370000
 $12   : ffffffff80370000 ffffffff80370000 ffffffff80094e80 0000000000000000
 $16   : ffffffff80005000 0000000000000004 000000007f885ec8 9800000007990428
 $20   : 9800000007f28208 9800000007f28208 0000000007918613 9800000000363060
 $24   : 0000000000000000 0000000000416a00                                  
 $28   : 9800000007970000 9800000007973cc0 0000000000000001 ffffffff800a36dc
 Hi    : 0000000000016cb0
 Lo    : 0000000000007990
 epc   : 0000000000000000 _stext+0x7ff7fc00/0x40     Not tainted
 ra    : ffffffff800a36dc r4k_flush_cache_page+0x13c/0x208
 Status: b00064e3    KX SX UX KERNEL EXL IE 
 Cause : 00808008
 BadVA : 0000000000000000
 PrId  : 000028a0
 Modules linked in:
 Process rcS (pid: 603, threadinfo=9800000007970000, task=980000000796f848)
 Stack : 9800000007f28208 000000007f885ec8 0000000000000001 98000000011a7d40
         ffffffff800fc908 ffffffff800fc8dc 980000000797efe0 00000000000168ea
         6800000000000000 0000000007918613 9800000007990428 000000007f885ec8
         980000000797efe0 9800000007f28208 9800000000363060 6db6db6db6db6db7
         0000000000000001 ffffffff800fce88 9800000000000002 9800000000363060
         000000000045c000 0000000000000000 0000000000000000 0000000000000000
         0000000000000428 ffffffff80000010 9800000007973eb0 9800000007f28208
         000000007f885ec8 98000000003630b8 980000000796f848 9800000000363060
         0000000000030000 0000000000000001 0000000000000000 ffffffff8009f640
         00030002800d6a80 9800000007973de8 9800000007973de8 ffffffff80100de4
         ...
 Call Trace:
  [<ffffffff800fc908>] do_wp_page+0x4d0/0x740
  [<ffffffff800fc8dc>] do_wp_page+0x4a4/0x740
  [<ffffffff800fce88>] __handle_mm_fault+0x310/0xe50
  [<ffffffff8009f640>] do_page_fault+0x2a0/0x470
  [<ffffffff80100de4>] do_brk+0x1dc/0x358
  [<ffffffff800c8b14>] do_sigaction+0x1dc/0x258
  [<ffffffff8010ef8c>] filp_close+0x64/0xc0
  [<ffffffff8010ef80>] filp_close+0x58/0xc0
  [<ffffffff800a0228>] tlb_do_page_fault_1+0x110/0x118
  [<ffffffff800829b8>] handle_cpu_int+0x20/0x28
  [<ffffffff80094e80>] sys32_rt_sigprocmask+0x0/0x180
 
 
 Code: (Bad address in epc)
 
 CPU 0 Unable to handle kernel paging request at virtual address 0000000000000000, epc == 0000000000000000, ra == ffffffff800a36dc
 Oops[#4]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffffb00064e0 ffffffff80370000 0000000000000000
 $ 4   : ffffffff80003000 0000000000008000 ffffffff80004000 0000000000000001
 $ 8   : 0000000000004000 0000000000008000 ffffffff80370000 ffffffff80370000
 $12   : ffffffff80370000 ffffffff80370000 ffffffff80094e80 0000000000000000
 $16   : ffffffff80003000 0000000000000004 000000007fe13ff8 98000000011aaaf8
 $20   : 98000000079d8818 98000000079da098 00000000079b9613 9800000000363620
 $24   : 0000000000000000 ffffffff80370000                                  
 $28   : 98000000079d0000 98000000079d3cc0 ffffffff80380000 ffffffff800a36dc
 Hi    : 0000000000016d8e
 Lo    : 00000000000079da
 epc   : 0000000000000000 _stext+0x7ff7fc00/0x40     Not tainted
 ra    : ffffffff800a36dc r4k_flush_cache_page+0x13c/0x208
 Status: b00064e3    KX SX UX KERNEL EXL IE 
 Cause : 00808008
 BadVA : 0000000000000000
 PrId  : 000028a0
 Modules linked in:
 Process S02mountvirtfs (pid: 606, threadinfo=98000000079d0000, task=980000000796f260)
 Stack : 98000000079d8818 000000007fe13ff8 98000000079e9000 98000000011aa078
         ffffffff800fc748 ffffffff800a1f48 98000000079d9ff8 ffffffff8037da90
         6800000000000000 00000000079b9613 98000000079da098 000000007fe13ff8
         98000000079d9ff8 98000000079d8818 9800000000363620 6db6db6db6db6db7
         0000000000000001 ffffffff800fce88 0000000000000002 ffffffff800c1110
         000000000041a000 98000000079d3d60 0000000000000000 0000000000000000
         0000000000000098 ffffffff80380000 98000000079d3eb0 98000000079d8818
         000000007fe13ff8 9800000000363678 980000000796f260 9800000000363620
         0000000000030000 0000000000000001 000000007fe14008 ffffffff8009f640
         00030002079d3eb0 0000000000000012 98000000079d3df0 98000000079d3df0
         ...
 Call Trace:
  [<ffffffff800fc748>] do_wp_page+0x310/0x740
  [<ffffffff800a1f48>] r4k_blast_dcache_page_dc32+0x88/0xa0
  [<ffffffff800fce88>] __handle_mm_fault+0x310/0xe50
  [<ffffffff800c1110>] do_softirq+0xa0/0xd0
  [<ffffffff8009f640>] do_page_fault+0x2a0/0x470
  [<ffffffff800a0228>] tlb_do_page_fault_1+0x110/0x118
  [<ffffffff800829b8>] handle_cpu_int+0x20/0x28
  [<ffffffff80094e80>] sys32_rt_sigprocmask+0x0/0x180
 
 
 Code: (Bad address in epc)
 
 CPU 0 Unable to handle kernel paging request at virtual address 0000000000000000, epc == 0000000000000000, ra == ffffffff800a36dc
 Oops[#5]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffffb00064e0 ffffffff80370000 0000000000000000
 $ 4   : ffffffff80003000 0000000000008000 ffffffff80004000 0000000000000001
 $ 8   : 0000000000004000 0000000000008000 00000000079b9613 ffffffff80370000
 $12   : ffffffff80370000 ffffffff80370000 ffffffff80094e80 0000000000000000
 $16   : ffffffff80003000 0000000000000004 000000007fe13f88 98000000079de098
 $20   : 98000000079314c8 98000000079314c8 00000000079b9613 9800000000363620
 $24   : 0000000000000000 0000000000416a00                                  
 $28   : 98000000079d0000 98000000079d3cc0 0000000000000001 ffffffff800a36dc
 Hi    : 0000000000016d9a
 Lo    : 00000000000079de
 epc   : 0000000000000000 _stext+0x7ff7fc00/0x40     Not tainted
 ra    : ffffffff800a36dc r4k_flush_cache_page+0x13c/0x208
 Status: b00064e3    KX SX UX KERNEL EXL IE 
 Cause : 00808008
 BadVA : 0000000000000000
 PrId  : 000028a0
 Modules linked in:
 Process S02mountvirtfs (pid: 607, threadinfo=98000000079d0000, task=980000000796f260)
 Stack : 98000000079314c8 000000007fe13f88 0000000000000001 98000000011aa078
         ffffffff800fc908 ffffffff800fc8dc 98000000079e1ff8 ffffffff8037da90
         6800000000000000 00000000079b9613 98000000079de098 000000007fe13f88
         98000000079e1ff8 98000000079314c8 9800000000363620 6db6db6db6db6db7
         0000000000000001 ffffffff800fce88 0000000000000002 ffffffff800c1110
         000000000045c000 98000000079d3d60 0000000000000000 0000000000000000
         0000000000000098 ffffffff80380000 98000000079d3eb0 98000000079314c8
         000000007fe13f88 9800000000363678 980000000796f260 9800000000363620
         0000000000030000 0000000000000001 0000000000000000 ffffffff8009f640
         00030002079d3eb0 0000000000000012 98000000079d3df0 98000000079d3df0
         ...
 Call Trace:
  [<ffffffff800fc908>] do_wp_page+0x4d0/0x740
  [<ffffffff800fc8dc>] do_wp_page+0x4a4/0x740
  [<ffffffff800fce88>] __handle_mm_fault+0x310/0xe50
  [<ffffffff800c1110>] do_softirq+0xa0/0xd0
  [<ffffffff8009f640>] do_page_fault+0x2a0/0x470
  [<ffffffff800a0228>] tlb_do_page_fault_1+0x110/0x118
  [<ffffffff800829b8>] handle_cpu_int+0x20/0x28
  [<ffffffff80094e80>] sys32_rt_sigprocmask+0x0/0x180
 
 
 Code: (Bad address in epc)
 
 Break instruction in kernel code[#6]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffffb00064e0 ffffffffffffffff ffffffffb00064e1
 $ 4   : 0000000000000020 6800000000000000 98000000079cb000 0000000000000000
 $ 8   : 0000000000000017 0000c00000000003 ffffffff80370000 2ae156c600000000
 $12   : ffffffff80380000 000000001000001e ffffffff80091258 20203e706d75643c
 $16   : 98000000079ca000 98000000011aa078 000000007fe13fb0 98000000011aa430
 $20   : 9800000007f28208 9800000007976098 00000000079b969b 9800000000363060
 $24   : 0000000000000000 ffffffff800a1ec0                                  
 $28   : 9800000007970000 9800000007973cf0 ffffffff80380000 ffffffff800fc70c
 Hi    : 0000000000016c62
 Lo    : 0000000000007976
 epc   : ffffffff801036c8 page_remove_rmap+0x78/0x88     Not tainted
 ra    : ffffffff800fc70c do_wp_page+0x2d4/0x740
 Status: b00064e3    KX SX UX KERNEL EXL IE 
 Cause : 00808024
 PrId  : 000028a0
 Modules linked in:
 Process S02mountvirtfs (pid: 605, threadinfo=9800000007970000, task=980000000796f848)
 Stack : 980000000799aff8 fffffffffffffdee 6800000000000000 00000000079b969b
         9800000007976098 000000007fe13fb0 980000000799aff8 9800000007f28208
         9800000000363060 6db6db6db6db6db7 0000000000000001 ffffffff800fce88
         0000000000000002 ffffffff00000001 9800000007973d60 9800000007973d60
         980000000796f848 0000000000000001 0000000000000098 ffffffff80380000
         9800000007973eb0 9800000007f28208 000000007fe13fb0 98000000003630b8
         980000000796f848 9800000000363060 0000000000030000 0000000000000001
         0000000000000002 ffffffff8009f640 0003000207973eb0 0000000000000012
         9800000007973df0 9800000007973df0 0000000000000000 ffffffff8037a578
         000000000000000a ffffffff80380000 0000000000000001 ffffffff8037da90
         ...
 Call Trace:
  [<ffffffff800fce88>] __handle_mm_fault+0x310/0xe50
  [<ffffffff8009f640>] do_page_fault+0x2a0/0x470
  [<ffffffff800c0f94>] __do_softirq+0xbc/0x198
  [<ffffffff800a0228>] tlb_do_page_fault_1+0x110/0x118
  [<ffffffff800829b8>] handle_cpu_int+0x20/0x28
  [<ffffffff80091258>] sys32_llseek+0x0/0x30
 
 
 Code: 24040020  0803a884  2405ffff <0200000d> 24040020  0803a884  2405ffff  67bdffb0  ffb20020 
 Break instruction in kernel code[#7]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffffb00064e0 fffffffffffffffe ffffffffb00064e1
 $ 4   : 0000000000000020 0000000000000000 00000000079b969b 00000000001aa078
 $ 8   : 00000000000079b9 000000007fe13000 ffffffff80373ce0 ffffffff80370000
 $12   : ffffffff803a0000 ffffffff80390000 ffffffff80310000 ffffffff80380000
 $16   : 9800000007976098 ffffffffffffffbf 000000007fe13000 98000000011aa078
 $20   : 000000007fe15000 000000000028cc95 000000007fe15000 980000000799aff8
 $24   : ffffffff80310000 ffffffff802c0000                                  
 $28   : 9800000007970000 98000000079739a0 0000000000000000 ffffffff800fb440
 Hi    : 0000000000016c62
 Lo    : 0000000000007976
 epc   : ffffffff801036c8 page_remove_rmap+0x78/0x88     Not tainted
 ra    : ffffffff800fb440 unmap_vmas+0x350/0x788
 Status: b00064e3    KX SX UX KERNEL EXL IE 
 Cause : 00808024
 PrId  : 000028a0
 Modules linked in:
 Process S02mountvirtfs (pid: 605, threadinfo=9800000007970000, task=980000000796f848)
 Stack : 0000000000000000 000000007fe15000 000000007fe14fff 000000007fe14fff
         9800000000363060 ffffffff80373ce0 fffffffffffffffc 9800000007994008
         9800000007994008 0000000000000001 0000000000000000 0000000000000001
         9800000007973a80 9800000007f28208 0000000000000000 ffffffffffffffff
         9800000007973a88 0000000000000000 98000000079316d8 9800000000363060
         0000000000000001 000000000000000b 9800000007f28208 9800000007976098
         00000000079b969b 9800000000363060 ffffffff80380000 ffffffff800ff244
         ffffffff80373ce0 0000000000000059 9800000000363060 980000000796f848
         ffffffff800b67a0 ffffffff800b6798 9800000007973bc0 ffffffff800bcba0
         9800000007973ae8 ffffffff80310000 9800000007973bc0 98000000011aa078
         ...
 Call Trace:
  [<ffffffff800ff244>] exit_mmap+0x8c/0x178
  [<ffffffff800b67a0>] mmput+0x88/0x158
  [<ffffffff800b6798>] mmput+0x80/0x158
  [<ffffffff800bcba0>] do_exit+0x198/0xda8
  [<ffffffff800887d0>] nmi_exception_handler+0x0/0x50
  [<ffffffff800887c8>] die+0xb0/0xb8
  [<ffffffff80088d20>] do_tr+0x0/0x118
  [<ffffffff802b3254>] __wait_on_bit_lock+0x104/0x1c0
  [<ffffffff800e5010>] __lock_page+0x80/0x90
  [<ffffffff800d6bf8>] wake_bit_function+0x0/0x58
  [<ffffffff800827b8>] handle_bp_int+0x20/0x28
  [<ffffffff80091258>] sys32_llseek+0x0/0x30
  [<ffffffff800a1ec0>] r4k_blast_dcache_page_dc32+0x0/0xa0
  [<ffffffff800fc70c>] do_wp_page+0x2d4/0x740
  [<ffffffff801036c8>] page_remove_rmap+0x78/0x88
  [<ffffffff800fce88>] __handle_mm_fault+0x310/0xe50
  [<ffffffff8009f640>] do_page_fault+0x2a0/0x470
  [<ffffffff800c0f94>] __do_softirq+0xbc/0x198
  [<ffffffff800a0228>] tlb_do_page_fault_1+0x110/0x118
  [<ffffffff800829b8>] handle_cpu_int+0x20/0x28
  [<ffffffff80091258>] sys32_llseek+0x0/0x30
 
 
 Code: 24040020  0803a884  2405ffff <0200000d> 24040020  0803a884  2405ffff  67bdffb0  ffb20020 
 Fixing recursive fault but reboot is needed!
 

-- 
Martin Michlmayr
http://www.cyrius.com/
