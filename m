Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Nov 2018 16:00:57 +0100 (CET)
Received: from relmlor2.renesas.com ([210.160.252.172]:54931 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992819AbeKPPAw23Cs9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Nov 2018 16:00:52 +0100
Received: from unknown (HELO relmlir4.idc.renesas.com) ([10.200.68.154])
  by relmlie6.idc.renesas.com with ESMTP; 17 Nov 2018 00:00:50 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir4.idc.renesas.com (Postfix) with ESMTP id 11E52E3B81;
        Sat, 17 Nov 2018 00:00:50 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.56,240,1539615600"; 
   d="scan'208";a="297674602"
Received: from unknown (HELO vbox.ree.adwin.renesas.com) ([10.226.37.67])
  by relmlii2.idc.renesas.com with ESMTP; 17 Nov 2018 00:00:47 +0900
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: [PATCH v6 5/6] MIPS: Loongson 2F: Add clk_get_optional() function
Date:   Fri, 16 Nov 2018 14:59:36 +0000
Message-Id: <20181116145937.27660-6-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181116145937.27660-1-phil.edworthy@renesas.com>
References: <20181116145937.27660-1-phil.edworthy@renesas.com>
Return-Path: <phil.edworthy@renesas.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phil.edworthy@renesas.com
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

clk_get_optional() returns NULL if not found instead of -ENOENT,
otherwise the behaviour is the same as clk_get().

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/mips/loongson64/lemote-2f/clock.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/loongson64/lemote-2f/clock.c b/arch/mips/loongson64/lemote-2f/clock.c
index 8281334df9c8..abbade58b635 100644
--- a/arch/mips/loongson64/lemote-2f/clock.c
+++ b/arch/mips/loongson64/lemote-2f/clock.c
@@ -53,6 +53,17 @@ struct clk *clk_get(struct device *dev, const char *id)
 }
 EXPORT_SYMBOL(clk_get);
 
+struct clk *clk_get_optional(struct device *dev, const char *id)
+{
+	struct clk *clk = clk_get(dev, id);
+
+	if (clk == ERR_PTR(-ENOENT))
+		clk = NULL;
+
+	return clk;
+}
+EXPORT_SYMBOL(clk_get_optional);
+
 static void propagate_rate(struct clk *clk)
 {
 	struct clk *clkp;
-- 
2.17.1
