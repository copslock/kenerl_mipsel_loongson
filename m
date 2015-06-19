Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jun 2015 22:39:11 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41125 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008961AbbFSUjJVeHKT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Jun 2015 22:39:09 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 034B5BFD;
        Fri, 19 Jun 2015 20:39:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonas Gorski <jogo@openwrt.org>,
        linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 065/105] MIPS: ralink: Fix clearing the illegal access interrupt
Date:   Fri, 19 Jun 2015 13:35:55 -0700
Message-Id: <20150619203600.105391801@linuxfoundation.org>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <20150619203558.187802739@linuxfoundation.org>
References: <20150619203558.187802739@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.0-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ralink/ill_acc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/ralink/ill_acc.c
+++ b/arch/mips/ralink/ill_acc.c
@@ -41,7 +41,7 @@ static irqreturn_t ill_acc_irq_handler(i
 		addr, (type >> ILL_ACC_OFF_S) & ILL_ACC_OFF_M,
 		type & ILL_ACC_LEN_M);
 
-	rt_memc_w32(REG_ILL_ACC_TYPE, REG_ILL_ACC_TYPE);
+	rt_memc_w32(ILL_INT_STATUS, REG_ILL_ACC_TYPE);
 
 	return IRQ_HANDLED;
 }
