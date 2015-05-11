Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 19:58:24 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35748 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027465AbbEKRzug8iTt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:50 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F1297BB6;
        Mon, 11 May 2015 17:55:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 16/72] MIPS: r4kcache: Use correct base register for MIPS R6 cache flushes
Date:   Mon, 11 May 2015 10:54:22 -0700
Message-Id: <20150511175437.598355085@linuxfoundation.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <20150511175437.112151861@linuxfoundation.org>
References: <20150511175437.112151861@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Markos Chandras <markos.chandras@imgtec.com>

Commit f6b39ae6f4d6ee835bb16e452086121aa010f1a7 upstream.

Commit 934c79231c1b("MIPS: asm: r4kcache: Add MIPS R6 cache unroll
functions") added support for MIPS R6 cache flushes but it used the
wrong base address register to perform the flushes so the same lines
were flushed over and over. Moreover, replace the "addiu" instructions
with LONG_ADDIU so the correct base address is calculated for 64-bit
cores.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Fixes: 934c79231c1b("MIPS: asm: r4kcache: Add MIPS R6 cache unroll functions")
Cc: linux-mips@linux-mips.org
Reviewed-by: Maciej W. Rozycki <macro@linux-mips.org>
Patchwork: https://patchwork.linux-mips.org/patch/9384/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/r4kcache.h |   89 +++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 44 deletions(-)

--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -12,6 +12,8 @@
 #ifndef _ASM_R4KCACHE_H
 #define _ASM_R4KCACHE_H
 
+#include <linux/stringify.h>
+
 #include <asm/asm.h>
 #include <asm/cacheops.h>
 #include <asm/compiler.h>
@@ -344,7 +346,7 @@ static inline void invalidate_tcache_pag
 	"	cache %1, 0x0a0(%0); cache %1, 0x0b0(%0)\n"	\
 	"	cache %1, 0x0c0(%0); cache %1, 0x0d0(%0)\n"	\
 	"	cache %1, 0x0e0(%0); cache %1, 0x0f0(%0)\n"	\
-	"	addiu $1, $0, 0x100			\n"	\
+	"	"__stringify(LONG_ADDIU)" $1, %0, 0x100	\n"	\
 	"	cache %1, 0x000($1); cache %1, 0x010($1)\n"	\
 	"	cache %1, 0x020($1); cache %1, 0x030($1)\n"	\
 	"	cache %1, 0x040($1); cache %1, 0x050($1)\n"	\
@@ -368,17 +370,17 @@ static inline void invalidate_tcache_pag
 	"	cache %1, 0x040(%0); cache %1, 0x060(%0)\n"	\
 	"	cache %1, 0x080(%0); cache %1, 0x0a0(%0)\n"	\
 	"	cache %1, 0x0c0(%0); cache %1, 0x0e0(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
+	"	"__stringify(LONG_ADDIU)" $1, %0, 0x100 \n"	\
 	"	cache %1, 0x000($1); cache %1, 0x020($1)\n"	\
 	"	cache %1, 0x040($1); cache %1, 0x060($1)\n"	\
 	"	cache %1, 0x080($1); cache %1, 0x0a0($1)\n"	\
 	"	cache %1, 0x0c0($1); cache %1, 0x0e0($1)\n"	\
-	"	addiu $1, $1, 0x100\n"				\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
 	"	cache %1, 0x000($1); cache %1, 0x020($1)\n"	\
 	"	cache %1, 0x040($1); cache %1, 0x060($1)\n"	\
 	"	cache %1, 0x080($1); cache %1, 0x0a0($1)\n"	\
 	"	cache %1, 0x0c0($1); cache %1, 0x0e0($1)\n"	\
-	"	addiu $1, $1, 0x100\n"				\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100\n"	\
 	"	cache %1, 0x000($1); cache %1, 0x020($1)\n"	\
 	"	cache %1, 0x040($1); cache %1, 0x060($1)\n"	\
 	"	cache %1, 0x080($1); cache %1, 0x0a0($1)\n"	\
@@ -396,25 +398,25 @@ static inline void invalidate_tcache_pag
 	"	.set noat\n"					\
 	"	cache %1, 0x000(%0); cache %1, 0x040(%0)\n"	\
 	"	cache %1, 0x080(%0); cache %1, 0x0c0(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
+	"	"__stringify(LONG_ADDIU)" $1, %0, 0x100 \n"	\
 	"	cache %1, 0x000($1); cache %1, 0x040($1)\n"	\
 	"	cache %1, 0x080($1); cache %1, 0x0c0($1)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
 	"	cache %1, 0x000($1); cache %1, 0x040($1)\n"	\
 	"	cache %1, 0x080($1); cache %1, 0x0c0($1)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
 	"	cache %1, 0x000($1); cache %1, 0x040($1)\n"	\
 	"	cache %1, 0x080($1); cache %1, 0x0c0($1)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
 	"	cache %1, 0x000($1); cache %1, 0x040($1)\n"	\
 	"	cache %1, 0x080($1); cache %1, 0x0c0($1)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
 	"	cache %1, 0x000($1); cache %1, 0x040($1)\n"	\
 	"	cache %1, 0x080($1); cache %1, 0x0c0($1)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
 	"	cache %1, 0x000($1); cache %1, 0x040($1)\n"	\
 	"	cache %1, 0x080($1); cache %1, 0x0c0($1)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
 	"	cache %1, 0x000($1); cache %1, 0x040($1)\n"	\
 	"	cache %1, 0x080($1); cache %1, 0x0c0($1)\n"	\
 	"	.set pop\n"					\
@@ -429,39 +431,38 @@ static inline void invalidate_tcache_pag
 	"	.set mips64r6\n"				\
 	"	.set noat\n"					\
 	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
-	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
-	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
-	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
-	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
-	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
-	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
-	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
-	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
-	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
-	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
-	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
-	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
-	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
-	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
-	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
-	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
-	"	addiu $1, %0, 0x100\n"				\
+	"	"__stringify(LONG_ADDIU)" $1, %0, 0x100 \n"	\
+	"	cache %1, 0x000($1); cache %1, 0x080($1)\n"	\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
+	"	cache %1, 0x000($1); cache %1, 0x080($1)\n"	\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
+	"	cache %1, 0x000($1); cache %1, 0x080($1)\n"	\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
+	"	cache %1, 0x000($1); cache %1, 0x080($1)\n"	\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
+	"	cache %1, 0x000($1); cache %1, 0x080($1)\n"	\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
+	"	cache %1, 0x000($1); cache %1, 0x080($1)\n"	\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
+	"	cache %1, 0x000($1); cache %1, 0x080($1)\n"	\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
+	"	cache %1, 0x000($1); cache %1, 0x080($1)\n"	\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
+	"	cache %1, 0x000($1); cache %1, 0x080($1)\n"	\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
+	"	cache %1, 0x000($1); cache %1, 0x080($1)\n"	\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
+	"	cache %1, 0x000($1); cache %1, 0x080($1)\n"	\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
+	"	cache %1, 0x000($1); cache %1, 0x080($1)\n"	\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
+	"	cache %1, 0x000($1); cache %1, 0x080($1)\n"	\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
+	"	cache %1, 0x000($1); cache %1, 0x080($1)\n"	\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
+	"	cache %1, 0x000($1); cache %1, 0x080($1)\n"	\
+	"	"__stringify(LONG_ADDIU)" $1, $1, 0x100 \n"	\
+	"	cache %1, 0x000($1); cache %1, 0x080($1)\n"	\
 	"	.set pop\n"					\
 		:						\
 		: "r" (base),					\
