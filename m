Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Aug 2016 08:05:53 +0200 (CEST)
Received: from resqmta-ch2-09v.sys.comcast.net ([69.252.207.41]:57637 "EHLO
        resqmta-ch2-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992022AbcH2GFqdSMWL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Aug 2016 08:05:46 +0200
Received: from resomta-ch2-06v.sys.comcast.net ([69.252.207.102])
        by resqmta-ch2-09v.sys.comcast.net with SMTP
        id eFhUbMZPn1XXBeFhUbUkNr; Mon, 29 Aug 2016 06:05:40 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-06v.sys.comcast.net with SMTP
        id eFhSbqgLrvVwmeFhSbse6B; Mon, 29 Aug 2016 06:05:39 +0000
Subject: Re: SGI Octane && Bridge DMA bug
To:     linux-mips@linux-mips.org
References: <034a1d88-bdf2-8724-6e04-5ae0ba3aef62@gentoo.org>
 <21a02eff-9bd0-c3b9-9845-21b302b8d5ca@gentoo.org>
 <CAGVrzcZ-UsWr_KTLmCHPjv0Qz=GmCp-g3Cqtq8Q3LfeXRFVHLQ@mail.gmail.com>
 <b5270219-8af1-1922-68be-1a216693dc27@gentoo.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <d53b578f-7080-9e59-ba36-649e26d103ab@gentoo.org>
Date:   Mon, 29 Aug 2016 02:05:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <b5270219-8af1-1922-68be-1a216693dc27@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfB/6nmf9C57+ukmUolUzYprq9/x2FKh+d/mRjoQzrpixTdCO+SqjA678a3f9Uf22Xzj27LQQ53tawPRoKv82NABLoQYeARwnTsYcac51VB+wnK/FA41z
 ZwjQecwem7bzaSlWwK71Q/SMccworRaJs4uI6Oxfs6ASOk7jda6l88NI
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 08/28/2016 23:33, Joshua Kinard wrote:
> On 08/28/2016 14:06, Florian Fainelli wrote:
>> 2016-08-28 9:58 GMT-07:00 Joshua Kinard <kumba@gentoo.org>:
>>> On 08/28/2016 08:01, Joshua Kinard wrote:

[snip]

>>
>> Regarding your first question, for all plat_dma_* operations you
>> should be able to inspect the struct device properties and provide the
>> correct implementation based on whether this device is a child of the
>> Bridge IOMMU or not (e.g: looking at dev->parent.name for instance?)
> 
> Stan's original code used to check the struct device *dev arg for !NULL to
> determine if it needed to be cast to struct pci_device for Bridge ops, else,
> regard it as the Impact board.  But when Impact was converted to a platform
> device, that check would no longer work (dev was always set then), so I
> switched it to checking that dev->bus->name was "pci".  I thought that code got
> executed a lot, though, and strcmp() is expensive.  Turns out, the plat_dma_*
> functions are not called very often, so a strcmp() shouldn't be too much of an
> issue.
> 
> 
>> You are right that this only works for addresses that have already
>> been allocated, if you need to make sure that the allocation falls
>> under a particular range as well, which is not taken care of by
>> dma-default.c, either setting an appropriate dma_mask, or providing a
>> custom implementation for dma_ma_ops may be required here.
> 
> OpenBSD's using some "uvm" subsystem that appears to be quite adaptable once
> you set a few parameters, which is what their xbridge driver is doing, but it's
> completely unlike what Linux has.  I can't tell yet if I have to guarantee that
> Bridge DMA allocations have to stay within 0x20000000 and 0x9fffffff (possibly
> subtracting/adding 0x20000000 as needed to deal w/ the physical address
> offset), or if I have to just translate already-allocated addresses to/from
> that range.  If the latter, I should be able to do that w/ dma-coherence.h.
> Else, it'll probably be a custom dma_ops setup.  At least I have Loongson and
> Octeon to look at for examples.
> 
> Luckily, SGI appears to have imported large chunks of the original IRIX PCI
> code into Linux when they were bringing up the Altix platform.  So I've been
> referring back to 2.4.18 and 2.5.70 to see how the "pcibr.c" and "xtalk.c"
> drivers implemented a lot of stuff in IA64.
> 
> Can't find anything specific to the Octane in the Linux code, though.  So I
> can't tell if they had any workarounds in place or not for the Bridge ASIC on
> this platform.  If they did, they probably removed them.
> 

Hrm, so it looks like qla1280 sets a 64-bit DMA mask if BITS_PER_LONG == 64.
I've tried using ZONE_DMA or ZONE_DMA32 (but not both together), with no real
luck so far.  During boot, qla1280 seems to have no issues doing DMA for the
disk probing and other actions.  MD and XFS are the drivers that are triggering
the random Oopses when they try to assemble an array or mount the root partition.

Since ZONE_DMA is for the old 24-bit DMA space (16MB), I think for Octane, I
want ZONE_DMA32, but override MAX_DMA32_PFN to be (1UL << (31 - PAGE_SHIFT)).
Still need to figure out how to handle translating between phys and DMA
addresses to handle the 512MB physical address offset imposed by the system's
design.

I think some of the confusion also arises in that Octane provides three
separate groups of "windows" into Crosstalk space via HEART, its system controller:

  - sixteen 16MB "small" windows, 0x000010000000 - 0x00001f000000
  - sixteen 2GB "medium" windows, 0x000800000000 - 0x000f80000000
  - fifteen 64GB "large" windows, 0x001000000000 - 0x00f000000000

The existing Octane code appears to be picking a "default" window setup by the
firmware, which seems to be the large 64GB windows.  I think some kind of
translation layer would be needed to talk to the HEART to dynamically shift
between the three windows.  Although, not sure why you'd need the smaller
windows at all (64GB is big enough for everyone, right?).

Then you've got the Crossbow (XBOW) that the HEART connects to as widget #8,
and that's how it accesses the other widgets, such as Bridge (widget #f) or
Impact video (widget #c).

Bridge grants you three methods of accessing PCI devices:

  - 64-bit direct-mapped DMA addressing (not affected by 31-bit window bug)
  - 32-bit direct-mapped DMA addressing (affected by 31-bit window bug)
  - 32-bit translated addresses, via a type of built-in IOMMU ("ATE")

The ATE is reportedly rather buggy and OpenBSD seems to avoid using it (only
has 128 "internal" translation entries and cannot be updated while DMA is in
progress).  They go for the 32-bit direct-mapped DMA instead.

On Linux, I've got the Bridge driver using direct-mapped 64-bit DMA for Octane
and Onyx2, and that seems to work OK for Onyx2, regardless of installed memory
(8GB).  Octane is where the problems begin if installed memory is >2GB.  So I
suspect this 31-bit bug is Octane-exclusive.

It would probably help if I understood PCI addressing better.  Still confused
over what a BAR is for, and why qla1280 needs three of them (#0, #1, and #6).
Additionally, if qla1280 can do 64-bit DMA using Bridge's 64-bit direct-mapped
mode, and thus dodge the 31-bit bug, I'm puzzled why it's always MD or XFS that
trigger the Oops.

Do software drivers like MD/XFS do their own DMA, or do they use the DMA
provided by the disk driver?

Goal is to at least get the base I/O devices to work right w/ >2GB RAM,
preferably as 64-bit PCI devices.  I can then go back and look at handling
additional Bridge widgets (such as the PCI shoebox or XIO shoehorn adapters).
PCI devices plugged into the shoebox/horn will probably be pure 32-bit devices,
so I'll have to defeat this 31-bit bug somehow.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
