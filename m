Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 13:34:49 +0200 (CEST)
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:59168 "EHLO
        cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825737AbaETLemaS69c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 May 2014 13:34:42 +0200
Received: from cpsps-ews26.kpnxchange.com ([10.94.84.192]) by cpsmtpb-ews08.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Tue, 20 May 2014 13:34:37 +0200
Received: from CPSMTPM-TLF102.kpnxchange.com ([195.121.3.5]) by cpsps-ews26.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Tue, 20 May 2014 13:34:36 +0200
Received: from [192.168.10.106] ([195.240.213.44]) by CPSMTPM-TLF102.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
         Tue, 20 May 2014 13:34:36 +0200
Message-ID: <1400585676.4912.38.camel@x220>
Subject: [PATCH] MIPS: remove CONFIG_PMCTWILED completely
From:   Paul Bolle <pebolle@tiscali.nl>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Date:   Tue, 20 May 2014 13:34:36 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-2.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 May 2014 11:34:36.0579 (UTC) FILETIME=[7A8B4730:01CF741F]
X-RcptDomain: linux-mips.org
Return-Path: <pebolle@tiscali.nl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pebolle@tiscali.nl
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

Commit 8b284dbc2200 ("MIPS: PNX Removing dead CONFIG_PMCTWILED") missed
one reference to CONFIG_PMCTWILED in the code. It also missed one
related reference to pmctwiled_setup(). Remove these references now.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 arch/mips/pmcs-msp71xx/msp_setup.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/mips/pmcs-msp71xx/msp_setup.c b/arch/mips/pmcs-msp71xx/msp_setup.c
index 7e980767679c..ba9d518dc624 100644
--- a/arch/mips/pmcs-msp71xx/msp_setup.c
+++ b/arch/mips/pmcs-msp71xx/msp_setup.c
@@ -27,7 +27,6 @@
 #endif
 
 extern void msp_serial_setup(void);
-extern void pmctwiled_setup(void);
 
 #if defined(CONFIG_PMC_MSP7120_EVAL) || \
     defined(CONFIG_PMC_MSP7120_GW) || \
@@ -235,12 +234,4 @@ void __init prom_init(void)
 		register_smp_ops(&msp_smtc_smp_ops);
 #endif
 	}
-
-#ifdef CONFIG_PMCTWILED
-	/*
-	 * Setup LED states before the subsys_initcall loads other
-	 * dependent drivers/modules.
-	 */
-	pmctwiled_setup();
-#endif
 }
-- 
1.9.0
