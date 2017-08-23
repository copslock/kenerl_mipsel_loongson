Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2017 20:21:01 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64841 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993929AbdHWSURT0j0I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2017 20:20:17 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 4D9B61C162329;
        Wed, 23 Aug 2017 19:20:07 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 23 Aug 2017 19:20:11
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <trivial@kernel.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 06/11] MIPS: Include elf-randomize.h for arch_mmap_rnd() & arch_randomize_brk()
Date:   Wed, 23 Aug 2017 11:17:49 -0700
Message-ID: <20170823181754.24044-7-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170823181754.24044-1-paul.burton@imgtec.com>
References: <20170823181754.24044-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59782
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

arch/mips/mm/mmap.c provides our implementations of the arch_mmap_rnd()
& arch_randomize_brk() functions, but doesn't include the
linux/elf-randomize.h header which declares them. This leads to warnings
from sparse:

  arch/mips/mm/mmap.c:146:15: warning: symbol 'arch_mmap_rnd' was not
    declared. Should it be static?
  arch/mips/mm/mmap.c:190:15: warning: symbol 'arch_randomize_brk' was
    not declared. Should it be static?

Fix this by including linux/elf-randomize.h to get the declarations of
arch_mmap_rnd() & arch_randomize_brk().

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---

 arch/mips/mm/mmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index 28adeabe851f..33d3251ecd37 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -7,6 +7,7 @@
  *   written by Ralf Baechle <ralf@linux-mips.org>
  */
 #include <linux/compiler.h>
+#include <linux/elf-randomize.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
-- 
2.14.1
