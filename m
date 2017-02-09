Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Feb 2017 19:37:30 +0100 (CET)
Received: from resqmta-po-09v.sys.comcast.net ([IPv6:2001:558:fe16:19:96:114:154:168]:58168
        "EHLO resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993133AbdBIShXSwA0Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Feb 2017 19:37:23 +0100
Received: from resomta-po-12v.sys.comcast.net ([96.114.154.236])
        by resqmta-po-09v.sys.comcast.net with SMTP
        id btZ3cczsIODBvbtarcE9Ly; Thu, 09 Feb 2017 18:37:21 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-po-12v.sys.comcast.net with SMTP
        id btaocqr2nL4A9btapcm0FH; Thu, 09 Feb 2017 18:37:21 +0000
Subject: Re: [PATCH 12/12] MIPS: PCI: Fix IP27 for the PCI_PROBE_ONLY case
To:     Bjorn Helgaas <bhelgaas@google.com>
References: <20170207061356.8270-1-kumba@gentoo.org>
 <20170207061356.8270-13-kumba@gentoo.org>
 <CAErSpo6yKAE1_c1eZJapnjD1g0pocyOxed3_Eumdp_026uhDuA@mail.gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux/MIPS <linux-mips@linux-mips.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <bb0e51d8-ce27-0b12-3963-1a5e3d1eaa57@gentoo.org>
Date:   Thu, 9 Feb 2017 13:36:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAErSpo6yKAE1_c1eZJapnjD1g0pocyOxed3_Eumdp_026uhDuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfB6ykqqpBOEKuj4QpSS3rihFP26kVuxikwHXSr7vOGf7Xzzr8t6RCWom9cfr4gjZvqx23zsZE4cIQ25njRYSxgebL4j8TCVXh3vW18PNuPoMa9KU3Qkf
 6vV0zAprZwgHutk6AGeiJHOTQOD+wBHjkupS2StsXlfPPaKBytdGASf/zpXDhgzXp1tJzicejEIlXSDk6RH48l8urTCon4iUve8BggHB/nI7/6tAaz3wym01
 W3Y3kG7RMOuVy4rndeqq84BRK3e1syGUriOq1BFB/8Zg4+YxiprS7jjsCB8QnRg7DHgILfTp5TCRp5o4XuBbJw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56748
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

On 02/07/2017 13:29, Bjorn Helgaas wrote:

[snip]

>>
>> However, IP27 is completely different in this regard.  Instead of using
>> ioremapped addresses for I/O, IP27 has a dedicated address range,
>> 0x92xxxxxxxxxxxxxx, that is used for all I/O access.  Since this is
>> uncached physical address space, the generic MIPS PCI code will not
>> probe it correctly and thus, the original behavior of PCI_PROBE_ONLY
>> needs to be restored only for the IP27 platform to bypass this logic
>> and have working PCI, at least for the IO6/IO6G board that houses the
>> base devices, until a better solution is found.
> 
> It sounds like there's something different about how ioremap() works
> on these platforms and PCI probing is tripping over that.  I'd really
> like to understand more about this difference to see if we can
> converge that instead of adding back the PCI_PROBE_ONLY usage.
> 
> Drivers shouldn't know whether they're running on IP27 or IP30, and
> they should be using ioremap() in both cases.  Does ioremap() work
> differently on IP27 and IP30?  Does this have something to do with
> plat_ioremap() or fixup_bigphys_addr()?

Okay, I think I have a rough idea on the differences with the I/O addresses on
IP27 and IP30.  It all boils down to the return value of a macro called
NODE_SWIN_BASE, which operates differently on each platform.

I don't fuilly understand //why// SGI did it a certain way, but HUB in IP27
gives you two sets of "windows" into Crosstalk space, "Big" (BWIN) and "Little"
(LWIN).  IP30's HEART chip has three sets of these windows (as I recall now
from and appendix in the BRIDGE docs), Big (BWIN), medium (MWIN) and small (SWIN).

So on IP27, HUB has seven BWIN spaces at 512MB each, and one LWIN space at
256MB (with a second LWIN that's aliased to the first).  The LWIN is broken
into sixteen 16MB spaces, which, I think, is what we're calling "Small windows"
or SWIN's (Ralf, correct me if wrong).

IP30's HEART allocates 64G of space per Xtalk widget for BWIN, 2G/widget for
MWIN, and 16MB/widget for SWIN.  As such, since HUB doesn't have an MWIN, you
only find definitions of NODE_BWIN_BASE and NODE_SWIN_BASE in either IP27 or
IP30's sources.  Specifically, our focus is really only on NODE_SWIN_BASE,
because the BWIN spaces need to be mapped into translation tables somewhere,
and Linux lacks that capability.  There is also a corresponding
RAW_NODE_SWIN_BASE for both platforms that gives back the full address in
uncached physical address space.

IP30's definition of NODE_SWIN_BASE is:
#define NODE_SWIN_BASE(nasid, widget) \
	(0x0000000010000000 | (((unsigned long)(widget)) << 24))

And IP30's RAW_NODE_SWIN_BASE:
#define RAW_NODE_SWIN_BASE(nasid, widget) \
	(0x9000000010000000 | (((unsigned long)(widget)) << 24))


Contrast that to IP27's NODE_SWIN_BASE (for the __ASSEMBLY__ case)
in arch/mips/include/asm/sn/sn0/addrs.h:
#define NODE_SWIN_BASE(nasid, widget) \
	(NODE_IO_BASE(nasid) + (UINT64_CAST(widget) << SWIN_SIZE_BITS))

(IP27's RAW_NODE_SWIN_BASE is the same as above)

SWIN_SIZE_BITS is '24', so it matches IP30's.  The difference is the value of
NODE_IO_BASE that takes a nasid (NUMA address space identifier or node id) and
returns the correct address in IP27's memory space to get to a specific node's
I/O Base, which is 0x9200000000000000 plus the node ID.  Merged with the widget
ID shifted by 24 bits, and that's why we're getting the 0x92xx addresses.

Basically, IP30 is returning the widget offset //without// the I/O base
factored in, and that's why RAW_NODE_SWIN_BASE is provided to get the widget
address in uncached physical address space.  Whereas IP27's NODE_SWIN_BASE is
an alias to its RAW_NODE_SWIN_BASE definition and turning 0x92xxx addresses.

---

Then we look in arch/mips/include/asm/io.h at the function __ioremap_mode and
see this construct near the top:

        if (cpu_has_64bit_addresses) {
                u64 base = UNCAC_BASE;

                /*
                 * R10000 supports a 2 bit uncached attribute therefore
                 * UNCAC_BASE may not equal IO_BASE.
                 */
                if (flags == _CACHE_UNCACHED)
                        base = (u64) IO_BASE;
                return (void __iomem *) (unsigned long) (base + offset);

For IP30, when we set up the BRIDGE parameters, we use NODE_SWIN_BASE to set
the BRIDGE's MEM and IO start/end ranges and thus get back an address where the
upper bits are all zero's.  Which the PCI layer then fiddles with to yield an
address like 0x000000f100000000.  When that gets run through ioremap() by a
driver's probe, we should be getting something like 0x900000f100000000, because
IP30 uses the generic definition of IO_BASE defined in MIPS
asm-generic/spaces.h.  And the devices probe correctly.

For IP27, I program BRIDGE the same way, but because IP27's NODE_SWIN_BASE is
returning the 0x92xxx addresses in uncached space, my guess is ioremap(), as
called by the drivers, is doubling that, yielding addresses like 0x24xxx, which
unprotected, should generate an unhandled kernel unaligned access or such.
Properly protected, attempts to access such an address probably just fail outright.

---

So my thinking, which I'll test out over the weekend, is whether we can change
IP27's NODE_SWIN_BASE to behave more like IP30's and just return the widget id
shifted by 24 bits, then let ioremap() calls actually do the conversion to the
0x92xxx IO_BASE address space.  There's only a handful of places in IP27's code
and headers where NODE_SWIN_BASE is actually used, so I'll have to see which
ones need to become RAW_NODE_SWIN_BASE (e.g., for direct HUB or XBOW access),
and which can stay as NODE_SWIN_BASE.

That would then allow the correct operation of ioremap() to return the 0x92xxx
address space for drivers and I guess PCI to probe correctly.  We'll find out!

--J
