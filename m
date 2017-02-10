Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Feb 2017 00:01:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24638 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992236AbdBJXBhUaW0t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Feb 2017 00:01:37 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 255A2FBC65598;
        Fri, 10 Feb 2017 23:01:25 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 10 Feb 2017 23:01:29 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Justin Chen <justin.chen@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH] MIPS: Fix cacheinfo overflow
Date:   Fri, 10 Feb 2017 23:01:20 +0000
Message-ID: <20170210230120.21588-1-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170208234523.GA13263@roeck-us.net>
References: <20170208234523.GA13263@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

The recently added MIPS cacheinfo support used a macro populate_cache()
to populate the cacheinfo structures depending on which caches are
present. However the macro contains multiple statements without
enclosing them in a do {} while (0) loop, so the L2 and L3 cache
conditionals in populate_cache_leaves() only conditionalised the first
statement in the macro.

This overflows the buffer allocated by detect_cache_attributes(),
resulting in boot failures under QEMU where neither the L2 or L2 caches
are present.

Enclose the macro statements in a do {} while (0) block to keep the
whole macro inside the conditionals.

Fixes: ef462f3b64e9 ("MIPS: Add cacheinfo support")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Justin Chen <justin.chen@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: bcm-kernel-feedback-list@broadcom.com
---
 arch/mips/kernel/cacheinfo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/cacheinfo.c b/arch/mips/kernel/cacheinfo.c
index a92bbbae969b..97d5239ca47b 100644
--- a/arch/mips/kernel/cacheinfo.c
+++ b/arch/mips/kernel/cacheinfo.c
@@ -17,6 +17,7 @@
 
 /* Populates leaf and increments to next leaf */
 #define populate_cache(cache, leaf, c_level, c_type)		\
+do {								\
 	leaf->type = c_type;					\
 	leaf->level = c_level;					\
 	leaf->coherency_line_size = c->cache.linesz;		\
@@ -24,7 +25,8 @@
 	leaf->ways_of_associativity = c->cache.ways;		\
 	leaf->size = c->cache.linesz * c->cache.sets *		\
 		c->cache.ways;					\
-	leaf++;
+	leaf++;							\
+} while (0)
 
 static int __init_cache_level(unsigned int cpu)
 {
-- 
2.11.0
