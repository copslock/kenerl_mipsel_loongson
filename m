Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2015 17:48:26 +0100 (CET)
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:35702 "EHLO
        smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006607AbbKRQsZCExJI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2015 17:48:25 +0100
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
        by smtpfb1-g21.free.fr (Postfix) with ESMTP id 3CC9777C808;
        Tue, 17 Nov 2015 21:52:36 +0100 (CET)
Received: from localhost.localdomain (unknown [80.171.215.189])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 7D9A2A6249;
        Tue, 17 Nov 2015 21:52:22 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Alban Bedel <albeu@free.fr>, Ralf Baechle <ralf@linux-mips.org>,
        Felix Fietkau <nbd@openwrt.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MIPS: ath79: Remove some unused code from setup.c
Date:   Tue, 17 Nov 2015 21:52:01 +0100
Message-Id: <1447793523-19430-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1447793523-19430-1-git-send-email-albeu@free.fr>
References: <1447793523-19430-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

Remove the unused defines for the reference clocks rate
and the useless machine init function.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/setup.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 8755d61..be451ee4a 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -36,10 +36,6 @@
 
 #define ATH79_SYS_TYPE_LEN	64
 
-#define AR71XX_BASE_FREQ	40000000
-#define AR724X_BASE_FREQ	5000000
-#define AR913X_BASE_FREQ	5000000
-
 static char ath79_sys_type[ATH79_SYS_TYPE_LEN];
 
 static void ath79_restart(char *command)
@@ -272,15 +268,10 @@ void __init device_tree_init(void)
 	unflatten_and_copy_device_tree();
 }
 
-static void __init ath79_generic_init(void)
-{
-	/* Nothing to do */
-}
-
 MIPS_MACHINE(ATH79_MACH_GENERIC,
 	     "Generic",
 	     "Generic AR71XX/AR724X/AR913X based board",
-	     ath79_generic_init);
+	     NULL);
 
 MIPS_MACHINE(ATH79_MACH_GENERIC_OF,
 	     "DTB",
-- 
2.0.0
