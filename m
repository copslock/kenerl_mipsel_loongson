Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Sep 2016 17:39:09 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:35522 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991932AbcIWPjDGFDBi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Sep 2016 17:39:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 4F9A490C492D2;
        Fri, 23 Sep 2016 16:38:53 +0100 (IST)
Received: from localhost (10.100.200.111) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 23 Sep
 2016 16:38:56 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] of: Prevent unaligned access in of_alias_scan()
Date:   Fri, 23 Sep 2016 16:38:27 +0100
Message-ID: <20160923153827.8263-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.111]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

When allocating a struct alias_prop, of_alias_scan() only requested that
it be aligned on a 4 byte boundary. The struct contains pointers which
leads to us attempting 64 bit writes on 64 bit systems, and if the CPU
doesn't support unaligned memory accesses then this causes problems -
for example on some MIPS64r2 CPUs including the "mips64r2-generic" QEMU
emulated CPU it will trigger an address error exception.

Fix this by requesting alignment for the struct alias_prop allocation
matching that which the compiler expects, using the __alignof__ keyword.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
---
 drivers/of/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 3ce6953..448aa40 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -2042,7 +2042,7 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 			continue;
 
 		/* Allocate an alias_prop with enough space for the stem */
-		ap = dt_alloc(sizeof(*ap) + len + 1, 4);
+		ap = dt_alloc(sizeof(*ap) + len + 1, __alignof__(*ap));
 		if (!ap)
 			continue;
 		memset(ap, 0, sizeof(*ap) + len + 1);
-- 
2.10.0
