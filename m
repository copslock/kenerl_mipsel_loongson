Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 08:19:13 +0200 (CEST)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:40104 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817667Ab2JWGRkH6Vhd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 08:17:40 +0200
Received: by mail-pa0-f49.google.com with SMTP id bi5so2352864pad.36
        for <multiple recipients>; Mon, 22 Oct 2012 23:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/cVxNdmeCSwlhz7TeHGLUTBSy5l3yxiVEJey3HoocSk=;
        b=Lsyj04a/zQA75mwcbSgbxGtZPAJZ2Rsa6lNeKDD21+2391+la3PnguXeQ6qkQMeFdP
         hH2muylDNzvLvGvDLAiVYIbGvFZf2wvsrULdEH1HwMmgynCxhielVNm9BeNjIN8yV3q6
         x6+0HSn04YgpY+4DypK8lJ1v7hDY/qwysJ9SMvz0iIKpXIWpUyxH2Ig/bMJhc4sJK2Ke
         IgbHaw1RBQDrdym+gWyruENpcJyCZ2SUo6gwhDNvi8FD6LrlWGy/MRPA3q6KbBJb4TF6
         SdGlPnRFBpTGJGWbyLVITfSxb2tuclfTtC1WMa6t7bTNG9w79PRsamffRoPJxUIs2bta
         jyTQ==
Received: by 10.66.86.165 with SMTP id q5mr32329595paz.18.1350973058038;
        Mon, 22 Oct 2012 23:17:38 -0700 (PDT)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id bc8sm7185918pab.5.2012.10.22.23.17.32
        (version=SSLv3 cipher=OTHER);
        Mon, 22 Oct 2012 23:17:37 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org
Cc:     mturquette@linaro.org, Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 4/4] MIPS: Loongson1B: Fix a typo
Date:   Tue, 23 Oct 2012 14:17:03 +0800
Message-Id: <1350973023-7667-5-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1350973023-7667-1-git-send-email-keguang.zhang@gmail.com>
References: <1350973023-7667-1-git-send-email-keguang.zhang@gmail.com>
X-archive-position: 34742
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keguang.zhang@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Fix a typo in the code.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/loongson1/common/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/loongson1/common/clock.c b/arch/mips/loongson1/common/clock.c
index 7db0a6a..07133de 100644
--- a/arch/mips/loongson1/common/clock.c
+++ b/arch/mips/loongson1/common/clock.c
@@ -22,7 +22,7 @@ void __init plat_time_init(void)
 	/* setup mips r4k timer */
 	clk = clk_get(NULL, "cpu");
 	if (IS_ERR(clk))
-		panic("unable to get dc clock, err=%ld", PTR_ERR(clk));
+		panic("unable to get cpu clock, err=%ld", PTR_ERR(clk));
 
 	mips_hpt_frequency = clk_get_rate(clk) / 2;
 }
-- 
1.7.1
