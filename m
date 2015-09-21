Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Sep 2015 15:36:32 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37387 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008401AbbIUNgbVK74j (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Sep 2015 15:36:31 +0200
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout2.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NV1005VZ4GOSH60@mailout2.w1.samsung.com>; Mon,
 21 Sep 2015 14:36:24 +0100 (BST)
X-AuditID: cbfec7f4-f79c56d0000012ee-04-560007d8fb26
Received: from eusync3.samsung.com ( [203.254.199.213])
        by eucpsbgm1.samsung.com (EUCPMTA) with SMTP id 21.77.04846.8D700065; Mon,
 21 Sep 2015 14:36:24 +0100 (BST)
Received: from AMDC1061.digital.local ([106.116.147.88])
 by eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTPA id <0NV100LNT4DTKI10@eusync3.samsung.com>; Mon,
 21 Sep 2015 14:36:24 +0100 (BST)
From:   Andrzej Hajda <a.hajda@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 36/38] MIPS: remove invalid check
Date:   Mon, 21 Sep 2015 15:34:08 +0200
Message-id: <1442842450-29769-37-git-send-email-a.hajda@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
References: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42I5/e/4Vd0b7AxhBuu/KVncWneO1WLjjPWs
        Fpd3zWGzmDB1ErvF2iN32S0+397OanFpj4oDu0fPzjOMHkdXrmXy6NuyitHj8ya5AJYoLpuU
        1JzMstQifbsErozF7SsYC/6zVSx9uYKtgfEwaxcjJ4eEgInE262vGSFsMYkL99azdTFycQgJ
        LGWUaG+ewwjhNDFJnH67hQmkik1AU+Lv5ptsILaIgILE5t5nrCBFzAL/GSVubT0BNlZYwFDi
        /cvLYEUsAqoSv5fuYwaxeQVcJJ7MOMwEsU5O4uSxyWD1nEDxAwe/sIDYQgLOEgeWHGGawMi7
        gJFhFaNoamlyQXFSeq6hXnFibnFpXrpecn7uJkZIMH3Zwbj4mNUhRgEORiUeXgeB/6FCrIll
        xZW5hxglOJiVRHh1ZgGFeFMSK6tSi/Lji0pzUosPMUpzsCiJ887d9T5ESCA9sSQ1OzW1ILUI
        JsvEwSnVwDiBcQI3k+Hv0wHrrhgXKu8SP3qtVZ0nT2CWbFYBQ1s3w06+ea873M1d9bfuXdk/
        O+nB9SgfKbvgR6vv/F97sfKOc15yVl1/p7Dt+3iB5hfdvf2VS4ML5sWZxTF/TNauujYxpf+W
        JJ+FW9yzJY1TZ3Guk9RezjnlkOk0fevvS5Yt9Thy+N+r90osxRmJhlrMRcWJAP4I1kQiAgAA
Return-Path: <a.hajda@samsung.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49250
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.hajda@samsung.com
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

Unsigned values cannot be lesser than zero.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2038576

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/mips/mm/sc-mips.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/sc-mips.c b/arch/mips/mm/sc-mips.c
index 53ea839..1755187 100644
--- a/arch/mips/mm/sc-mips.c
+++ b/arch/mips/mm/sc-mips.c
@@ -162,13 +162,13 @@ static inline int __init mips_sc_probe(void)
 		return 0;
 
 	tmp = (config2 >> 8) & 0x0f;
-	if (0 <= tmp && tmp <= 7)
+	if (tmp <= 7)
 		c->scache.sets = 64 << tmp;
 	else
 		return 0;
 
 	tmp = (config2 >> 0) & 0x0f;
-	if (0 <= tmp && tmp <= 7)
+	if (tmp <= 7)
 		c->scache.ways = tmp + 1;
 	else
 		return 0;
-- 
1.9.1
