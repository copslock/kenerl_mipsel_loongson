Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 15:58:49 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41227 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011740AbbLGO6Mal0Ac (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 15:58:12 +0100
Received: from localhost (unknown [66.228.68.140])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5B361A7E;
        Mon,  7 Dec 2015 14:58:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alban Bedel <albeu@free.fr>,
        Felix Fietkau <nbd@openwrt.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.2 043/124] MIPS: ath79: Fix the DDR control initialization on ar71xx and ar934x
Date:   Mon,  7 Dec 2015 09:55:33 -0500
Message-Id: <20151207144921.819530273@linuxfoundation.org>
X-Mailer: git-send-email 2.6.3
In-Reply-To: <20151207144919.656035367@linuxfoundation.org>
References: <20151207144919.656035367@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50364
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

4.2-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alban Bedel <albeu@free.fr>

commit 5011a7e808c9fec643d752c5a495a48f27268a48 upstream.

The DDR control initialization needs to know the SoC type, however
ath79_detect_sys_type() was called after ath79_ddr_ctrl_init().
Reverse the order to fix the DDR control initialization on ar71xx and
ar934x.

Signed-off-by: Alban Bedel <albeu@free.fr>
Cc: Felix Fietkau <nbd@openwrt.org>
Cc: Qais Yousef <qais.yousef@imgtec.com>
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/11500/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ath79/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -216,9 +216,9 @@ void __init plat_mem_setup(void)
 					   AR71XX_RESET_SIZE);
 	ath79_pll_base = ioremap_nocache(AR71XX_PLL_BASE,
 					 AR71XX_PLL_SIZE);
+	ath79_detect_sys_type();
 	ath79_ddr_ctrl_init();
 
-	ath79_detect_sys_type();
 	if (mips_machtype != ATH79_MACH_GENERIC_OF)
 		detect_memory_region(0, ATH79_MEM_SIZE_MIN, ATH79_MEM_SIZE_MAX);
 
