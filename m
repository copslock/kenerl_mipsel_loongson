Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jul 2017 12:18:45 +0200 (CEST)
Received: from mail-wr0-x243.google.com ([IPv6:2a00:1450:400c:c0c::243]:35773
        "EHLO mail-wr0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994849AbdGRKRxp6rVd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jul 2017 12:17:53 +0200
Received: by mail-wr0-x243.google.com with SMTP id a10so3657648wrd.2;
        Tue, 18 Jul 2017 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/V0Xj6tFvR/XVnWakOgTCasASH1qzl4eRLD/BIUMfOc=;
        b=Fb3+emKnnWR+cNXTNoYOBqKpYyDPdJvznqJw1Vp2DMbHgq/H9sahxL2Wow+9P+RMkE
         tbDqZ/PImDCnJ+PuiUSlb8dQs5wEmvu3sOWmVTa2uYvtmf4s7/suomeJQ+mPT+npfXp9
         NpkOvnfoR+kat098W4c00dAThFtxzB59bWHhEUCBgv87UO1kMZhIQV6KOLSLPGhFVgya
         5o6VrXtWWPO8Hw/XfVtsBqb4Xbxsd3ce3vbFF2BXZF1XnY7HipcIImxiCbGRAn+z3L2T
         DJjuS8+QAzGRV0e5G7D1MFMXcsiO0fB745mLAH4rvDc9Ww0dZlJIuI6kLjGwuzG7VwIP
         Q1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/V0Xj6tFvR/XVnWakOgTCasASH1qzl4eRLD/BIUMfOc=;
        b=BuiLLtdSoSaHyl4cnJ1+fymx2/RlrEQyVM9AcDLfz7fq8PkZdmaPbzj0OSX88WtzU1
         Vsak/SGyZGttoUTDCDimMboVBvg4J47H2D7qZyvKgjaSGAXt9T7yQ8mn7XvMul8lXQI0
         9FvKIGVwd2StUj9e1OqrLPylYQQtT/g4MaML4oj15tqx0un6zAYyiiJh7gJDij/Iz9Ov
         SUjYhY01DTROnccfeJ2JDoLOYCdzWA9GkkgU+0D1BJyePK1uI5ciRLx5ZMs3D4rEEmwU
         PI+Do/3pfvcnHB0LWTJQGY5wzT2NhA68Q2hr5h5lXiHBV5X+J4o3EyYTMENFESYL4G81
         yubw==
X-Gm-Message-State: AIVw112rKozaehH7wnjO5vvvLm7aEDcYIdXr+B/BGVZWOU5X3KynU16H
        O6/lFooLuQBRWM9K
X-Received: by 10.28.91.138 with SMTP id p132mr1208709wmb.92.1500373068293;
        Tue, 18 Jul 2017 03:17:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::48e])
        by smtp.gmail.com with ESMTPSA id 9sm3253728wml.25.2017.07.18.03.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jul 2017 03:17:47 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] MIPS: Loongson 2F: allow NULL clock for clk_get_rate
Date:   Tue, 18 Jul 2017 12:17:28 +0200
Message-Id: <20170718101730.2541-8-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20170718101730.2541-1-jonas.gorski@gmail.com>
References: <20170718101730.2541-1-jonas.gorski@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Make the behaviour of clk_get_rate consistent with common clk's
clk_get_rate by accepting NULL clocks as parameter, as some device
drivers rely on this.

Make the behaviour of clk_get_rate consistent with common clk's
clk_get_rate by accepting NULL clocks as parameter. Some device
drivers rely on this, and will cause an OOPS otherwise.

Fixes: f8ede0f700f5 ("MIPS: Loongson 2F: Add CPU frequency scaling support")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Reported-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/loongson64/lemote-2f/clock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/loongson64/lemote-2f/clock.c b/arch/mips/loongson64/lemote-2f/clock.c
index a78fb657068c..8281334df9c8 100644
--- a/arch/mips/loongson64/lemote-2f/clock.c
+++ b/arch/mips/loongson64/lemote-2f/clock.c
@@ -80,6 +80,9 @@ EXPORT_SYMBOL(clk_disable);
 
 unsigned long clk_get_rate(struct clk *clk)
 {
+	if (!clk)
+		return 0;
+
 	return (unsigned long)clk->rate;
 }
 EXPORT_SYMBOL(clk_get_rate);
-- 
2.11.0
