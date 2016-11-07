Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Nov 2016 12:19:22 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18505 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992126AbcKGLSiGltSd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Nov 2016 12:18:38 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id EF275C76D1EA9;
        Mon,  7 Nov 2016 11:18:29 +0000 (GMT)
Received: from localhost (10.100.200.221) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 7 Nov
 2016 11:18:31 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 1/7] MIPS: lib: Split lib-y to a line per file
Date:   Mon, 7 Nov 2016 11:17:56 +0000
Message-ID: <20161107111802.12071-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161107111802.12071-1-paul.burton@imgtec.com>
References: <20161107111802.12071-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.221]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55695
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

Split the lib-y assignment in arch/mips/lib/Makefile to a line per file
such that we can modify the list more easily, with clearer diffs.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 arch/mips/lib/Makefile | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/mips/lib/Makefile b/arch/mips/lib/Makefile
index 0344e57..c0f0d1d 100644
--- a/arch/mips/lib/Makefile
+++ b/arch/mips/lib/Makefile
@@ -2,9 +2,16 @@
 # Makefile for MIPS-specific library files..
 #
 
-lib-y	+= bitops.o csum_partial.o delay.o memcpy.o memset.o \
-	   mips-atomic.o strlen_user.o strncpy_user.o \
-	   strnlen_user.o uncached.o
+lib-y += bitops.o
+lib-y += csum_partial.o
+lib-y += delay.o
+lib-y += memcpy.o
+lib-y += memset.o
+lib-y += mips-atomic.o
+lib-y += strlen_user.o
+lib-y += strncpy_user.o
+lib-y += strnlen_user.o
+lib-y += uncached.o
 
 obj-y			+= iomap.o
 obj-$(CONFIG_PCI)	+= iomap-pci.o
-- 
2.10.2
