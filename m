Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 12:22:51 +0100 (CET)
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:25502 "EHLO
        mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010216AbbAGLV0Z86r3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Jan 2015 12:21:26 +0100
X-IronPort-AV: E=Sophos;i="5.07,714,1413270000"; 
   d="scan'208";a="54298895"
Received: from irvexchcas07.broadcom.com (HELO IRVEXCHCAS07.corp.ad.broadcom.com) ([10.9.208.55])
  by mail-gw2-out.broadcom.com with ESMTP; 07 Jan 2015 03:55:59 -0800
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP Server
 (TLS) id 14.3.174.1; Wed, 7 Jan 2015 03:21:24 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP Server id
 14.3.174.1; Wed, 7 Jan 2015 03:21:39 -0800
Received: from netl-snoppy.ban.broadcom.com (netl-snoppy.ban.broadcom.com
 [10.132.128.129])      by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 2A00040FE6;    Wed,  7 Jan 2015 03:20:36 -0800 (PST)
From:   Jayachandran C <jchandra@broadcom.com>
To:     <linux-mips@linux-mips.org>
CC:     Ganesan Ramalingam <ganesanr@broadcom.com>, <ralf@linux-mips.org>,
        Jayachandran C <jchandra@broadcom.com>
Subject: [PATCH 06/17] MIPS: Netlogic: Fix frequency calculation register
Date:   Wed, 7 Jan 2015 16:58:27 +0530
Message-ID: <1420630118-17198-7-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
References: <1420630118-17198-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

From: Ganesan Ramalingam <ganesanr@broadcom.com>

Change the PIC frequency calculation to use the register that has the
current configuration. The existing code used the register that is
written to change frequency, which can have an invalid value if the
firmware did not set it up correctly.

Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/netlogic/xlp-hal/sys.h | 3 +++
 arch/mips/netlogic/xlp/nlm_hal.c             | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/netlogic/xlp-hal/sys.h b/arch/mips/include/asm/netlogic/xlp-hal/sys.h
index bc7bddf..6bcf395 100644
--- a/arch/mips/include/asm/netlogic/xlp-hal/sys.h
+++ b/arch/mips/include/asm/netlogic/xlp-hal/sys.h
@@ -177,6 +177,9 @@
 #define SYS_9XX_CLK_DEV_DIV			0x18d
 #define SYS_9XX_CLK_DEV_CHG			0x18f
 
+#define SYS_9XX_CLK_DEV_SEL_REG			0x1a4
+#define SYS_9XX_CLK_DEV_DIV_REG			0x1a6
+
 /* Registers changed on 9XX */
 #define SYS_9XX_POWER_ON_RESET_CFG		0x00
 #define SYS_9XX_CHIP_RESET			0x01
diff --git a/arch/mips/netlogic/xlp/nlm_hal.c b/arch/mips/netlogic/xlp/nlm_hal.c
index de41fb5..b80d893 100644
--- a/arch/mips/netlogic/xlp/nlm_hal.c
+++ b/arch/mips/netlogic/xlp/nlm_hal.c
@@ -332,7 +332,7 @@ static unsigned int nlm_xlp2_get_pic_frequency(int node)
 	/* Find the clock source PLL device for PIC */
 	if (cpu_xlp9xx) {
 		reg_select = nlm_read_sys_reg(clockbase,
-				SYS_9XX_CLK_DEV_SEL) & 0x3;
+				SYS_9XX_CLK_DEV_SEL_REG) & 0x3;
 		switch (reg_select) {
 		case 0:
 			ctrl_val0 = nlm_read_sys_reg(clockbase,
@@ -361,7 +361,7 @@ static unsigned int nlm_xlp2_get_pic_frequency(int node)
 		}
 	} else {
 		reg_select = (nlm_read_sys_reg(sysbase,
-					SYS_CLK_DEV_SEL) >> 22) & 0x3;
+					SYS_CLK_DEV_SEL_REG) >> 22) & 0x3;
 		switch (reg_select) {
 		case 0:
 			ctrl_val0 = nlm_read_sys_reg(sysbase,
@@ -425,10 +425,10 @@ static unsigned int nlm_xlp2_get_pic_frequency(int node)
 	/* PIC post divider, which happens after PLL */
 	if (cpu_xlp9xx)
 		pic_div = nlm_read_sys_reg(clockbase,
-				SYS_9XX_CLK_DEV_DIV) & 0x3;
+				SYS_9XX_CLK_DEV_DIV_REG) & 0x3;
 	else
 		pic_div = (nlm_read_sys_reg(sysbase,
-					SYS_CLK_DEV_DIV) >> 22) & 0x3;
+					SYS_CLK_DEV_DIV_REG) >> 22) & 0x3;
 	do_div(pll_out_freq_num, 1 << pic_div);
 
 	return pll_out_freq_num;
-- 
1.9.1
