Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Sep 2016 20:06:01 +0200 (CEST)
Received: from conuserg-10.nifty.com ([210.131.2.77]:40674 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991977AbcIRSFybJdAh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Sep 2016 20:05:54 +0200
Received: from grover.sesame (FL1-111-169-71-157.osk.mesh.ad.jp [111.169.71.157]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id u8II4aDd017348;
        Mon, 19 Sep 2016 03:04:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com u8II4aDd017348
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1474221879;
        bh=WwXnpdHNicD9zDdJA5Y3AIhwZMLkHt7yHQqPbng5lNw=;
        h=From:To:Cc:Subject:Date:From;
        b=kew6G0RvbMZerneS/fK5o2PziNYGqRLrC/8M20fNIL6UPQ5y0WL7uLPY+UUJsq+rl
         WN2qjUGONOivBnPGgelntMLzNAk3Y62JceiZpS4QNbWdSJDzwaYY35IAY9LeSQiLE1
         1IR5etmm4twkEbDNwDUq5AOzXBjV5zI7/9pZ/hS7agcu0PycOcYEyMfo4yz9tFz0nS
         l7WY0NNdKxCqr9jwMPesgCAvhDjDwsKpZffk+P/xNafep23ilDjg0j8KhhsqNZodNQ
         CndK3nbt0XvfDeCEGVBqEWc8jjCK+5mqsBvBI9xYq6gKWu1lv2mq6Ym1imSZ5/0U2j
         PfQlrKQ8bFlzw==
X-Nifty-SrcIP: [111.169.71.157]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4] MIPS: bcm63xx: let clk_disable() return immediately if clk is NULL
Date:   Mon, 19 Sep 2016 03:04:35 +0900
Message-Id: <1474221875-22687-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

In many of clk_disable() implementations, it is a no-op for a NULL
pointer input, but this is one of the exceptions.

Making it treewide consistent will allow clock consumers to call
clk_disable() without NULL pointer check.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4:
  - Split into per-arch patches

Changes in v3:
  - Return only when clk is NULL.  Do not take care of error pointer.

Changes in v2:
  - Rebase on Linux 4.6-rc1

 arch/mips/bcm63xx/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 6375652..b49fc9c 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -326,6 +326,9 @@ EXPORT_SYMBOL(clk_enable);
 
 void clk_disable(struct clk *clk)
 {
+	if (!clk)
+		return;
+
 	mutex_lock(&clocks_mutex);
 	clk_disable_unlocked(clk);
 	mutex_unlock(&clocks_mutex);
-- 
1.9.1
