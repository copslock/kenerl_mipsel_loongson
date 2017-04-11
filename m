Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Apr 2017 09:01:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32388 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993914AbdDKHAwKXKY6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Apr 2017 09:00:52 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 3F3B3CCB8A9D2;
        Tue, 11 Apr 2017 08:00:44 +0100 (IST)
Received: from WR-NOWAKOWSKI.kl.imgtec.org (10.80.2.5) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 11 Apr 2017 08:00:45 +0100
From:   Marcin Nowakowski <marcin.nowakowski@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Subject: [PATCH 2/3] MIPS: highmem: ensure that we don't use more than one page for PTEs
Date:   Tue, 11 Apr 2017 09:00:35 +0200
Message-ID: <1491894036-5440-3-git-send-email-marcin.nowakowski@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1491894036-5440-1-git-send-email-marcin.nowakowski@imgtec.com>
References: <1491894036-5440-1-git-send-email-marcin.nowakowski@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.2.5]
Return-Path: <Marcin.Nowakowski@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcin.nowakowski@imgtec.com
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

All PTEs used by PKMAP should be allocated in a contiguous memory area,
but we do not currently have a mechanism to enforce that, so ensure that
we don't try to allocate more entries than would fit in a single page.

Current fixed value of 1024 would not work with XPA enabled when
sizeof(pte_t)==8 and we need two pages to store pte tables.

Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
---
 arch/mips/include/asm/highmem.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/include/asm/highmem.h b/arch/mips/include/asm/highmem.h
index d34536e..279b6d1 100644
--- a/arch/mips/include/asm/highmem.h
+++ b/arch/mips/include/asm/highmem.h
@@ -35,7 +35,12 @@ extern pte_t *pkmap_page_table;
  * easily, subsequent pte tables have to be allocated in one physical
  * chunk of RAM.
  */
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+#define LAST_PKMAP 512
+#else
 #define LAST_PKMAP 1024
+#endif
+
 #define LAST_PKMAP_MASK (LAST_PKMAP-1)
 #define PKMAP_NR(virt)	((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)	(PKMAP_BASE + ((nr) << PAGE_SHIFT))
-- 
2.7.4
