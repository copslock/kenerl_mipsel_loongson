Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Dec 2013 18:33:59 +0100 (CET)
Received: from fep14.mx.upcmail.net ([62.179.121.34]:42574 "EHLO
        fep14.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6871922Ab3LYOHl4UJpv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Dec 2013 15:07:41 +0100
Received: from edge02.upcmail.net ([192.168.13.237])
          by viefep14-int.chello.at
          (InterMail vM.8.01.05.05 201-2260-151-110-20120111) with ESMTP
          id <20131225140736.YWHW2802.viefep14-int.chello.at@edge02.upcmail.net>;
          Wed, 25 Dec 2013 15:07:36 +0100
Received: from router.bayer.uni.cx ([94.113.216.134])
        by edge02.upcmail.net with edge
        id 5q7c1n00N2uZlV202q7cEX; Wed, 25 Dec 2013 15:07:36 +0100
X-SourceIP: 94.113.216.134
Received: from frank (localhost [IPv6:::1])
        by router.bayer.uni.cx (Postfix) with SMTP id D557F3BEE5;
        Wed, 25 Dec 2013 15:07:34 +0100 (CET)
Received: by frank (sSMTP sendmail emulation); Wed, 25 Dec 2013 15:05:05 +0100
From:   =?UTF-8?q?Petr=20P=C3=ADsa=C5=99?= <petr.pisar@atlas.cz>
To:     <linux-mips@linux-mips.org>
Cc:     =?UTF-8?q?Petr=20P=C3=ADsa=C5=99?= <petr.pisar@atlas.cz>
Subject: [PATCH 1/2] Fix cache flushing on Loongson 2
Date:   Wed, 25 Dec 2013 15:04:21 +0100
Message-Id: <1387980262-2250-2-git-send-email-petr.pisar@atlas.cz>
X-Mailer: git-send-email 1.8.5.1
In-Reply-To: <1387980262-2250-1-git-send-email-petr.pisar@atlas.cz>
References: <1387980262-2250-1-git-send-email-petr.pisar@atlas.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <petr.pisar@atlas.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: petr.pisar@atlas.cz
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

This bug was introduced by an unintended branch swap in commit
14bd8c082016cd1f67fdfd702e4cf6367869a712 (MIPS: Loongson:
Get rid of Loongson 2 #ifdefery all over arch/mips).

Signed-off-by: Petr Písař <petr.pisar@atlas.cz>
---
 arch/mips/mm/c-r4k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 62ffd20..1c2029d 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -580,11 +580,11 @@ static inline void local_r4k_flush_icache_range(unsigned long start, unsigned lo
 	else {
 		switch (boot_cpu_type()) {
 		case CPU_LOONGSON2:
-			protected_blast_icache_range(start, end);
+			protected_loongson23_blast_icache_range(start, end);
 			break;
 
 		default:
-			protected_loongson23_blast_icache_range(start, end);
+			protected_blast_icache_range(start, end);
 			break;
 		}
 	}
-- 
1.8.5.1
