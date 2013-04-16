Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 10:34:47 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:40331 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827531Ab3DPIcVTuotA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Apr 2013 10:32:21 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH V4 09/14] MIPS: ralink: add pci group to struct ralink_pinmux
Date:   Tue, 16 Apr 2013 10:28:04 +0200
Message-Id: <1366100889-21072-9-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1366100889-21072-1-git-send-email-blogic@openwrt.org>
References: <1366100889-21072-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

From: Gabor Juhos <juhosg@openwrt.org>

This will be used for RT3662/RT3883.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Acked-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/common.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
index f4b19c6..bebd149 100644
--- a/arch/mips/ralink/common.h
+++ b/arch/mips/ralink/common.h
@@ -23,6 +23,9 @@ struct ralink_pinmux {
 	struct ralink_pinmux_grp *uart;
 	int uart_shift;
 	void (*wdt_reset)(void);
+	struct ralink_pinmux_grp *pci;
+	int pci_shift;
+	u32 pci_mask;
 };
 extern struct ralink_pinmux rt_gpio_pinmux;
 
-- 
1.7.10.4
