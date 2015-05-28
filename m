Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2015 22:37:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30233 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007644AbbE1Uhawvavz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2015 22:37:30 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 294F7BCC5CA;
        Thu, 28 May 2015 21:37:24 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 28 May
 2015 21:37:27 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Thu, 28 May
 2015 21:37:27 +0100
Received: from [127.0.1.1] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server id 14.3.174.1; Thu, 28 May 2015
 13:37:23 -0700
Subject: [PATCH] MIPS: bugfix of local_r4k_flush_icache_range - added L2
 flush
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     <linux-mips@linux-mips.org>, <david.daney@cavium.com>,
        <cernekee@gmail.com>, <linux-kernel@vger.kernel.org>,
        <ralf@linux-mips.org>, <macro@codesourcery.com>,
        <markos.chandras@imgtec.com>, <kumba@gentoo.org>
Date:   Thu, 28 May 2015 13:37:24 -0700
Message-ID: <20150528203724.28800.63700.stgit@ubuntu-yegoshin>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47718
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

This function is used to flush code used in NMI and EJTAG debug exceptions.
However, during that exceptions the Status.ERL bit is set, which means
that code runs as UNCACHABLE. So, flush code down to memory is needed.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
---
 arch/mips/mm/c-r4k.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 0dbb65a51ce5..9f0299bb9a2a 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -666,17 +666,9 @@ static inline void local_r4k_flush_icache_range(unsigned long start, unsigned lo
 			break;
 		}
 	}
-#ifdef CONFIG_EVA
-	/*
-	 * Due to all possible segment mappings, there might cache aliases
-	 * caused by the bootloader being in non-EVA mode, and the CPU switching
-	 * to EVA during early kernel init. It's best to flush the scache
-	 * to avoid having secondary cores fetching stale data and lead to
-	 * kernel crashes.
-	 */
+
 	bc_wback_inv(start, (end - start));
 	__sync();
-#endif
 }
 
 static inline void local_r4k_flush_icache_range_ipi(void *args)
