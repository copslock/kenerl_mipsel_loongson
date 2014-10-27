Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2014 22:38:52 +0100 (CET)
Received: from mail-pd0-f201.google.com ([209.85.192.201]:62782 "EHLO
        mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011464AbaJ0Vie5EKE7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2014 22:38:34 +0100
Received: by mail-pd0-f201.google.com with SMTP id r10so514160pdi.4
        for <linux-mips@linux-mips.org>; Mon, 27 Oct 2014 14:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8XvVbMjSC9SaNtYb9GagFfN7gzBKVzyY6nqn/kOr14c=;
        b=NQscpILQCcb6I4OpM6Vxl5eYDTCyxV6b7jN6gPw+yyqopvyE1MgxDeZ4g/k5CjSWz/
         VIgO8RRygE8uLincfDPz37EgCuCq+VWkNkqfuvCaLJuIoh+R+w9YA3AQP5zrrdlYTeLb
         6I0zbOi3bHB/3DeRc9WOKygucfjIiZ0K8GyNsBHTxipDIkFE6641Db+TgIOis5unWKaW
         3BtbOpVjTPtCcf3CwwUjrpjlA/0bFeHaxCxQQgUkQBuDfmwWbMR2RmLkimFZexEBPzNL
         e6uO+crBuxnswTlNhFoCkh3f3N8XETiWxQm9B3Fl+fisSjnaYsz31FLroYLZWR39Mkzw
         wHpA==
X-Gm-Message-State: ALoCoQnHqbFiUWvDx2qCtEXptPJcTzjyj1uoXaHvoB5JWoIw7JKtfHvJrA1JWbuXpo0Q60QdhjWj
X-Received: by 10.68.57.226 with SMTP id l2mr22371187pbq.1.1414445908238;
        Mon, 27 Oct 2014 14:38:28 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n22si700327yhd.1.2014.10.27.14.38.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Oct 2014 14:38:28 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id WkmMYeHZ.1; Mon, 27 Oct 2014 14:38:28 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 71F2C220BC4; Mon, 27 Oct 2014 14:38:27 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Qais Yousef <qais.yousef@imgtec.com>, linux-mips@linux-mips.org,
        Andrew Bresticker <abrestic@chromium.org>
Subject: [PATCH 2/3] MIPS: SEAD3: Use __raw_readl to read configuration register
Date:   Mon, 27 Oct 2014 14:38:23 -0700
Message-Id: <1414445904-4781-2-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1414445904-4781-1-git-send-email-abrestic@chromium.org>
References: <1414445904-4781-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43608
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

No byte swapping is necessary for the SEAD3 configuration register.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/mti-sead3/sead3-int.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/mti-sead3/sead3-int.c b/arch/mips/mti-sead3/sead3-int.c
index 5c6b949..e31e17f 100644
--- a/arch/mips/mti-sead3/sead3-int.c
+++ b/arch/mips/mti-sead3/sead3-int.c
@@ -28,7 +28,8 @@ void __init arch_init_irq(void)
 		mips_cpu_irq_init();
 
 	sead3_config_reg = ioremap_nocache(SEAD_CONFIG_BASE, SEAD_CONFIG_SIZE);
-	gic_present = (readl(sead3_config_reg) & SEAD_CONFIG_GIC_PRESENT_MSK) >>
+	gic_present = (__raw_readl(sead3_config_reg) &
+		       SEAD_CONFIG_GIC_PRESENT_MSK) >>
 		SEAD_CONFIG_GIC_PRESENT_SHF;
 	pr_info("GIC: %spresent\n", (gic_present) ? "" : "not ");
 	pr_info("EIC: %s\n",
-- 
2.1.0.rc2.206.gedb03e5
