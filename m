Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Dec 2009 01:44:13 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:40928 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1494755AbZLOAoJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Dec 2009 01:44:09 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id BD6B934180AB;
        Tue, 15 Dec 2009 01:44:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E9EVFUdgWGhF; Tue, 15 Dec 2009 01:44:06 +0100 (CET)
Received: from lenovo.localnet (florian.mimichou.net [88.178.11.95])
        by zmc.proxad.net (Postfix) with ESMTPSA id E14A4341809D;
        Tue, 15 Dec 2009 01:44:05 +0100 (CET)
From:   Florian Fainelli <ffainelli@freebox.fr>
Organization: Freebox
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] MIPS: add readl/write_be
Date:   Tue, 15 Dec 2009 01:44:03 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.30-2-686; KDE/4.3.2; i686; ; )
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        ralf@linux-mips.org
References: <200912121757.56365.ffainelli@freebox.fr> <200912141802.13171.ffainelli@freebox.fr> <10f740e80912141105kcccb4e9y68cf47b35bb7a648@mail.gmail.com>
In-Reply-To: <10f740e80912141105kcccb4e9y68cf47b35bb7a648@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200912150144.04051.ffainelli@freebox.fr>
Return-Path: <ffainelli@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ffainelli@freebox.fr
Precedence: bulk
X-list: linux-mips

Hi Geert,

Le lundi 14 décembre 2009 20:05:50, Geert Uytterhoeven a écrit :
> On Mon, Dec 14, 2009 at 18:02, Florian Fainelli <ffainelli@freebox.fr> wrote:
> > On Saturday 12 December 2009 20:31:14 Thomas Bogendoerfer wrote:
> >> On Sat, Dec 12, 2009 at 05:57:56PM +0100, Florian Fainelli wrote:
> >> > +#define readl_be(addr)                     __raw_readl((__force
> >> > unsigned *)addr) +#define writel_be(val, addr)              
> >> > __raw_writel(val, (__force unsigned *)addr)
> >>
> >> looks broken for little endian machines. __raw_XXX doesn't do any
> >> swapping, so IMHO the correct thing would be to use
> >> be32_to_cpu/cpu_to_be32.
> >
> > Yeah, I missed that point. Please find below version 2 of the patch which
> > also addresses David's comment. --
> > From: Florian Fainelli <ffainelli@freebox.fr>
> > Subject: [PATCH v2] MIPS: add readl_be/writel_be
> >
> > MIPS currently lacks the readl_be and writel_be accessors
> > which are required by BCM63xx for OHCI and EHCI support.
> > Let's define them globally for MIPS. This also fixes the
> > compilation of the bcm63xx defconfig against USB.
> >
> > Changes from v1:
> > - make it work on little-endian machines
> > - protect macros arguments with parenthesis
> >
> > Signed-off-by: Florian Fainelli <ffainelli@freebox.fr>
> > ---
> > diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> > index 436878e..4a76d39 100644
> > --- a/arch/mips/include/asm/io.h
> > +++ b/arch/mips/include/asm/io.h
> > @@ -447,6 +447,9 @@ __BUILDIO(q, u64)
> >  #define readl_relaxed                  readl
> >  #define readq_relaxed                  readq
> >
> > +#define readl_be(addr)                 cpu_to_be32(__raw_readl((__force
> > unsigned *)(addr))) +#define writel_be(val, addr)          
> > __raw_writel(be32_to_cpu((val)), (__force unsigned *)(addr))
> 
> Shouldn't it be the other way around (cpu <-> be32), i.e.
> 
> #define readl_be(addr)
> be32_to_cpu(__raw_readl((__force unsigned *)(addr)))
> #define writel_be(val, addr)
> __raw_writel(cpu_to_be32((val)), (__force unsigned *)(addr))

It should, I inverted the semantics. I should think twice before sending stuff :)
--
From: Florian Fainelli <ffainelli@freebox.fr>
Subject: [PATCH v3] MIPS: add readl/write_be accessors

MIPS currently lacks the readl_be and writel_be accessors
which are required by BCM63xx for OHCI and EHCI support.
Let's define them globally for MIPS. This also fixes the
compilation of the bcm63xx defconfig against USB.

Changes from v2:
- fixed the be/cpu endianness inversion

Changes from v1:
- make it work on little-endian machines
- protect macros arguments with parenthesis

Signed-off-by: Florian Fainelli <ffainelli@freebox.fr>
---
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 436878e..65d7843 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -447,6 +447,9 @@ __BUILDIO(q, u64)
 #define readl_relaxed			readl
 #define readq_relaxed			readq
 
+#define readl_be(addr)			be32_to_cpu(__raw_readl((__force unsigned *)(addr)))
+#define writel_be(val, addr)		__raw_writel(cpu_to_be32((val)), (__force unsigned *)(addr))
+
 /*
  * Some code tests for these symbols
  */
-- 
