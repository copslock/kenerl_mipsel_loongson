Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jun 2010 13:23:11 +0200 (CEST)
Received: from faui40.informatik.uni-erlangen.de ([131.188.34.40]:37241 "EHLO
        faui40.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S2097171Ab0FILWi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Jun 2010 13:22:38 +0200
Received: from faui49h (faui49h.informatik.uni-erlangen.de [131.188.42.58])
        by faui40.informatik.uni-erlangen.de (Postfix) with SMTP id C78615F26E;
        Wed,  9 Jun 2010 13:22:36 +0200 (MEST)
Received: by faui49h (sSMTP sendmail emulation); Wed, 09 Jun 2010 13:22:37 +0200
Date:   Wed, 9 Jun 2010 13:22:37 +0200
From:   Christoph Egger <siccegge@cs.fau.de>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     vamos@i4.informatik.uni-erlangen.de
Subject: [PATCH 7/9] Removing dead CONFIG_PMCTWILED
Message-ID: <0a4b5e5841e7842f7b80e368c1d103b5e98d3335.1275925108.git.siccegge@cs.fau.de>
References: <cover.1275925108.git.siccegge@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1275925108.git.siccegge@cs.fau.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27107
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: siccegge@cs.fau.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6344

CONFIG_PMCTWILED doesn't exist in Kconfig, therefore removing all
references for it from the source code.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c b/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c
index 11769b5..c841f08 100644
--- a/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c
+++ b/arch/mips/pmc-sierra/msp71xx/msp_hwbutton.c
@@ -32,9 +32,6 @@
 #include <msp_int.h>
 #include <msp_regs.h>
 #include <msp_regops.h>
-#ifdef CONFIG_PMCTWILED
-#include <msp_led_macros.h>
-#endif
 
 /* For hwbutton_interrupt->initial_state */
 #define HWBUTTON_HI	0x1
@@ -82,10 +79,6 @@ static void standby_on(void *data)
 	printk(KERN_WARNING "STANDBY switch was set to ON (not implemented)\n");
 
 	/* TODO: Put board in standby mode */
-#ifdef CONFIG_PMCTWILED
-	msp_led_turn_off(MSP_LED_PWRSTANDBY_GREEN);
-	msp_led_turn_on(MSP_LED_PWRSTANDBY_RED);
-#endif
 }
 
 static void standby_off(void *data)
@@ -94,10 +87,6 @@ static void standby_off(void *data)
 		"STANDBY switch was set to OFF (not implemented)\n");
 
 	/* TODO: Take out of standby mode */
-#ifdef CONFIG_PMCTWILED
-	msp_led_turn_on(MSP_LED_PWRSTANDBY_GREEN);
-	msp_led_turn_off(MSP_LED_PWRSTANDBY_RED);
-#endif
 }
 
 static struct hwbutton_interrupt softreset_sw = {
-- 
1.6.3.3
