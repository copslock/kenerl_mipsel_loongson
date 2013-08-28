Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Aug 2013 10:42:58 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:55241 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817033Ab3H1IlxgEnmx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 28 Aug 2013 10:41:53 +0200
Received: from arrakis.dune.hu (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 455AC2807C9;
        Wed, 28 Aug 2013 10:41:18 +0200 (CEST)
Received: from localhost.localdomain (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA;
        Wed, 28 Aug 2013 10:41:18 +0200 (CEST)
From:   Gabor Juhos <juhosg@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 2/6] MIPS: ath79: use local ref clock rate in ar934x_get_pll_freq
Date:   Wed, 28 Aug 2013 10:41:43 +0200
Message-Id: <1377679307-429-3-git-send-email-juhosg@openwrt.org>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1377679307-429-1-git-send-email-juhosg@openwrt.org>
References: <1377679307-429-1-git-send-email-juhosg@openwrt.org>
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

The reference clock rate is passed in the first
argument of the function. Use that instead of the
rate of the global ath79_ref_clk variable.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 arch/mips/ath79/clock.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 733017b..4378d63 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -174,12 +174,12 @@ static u32 __init ar934x_get_pll_freq(u32 ref, u32 ref_div, u32 nint, u32 nfrac,
 	u64 t;
 	u32 ret;
 
-	t = ath79_ref_clk.rate;
+	t = ref;
 	t *= nint;
 	do_div(t, ref_div);
 	ret = t;
 
-	t = ath79_ref_clk.rate;
+	t = ref;
 	t *= nfrac;
 	do_div(t, ref_div * frac);
 	ret += t;
-- 
1.7.10
