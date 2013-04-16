Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 10:53:46 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:41056 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835149Ab3DPIxY12H1e (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Apr 2013 10:53:24 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>
Subject: [PATCH V2 2/7] MIPS: ralink: add memory definition to struct ralink_soc_info
Date:   Tue, 16 Apr 2013 10:49:11 +0200
Message-Id: <1366102156-21281-2-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1366102156-21281-1-git-send-email-blogic@openwrt.org>
References: <1366102156-21281-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36223
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

Depending on the actual SoC we have a different base address as well as minimum
and maximum size for RAM. Add these fields to the per SoC structure.

Signed-off-by: John Crispin <blogic@openwrt.org>
---
 arch/mips/ralink/common.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/ralink/common.h b/arch/mips/ralink/common.h
index 299119b..83144c3 100644
--- a/arch/mips/ralink/common.h
+++ b/arch/mips/ralink/common.h
@@ -33,6 +33,11 @@ extern struct ralink_pinmux rt_gpio_pinmux;
 struct ralink_soc_info {
 	unsigned char sys_type[RAMIPS_SYS_TYPE_LEN];
 	unsigned char *compatible;
+
+	unsigned long mem_base;
+	unsigned long mem_size;
+	unsigned long mem_size_min;
+	unsigned long mem_size_max;
 };
 extern struct ralink_soc_info soc_info;
 
-- 
1.7.10.4
