Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2016 22:27:54 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11149 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993038AbcJTU1jyy2OK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Oct 2016 22:27:39 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8A1B46B035B9F;
        Thu, 20 Oct 2016 21:27:29 +0100 (IST)
Received: from localhost (10.100.200.119) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 20 Oct
 2016 21:27:33 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/6] kbuild: Keep device tree tables though dead code elimination
Date:   Thu, 20 Oct 2016 21:27:00 +0100
Message-ID: <20161020202705.3783-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161020202705.3783-1-paul.burton@imgtec.com>
References: <20161020202705.3783-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.119]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55530
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

When CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is enabled we must ensure that
we still keep the device tree tables, otherwise we end up unable to
probe drivers on systems that do so using device tree & we throw away
the bulk of those drivers because they cease to be referenced.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
---

 include/asm-generic/vmlinux.lds.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3074796..b648d97 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -169,8 +169,8 @@
 #define _OF_TABLE_1(name)						\
 	. = ALIGN(8);							\
 	VMLINUX_SYMBOL(__##name##_of_table) = .;			\
-	*(__##name##_of_table)						\
-	*(__##name##_of_table_end)
+	KEEP(*(__##name##_of_table))					\
+	KEEP(*(__##name##_of_table_end))
 
 #define CLKSRC_OF_TABLES()	OF_TABLE(CONFIG_CLKSRC_OF, clksrc)
 #define IRQCHIP_OF_MATCH_TABLE() OF_TABLE(CONFIG_IRQCHIP, irqchip)
-- 
2.10.0
