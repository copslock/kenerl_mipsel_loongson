Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2016 23:25:17 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22948 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993015AbcISVYAYcOso (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Sep 2016 23:24:00 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5E0DA6D45F6A6;
        Mon, 19 Sep 2016 22:23:40 +0100 (IST)
Received: from localhost (10.100.200.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 19 Sep
 2016 22:23:44 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/14] MIPS: Malta: Remove custom DT match table
Date:   Mon, 19 Sep 2016 22:21:25 +0100
Message-ID: <20160919212132.28893-9-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160919212132.28893-1-paul.burton@imgtec.com>
References: <20160919212132.28893-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.110]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55181
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

Since commit 44a7185c2ae6 ("of/platform: Add common method to populate
default bus") the Malta publish_devices initcall has essentially been a
no-op. Remove it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

Changes in v2:
- New patch to deal with 44a7185c2ae6

 arch/mips/mti-malta/malta-dt.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/mips/mti-malta/malta-dt.c b/arch/mips/mti-malta/malta-dt.c
index 47a2288..4822943 100644
--- a/arch/mips/mti-malta/malta-dt.c
+++ b/arch/mips/mti-malta/malta-dt.c
@@ -17,18 +17,3 @@ void __init device_tree_init(void)
 {
 	unflatten_and_copy_device_tree();
 }
-
-static const struct of_device_id bus_ids[] __initconst = {
-	{ .compatible = "simple-bus", },
-	{ .compatible = "isa", },
-	{},
-};
-
-static int __init publish_devices(void)
-{
-	if (!of_have_populated_dt())
-		return 0;
-
-	return of_platform_bus_probe(NULL, bus_ids, NULL);
-}
-device_initcall(publish_devices);
-- 
2.9.3
