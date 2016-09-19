Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2016 23:24:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:21329 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993016AbcISVXqGVVxF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Sep 2016 23:23:46 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id EDCFE5F0D7604;
        Mon, 19 Sep 2016 22:23:25 +0100 (IST)
Received: from localhost (10.100.200.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 19 Sep
 2016 22:23:29 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/14] of/platform: Probe "isa" busses by default
Date:   Mon, 19 Sep 2016 22:21:24 +0100
Message-ID: <20160919212132.28893-8-paul.burton@imgtec.com>
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
X-archive-position: 55180
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
default bus") platforms calling of_platform_bus_probe from an initcall
is either a rather unsafe race with of_platform_default_populate_init or
a no-op. The MIPS Malta board needs to probe devices under an ISA bus,
which we do support in the of_busses array but until now haven't
included in of_default_bus_match_table.

Add an "isa" entry to of_default_bus_match_table such that we can just
accept use of of_platform_default_populate_init & remove the
Malta-specific match table in a later patch.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>

---

Changes in v2:
- New patch to deal with 44a7185c2ae6

 drivers/of/platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index f39ccd5..d85e431 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -29,6 +29,7 @@
 const struct of_device_id of_default_bus_match_table[] = {
 	{ .compatible = "simple-bus", },
 	{ .compatible = "simple-mfd", },
+	{ .compatible = "isa", },
 #ifdef CONFIG_ARM_AMBA
 	{ .compatible = "arm,amba-bus", },
 #endif /* CONFIG_ARM_AMBA */
-- 
2.9.3
