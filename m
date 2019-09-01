Return-Path: <SRS0=OeKb=W4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB40C3A5A4
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E122522CE9
	for <linux-mips@archiver.kernel.org>; Sun,  1 Sep 2019 16:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfIAQSf (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 1 Sep 2019 12:18:35 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:44300 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfIAQSf (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sun, 1 Sep 2019 12:18:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 505173F63C
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:18:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UBJatOIyCwLM for <linux-mips@vger.kernel.org>;
        Sun,  1 Sep 2019 18:18:32 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 9AB143F58C
        for <linux-mips@vger.kernel.org>; Sun,  1 Sep 2019 18:18:32 +0200 (CEST)
Date:   Sun, 1 Sep 2019 18:18:32 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     linux-mips@vger.kernel.org
Subject: [PATCH 078/120] MIPS: PS2: GS: Read privileged registers
Message-ID: <b6d91cb48c10284a99fcfa5e3ded11480970d0d0.1567326213.git.noring@nocrew.org>
References: <cover.1567326213.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1567326213.git.noring@nocrew.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

All privileged Graphics Synthesizer register functions follow the same
pattern. For example, the reading the CSR register:

    u64 gs_readq_csr(void);

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 arch/mips/include/asm/mach-ps2/gs-registers.h |  5 ++++
 drivers/ps2/gs-registers.c                    | 24 +++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/mips/include/asm/mach-ps2/gs-registers.h b/arch/mips/include/asm/mach-ps2/gs-registers.h
index 291b503447e4..315a25c102c9 100644
--- a/arch/mips/include/asm/mach-ps2/gs-registers.h
+++ b/arch/mips/include/asm/mach-ps2/gs-registers.h
@@ -548,11 +548,15 @@ struct gs_siglblid {
 #define GS_DECLARE_VALID_REG(reg)			\
 	bool gs_valid_##reg(void)
 
+#define GS_DECLARE_RQ_REG(reg)				\
+	u64 gs_readq_##reg(void)
+
 #define GS_DECLARE_WQ_REG(reg)				\
 	void gs_writeq_##reg(u64 value)
 
 #define GS_DECLARE_RW_REG(reg)				\
 	GS_DECLARE_VALID_REG(reg);			\
+	GS_DECLARE_RQ_REG(reg);				\
 	GS_DECLARE_WQ_REG(reg)
 
 /**
@@ -562,6 +566,7 @@ struct gs_siglblid {
  * pattern. For example, the CSR register has the following functions::
  *
  *	bool gs_valid_csr(void);
+ *	u64 gs_readq_csr(void);
  *	void gs_writeq_csr(u64 value);
  *
  * gs_valid_csr() indicates whether CSR is readable, which is always true,
diff --git a/drivers/ps2/gs-registers.c b/drivers/ps2/gs-registers.c
index 781604b874b5..debaf0153fbe 100644
--- a/drivers/ps2/gs-registers.c
+++ b/drivers/ps2/gs-registers.c
@@ -52,6 +52,14 @@ static struct {
 	}								\
 	EXPORT_SYMBOL_GPL(gs_valid_##reg)
 
+/* Read-write registers are not shadowed and trivially read. */
+#define GS_DEFINE_RQ_RW_REG(reg, addr)					\
+	u64 gs_readq_##reg(void)					\
+	{								\
+		return inq(addr);					\
+	}								\
+	EXPORT_SYMBOL_GPL(gs_readq_##reg)
+
 /* Read-write registers are not shadowed and trivially write. */
 #define GS_DEFINE_WQ_RW_REG(reg, addr)					\
 	void gs_writeq_##reg(u64 value)					\
@@ -73,6 +81,20 @@ static struct {
 	}								\
 	EXPORT_SYMBOL_GPL(gs_valid_##reg)
 
+/* Write-only registers are shadowed and reading requires a previous write. */
+#define GS_DEFINE_RQ_WO_REG(reg, addr)					\
+	u64 gs_readq_##reg(void)					\
+	{								\
+		unsigned long flags;					\
+		u64 value;						\
+		spin_lock_irqsave(&gs_registers.lock, flags);		\
+		WARN_ON_ONCE(!gs_registers.reg.valid);			\
+		value = gs_registers.reg.value;				\
+		spin_unlock_irqrestore(&gs_registers.lock, flags);	\
+		return value;						\
+	}								\
+	EXPORT_SYMBOL_GPL(gs_readq_##reg)
+
 /* Write-only registers are shadowed and reading requires a previous write. */
 #define GS_DEFINE_WQ_WO_REG(reg, addr)					\
 	void gs_writeq_##reg(u64 value)					\
@@ -89,11 +111,13 @@ static struct {
 /* Only CSR and SIGLBLID are read-write (RW) with hardware. */
 #define GS_DEFINE_RW_REG(reg, addr)					\
 	GS_DEFINE_VALID_RW_REG(reg, addr);				\
+	GS_DEFINE_RQ_RW_REG(reg, addr);					\
 	GS_DEFINE_WQ_RW_REG(reg, addr)
 
 /* The rest are write-only (WO) with reading emulated by shadow registers. */
 #define GS_DEFINE_WO_REG(reg, addr)					\
 	GS_DEFINE_VALID_WO_REG(reg, addr);				\
+	GS_DEFINE_RQ_WO_REG(reg, addr);					\
 	GS_DEFINE_WQ_WO_REG(reg, addr)
 
 GS_DEFINE_WO_REG(pmode,    GS_PMODE);
-- 
2.21.0

