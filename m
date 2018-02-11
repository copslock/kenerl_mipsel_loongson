Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Feb 2018 09:09:40 +0100 (CET)
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:58997 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeBKIJdPr1Ws (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Feb 2018 09:09:33 +0100
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 362003F5D0;
        Sun, 11 Feb 2018 09:09:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id X_ffyhZY3Pkb; Sun, 11 Feb 2018 09:09:22 +0100 (CET)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id DE1603F45D;
        Sun, 11 Feb 2018 09:09:17 +0100 (CET)
Date:   Sun, 11 Feb 2018 09:09:16 +0100
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@mips.com>,
        =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>
Cc:     linux-mips@linux-mips.org
Subject: [RFC] MIPS: R5900: The ERET instruction has issues with delay slot
 and CACHE
Message-ID: <20180211080914.GE2222@localhost.localdomain>
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
X-archive-position: 62490
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

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index e23765312e25..b67f31d04716 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -1378,6 +1378,16 @@ static void build_r4000_tlb_refill_handler(void)
 		uasm_l_leave(&l, p);
 		uasm_i_eret(&p); /* return from trap */
 	}
+
+#ifdef CONFIG_CPU_R5900
+	/* There should be nothing which can be interpreted as cache instruction. */
+	uasm_i_nop(&p);
+	uasm_i_nop(&p);
+	uasm_i_nop(&p);
+	uasm_i_nop(&p);
+	uasm_i_nop(&p);
+#endif
+
 #ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
 	uasm_l_tlb_huge_update(&l, p);
 	if (htlb_info.need_reload_pte)
@@ -2132,6 +2142,14 @@ build_r4000_tlbchange_handler_tail(u32 **p, struct uasm_label **l,
 	uasm_l_leave(l, *p);
 	build_restore_work_registers(p);
 	uasm_i_eret(p); /* return from trap */
+#ifdef CONFIG_CPU_R5900
+	/* There should be nothing which can be interpreted as cache instruction. */
+	uasm_i_nop(p);
+	uasm_i_nop(p);
+	uasm_i_nop(p);
+	uasm_i_nop(p);
+	uasm_i_nop(p);
+#endif
 
 #ifdef CONFIG_64BIT
 	build_get_pgd_vmalloc64(p, l, r, tmp, ptr, not_refill);
