Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 12 Dec 2009 17:58:13 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:51632 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493162AbZLLQ56 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 12 Dec 2009 17:57:58 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 9C5DD341810B;
        Sat, 12 Dec 2009 17:57:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IdX9+eFGyzEZ; Sat, 12 Dec 2009 17:57:57 +0100 (CET)
Received: from lenovo.localnet (florian.mimichou.net [88.178.11.95])
        by zmc.proxad.net (Postfix) with ESMTPSA id 086E634180CD;
        Sat, 12 Dec 2009 17:57:57 +0100 (CET)
From:   Florian Fainelli <ffainelli@freebox.fr>
To:     linux-mips@linux-mips.org, Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 2/2] MIPS: add readl/write_be
Date:   Sat, 12 Dec 2009 17:57:56 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.30-2-686; KDE/4.3.2; i686; ; )
Organization: Freebox
Cc:     ralf@linux-mips.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200912121757.56365.ffainelli@freebox.fr>
Return-Path: <ffainelli@freebox.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ffainelli@freebox.fr
Precedence: bulk
X-list: linux-mips

MIPS currently lacks the readl_be and writel_be accessors
which are required by BCM63xx for OHCI and EHCI support.
Let's define them globally for MIPS. This also fixes the
compilation of the bcm63xx defconfig against USB.

Signed-off-by: Florian Fainelli <ffainelli@freebox.fr>
---
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 436878e..65cb4e4 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -447,6 +447,9 @@ __BUILDIO(q, u64)
 #define readl_relaxed			readl
 #define readq_relaxed			readq
 
+#define readl_be(addr)			__raw_readl((__force unsigned *)addr)
+#define writel_be(val, addr)		__raw_writel(val, (__force unsigned *)addr)
+
 /*
  * Some code tests for these symbols
  */
-- 
