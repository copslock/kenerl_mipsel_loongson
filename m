Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Dec 2009 11:27:46 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:57608 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493517AbZLPK1i (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Dec 2009 11:27:38 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 4FE87341832C;
        Wed, 16 Dec 2009 11:27:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id An2r6S0PFLFR; Wed, 16 Dec 2009 11:27:35 +0100 (CET)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by zmc.proxad.net (Postfix) with ESMTPSA id D0DE03418277;
        Wed, 16 Dec 2009 11:27:35 +0100 (CET)
From:   Florian Fainelli <ffainelli@freebox.fr>
Organization: Freebox
To:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: add readl/write_be
Date:   Wed, 16 Dec 2009 11:29:06 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-16-server; KDE/4.3.2; x86_64; ; )
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
References: <200912121757.56365.ffainelli@freebox.fr> <200912150144.04051.ffainelli@freebox.fr> <20091215082521.GA16778@linux-mips.org>
In-Reply-To: <20091215082521.GA16778@linux-mips.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200912161129.07023.ffainelli@freebox.fr>
Return-Path: <ffainelli@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25408
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ffainelli@freebox.fr
Precedence: bulk
X-list: linux-mips

From: Florian Fainelli <ffainelli@freebox.fr>
Subject: [PATCH v3] MIPS: add readl/write_be accessors

MIPS currently lacks the readl_be and writel_be accessors
which are required by BCM63xx for OHCI and EHCI support.
Let's define them globally for MIPS. This also fixes the
compilation of the bcm63xx defconfig against USB.

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
