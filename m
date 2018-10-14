Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Oct 2018 01:51:34 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990509AbeJNXv1a00sR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Oct 2018 01:51:27 +0200
Date:   Mon, 15 Oct 2018 00:51:27 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Fredrik Noring <noring@nocrew.org>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>
Subject: Re: [PATCH] TC: Set DMA masks for devices
In-Reply-To: <20181006092156.GA6783@sx-9>
Message-ID: <alpine.LFD.2.21.1810061515200.7757@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1810030109210.5483@eddie.linux-mips.org> <20181004165720.GA2361@sx-9> <alpine.LFD.2.21.1810041916420.12089@eddie.linux-mips.org> <20181005145612.GA2341@sx-9> <alpine.LFD.2.21.1810051602280.22125@eddie.linux-mips.org>
 <20181006092156.GA6783@sx-9>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66840
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

> >  From the description I take it it is some MMIO memory rather than host 
> > memory.  I fail to see how it is supposed to work with these calls for 
> > non-system memory, which certainly any MMIO memory is, which surely is not 
> > under the supervision of the kernel memory allocator.
> 
> I agree, this is obscure to me too.

 I can't be bothered (sorry!) to study this code or the datasheet for the 
IC to figure out what the arrangement is, but I do encourage you to do so 
if you want to make any changes here.

> >  Mind that the DEFZA runs its own RTOS for initialization and management 
> > support, including in particular SMT (Station Management).  This is run on 
> > an MC68000 processor.  That processor is interfaced to a bus where board 
> > memory is attached as well as the RMC (Ring Memory Controller) chip, which 
> > acts as a DMA master on that bus, like does the host bus interface.  Also 
> > certain control register writes from the host raise interrupts to the 
> > MC68000 for special situations to handle.
> > 
> >  All the PDQ-based FDDI adapters also have an M68000 which runs an RTOS, 
> > however the presence of the PDQ ASIC makes their architecture slightly 
> > different as the FDDI chipset does host DMA via the PDQ ASIC, which acts 
> > as a master on the host bus (possibly through a bridge chip like the PFI, 
> > though TURBOchannel for example is interfaced directly).
> 
> How is its firmware handled? The Linux MIPS wiki entry for the DECstation
> firmware
> 
> https://www.linux-mips.org/wiki/DECstation#Firmware
> 
> is a TODO. :)

 I'm not sure who actually created that entry and what they had in mind.  
Likely the console firmware and any of its peculiarities related to Linux.

> The main reason I'm asking is that the IOP is a MIPS R3000
> (apparently in later product models replaced with a PowerPC 405GP and its
> DECKARD software emulator) that also needs firmware. The IOP most likely
> ought to handle multiple firmware files, in the IRX format, depending on
> its set of services.

 The firmware of these FDDI boards is stored in flash memory onboard, so 
you don't need to do anything to load it as it boots by itself.

 There is a documented way to flash a firmware image by fiddling with the 
control registers appropriately, downloading the new image to board RAM 
and then requesting the board to transfer the image to onboard flash.  
From documentation I gather this process is done entirely by board 
circuitry with no software involved on the board side, that is a failed 
firmware flashing process does not preclude another attempt.

 Normally to start initializing the board you just assert/deassert RESET 
with one of the control registers and the board boots.

 It takes DEFZA 10s to boot (the documented amount of time to wait for the 
driver to wait for the boostrap to complete is 30s).  This is why I made 
initialisation messages so verbose, so that the user is not confused and 
does not conclude the kernel has hung.

 You need to boot the board to retrieve its MAC address as the onboard 
PROM chip holding the address is not accesssible from the host side and 
the address is only returned by the INIT command (NB there is no way to 
override it either).  There is an undocumented quicker way board's console 
support code uses for presentation purposes in a system's console monitor, 
but that's board's internal protocol and I didn't want to risk an 
incompatibility with some board revision out there.

 Therefore the board driver requests its interrupt right away, sets a 
timer, cycles RESET and puts the driver to sleep so that the system does 
not become frozen if the driver is loaded as a module during normal Linux 
operation.  Then either a state change interrupt from the board or the 
timer fires and the driver resumes from there accordingly.

 After reboot a command has to be sent to the board to initialise the DMA 
rings and it also takes a while, though not as much.  My measurements 
indicate 160ms, but it's obviously still too long for the driver to just 
busy-wait there twiddling thumbs, so it puts itself to sleep too.

 An unfortunate side effect of this design is that the the IRQ handler is 
called `tcX' rather than `fddiX', as observed in /proc/interrupts.  Maybe 
I'll propose a `rename_irq' API, however I'm not sure if it's worth it.

 The board also has to be reset during normal operation if the so called 
PC Trace (Physical Connection Trace) event has happened in the course of 
FDDI ring fault recovery (i.e. when the token has been lost and could not 
have been restored with beaconing).  That event causes the board to switch 
into the halted state (the link status LED changes from green to red to 
signify the problem) and the board has to be rebooted by the driver to 
verify it's not this board that is the FDDI station having caused the ring 
fault.

 Then all the usual commands have to be sent to initialise the board, set 
FDDI link parameters, add any CAM entries that were set before the reboot 
and set the promiscuous mode if in use, and then finally join the ring.  
So this is handled with an interrupt-driven state machine as otherwise 
again the driver would have to freeze the system for the duration of all 
this processing.

 The PDQ-based adapters are much quicker, they boot in ~1s.  However the 
current `defxx' driver is flawed in that it does not handle that PC Trace 
event with a state machine and it does freeze the system if that happens, 
remaining in the hardirq context throughout.  Also it may fail DMA buffer 
allocation in the course of the reboot as it (unnecessarily) frees all the 
buffers previously allocated and requests new ones instead.

 I need to fix this all, modelling the solution after `defza', however I 
want to upstream the latter driver first.  Fortunately PC Trace events are 
not that common, but earlier this year someone has already complained 
about this issue with `defxx' causing unacceptable latency problems with 
their system, so I do need to look into it.

> Have you implemented sysfs structures to inspect the DEFZA RTOS? That is
> something I would like to do for the IOP.

 There is no (documented) way to access the internals of board firmware 
(except for the request to flash it).  You only have have access to 
onboard 1MiB of RAM and a bunch of control/status registers.  Likewise 
with the PDQ-based adapters, although their use of RAM is not clearly 
documented (the PFI has a separate BAR for board RAM access) -- I find it 
hard to believe they'd put 1MiB of RAM there only to support firmware 
upgrades, so I think it is still used as a temporary packet buffer and 
other operational purposes.

> > This is a DECstation 5000/2x0
> > CPU0 revision is: 00000440 (R4400SC)
> > FPU revision is: 00000500
> > Checking for the multiply/shift bug... no.
> > Checking for the daddiu bug... yes, workaround... yes.
> > Determined physical RAM map:
> >  memory: 0000000004000000 @ 0000000000000000 (usable)
> 
> Considering the amount of memory, how do compile for it?

 The kernel can be cross-compiled easily and with no pitfalls, so this is 
what I have been always doing.

 With userland builds most software packages can be cross-compiled, but I 
prefer native builds indeed, as these do not require manual tweaking of 
any parameters that cannot be inferred in cross-compilation (fortunately 
modern versions of Autoconf are able to figure out what the sizes of data 
types are even if cross-compiling, as setting these manually used to be a 
real pain).

 For those I usually use my Broadcom SWARM board, which is clocked at 
800Mhz and currently has 3200MiB of RAM (pending a firmware fix of DRAM 
controller initialisation that will hopefully allow for full 4GiB possible 
with modules available on the market out of 8GiB theoretical maximum).  
The SWARM has switchable endianness with the line to control it at reset 
wired to a PCB header used with a jumper as shipped.  I have instead wired 
it to an external switch mounted on a cover plate of an unused option 
slot, so that I don't have to pull the system apart to change the 
endianness.

 I have better equipped DECstations at my remote site though; the maximum 
amount of RAM the /200, /240 and /260 models accept is 480MiB.  The 
remaining 32MiB of space addressable via the KSEG0/KSEG1 spaces is used 
for system ROM and MMIO (for onboard I/O circuitry and TURBOchannel).  
TURBOchannel can also be accessed from 0x20000000 physical up (not with 
the /200), for 3 slots of 512MiB of MMIO space each, however due to an API 
shortcoming system firmware cannot cope with that (as documented on the 
DECstation wiki).

  Maciej
