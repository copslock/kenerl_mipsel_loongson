Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 14:37:53 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:57296 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27025723AbbDQMhScPHpd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Apr 2015 14:37:18 +0200
Received: from localhost.localdomain (unknown [78.54.181.212])
        (Authenticated sender: albeu)
        by smtp4-g21.free.fr (Postfix) with ESMTPA id 6A1A44C803A;
        Fri, 17 Apr 2015 14:34:57 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] MIPS: ath79: Fix the PCI memory size and offset of window 7
Date:   Fri, 17 Apr 2015 14:36:17 +0200
Message-Id: <1429274178-4337-5-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429274178-4337-1-git-send-email-albeu@free.fr>
References: <1429274178-4337-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46883
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

The define AR71XX_PCI_MEM_SIZE miss one window, there is 7 windows,
not 6. To make things clearer, and allow simpler code, derive
AR71XX_PCI_MEM_SIZE from the newly introduced AR71XX_PCI_WIN_COUNT
and AR71XX_PCI_WIN_SIZE.

The define AR71XX_PCI_WIN7_OFFS also add a typo, fix it.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/include/asm/mach-ath79/ar71xx_regs.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
index aa3800c..e2669a8 100644
--- a/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
+++ b/arch/mips/include/asm/mach-ath79/ar71xx_regs.h
@@ -41,7 +41,9 @@
 #define AR71XX_RESET_SIZE	0x100
 
 #define AR71XX_PCI_MEM_BASE	0x10000000
-#define AR71XX_PCI_MEM_SIZE	0x07000000
+#define AR71XX_PCI_WIN_COUNT	8
+#define AR71XX_PCI_WIN_SIZE	0x01000000
+#define AR71XX_PCI_MEM_SIZE	(AR71XX_PCI_WIN_COUNT * AR71XX_PCI_WIN_SIZE)
 
 #define AR71XX_PCI_WIN0_OFFS	0x10000000
 #define AR71XX_PCI_WIN1_OFFS	0x11000000
@@ -50,7 +52,7 @@
 #define AR71XX_PCI_WIN4_OFFS	0x14000000
 #define AR71XX_PCI_WIN5_OFFS	0x15000000
 #define AR71XX_PCI_WIN6_OFFS	0x16000000
-#define AR71XX_PCI_WIN7_OFFS	0x07000000
+#define AR71XX_PCI_WIN7_OFFS	0x17000000
 
 #define AR71XX_PCI_CFG_BASE	\
 	(AR71XX_PCI_MEM_BASE + AR71XX_PCI_WIN7_OFFS + 0x10000)
-- 
2.0.0
