Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 13:24:00 +0200 (CEST)
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:37319 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S2097166Ab0FILX2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 13:23:28 +0200
Received: from faui49h (faui49h.informatik.uni-erlangen.de [131.188.42.58])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id 504435F26E;
        Wed,  9 Jun 2010 13:23:27 +0200 (MEST)
Received: by faui49h (sSMTP sendmail emulation); Wed, 09 Jun 2010 13:23:27 +0200
Date:   Wed, 9 Jun 2010 13:23:27 +0200
From:   Christoph Egger <siccegge@cs.fau.de>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Yoichi Yuasa <yuasa@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     vamos@i4.informatik.uni-erlangen.de
Subject: [PATCH 9/9] Removing dead CONFIG_MTD_PMC_MSP_RAMROOT
Message-ID: <2f41f9174bd6ba24b5609e06e87c47d5f44446d1.1275925108.git.siccegge@cs.fau.de>
References: <cover.1275925108.git.siccegge@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1275925108.git.siccegge@cs.fau.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: siccegge@cs.fau.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6347

CONFIG_MTD_PMC_MSP_RAMROOT doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 .../mips/include/asm/pmc-sierra/msp71xx/msp_prom.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h b/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
index 54ef1a9..786d82d 100644
--- a/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
+++ b/arch/mips/include/asm/pmc-sierra/msp71xx/msp_prom.h
@@ -124,10 +124,6 @@ extern void prom_meminit(void);
 extern void prom_fixup_mem_map(unsigned long start_mem,
 			       unsigned long end_mem);
 
-#ifdef CONFIG_MTD_PMC_MSP_RAMROOT
-extern bool get_ramroot(void **start, unsigned long *size);
-#endif
-
 extern int get_ethernet_addr(char *ethaddr_name, char *ethernet_addr);
 extern unsigned long get_deviceid(void);
 extern char identify_enet(unsigned long interface_num);
-- 
1.6.3.3
