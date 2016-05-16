Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2016 14:15:50 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27014177AbcEPMPrhnNqU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 May 2016 14:15:47 +0200
Date:   Mon, 16 May 2016 13:15:47 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org
Subject: [PATCH] DEC: Export `ioasic_ssr_lock' to modules
Message-ID: <alpine.LFD.2.20.1605161305050.19898@eddie.linux-mips.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53456
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Fix a modular `declance' regression caused by LMO commit bb46bf30d13f 
("DECstation SCSI driver clean-ups.")

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
linux-mips-dec-ioasic-ssr-lock-export.diff
Index: linux-20160515-declance-module/arch/mips/dec/setup.c
===================================================================
--- linux-20160515-declance-module.orig/arch/mips/dec/setup.c
+++ linux-20160515-declance-module/arch/mips/dec/setup.c
@@ -60,6 +60,7 @@ EXPORT_SYMBOL(dec_kn_slot_size);
 int dec_tc_bus;
 
 DEFINE_SPINLOCK(ioasic_ssr_lock);
+EXPORT_SYMBOL(ioasic_ssr_lock);
 
 volatile u32 *ioasic_base;
 
