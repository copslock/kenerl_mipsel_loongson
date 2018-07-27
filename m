Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2018 11:47:28 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:42018 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990423AbeG0JrYF21uF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jul 2018 11:47:24 +0200
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C4520898;
        Fri, 27 Jul 2018 09:47:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>,
        Paul Burton <paul.burton@mips.com>,
        Alban Bedel <albeu@free.fr>, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.17 03/66] MIPS: ath79: fix register address in ath79_ddr_wb_flush()
Date:   Fri, 27 Jul 2018 11:44:56 +0200
Message-Id: <20180727093809.414348908@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65188
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

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

commit bc88ad2efd11f29e00a4fd60fcd1887abfe76833 upstream.

ath79_ddr_wb_flush_base has the type void __iomem *, so register offsets
need to be a multiple of 4 in order to access the intended register.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 24b0e3e84fbf ("MIPS: ath79: Improve the DDR controller interface")
Patchwork: https://patchwork.linux-mips.org/patch/19912/
Cc: Alban Bedel <albeu@free.fr>
Cc: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org # 4.2+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ath79/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/ath79/common.c
+++ b/arch/mips/ath79/common.c
@@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(ath79_ddr_ctrl_init);
 
 void ath79_ddr_wb_flush(u32 reg)
 {
-	void __iomem *flush_reg = ath79_ddr_wb_flush_base + reg;
+	void __iomem *flush_reg = ath79_ddr_wb_flush_base + (reg * 4);
 
 	/* Flush the DDR write buffer. */
 	__raw_writel(0x1, flush_reg);
