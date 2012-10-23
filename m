Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 08:18:53 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:36204 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817419Ab2JWGRjzPMzj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 08:17:39 +0200
Received: by mail-pb0-f49.google.com with SMTP id xa7so180494pbc.36
        for <multiple recipients>; Mon, 22 Oct 2012 23:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=G6h3yp9Ua0M2+fd38ZAwEWPAh/Ig3hsBqCswbRuSBtA=;
        b=feGBWyE6/ULA6Y7oS4c/hingm1PJgNPNCcLt0qbzNq5gjBc8cmiDSVu9aGy62HriAS
         VV2HGXH16IaMuerZMRMnsLdIDWAyF8xRClWbvyKiqs3nFu2+sM9H2r4bHFuxyrCg2fJw
         v1iUx3kvq1zUFz45uhu+w0Bi5AYzQMeCiTQqcBVCoBgFYp0k6qOow2u5+VlCNL0lDDqA
         I9jJQJdnvlke2amZ8RVfmRkaW9cgKJw21EjRKt8M0sCdyIBpHVu37PlBybKtGckECndO
         ipq5H61saXIUf1lqa4TzMzmIKcSEDb3apymbvFiM5jblBG3LLs/+AjEsXOxsmekmyQ9E
         maGg==
Received: by 10.68.136.229 with SMTP id qd5mr36812034pbb.154.1350973052081;
        Mon, 22 Oct 2012 23:17:32 -0700 (PDT)
Received: from kelvin-Work.chd.intersil.com ([182.148.112.76])
        by mx.google.com with ESMTPS id bc8sm7185918pab.5.2012.10.22.23.17.27
        (version=SSLv3 cipher=OTHER);
        Mon, 22 Oct 2012 23:17:30 -0700 (PDT)
From:   Kelvin Cheung <keguang.zhang@gmail.com>
To:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        ralf@linux-mips.org
Cc:     mturquette@linaro.org, Kelvin Cheung <keguang.zhang@gmail.com>
Subject: [PATCH 3/4] MIPS: Loongson1B: Update stmmac_mdio_bus_data
Date:   Tue, 23 Oct 2012 14:17:02 +0800
Message-Id: <1350973023-7667-4-git-send-email-keguang.zhang@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1350973023-7667-1-git-send-email-keguang.zhang@gmail.com>
References: <1350973023-7667-1-git-send-email-keguang.zhang@gmail.com>
X-archive-position: 34741
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

Update stmmac_mdio_bus_data accordingly due to the upstream change.

Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
---
 arch/mips/loongson1/common/platform.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/loongson1/common/platform.c b/arch/mips/loongson1/common/platform.c
index 5ca38dc..3a42276 100644
--- a/arch/mips/loongson1/common/platform.c
+++ b/arch/mips/loongson1/common/platform.c
@@ -71,7 +71,6 @@ static struct resource ls1x_eth0_resources[] = {
 };
 
 static struct stmmac_mdio_bus_data ls1x_mdio_bus_data = {
-	.bus_id		= 0,
 	.phy_mask	= 0,
 };
 
-- 
1.7.1
