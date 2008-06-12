Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 20:03:08 +0100 (BST)
Received: from ripley.ciena.com ([63.118.34.24]:32616 "EHLO ripley.ciena.com")
	by ftp.linux-mips.org with ESMTP id S28580687AbYFLTDF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jun 2008 20:03:05 +0100
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [SPAM] linux-2.6.25.4 Porting OOPS
Date:	Thu, 12 Jun 2008 15:02:31 -0400
Message-ID: <A3BA2251DD85404FBBEF7478C29D8742F26EFE@onmxm01.ciena.com>
In-Reply-To: <dcf6addc0806120251t4785dc09tc4a6f0854c5cd425@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [SPAM] linux-2.6.25.4 Porting OOPS
Thread-Index: AcjMcgBfCmtwKgxyS6S8eSW8ouBHYgAQDO5g
References: <dcf6addc0806082001m19d54184pc8ab42b0875c5238@mail.gmail.com> <20B109E2-594E-4329-95C7-F67E9A7882E2@27m.se> <dcf6addc0806120251t4785dc09tc4a6f0854c5cd425@mail.gmail.com>
From:	"Pelton, Dave" <dpelton@ciena.com>
To:	"J.Ma" <sync.jma@gmail.com>, "Markus Gothe" <markus.gothe@27m.se>
Cc:	<linux-mips@linux-mips.org>
X-OriginalArrivalTime: 12 Jun 2008 19:02:31.0559 (UTC) FILETIME=[DDB5C970:01C8CCBE]
Return-Path: <dpelton@ciena.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19524
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dpelton@ciena.com
Precedence: bulk
X-list: linux-mips

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of J.Ma
> Sent: Thursday, June 12, 2008 5:52 AM
> To: Markus Gothe
> Cc: linux-mips@linux-mips.org
> Subject: Re: [SPAM] linux-2.6.25.4 Porting OOPS
> 
> On Mon, Jun 9, 2008 at 1:53 PM, Markus Gothe 
> <markus.gothe@27m.se> wrote:
> > Start with checking the memory mapping as hinted by:
> > ra    : 8000dd10 copy_user_highpage+0x98/0x158
> > //Markus
> 
> Thank you for your advice, I checked this function and found that the
> problem might be "cpu_has_dc_aliases", After disabling
> MIPS_CACHE_ALIASES in probe_pcache(), the linux goes on with no oops.
> Could anyone here provide instructions about fusion MIPS SOC(R3K/R4K
> for example)? It confused me a lot. :)


Recently I have been working with 2.6.25.4 on a Broadcom SOC (Raven
56210) with an embedded MIPS32 core, and I had problems similar to what
you were experiencing.

My understanding of the probe code is that there is an automatic
detection of data cache aliasing based on the size of your memory and
the properties of the data cache itself.  Thus while your fix may
address
your initial kernel OOPs problem, you may be exposed to other problems
as
a result of data cache aliasing.

The problem I had on my system was that my userspace init would crash
(SIGSEGV).  The same userspace code would run fine on an older kernel
(2.6.14).  Changing the init call to other things (such as /bin/sh)
would
lead to similar problems.  Using a JTAG debugger, I was able to track
things into the copy_user_highpage function, and I found that this
function was calling copy_page with a source address that had incorrect
data.  The source address was coming from kmap_coherent (which is only
used if cpu_has_dc_aliases is true).  As far as I can tell, the job of
kmap_coherent is to map a user page into kernel virtual memory (kseg2).
Normally kseg2 is in the address range 0xC0000000-0xFFFFFFFF.  However,
on the BMIPS3300 (the embedded MIPS32 core used on my SOC), there is a
range of addresses within kseg2 that are reserved
(0xFF200000-0xFFFEFFFF).
This means that the TLB entry that kmap_coherent creates will not work
if it falls within the reserved range.  The virtual address space used
by kmap_coherent is controlled by FIXADDR_TOP in
include/asm-mips/fixmap.h.
To fix my issue, I changed FIXADDR_TOP to avoid the reserved address
space.

I am hoping to provide a full set of patches to support the evaluation
board that has this chip.  In the meantime, here is the change I made to
include/asm-mips/fixmap.h:

--- linux-2.6.25.4-clean/include/asm-mips/fixmap.h      2008-05-15
11:00:12.000000000 -0400
+++ linux-2.6.25.4/include/asm-mips/fixmap.h    2008-06-12
13:21:49.042673000 -0400
@@ -69,6 +69,8 @@ enum fixed_addresses {
  */
 #if defined(CONFIG_CPU_TX39XX) || defined(CONFIG_CPU_TX49XX)
 #define FIXADDR_TOP    ((unsigned long)(long)(int)(0xff000000 -
0x20000))
+#elif defined(CONFIG_CPU_BMIPS3300)
+#define FIXADDR_TOP    ((unsigned long)(long)(int)0xff200000 - 0x1000)
 #else
 #define FIXADDR_TOP    ((unsigned long)(long)(int)0xfffe0000)
 #endif

You will need to define CONFIG_CPU_BMIPS3300 in your config file for
this change to be applied.  I suspect that the same core is present in
a number of Broadcom SOC designs, so this issue may exist for a number
of different chips.


- David Pelton
