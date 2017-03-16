Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Mar 2017 14:06:25 +0100 (CET)
Received: from smtpbg202.qq.com ([184.105.206.29]:53650 "EHLO smtpbg202.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991955AbdCPNGRmmZl- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Mar 2017 14:06:17 +0100
X-QQ-mid: bizesmtp3t1489669549tf9zel0e6
Received: from software.domain.org (unknown [222.92.8.142])
        by esmtp4.qq.com (ESMTP) with 
        id ; Thu, 16 Mar 2017 21:03:57 +0800 (CST)
X-QQ-SSF: 01100000002000F0FK82000A0000000
X-QQ-FEAT: vvj9aApAGBjUt2nGXbWuElTdlS4YDUaL67HLPJqXFoHcmjH4gp+XM5M24NqIu
        OMdWLh8hlY4fkOLHffUcfQtjOtooWJ7zyxM7VkchYbg/NUGmB8L4Z+ui+dp98M63g7EAfzJ
        tjMzR6Eu2JI6VFEXjoq4I6D09JVwRsTnyXSbgTPyrGHrBtKkJDEwxHMOQ9bJZffEOj+QL0h
        meYsB84HHvOMF7tYxOLzBsLuf+DHUGko/Q5cuwa0AxcyRoIziLauPEGMCuW4pBXg2wGxdB6
        Ur+3x12RHNHQS20GgGr+ZD4UugUHVA0me37Q==
X-QQ-GoodBg: 0
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
Subject: [PATCH RESEND V2 5/7] MIPS: c-r4k: Fix Loongson-3's vcache/scache waysize calculation
Date:   Thu, 16 Mar 2017 21:00:29 +0800
Message-Id: <1489669231-28162-5-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1489669231-28162-1-git-send-email-chenhc@lemote.com>
References: <1489669231-28162-1-git-send-email-chenhc@lemote.com>
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenhc@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

If scache.waysize is 0, r4k___flush_cache_all() will do nothing and
then cause bugs. BTW, though vcache.waysize isn't being used by now,
we also fix its calculation.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/mm/c-r4k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index e7f798d..3fe99cb 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1562,6 +1562,7 @@ static void probe_vcache(void)
 	vcache_size = c->vcache.sets * c->vcache.ways * c->vcache.linesz;
 
 	c->vcache.waybit = 0;
+	c->vcache.waysize = vcache_size / c->vcache.ways;
 
 	pr_info("Unified victim cache %ldkB %s, linesize %d bytes.\n",
 		vcache_size >> 10, way_string[c->vcache.ways], c->vcache.linesz);
@@ -1664,6 +1665,7 @@ static void __init loongson3_sc_init(void)
 	/* Loongson-3 has 4 cores, 1MB scache for each. scaches are shared */
 	scache_size *= 4;
 	c->scache.waybit = 0;
+	c->scache.waysize = scache_size / c->scache.ways;
 	pr_info("Unified secondary cache %ldkB %s, linesize %d bytes.\n",
 	       scache_size >> 10, way_string[c->scache.ways], c->scache.linesz);
 	if (scache_size)
-- 
2.7.0
