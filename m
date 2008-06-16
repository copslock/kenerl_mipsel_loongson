Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2008 16:52:11 +0100 (BST)
Received: from hicks.ciena.com ([63.118.34.22]:63753 "EHLO hicks.ciena.com")
	by ftp.linux-mips.org with ESMTP id S20039780AbYFPPwJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jun 2008 16:52:09 +0100
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAAMpVkg/dicb/2dsb2JhbACtUQ
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [SPAM] linux-2.6.25.4 Porting OOPS
Date:	Mon, 16 Jun 2008 11:52:08 -0400
Message-ID: <C34407D180E1CD45900A63F8E6448CBFFA44@onmxm01.ciena.com>
In-Reply-To: <485303CE.8060504@cisco.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [SPAM] linux-2.6.25.4 Porting OOPS
Thread-Index: AcjNrfqBQoKFHNPtTUG9QUci5nASxgCFmUfA
References: <dcf6addc0806082001m19d54184pc8ab42b0875c5238@mail.gmail.com> <20B109E2-594E-4329-95C7-F67E9A7882E2@27m.se> <dcf6addc0806120251t4785dc09tc4a6f0854c5cd425@mail.gmail.com> <A3BA2251DD85404FBBEF7478C29D8742F26EFE@onmxm01.ciena.com> <485303CE.8060504@cisco.com>
From:	"Pelton, Dave" <dpelton@ciena.com>
To:	"David VomLehn" <dvomlehn@cisco.com>
Cc:	"J.Ma" <sync.jma@gmail.com>, "Markus Gothe" <markus.gothe@27m.se>,
	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 16 Jun 2008 15:52:06.0241 (UTC) FILETIME=[ED579D10:01C8CFC8]
Return-Path: <dpelton@ciena.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dpelton@ciena.com
Precedence: bulk
X-list: linux-mips

David VomLehn wrote:
> Pelton, Dave wrote:
> > <snip>
> > Normally kseg2 is in the address range 0xC0000000-0xFFFFFFFF.
However,
> > on the BMIPS3300 (the embedded MIPS32 core used on my SOC), there is
a
> > range of addresses within kseg2 that are reserved
> > (0xFF200000-0xFFFEFFFF).
> > This means that the TLB entry that kmap_coherent creates will not
work
> > if it falls within the reserved range.  The virtual address space
used
> > by kmap_coherent is controlled by FIXADDR_TOP in
> > include/asm-mips/fixmap.h.
> > To fix my issue, I changed FIXADDR_TOP to avoid the reserved address
> > space.
> <snip>
> 
> Is your range of addresses reserved on the BMIPS3300 because it is
being used as
> dseg, i.e. because it is being used for debugging? If I read the
documentation on
> the processor I am using, the 24Kc, it has a similar issue. I don't
need to be
> able to use kmap_coherent because the 24K hardware takes care of data
coherence
> issues, i.e. cpu_has_dc_aliases is false, but I'm sort of thinking we
might just
> generally want to change FIXADDR_TOP to avoid address in the dseg
range for all
> MIPS32 processors. As we work our way through some of the cache
flushing issues
> related to using high memory, I'd like to be able to develop code that
works on
> processors for which cpu_has_dc_aliases is true. If my kmap_coherent
is working I
> can check things out for those processors and then simply use
kmap_atomic for
> processors where cpu_has_dc_aliases is false.

Apologies in advance for what my plain-text impaired mail client is
likely to do to this message.  The reserved range on the BMIPS3300 is
used by memory mapped registers.  I am not a memory management expert,
so I am not sure what implications there would be to moving FIXADDR_TOP
as a general fix.  The impression I have from general MIPS documentation
is that kseg2 should not be used for memory mapped i/o and hence
platforms that do this should be treated as an exception case, rather
than moving the general case to deal with this.

- David Pelton
