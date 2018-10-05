Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Oct 2018 00:53:02 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23994642AbeJEWw5eJE6g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 6 Oct 2018 00:52:57 +0200
Date:   Fri, 5 Oct 2018 23:52:57 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Fredrik Noring <noring@nocrew.org>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>
Subject: Re: [PATCH] TC: Set DMA masks for devices
In-Reply-To: <20181005145612.GA2341@sx-9>
Message-ID: <alpine.LFD.2.21.1810051602280.22125@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1810030109210.5483@eddie.linux-mips.org> <20181004165720.GA2361@sx-9> <alpine.LFD.2.21.1810041916420.12089@eddie.linux-mips.org> <20181005145612.GA2341@sx-9>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Fredrik,

> >  I take it you mean 0-0x1fffff obviously; let's be accurate in a technical 
> > discussion and avoid ambiguous cases.
> 
> That's interesting. :) 0x1fffff is not a valid DMA address due to alignment
> restrictions, so if one wants to indicate a closed [inclusive] DMA address
> interval it would be 0-0x1ffffc, since the 32-bit word rather than the byte
> is the unit of the IOP DMA. In mathematics and programming languages it is
> often convenient to work with half-open intervals denoted by "[0,0x200000)"
> in this case. I think both notations are technically accurate, but they do
> emphasize different aspects of addresses and memory. I can switch to your
> byte-centric notation if that helps. :)

 Well, the byte at 0x1fffff may not be individually addressable by this 
particular DMA engine, but surely it is there included in DMA transfers 
accessing the location that spans it.  If instead you prefer to use the 
mathematical notation to specify inclusive/exclusive ranges, then of 
course I'm fine with that too.

> >  And indeed e.g. `dma_map_single' does handle that and given a CPU-side 
> > physical memory address returns a corresponding DMA-side address.  And the 
> > DMA mask has to reflect that and describe the DMA side, as it's the device 
> > side that has an address space limitation here and any offset resulting 
> > from a non-identity mapping does not change that limitation, although the 
> > offset does have of course to be taken into account by `dma_map_single', 
> > etc. in determining whether the memory area requested for use by a DMA 
> > device can be used directly or whether a bounce buffer will be required 
> > for that mapping.
> 
> Ah... memory that is known to be DMA compatible is allocated separately,
> and then handed over to the DMA subsystem using dma_declare_coherent_memory.

 Well, that does specify both a CPU-side and a corresponding DMA-side 
address too.

> This is done once during driver initialisation. The drivers ohci-sm501.c and
> ohci-tmio.c do that too, which is why I suspect they might broken as well.
> 
> The SM501 driver has this explanation:
> 
> 	/* The sm501 chip is equipped with local memory that may be used
> 	 * by on-chip devices such as the video controller and the usb host.
> 	 * This driver uses dma_declare_coherent_memory() to make sure
> 	 * usb allocations with dma_alloc_coherent() allocate from
> 	 * this local memory. The dma_handle returned by dma_alloc_coherent()
> 	 * will be an offset starting from 0 for the first local memory byte.

 From the description I take it it is some MMIO memory rather than host 
memory.  I fail to see how it is supposed to work with these calls for 
non-system memory, which certainly any MMIO memory is, which surely is not 
under the supervision of the kernel memory allocator.

 There are calls for MMIO memory defined in the DMA API, specifically 
`dma_map_resource' and `dma_unmap_resource'.  I've never used them myself, 
and I gather they provide you with a way for CPUs to access MMIO memory 
with caching enabled and without the need to use the MMIO accessors only, 
such as `readl', `writel', etc., which are expected to avoid going through 
any CPU cache.  Maybe these are what you're after?

 But maybe I'm missing something.

> 	 *
> 	 * So as long as data is allocated using dma_alloc_coherent() all is
> 	 * fine. This is however not always the case - buffers may be allocated
> 	 * using kmalloc() - so the usb core needs to be told that it must copy
> 	 * data into our local memory if the buffers happen to be placed in
> 	 * regular memory. The HCD_LOCAL_MEM flag does just that.
> 	 */

 This raises a hack alert to me TBH.

> >  Well, how can such a device use the DMA API in the first place?  If the 
> > device has local memory, than the driver has to manage it itself somehow 
> > if needed, and then arrange copying it to main memory, either by a CPU or 
> > a third-party DMA controller (data mover) if available.  Of course in the 
> > latter case a driver for the DMA controller may have to use the DMA API.
> 
> The coherently declared memory given to the DMA subsystem is used for a
> fixed sized DMA pool and no additional allocations are permitted. One could
> choose a DMA mask that pretends to be reasonable, or the opposite, a mask
> such as 1 that is unreasonable on purpose, as Robin writes:
> 
> 	Alternatively, there is perhaps some degree of argument for
> 	deliberately picking a nonzero but useless value like 1,
> 	although it looks like the MIPS allocator (at least the dma-
> 	default one) never actually checks whether the page it gets
> 	is within range of the device's coherent mask, which it
> 	probably should do.
> 
> 	https://lkml.org/lkml/2018/7/6/697

 It does look like an API abuse to me, as I noted above.

> >  I'll be resubmitting a driver for such a device shortly, the DEFZA (the 
> > previous submission can be found here: 
> > <https://marc.info/?l=linux-netdev&m=139841853827404>).  It is interesting 
> > in that the FDDI engine supports host DMA on the reception side (and 
> > consequently the driver uses the DMA API to handle that), while on the 
> > transmission side (as well as with a couple of maintenance queues) it only 
> > does DMA with its onboard buffer memory, the contents of which need to be 
> > copied by the CPU.  So there's no use of the DMA API on the transmission 
> > or maintenance side.  However usual DMA rings (all located in board memory 
> > too) are used for all data moves.
> 
> The DMA for its onboard buffer memory appears to be very similar to the
> IOP and its DMA? That memory is currently copied by the EE, but there are
> other DMA controllers that could handle that, possibly synchronised using
> DMA chaining, which would assist the EE significantly.

 Mind that the DEFZA runs its own RTOS for initialization and management 
support, including in particular SMT (Station Management).  This is run on 
an MC68000 processor.  That processor is interfaced to a bus where board 
memory is attached as well as the RMC (Ring Memory Controller) chip, which 
acts as a DMA master on that bus, like does the host bus interface.  Also 
certain control register writes from the host raise interrupts to the 
MC68000 for special situations to handle.

 All the PDQ-based FDDI adapters also have an M68000 which runs an RTOS, 
however the presence of the PDQ ASIC makes their architecture slightly 
different as the FDDI chipset does host DMA via the PDQ ASIC, which acts 
as a master on the host bus (possibly through a bridge chip like the PFI, 
though TURBOchannel for example is interfaced directly).

 These adapters went through several revisions, all using the Motorola 
FDDI chipset (originally designed by DEC and then sold to Motorola for 
fabrication and marketing, with DEC retaining an unlimited licence to 
use), but with the PDQ (Packet Data Queue, I believe; not officially 
confirmed) replacing the FSI (FDDI System Interface) block, and the CAMEL 
(MAC and ELM (Media Access Controller and Elasticity Buffer and Link 
Management)) and FCG (FDDI Clock Generator) blocks both retained.

> >  The PDQ ASIC was used to interface FDDI to many host buses and in 
> > addition to the 3 bus attachments mentioned above, all of which we have 
> > support for in Linux, it was also used for Q-bus (the DEFQA) and FutureBus 
> > (the DEFAA).  We may have support for the DEFQA one day as I have both 
> > such a board and a suitable system to use it with.  We are unlikely to 
> > have support for the DEFAA, as FutureBus was only used in high-end VAX and 
> > Alpha systems, the size of a full 19" rack at the very least, but it is 
> > there I believe only that the full PDQ addressing capability was actually 
> > utilised.
> 
> Thanks! By the way, is it possible to find spare parts for such vintage
> hardware these days in case of irrepairable failures?

 What do you mean by spare parts?  ICs?  Complete modules can certainly be 
chased, though obviously there are the more common ones, and then there 
are the exotic ones.

 The biggest challenge has turned out to be electrolytic capacitor 
failures in power supplies.  Unfortunately in late 1980s to mid 1990s 
several lines of low-ESR capacitors, used in output filters in switch-mode 
PSUs, were made with a new electrolyte formula based on a quaternary 
ammonium salt.  All they have turned out to suffer from excessive 
corrosion caused by that electrolyte, shortening the lifespan of those 
parts well below the expectations even in the enhanced lines specifically 
made with long life in mind.  Consequently those parts start leaking even 
if unused (or indeed never used) and then obviously cause PSU breakage if 
powered up.

 Those were all from reputable manufacturers, such as Chemi-con, Nichicon 
or Panasonic; not to be confused with the bulged capacitor problem, aka 
capacitor plague, which many ATX PSUs have suffered from mid 1990s to mid 
2000s where cheap parts were used from less reputable manufacturers.

 Sadly I have ruined a couple of PSUs before I realised what the problem 
was and I have been struggling since with tracking down other parts that 
have failed as a result.  I plan to get back to it sometime.

 Some DECstation models are affected, as is other DEC (and non-DEC) 
hardware:

* The 5000/200, /240 and /260 are not affected.

* The 2100 and 3100 are not if stored in their working orientation, as the 
  capacitors are mounted leads up in their PSUs and corrosion only breaks 
  the seal and not the aluminium can.

* The 5000/120, /125, /133 and /150 are all affected and are better 
  recapped -- all SXF Chemi-con parts have to be replaced at the very 
  least.  Newer PSUs use newer LXF Chemi-con parts that haven't failed for 
  me (yet?), but are expected to too.

* I can't speak of the 5000/20, /25, /33, /50 as I haven't got one of 
  these.

* Other pieces of hardware would have to be inspected by their respective 
  owners, e.g. I had a case where I had to recap the PSU of a small Cisco
  Ethernet switch with an FDDI bridge module from that era (that actually 
  used a stock industrial PSU you can still buy new, although at ~£500 + 
  VAT -- not exactly cheaply).

 Other parts that have been failing are the usual Dallas RTC chips having 
an integrated Lithium coin cell depleted; either the DS1287 or the DS1287A 
depending on the specific model of hardware.  DECstations have these chips 
located in the TURBOchannel slot area with little clearance around them.  
Therefore I have been slowly converting them to a version with a discrete 
coin cell embedded in the IC case instead, as photographically documented 
here: <ftp://ftp.linux-mips.org/pub/linux/mips/people/macro/ds1287/>.

 You can still get recently manufactured brand new DS12887 or DS12887A 
parts from Maxim through the usual distribution channels, however for 
reference systems, such as I consider mine, I prefer to use original parts 
to avoid surprises, as the DS12887/A chips have 104 bytes of general NVRAM 
as opposed to 50 bytes with the DS1287/A.

 NB according to HP end of sales for the DEFPA was only 2004-2005 and 
based on occasional enquiries I get as the maintainer it remains deployed 
in production environments.  These boards remain readily available on the 
second-hand market; sometimes you can get at unused old stock even.  
Unless you look for the less common SMF variants, that is.  I own a couple 
of universal-PCI DEFPA boards that use the most recent PFI-3 ASIC (earlier 
versions were 5V-only), some of which have HP recorded as the vendor in 
the subsystem ID.

 Also new TURBOchannel option hardware has been designed and manufactured 
recently, see: <http://www.flxd.de/tc-usb/>. :)  We'll get a Linux driver 
sometime.

> >  NB I sat on this fix from 2014, well before the warning was introduced in 
> > the first place, and it's only now that I got to unloading my patch queue. 
> > :(
> 
> Do you have the latest kernel running on your DECstation machines now? :)

 Yep:

Linux version 4.19.0-rc6 (macro@tp) (gcc version 4.1.2) #3 Mon Oct 1 00:22:03 BST 2018
bootconsole [prom0] enabled
This is a DECstation 5000/2x0
CPU0 revision is: 00000440 (R4400SC)
FPU revision is: 00000500
Checking for the multiply/shift bug... no.
Checking for the daddiu bug... yes, workaround... yes.
Determined physical RAM map:
 memory: 0000000004000000 @ 0000000000000000 (usable)
Primary instruction cache 16kB, VIPT, direct mapped, linesize 16 bytes.
Primary data cache 16kB, direct mapped, VIPT, no aliases, linesize 16 bytes
Unified secondary cache 1024kB direct mapped, linesize 32 bytes.
Zone ranges:
  Normal   [mem 0x0000000000000000-0x0000000003ffffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000000000-0x0000000003ffffff]
Initmem setup node 0 [mem 0x0000000000000000-0x0000000003ffffff]
On node 0 totalpages: 4096
  Normal zone: 14 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 4096 pages, LIFO batch:0
pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
pcpu-alloc: [0] 0
Built 1 zonelists, mobility grouping off.  Total pages: 4082
Kernel command line: rw console=ttyS3 debug panic=60 ip=bootp root=/dev/nfs
Dentry cache hash table entries: 8192 (order: 2, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 1, 32768 bytes)
Memory: 57632K/65536K available (5279K kernel code, 338K rwdata, 1004K rodata, 272K init, 216K bss, 7904K reserved, 0K cma-reserved)
NR_IRQS: 128
I/O ASIC clock frequency 24999536Hz
clocksource: dec-ioasic: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 76451836814 ns
sched_clock: 32 bits at 24MHz, resolution 40ns, wraps every 85900940267ns
MIPS counter frequency 60000464Hz
clocksource: MIPS: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 31854094440 ns
sched_clock: 32 bits at 60MHz, resolution 16ns, wraps every 35791117303ns
Console: colour dummy device 160x64
console [ttyS3] enabled
bootconsole [prom0] disabled
Calibrating delay loop... 59.33 BogoMIPS (lpj=231424)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 2048 (order: 0, 16384 bytes)
Mountpoint-cache hash table entries: 2048 (order: 0, 16384 bytes)
Checking for the daddi bug... no.
random: get_random_u32 called from bucket_table_alloc+0xbc/0x2e8 with crng_init=0
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 14931722236523437 ns
futex hash table entries: 256 (order: -2, 6144 bytes)
NET: Registered protocol family 16
Can't analyze schedule() prologue at (____ptrval____)
HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
SCSI subsystem initialized
tc: TURBOchannel rev. 1 at 25.0 MHz (without parity)
tc0: DEC      PMAG-AA  V1.0a
tc1: DEC      PMAF-FD  V3.1D
tc2: DEC      PMAF-AA  T5.2P-
clocksource: Switched to clocksource MIPS
NET: Registered protocol family 2
tcp_listen_portaddr_hash hash table entries: 1024 (order: 0, 16384 bytes)
TCP established hash table entries: 2048 (order: 0, 16384 bytes)
TCP bind hash table entries: 2048 (order: 0, 16384 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
UDP hash table entries: 512 (order: 0, 16384 bytes)
UDP-Lite hash table entries: 512 (order: 0, 16384 bytes)
NET: Registered protocol family 1
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
workingset: timestamp_bits=62 max_order=12 bucket_order=0
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Console: switching to mono frame buffer device 160x64
fb0: PMAG-AA frame buffer device at tc0
DECstation Z85C30 serial driver version 0.10
ttyS0 at MMIO 0x1f900008 (irq = 14, base_baud = 460800) is a Z85C30 SCC
ttyS1 at MMIO 0x1f900000 (irq = 14, base_baud = 460800) is a Z85C30 SCC
ttyS2 at MMIO 0x1f980008 (irq = 15, base_baud = 460800) is a Z85C30 SCC
ttyS3 at MMIO 0x1f980000 (irq = 15, base_baud = 460800) is a Z85C30 SCC
ms02-nv.c: v.1.0.0  13 Aug 2001  Maciej W. Rozycki.
mtd0: DEC MS02-NV NVRAM at 0x07000000, size 1MiB.
declance.c: v0.011 by Linux MIPS DECstation task force
declance0: IOASIC onboard LANCE, addr = 08:00:2b:35:62:c1, irq = 16
declance0: registered as eth0.
defxx: v1.11 2014/07/01  Lawrence V. Stefani and others
random: fast init done
tc1: DEFTA at MMIO addr = 0x1e900000, IRQ = 20, Hardware addr = 08-00-2b-a3-a3-29
tc1: registered as fddi0
defza: v.1.1.4  Oct  2 2018  Maciej W. Rozycki
tc2: DEC FDDIcontroller 700 or 700-C at 0x1f000000, irq 21
tc2: resetting the board...
tc2: OK
tc2: model 700 (DEFZA-AA), MMF PMD, address 08-00-2b-2e-6d-75
tc2: ROM rev. 1.0, firmware rev. 1.2, RMC rev. A, SMT ver. 1
tc2: link unavailable
tc2: registered as fddi1
mousedev: PS/2 mouse device common for all mice
rtc_cmos rtc_cmos: registered as rtc0
rtc_cmos rtc_cmos: no alarms, 50 bytes nvram
NET: Registered protocol family 10
Segment Routing with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
NET: Registered protocol family 17
rtc_cmos rtc_cmos: setting system clock to 2018-10-01 00:45:12 UTC (1538354712)
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from xxx.xxx.xxx.xxx, my address is xxx.xxx.xxx.xxx
IP-Config: Complete:
     device=eth0, hwaddr=08:00:2b:35:62:c1, ipaddr=xxx.xxx.xxx.xxx, mask=xxx.xxx.xxx.xxx, gw=xxx.xxx.xxx.xxx
fddi1: link available
     host=hhh.hhh.hhh.hhh, domain=, nis-domain=(none)
     bootserver=xxx.xxx.xxx.xxx, rootserver=xxx.xxx.xxx.xxx, rootpath=/ddd/ddd
     nameserver0=xxx.xxx.xxx.xxx
fddi1: link unavailable
VFS: Mounted root (nfs filesystem) on device 0:11.
Freeing unused PROM memory: 112k freed
Freeing unused kernel memory: 272K
This architecture does not have kernel memory protection.
Run /sbin/init as init process
[...]

I had to revert recent changes forcing the minimum of GCC 4.6, and then 
patch up the breakage that was the motivation for the version bump, as I 
cannot easily upgrade my compiler (the newest one I was able to make 
working without NPTL), which will be a process.

 Still 4.18 can be used pristine with CONFIG_32BIT, except for a recent 
build breakage with the RTC driver, my small fix for which has already 
been accepted.  I think 4.17 will build and boot just fine out of the box, 
and I expect the RTC fix to be backported to 4.18 too.

 For CONFIG_64BIT a fix for memory corruption with `memset' is required 
that applies to 4.17 and later versions, and is pending maintainer's 
acceptance.  So I think 4.16 will work just fine, but you need the 
toolchain (GCC+binutils) from my site with a DADDI and DADDIU workarounds 
implemented to build such a kernel.  I think the workarounds will never 
make it upstream due to their intrusiveness, but I mean to maintain them 
indefinitely (though as I mentioned above it'll make me a little bit yet 
to get beyond GCC 4.1.2).

  Maciej
