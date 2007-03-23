Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 16:17:59 +0000 (GMT)
Received: from mail.hcrest.com ([12.173.51.131]:10978 "EHLO mail.hcrest.com")
	by ftp.linux-mips.org with ESMTP id S20021730AbXCWQR5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 16:17:57 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: flush_anon_page for MIPS
Date:	Fri, 23 Mar 2007 12:17:23 -0400
Message-ID: <36E4692623C5974BA6661C0B18EE8EDF6CD399@MAILSERV.hcrest.com>
In-Reply-To: <cda58cb80703230912x29795fb8x54dd80f524739e5f@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
thread-topic: flush_anon_page for MIPS
Thread-Index: AcdtZhzx01rz8akmQF+jBiWrAmGZDAAAGw4g
From:	"Ravi Pratap" <Ravi.Pratap@hillcrestlabs.com>
To:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
Cc:	"Ralf Baechle" <ralf@linux-mips.org>,
	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, <miklos@szeredi.hu>,
	<linux-mips@linux-mips.org>
Return-Path: <Ravi.Pratap@hillcrestlabs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14643
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Ravi.Pratap@hillcrestlabs.com
Precedence: bulk
X-list: linux-mips

> From: Franck Bui-Huu [mailto:vagabon.xyz@gmail.com] 
> Sent: Friday, March 23, 2007 12:13 PM
> To: Ravi Pratap
> Cc: Ralf Baechle; Atsushi Nemoto; miklos@szeredi.hu; 
> linux-mips@linux-mips.org
> Subject: Re: flush_anon_page for MIPS
> 
> On 3/23/07, Ravi Pratap <Ravi.Pratap@hillcrestlabs.com> wrote:
> > > From: Ralf Baechle [mailto:ralf@linux-mips.org] What 
> processor does 
> > > it fail on?
> >
> > # cat /proc/cpuinfo
> > system type             : Sigma Designs TangoX
> > processor               : 0
> > cpu model               : MIPS 4KEc V6.8
> 
> Does this cpu have cache aliasings ?
> 
> How is configured the data cache ? Could you show the 'dmesg' output ?

Here you go. Let me know if you want more:


Configured for SMP8634 (revision ES6/RevA), detected SMP8634 (revision
ES7/RevB).
SMP863x/SMP864x Enabled Devices under Linux/XENV 0x48000000 = 0x00023efe
 BM/IDE PCIHost Ethernet IR FIP I2CM I2CS USB PCIDev1 PCIDev2 PCIDev3
PCIDev4 SCARD
Valid MEMCFG found at 0x10000fc0.
CPU revision is: 00019068
Determined physical RAM map:
 memory: 03fe0000 @ 10020000 (usable)
User-defined physical RAM map:
 memory: 04fe0000 @ 10020000 (usable)
On node 0 totalpages: 86016
  DMA zone: 86016 pages, LIFO batch:15
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
Built 1 zonelists
Kernel command line: mem=80m
Primary instruction cache 16kB, physically tagged, 2-way, linesize 16
bytes.
Primary data cache 16kB, 2-way, linesize 16 bytes.
Synthesized TLB refill handler (20 instructions).
Synthesized TLB load handler fastpath (32 instructions).
Synthesized TLB store handler fastpath (32 instructions).
Synthesized TLB modify handler fastpath (31 instructions).
PID hash table entries: 2048 (order: 11, 32768 bytes)
Using 150.750 MHz high precision timer.
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 71808k/81792k available (2756k kernel code, 9968k reserved, 408k
data, 3532k init, 0k highmem)
Calibrating delay loop... 299.00 BogoMIPS (lpj=149504)
Mount-cache hash table entries: 512
Checking for 'wait' instruction...  available.
NET: Registered protocol family 16
tangox: creating TLB mapping for 0x20000000 at 0xc0000000, size
0x08000000.
PCI: Initializing SMP863x/SMP864x PCI host controller
PCI: Remapped PCI I/O space 0x58000000 to 0xc8020000, size 64 kB
PCI: Remapped PCI config space 0x50000000 to 0xc8004000, size 10 kB
PCI: Configured SMP863x/SMP864x as PCI slave with 128MB PCI memory
PCI: Region size is 16384KB
PCI: Map DMA memory 0x10020000-0x15000000 for PCI at 0x12000000
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Created /proc/cpucache_info entry.
JFS: nTxBlock = 561, nTxLock = 4489
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Generic RTC Driver v1.07
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60
sec (nowayout= 0)
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing
disabled
serial8250: ttyS0 at MMIO 0x0 (irq = 9) is a 16550A
tangox_enet: ethernet driver for SMP863x/SMP864x internal mac
tangox_enet: detected phy at address 0x01
tangox_enet: mac address 00:16:e8:a9:4c:d5
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with
idebus=xx
ide0: SMP863x/SMP864x Bus Mastering IDE controller
Probing IDE interface ide0...
hda: ST3120213A, ATA DISK drive
hda: no 80 conductors cable, falling back to lower udma mode
hda: set to Ultra DMA mode 2
ide0: DMA enabled for ATA DISK hda
ide0 at 0x223c0-0x223c7,0x22398 on irq 26
hda: max request size: 128KiB
hda: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=16383/255/63,
UDMA(33)
hda: cache flushes supported
 hda: hda1 hda2 hda3
physmap flash device CS2: 400000 at 48000000
CS2: Physically mapped flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
CS2: Physically mapped flash: CFI does not contain boot bank location.
Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
CS2: flash size mismatched, re-do probing/initialization.
physmap flash device CS2: 4000000 at 48000000 (remapped c8100000)
CS2: Physically mapped flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
CS2: Physically mapped flash: CFI does not contain boot bank location.
Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Using physmap partition definition
Adding partition #1-#5
Creating 5 MTD partitions on "CS2: Physically mapped flash":
0x00000000-0x00020000 : "CS2-Part1"
0x00020000-0x00040000 : "CS2-Part2"
0x00040000-0x00080000 : "CS2-Part3"
0x00080000-0x003e0000 : "CS2-Part4"
0x003e0000-0x00400000 : "CS2-Part5"
physmap flash device CS3: 4000000 at 4c000000
CFI: Found no CS3: Physically mapped flash device at location zero
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver
(PCI)
USB Universal Host Controller Interface driver v2.3
driver tangox-ehci-hcd, 10 Dec 2004
TangoX USB initializing...
tangox-ehci-hcd tangox-ehci-hcd: TangoX USB 2.0
tangox-ehci-hcd tangox-ehci-hcd: new USB bus registered, assigned bus
number 1
tangox-ehci-hcd tangox-ehci-hcd: irq 48, io mem 0xa0021500
tangox-ehci-hcd tangox-ehci-hcd: USB 0.0 started, EHCI 1.00, driver 10
Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
TangoX USB was initialized.
Initializing TangoX USB OHCI Controller Polling mode, Membase=0xa0021500
Status=0x5
tangox-ohci-hcd tangox-ohci-hcd: USB Host Controller
tangox-ohci-hcd tangox-ohci-hcd: new USB bus registered, assigned bus
number 2
tangox-ohci-hcd tangox-ohci-hcd: io mem 0xa0021500
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usb 2-2: new low speed USB device using tangox-ohci-hcd and address 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Freeing unused kernel memory: 3532k freed
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
