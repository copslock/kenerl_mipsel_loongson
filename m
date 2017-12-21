Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Dec 2017 14:41:48 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:33662 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990437AbdLUNllWfvvZ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Dec 2017 14:41:41 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 21 Dec 2017 13:41:34 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 21 Dec
 2017 05:41:22 -0800
Date:   Thu, 21 Dec 2017 13:41:20 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Yuri Frolov <crashing.kernel@gmail.com>
CC:     <linux-mips@linux-mips.org>, <paul.burton@mips.com>
Subject: Re: [P5600 && EVA memory caching question] PCI region
Message-ID: <20171221134119.GE5027@jhogan-linux.mipstec.com>
References: <6132c323-32a7-1d38-b77c-a191be22faa4@gmail.com>
 <20171206114611.GM5027@jhogan-linux.mipstec.com>
 <330a5200-531f-fcfa-674a-c81fb3144e92@gmail.com>
 <20171214152138.GV5027@jhogan-linux.mipstec.com>
 <ca9adcbc-9777-46a0-ce0b-15e83e01fc72@gmail.com>
 <20171215232821.GA5027@jhogan-linux.mipstec.com>
 <b8706fae-aea8-99b5-f91d-37690eff6949@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <b8706fae-aea8-99b5-f91d-37690eff6949@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1513863693-298555-26274-40651-2
X-BESS-VER: 2017.16-r1712182224
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.188219
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61534
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

On Wed, Dec 20, 2017 at 06:11:04PM +0300, Yuri Frolov wrote:
> Hi, James
> 
> On 12/16/2017 02:28 AM, James Hogan wrote:
> > On Fri, Dec 15, 2017 at 05:05:12PM +0300, Yuri Frolov wrote:
> >> Hi, James
> >>
> >> On 12/14/2017 06:21 PM, James Hogan wrote:
> >>> Hi Yuri,
> >>>
> >>> On Thu, Dec 14, 2017 at 06:03:11PM +0300, Yuri Frolov wrote:
> >>>> Hi, James.
> >>>>
> >>>> Do I understand correctly, that in case of CONFIG_EVA=y, any logical
> >>>> address from 0x00000000 - 0xBFFFFFFF (3G) range accessed from the kernel
> >>>> space is:
> >>>> 1) Unmapped (no TLB translations)
> >>>> 2) Is mapped 1:1 to physical addresses? E.g, readl from 0x20000000 is,
> >>>> in fact a read from physical address 0x20000000? I mean, in legacy
> >>>> memory mapping scheme, logical addresses 0x80000000 - 0xBFFFFFFF in
> >>>> kernel space were being translated to the physical addresses from the
> >>>> low 512Mb (phys 0x00000000 - 0x20000000), no such bits stripping or
> >>>> something for EVA, the mapping is 1:1?
> >>> That depends on the EVA configuration. The hardware is fairly flexible
> >>> (which is both useful and painful - making supporting EVA from
> >>> multiplatform kernels particularly awkward), but that is one possible
> >>> configuration.
> >>>
> >>> E.g. ideally you probably want to keep seg5 (0x00000000..0x3FFFFFFF)
> >>> MUSK (TLB mapped for user & kernel) so that null dereferences from
> >>> kernel code are safely caught, but that costs you 1GB of directly
> >>> accessible physical address space from kernel mode.
> >> So, do I understand correctly, that provided we have these TLB entries
> >> in kernel,
> >>
> >> Index: 71 pgmask=16kb va=c0038000 asid=00
> >>           [ri=0 xi=0 pa=200e0000 c=2 d=1 v=1 g=1] [ri=0 xi=0 pa=00000000
> >> c=0 d=0 v=0 g=1]
> >> Index: 72 pgmask=16kb va=c0040000 asid=00
> >>           [ri=0 xi=0 pa=200c0000 c=2 d=1 v=1 g=1] [ri=0 xi=0 pa=200c4000
> >> c=2 d=1 v=1 g=1]
> >>
> >> u32 l;
> >>
> >> l = readl((const volatile void *)(0x200c0000 + 0x20))
> > assuming you have segment5 (0x00000000..0x3FFFFFFF) set to MUSUK, with
> > PA 0 (i.e. direct 1:1 mapping), it'd access PA 0x200c0020, but
> > presumably the segment will be configured to be cached (CCA 3) or cached
> > coherent (CCA 5).
> >
> >> and
> >> l = *(u32 *)(0xc0040000+ 0x20)
> > this will access physical addres 0x200c0020 uncached (CCA 2).
> >
> >> should return the same value?
> > So that would depend I think on whether there is a dirty value in the
> > cache. Possibly not. The cached mapping would see the dirty value. The
> > uncached mapping may see a stale value straight from RAM.
> >
> > Cheers
> > James
> I'm looking at arch/mips/include/asm//mach-malta/kernel-entry-init.h and 
> there is a definition for SegCtl2:
> 
>          /* SegCtl2 */
>          li      t0, ((MIPS_SEGCFG_MUSUK << MIPS_SEGCFG_AM_SHIFT) |      \
>                  (6 << MIPS_SEGCFG_PA_SHIFT) |                           \
>                  (1 << MIPS_SEGCFG_EU_SHIFT)) |                          \
>                  (((MIPS_SEGCFG_MUSUK << MIPS_SEGCFG_AM_SHIFT) |         \
>                  (4 << MIPS_SEGCFG_PA_SHIFT) |                           \
>                  (1 << MIPS_SEGCFG_EU_SHIFT)) << 16)
> 
> it defines, that kernel logical addresses from the range 0x00000000 - 
> 0x7fffffff are unmapped (no tlbs) and dictates, that in order to get a 
> physical address for any logical addresses from 0x00000000 - 0x3fffffff 
> range in kernel space, bits [31:29] of the logical address must be 
> changed to 100,
> and (again in kernel space) for any logical addresses from 0x40000000 - 
> 0x7fffffff range, bits [31:29] of the logical address must be changed to 
> 110, right?

yes, the Malta implementation is slightly ugly as it relies on a
hardware physical memory alias of RAM starting at PA 0x80000000.

> 
> What physical addresses will logical addresses 0x00000000 and 0x20000000 
> be translated in kernel space?.. logical 0x00000000 --> physical 
> 0x80000000, and logical 0x20000000 --> .... 0x80000000 too?

VA 0x20000000 -> PA 0xa0000000, since seg4 and seg5 are 1GB segments, so
its only bits 30 and up that can be changed. I seem to remember the bit
corresponding to bit 29 isn't even writable in the SegCtl2 register.

Does that clarify things?

Cheers
James

> Since we must to change bits [31:29], we have to change bit 29 ('1') in 
> logical address 0x200000000 to '0' (since PA for this range is 100).
> 
> So, what physical addresses will all logical addresses which have '1' at 
> 29 bit be translated, if we define PA as 100 and 110 in SegCtl2? It 
> looks like there's no flat translation of logical addresses to physical 
> addresses in kernel space, and this is obviously just not correct, there 
> is something simple I've been overlooking.
> 
> Thank you,
> Yuri
