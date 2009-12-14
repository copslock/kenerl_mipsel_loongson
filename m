Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Dec 2009 18:01:18 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:38362 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1494314AbZLNRBO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Dec 2009 18:01:14 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 4EC2034182F8;
        Mon, 14 Dec 2009 18:01:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S+L-gAz3og5L; Mon, 14 Dec 2009 18:01:13 +0100 (CET)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by zmc.proxad.net (Postfix) with ESMTPSA id CC22A34182DC;
        Mon, 14 Dec 2009 18:01:13 +0100 (CET)
From:   Florian Fainelli <ffainelli@freebox.fr>
Organization: Freebox
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 2/2] MIPS: add readl/write_be
Date:   Mon, 14 Dec 2009 18:02:13 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-16-server; KDE/4.3.2; x86_64; ; )
Cc:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>,
        ralf@linux-mips.org
References: <200912121757.56365.ffainelli@freebox.fr> <20091212193114.GA11103@alpha.franken.de>
In-Reply-To: <20091212193114.GA11103@alpha.franken.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200912141802.13171.ffainelli@freebox.fr>
Return-Path: <ffainelli@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ffainelli@freebox.fr
Precedence: bulk
X-list: linux-mips

Hello Thomas,

On Saturday 12 December 2009 20:31:14 Thomas Bogendoerfer wrote:
> On Sat, Dec 12, 2009 at 05:57:56PM +0100, Florian Fainelli wrote:
> > +#define readl_be(addr)			__raw_readl((__force unsigned *)addr)
> > +#define writel_be(val, addr)		__raw_writel(val, (__force unsigned
> > *)addr)
> 
> looks broken for little endian machines. __raw_XXX doesn't do any swapping,
> so IMHO the correct thing would be to use be32_to_cpu/cpu_to_be32.

Yeah, I missed that point. Please find below version 2 of the patch which also addresses David's comment.
--
From: Florian Fainelli <ffainelli@freebox.fr>
Subject: [PATCH v2] MIPS: add readl_be/writel_be

MIPS currently lacks the readl_be and writel_be accessors
which are required by BCM63xx for OHCI and EHCI support.
Let's define them globally for MIPS. This also fixes the
compilation of the bcm63xx defconfig against USB.

Changes from v1:
- make it work on little-endian machines
- protect macros arguments with parenthesis

Signed-off-by: Florian Fainelli <ffainelli@freebox.fr>
---
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 436878e..4a76d39 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -447,6 +447,9 @@ __BUILDIO(q, u64)
 #define readl_relaxed			readl
 #define readq_relaxed			readq
 
+#define readl_be(addr)			cpu_to_be32(__raw_readl((__force unsigned *)(addr)))
+#define writel_be(val, addr)		__raw_writel(be32_to_cpu((val)), (__force unsigned *)(addr))
+
 /*
  * Some code tests for these symbols
  */
-- 
