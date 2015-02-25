Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 04:58:18 +0100 (CET)
Received: from mail-pa0-f74.google.com ([209.85.220.74]:34471 "EHLO
        mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007220AbbBYD4UKg0Wv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Feb 2015 04:56:20 +0100
Received: by pabkx10 with SMTP id kx10so558215pab.1
        for <linux-mips@linux-mips.org>; Tue, 24 Feb 2015 19:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LBtFoWjla5nlafHI3wc8Tb75zCTyKrlJGgby5ir+YmU=;
        b=FPCwm3q7DBO18z1iGsqPtBks22HC7W8lFiqjYmVXZcPoAAooIPTq2AbN0xsLwnkcpe
         N1VT8Bs9cBHV6kOADs2RI54DwpINeCue4Wzpc8JzXDUrqY/4IBHPRNxl7oTOYHYAQToO
         GV1pL3RJD5HxdbEb33aUb/35leiGyG0xBq8lAkGP9NEGySu5QnuIb4KRm/dqF7cchPt3
         xohqqZcnHpk0rv8GEH4w5dXG7vewejzjW3fkTcRHyz5vmWpgjHLS4yMXESAb9SuHm1+L
         tYjROA/IAYr/2a/WqM2iRpTz5OCk0XrwUB/+K+te0cytNHxBrWhbr1pyqlMsLWCOIdd3
         neBA==
X-Gm-Message-State: ALoCoQk60eDtlryq2cCRZ+cmrbfQsdBc9idpn3R3AA3iE4zoasgZuMwAsq9kqYBcaqTH6y6uCRwd
X-Received: by 10.66.233.198 with SMTP id ty6mr1340417pac.24.1424836574275;
        Tue, 24 Feb 2015 19:56:14 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id p65si1457383yhd.5.2015.02.24.19.56.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2015 19:56:14 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id TzTZaMa2.2; Tue, 24 Feb 2015 19:56:14 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 458D4220DB2; Tue, 24 Feb 2015 19:56:13 -0800 (PST)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH 6/7] clk: pistachio: Register system interface gate clocks
Date:   Tue, 24 Feb 2015 19:56:06 -0800
Message-Id: <1424836567-7252-7-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1424836567-7252-1-git-send-email-abrestic@chromium.org>
References: <1424836567-7252-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45954
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Register the system interface gate clocks provided by the peripheral
general control block.  These clocks gate register access for various
peripherals.

Signed-off-by: Damien Horsley <Damien.Horsley@imgtec.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/clk/pistachio/clk-pistachio.c | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/clk/pistachio/clk-pistachio.c b/drivers/clk/pistachio/clk-pistachio.c
index 0eabb54..3351808 100644
--- a/drivers/clk/pistachio/clk-pistachio.c
+++ b/drivers/clk/pistachio/clk-pistachio.c
@@ -264,3 +264,45 @@ static void __init pistachio_clk_periph_init(struct device_node *np)
 }
 CLK_OF_DECLARE(pistachio_clk_periph, "img,pistachio-clk-periph",
 	       pistachio_clk_periph_init);
+
+static struct pistachio_gate pistachio_sys_gates[] __initdata = {
+	GATE(SYS_CLK_I2C0, "i2c0_sys", "sys", 0x8, 0),
+	GATE(SYS_CLK_I2C1, "i2c1_sys", "sys", 0x8, 1),
+	GATE(SYS_CLK_I2C2, "i2c2_sys", "sys", 0x8, 2),
+	GATE(SYS_CLK_I2C3, "i2c3_sys", "sys", 0x8, 3),
+	GATE(SYS_CLK_I2S_IN, "i2s_in_sys", "sys", 0x8, 4),
+	GATE(SYS_CLK_PAUD_OUT, "paud_out_sys", "sys", 0x8, 5),
+	GATE(SYS_CLK_SPDIF_OUT, "spdif_out_sys", "sys", 0x8, 6),
+	GATE(SYS_CLK_SPI0_MASTER, "spi0_master_sys", "sys", 0x8, 7),
+	GATE(SYS_CLK_SPI0_SLAVE, "spi0_slave_sys", "sys", 0x8, 8),
+	GATE(SYS_CLK_PWM, "pwm_sys", "sys", 0x8, 9),
+	GATE(SYS_CLK_UART0, "uart0_sys", "sys", 0x8, 10),
+	GATE(SYS_CLK_UART1, "uart1_sys", "sys", 0x8, 11),
+	GATE(SYS_CLK_SPI1, "spi1_sys", "sys", 0x8, 12),
+	GATE(SYS_CLK_MDC, "mdc_sys", "sys", 0x8, 13),
+	GATE(SYS_CLK_SD_HOST, "sd_host_sys", "sys", 0x8, 14),
+	GATE(SYS_CLK_ENET, "enet_sys", "sys", 0x8, 15),
+	GATE(SYS_CLK_IR, "ir_sys", "sys", 0x8, 16),
+	GATE(SYS_CLK_WD, "wd_sys", "sys", 0x8, 17),
+	GATE(SYS_CLK_TIMER, "timer_sys", "sys", 0x8, 18),
+	GATE(SYS_CLK_I2S_OUT, "i2s_out_sys", "sys", 0x8, 24),
+	GATE(SYS_CLK_SPDIF_IN, "spdif_in_sys", "sys", 0x8, 25),
+	GATE(SYS_CLK_EVENT_TIMER, "event_timer_sys", "sys", 0x8, 26),
+	GATE(SYS_CLK_HASH, "hash_sys", "sys", 0x8, 27),
+};
+
+static void __init pistachio_cr_periph_init(struct device_node *np)
+{
+	struct pistachio_clk_provider *p;
+
+	p = pistachio_clk_alloc_provider(np, SYS_CLK_NR_CLKS);
+	if (!p)
+		return;
+
+	pistachio_clk_register_gate(p, pistachio_sys_gates,
+				    ARRAY_SIZE(pistachio_sys_gates));
+
+	pistachio_clk_register_provider(p);
+}
+CLK_OF_DECLARE(pistachio_cr_periph, "img,pistachio-cr-periph",
+	       pistachio_cr_periph_init);
-- 
2.2.0.rc0.207.ga3a616c
