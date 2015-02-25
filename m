Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 04:58:02 +0100 (CET)
Received: from mail-ob0-f202.google.com ([209.85.214.202]:37824 "EHLO
        mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007219AbbBYD4UAbrYq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Feb 2015 04:56:20 +0100
Received: by mail-ob0-f202.google.com with SMTP id nt9so449674obb.1
        for <linux-mips@linux-mips.org>; Tue, 24 Feb 2015 19:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Lh8+9dWyK/GSzI0hoy311Tn7y0pLv1jHQ2GNexWut98=;
        b=kfpXBM+nPVuOJ+k2geGgOaN9xtVNY8lsJ+Tog26jszBiH104iTKRIbLRH8kN1Acw0r
         xK3XE4SHm8+EmWuC/4mwP0+p7kl+Gk9adAoUvbxLyNjmFwr0Pj5ztIibQ87DYZLq38kx
         MrqZs8QLBWD4juI/dWEWOlpYIYHaUITTkxu5GnOHDRHkk6f5lBGQ6Eyrt6IDLWpRAuLB
         VYq9TPfTAhFF3v245WB9PFU0c6DPun+vnLCdhkBWYJyrNbw5ojbgnUh5ulmo0tWZ2fq4
         rQ2Ss+auUvzABkCoc0ZiTvx1N1/9EWVtuV9UKrkdPwljFLo9FI0YYhLRim0ObyiA3+lg
         wl5A==
X-Gm-Message-State: ALoCoQmTqVuxILSzpVdcwTTtrqdameGuH2fU4pqcqPFXmRb5Ooz0U+MHvQecuI3fev36GvJp2Fm0
X-Received: by 10.182.78.69 with SMTP id z5mr1361334obw.4.1424836574859;
        Tue, 24 Feb 2015 19:56:14 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id 3si1459561yhe.0.2015.02.24.19.56.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2015 19:56:14 -0800 (PST)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id TIESvrwf.2; Tue, 24 Feb 2015 19:56:14 -0800
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id DC2E4221075; Tue, 24 Feb 2015 19:56:13 -0800 (PST)
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
Subject: [PATCH 7/7] clk: pistachio: Register external clock gates
Date:   Tue, 24 Feb 2015 19:56:07 -0800
Message-Id: <1424836567-7252-8-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
In-Reply-To: <1424836567-7252-1-git-send-email-abrestic@chromium.org>
References: <1424836567-7252-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45953
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

Register the clock gates for the external audio and ethernet
reference clocks provided by the top-level general control block.

Signed-off-by: Damien Horsley <Damien.Horsley@imgtec.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 drivers/clk/pistachio/clk-pistachio.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/pistachio/clk-pistachio.c b/drivers/clk/pistachio/clk-pistachio.c
index 3351808..8c0fe88 100644
--- a/drivers/clk/pistachio/clk-pistachio.c
+++ b/drivers/clk/pistachio/clk-pistachio.c
@@ -306,3 +306,24 @@ static void __init pistachio_cr_periph_init(struct device_node *np)
 }
 CLK_OF_DECLARE(pistachio_cr_periph, "img,pistachio-cr-periph",
 	       pistachio_cr_periph_init);
+
+static struct pistachio_gate pistachio_ext_gates[] __initdata = {
+	GATE(EXT_CLK_ENET_IN, "enet_clk_in_gate", "enet_clk_in", 0x58, 5),
+	GATE(EXT_CLK_AUDIO_IN, "audio_clk_in_gate", "audio_clk_in", 0x58, 8)
+};
+
+static void __init pistachio_cr_top_init(struct device_node *np)
+{
+	struct pistachio_clk_provider *p;
+
+	p = pistachio_clk_alloc_provider(np, EXT_CLK_NR_CLKS);
+	if (!p)
+		return;
+
+	pistachio_clk_register_gate(p, pistachio_ext_gates,
+				    ARRAY_SIZE(pistachio_ext_gates));
+
+	pistachio_clk_register_provider(p);
+}
+CLK_OF_DECLARE(pistachio_cr_top, "img,pistachio-cr-top",
+	       pistachio_cr_top_init);
-- 
2.2.0.rc0.207.ga3a616c
