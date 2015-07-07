Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jul 2015 20:24:26 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:51621 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013454AbbGGSYPeNulC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Jul 2015 20:24:15 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1ZCXXT-0001ui-11; Tue, 07 Jul 2015 18:24:15 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1ZCXXQ-0002SH-Q2; Tue, 07 Jul 2015 11:24:12 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Jonas Gorski <jogo@openwrt.org>, linux-mips@linux-mips.org,
        John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 054/102] MIPS: ralink: Fix clearing the illegal access interrupt
Date:   Tue,  7 Jul 2015 11:22:44 -0700
Message-Id: <1436293412-9033-55-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1436293412-9033-1-git-send-email-kamal@canonical.com>
References: <1436293412-9033-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.19.8-ckt3 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Gorski <jogo@openwrt.org>

commit 9dd6f1c166bc6e7b582f6203f2dc023ec65e3ed5 upstream.

Due to a typo the illegal access interrupt is never cleared in by
the interupt handler, causing an effective deadlock on the first
illegal access.

This was broken since the code was introduced in 5433acd81e87 ("MIPS:
ralink: add illegal access driver"), but only exposed when the Kconfig
symbol was added, thus enabling the code.

Fixes: a7b7aad383c ("MIPS: ralink: add missing symbol for RALINK_ILL_ACC")
Signed-off-by: Jonas Gorski <jogo@openwrt.org>
Cc: linux-mips@linux-mips.org
Cc: John Crispin <blogic@openwrt.org>
Patchwork: https://patchwork.linux-mips.org/patch/10172/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/ralink/ill_acc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ralink/ill_acc.c b/arch/mips/ralink/ill_acc.c
index e20b02e..e10d10b 100644
--- a/arch/mips/ralink/ill_acc.c
+++ b/arch/mips/ralink/ill_acc.c
@@ -41,7 +41,7 @@ static irqreturn_t ill_acc_irq_handler(int irq, void *_priv)
 		addr, (type >> ILL_ACC_OFF_S) & ILL_ACC_OFF_M,
 		type & ILL_ACC_LEN_M);
 
-	rt_memc_w32(REG_ILL_ACC_TYPE, REG_ILL_ACC_TYPE);
+	rt_memc_w32(ILL_INT_STATUS, REG_ILL_ACC_TYPE);
 
 	return IRQ_HANDLED;
 }
-- 
1.9.1
