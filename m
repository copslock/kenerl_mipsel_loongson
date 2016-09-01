Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 18:33:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60125 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992298AbcIAQbIg0W92 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 18:31:08 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 7F5629A7F6E63;
        Thu,  1 Sep 2016 17:30:49 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 1 Sep 2016 17:30:52 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: [PATCH 6/9] MIPS: cacheflush: Use __flush_icache_user_range()
Date:   Thu, 1 Sep 2016 17:30:12 +0100
Message-ID: <da700c1b02450c810931a8752e906ab8e90cb859.1472747205.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54934
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

The cacheflush(2) system call uses flush_icache_range() to flush a range
of usermode addresses from the icache, so change it to utilise the new
__flush_icache_user_range() API to allow the more generic
flush_icache_range() to be changed to work on kernel addresses only.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/mm/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index 5a644c3fe155..7ec0847c725a 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -78,7 +78,7 @@ SYSCALL_DEFINE3(cacheflush, unsigned long, addr, unsigned long, bytes,
 	if (!access_ok(VERIFY_WRITE, (void __user *) addr, bytes))
 		return -EFAULT;
 
-	flush_icache_range(addr, addr + bytes);
+	__flush_icache_user_range(addr, addr + bytes);
 
 	return 0;
 }
-- 
git-series 0.8.10
