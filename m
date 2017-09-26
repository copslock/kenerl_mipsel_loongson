Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Sep 2017 15:51:30 +0200 (CEST)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:33296
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992054AbdIZNvVNwa1a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Sep 2017 15:51:21 +0200
Received: by mail-pg0-x242.google.com with SMTP id i130so6809554pgc.0;
        Tue, 26 Sep 2017 06:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NWCrMuiW2Kxi4NqNAMzmSjaMSkeH2yhc6kr3KFpy9IM=;
        b=gEDDNVYs7E8b2XpOB1ag98qlMxfZG27cHcXdVIkYdGZTNry51sG1M1xOt2VBge/VnQ
         aRDZaNYBwUmVuXk8hGqVF4vjnf7uGX0/fa9hHcIwCaAtlnh19wsWgq3qtJhKWBn38EZv
         JgYuIOtwmNNOgYKt+wHJwTvoJeiIXNMi+G4kDdyonmnkSA6rA2UghKrzPu48CTw9z1Mq
         gn/Bx/0SKHw1x9o0jG+DGC4na6yCOStN1Uw67e99wyhKA6G0nfkQXnOzkIU8ySYdoS4q
         sb9YbAdRjK3/KwljzUTS9sSlYNhl1FiNOEAf49nqywacgdX0KKnmDmSBg3aaQUM0Hf9O
         b2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NWCrMuiW2Kxi4NqNAMzmSjaMSkeH2yhc6kr3KFpy9IM=;
        b=KZWCGf9l4dshDf8OE2FAHmewN0R2jEEijlsxrBI9exuhHu0AUtKK7+CQej7z/HuK0h
         kXKrgVZr7SfvDEMh8ZFL2ycx2E7wZ6K/MZeAj3yKMwTBG/CgnM1RyS8OFjI+V9aUF+EN
         GFq1HS3IfKTRTgnaZQxwqSVPnahvXBV+o4jyAhBrKgMaUv99lr1qMLACpv94znPVqKQb
         C3PxTSJDtoe5NPNBeSl6Sk3Dd+GxHiylKDUOfscJCl8JHzChFjgxNQvCLX9ANfxav/bL
         VJXfn1N6l5iPwGvPLzPs8JWekjHTF1LpBfYjWlyxxy6EeZt3va6/QSCNBR7DLuilFW6/
         CaKg==
X-Gm-Message-State: AHPjjUjd+YVey6gbQqmx4OWhhLrKYAMQiVvJHp7PKzHBfKKd5fJx+fZE
        pI/W4gkJZqLb8r3F5AWD4O0=
X-Google-Smtp-Source: AOwi7QAuBziPIqIhugV76fSG+dQO7HH/E5NiXeYJki6JG1UHpgkUKPsE8hRY2VQmvb+ur4RG0lX8kw==
X-Received: by 10.98.64.86 with SMTP id n83mr4529838pfa.231.1506433874399;
        Tue, 26 Sep 2017 06:51:14 -0700 (PDT)
Received: from gmail.com ([117.196.101.196])
        by smtp.gmail.com with ESMTPSA id l3sm15861365pgn.36.2017.09.26.06.51.10
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 06:51:13 -0700 (PDT)
Received: by gmail.com (sSMTP sendmail emulation); Tue, 26 Sep 2017 19:21:07 +0530
From:   Bhumika Goyal <bhumirks@gmail.com>
To:     julia.lawall@lip6.fr, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:     Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] MIPS: Alchemy: make clk_ops const
Date:   Tue, 26 Sep 2017 19:21:05 +0530
Message-Id: <1506433865-31126-1-git-send-email-bhumirks@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <bhumirks@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60156
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhumirks@gmail.com
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

Make these const as they are only stored in the "const " ops field of a
clk_init_data structure.

Structure found using Coccinelle and changes done by hand.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 arch/mips/alchemy/common/clock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/alchemy/common/clock.c b/arch/mips/alchemy/common/clock.c
index 7ba7ea0..1e6db08 100644
--- a/arch/mips/alchemy/common/clock.c
+++ b/arch/mips/alchemy/common/clock.c
@@ -142,7 +142,7 @@ void __init alchemy_set_lpj(void)
 	preset_lpj /= 2 * HZ;
 }
 
-static struct clk_ops alchemy_clkops_cpu = {
+static const struct clk_ops alchemy_clkops_cpu = {
 	.recalc_rate	= alchemy_clk_cpu_recalc,
 };
 
@@ -223,7 +223,7 @@ static long alchemy_clk_aux_roundr(struct clk_hw *hw,
 	return (*parent_rate) * mult;
 }
 
-static struct clk_ops alchemy_clkops_aux = {
+static const struct clk_ops alchemy_clkops_aux = {
 	.recalc_rate	= alchemy_clk_aux_recalc,
 	.set_rate	= alchemy_clk_aux_setr,
 	.round_rate	= alchemy_clk_aux_roundr,
@@ -575,7 +575,7 @@ static int alchemy_clk_fgv1_detr(struct clk_hw *hw,
 }
 
 /* Au1000, Au1100, Au15x0, Au12x0 */
-static struct clk_ops alchemy_clkops_fgenv1 = {
+static const struct clk_ops alchemy_clkops_fgenv1 = {
 	.recalc_rate	= alchemy_clk_fgv1_recalc,
 	.determine_rate	= alchemy_clk_fgv1_detr,
 	.set_rate	= alchemy_clk_fgv1_setr,
@@ -716,7 +716,7 @@ static int alchemy_clk_fgv2_detr(struct clk_hw *hw,
 }
 
 /* Au1300 larger input mux, no separate disable bit, flexible divider */
-static struct clk_ops alchemy_clkops_fgenv2 = {
+static const struct clk_ops alchemy_clkops_fgenv2 = {
 	.recalc_rate	= alchemy_clk_fgv2_recalc,
 	.determine_rate	= alchemy_clk_fgv2_detr,
 	.set_rate	= alchemy_clk_fgv2_setr,
@@ -924,7 +924,7 @@ static int alchemy_clk_csrc_detr(struct clk_hw *hw,
 	return alchemy_clk_fgcs_detr(hw, req, scale, 4);
 }
 
-static struct clk_ops alchemy_clkops_csrc = {
+static const struct clk_ops alchemy_clkops_csrc = {
 	.recalc_rate	= alchemy_clk_csrc_recalc,
 	.determine_rate	= alchemy_clk_csrc_detr,
 	.set_rate	= alchemy_clk_csrc_setr,
-- 
1.9.1
