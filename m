Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2018 09:01:54 +0100 (CET)
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:51048 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeBKIBsTbsNs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Feb 2018 09:01:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 67ABE3F56A;
        Sun, 11 Feb 2018 09:01:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iWTtyexUvfjy; Sun, 11 Feb 2018 09:01:38 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 8BB4A3F4AE;
        Sun, 11 Feb 2018 09:01:34 +0100 (CET)
Date:   Sun, 11 Feb 2018 09:01:33 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>,
        =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Cc:     linux-mips@linux-mips.org
Subject: [RFC] MIPS: R5900: Workaround for CACHE instruction near branch
 delay slot
Message-ID: <20180211080132.GD2222@localhost.localdomain>
References: <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk>
 <20170927172107.GB2631@localhost.localdomain>
 <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
This change has been ported from v2.6 patches. I have not found any note
describing this in the TX79 manual.

diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 4008298c1880..a0b0fbedad8c 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -52,6 +52,14 @@ NESTED(except_vec3_generic, 0, sp)
 #endif
 	PTR_L	k0, exception_handlers(k1)
 	jr	k0
+#ifdef CONFIG_CPU_R5900
+	/* There should be nothing which looks like a cache instruction. */
+	nop
+	nop
+	nop
+	nop
+	nop
+#endif
 	.set	pop
 	END(except_vec3_generic)
 
@@ -709,6 +717,14 @@ isrdhwr:
 	.set	arch=r4000
 	eret
 	.set	mips0
+#ifdef CONFIG_CPU_R5900
+	/* There should be nothing which looks like cache instruction. */
+	nop
+	nop
+	nop
+	nop
+	nop
+#endif
 #endif
 	.set	pop
 	END(handle_ri_rdhwr)
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 761b6c369321..795c490a429f 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1950,12 +1950,36 @@ void __init *set_except_vector(int n, void *addr)
 		u32 *buf = (u32 *)(ebase + 0x200);
 		unsigned int k0 = 26;
 		if ((handler & jump_mask) == ((ebase + 0x200) & jump_mask)) {
+#ifdef CONFIG_CPU_R5900
+			uasm_i_nop(&buf);
+			uasm_i_nop(&buf);
+#endif
 			uasm_i_j(&buf, handler & ~jump_mask);
 			uasm_i_nop(&buf);
+#ifdef CONFIG_CPU_R5900
+			/* There are no data allowed which could be interpreted as cache instruction. */
+			uasm_i_nop(&buf);
+			uasm_i_nop(&buf);
+			uasm_i_nop(&buf);
+			uasm_i_nop(&buf);
+			uasm_i_nop(&buf);
+#endif
 		} else {
+#ifdef CONFIG_CPU_R5900
+			uasm_i_nop(&buf);
+			uasm_i_nop(&buf);
+#endif
 			UASM_i_LA(&buf, k0, handler);
 			uasm_i_jr(&buf, k0);
 			uasm_i_nop(&buf);
+#ifdef CONFIG_CPU_R5900
+			/* There are no data allowed which could be interpreted as cache instruction. */
+			uasm_i_nop(&buf);
+			uasm_i_nop(&buf);
+			uasm_i_nop(&buf);
+			uasm_i_nop(&buf);
+			uasm_i_nop(&buf);
+#endif
 		}
 		local_flush_icache_range(ebase + 0x200, (unsigned long)buf);
 	}
