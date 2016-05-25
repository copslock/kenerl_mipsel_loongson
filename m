Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 May 2016 12:07:18 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13869 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006657AbcEYKHQjmBro (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 May 2016 12:07:16 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 05D54540CBCB0;
        Wed, 25 May 2016 11:07:05 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 25 May 2016 11:07:08 +0100
Received: from hhunt-arch.le.imgtec.org (192.168.154.26) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 25 May 2016 11:07:07 +0100
From:   Harvey Hunt <harvey.hunt@imgtec.com>
To:     <ralf@linux-mips.org>
CC:     Harvey Hunt <harvey.hunt@imgtec.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        "# 4 . 2 . x-" <stable@vger.kernel.org>
Subject: [PATCH] MIPS: lib: Mark intrinsics notrace
Date:   Wed, 25 May 2016 11:06:35 +0100
Message-ID: <20160525100635.22541-1-harvey.hunt@imgtec.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.26]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: harvey.hunt@imgtec.com
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

On certain MIPS32 devices, the ftrace tracer "function_graph" uses
__lshrdi3() during the capturing of trace data. ftrace then attempts to
trace __lshrdi3() which leads to infinite recursion and a stack overflow.
Fix this by marking __lshrdi3() as notrace. Mark the other compiler
intrinsics as notrace in case the compiler decides to use them in the
ftrace path.

Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
Cc: <linux-mips@linux-mips.org>
Cc: <linux-kernel@vger.kernel.org>
Cc: <stable@vger.kernel.org> # 4.2.x-
---
I've only been able to test this patch as far back as 4.2, although
the issue could have existed before then.

 arch/mips/lib/ashldi3.c | 2 +-
 arch/mips/lib/ashrdi3.c | 2 +-
 arch/mips/lib/bswapdi.c | 2 +-
 arch/mips/lib/bswapsi.c | 2 +-
 arch/mips/lib/cmpdi2.c  | 2 +-
 arch/mips/lib/lshrdi3.c | 2 +-
 arch/mips/lib/ucmpdi2.c | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/lib/ashldi3.c b/arch/mips/lib/ashldi3.c
index beb80f31..927dc94 100644
--- a/arch/mips/lib/ashldi3.c
+++ b/arch/mips/lib/ashldi3.c
@@ -2,7 +2,7 @@
 
 #include "libgcc.h"
 
-long long __ashldi3(long long u, word_type b)
+long long notrace __ashldi3(long long u, word_type b)
 {
 	DWunion uu, w;
 	word_type bm;
diff --git a/arch/mips/lib/ashrdi3.c b/arch/mips/lib/ashrdi3.c
index c884a91..9fdf1a5 100644
--- a/arch/mips/lib/ashrdi3.c
+++ b/arch/mips/lib/ashrdi3.c
@@ -2,7 +2,7 @@
 
 #include "libgcc.h"
 
-long long __ashrdi3(long long u, word_type b)
+long long notrace __ashrdi3(long long u, word_type b)
 {
 	DWunion uu, w;
 	word_type bm;
diff --git a/arch/mips/lib/bswapdi.c b/arch/mips/lib/bswapdi.c
index 77e5f9c..e3e77aa 100644
--- a/arch/mips/lib/bswapdi.c
+++ b/arch/mips/lib/bswapdi.c
@@ -1,6 +1,6 @@
 #include <linux/module.h>
 
-unsigned long long __bswapdi2(unsigned long long u)
+unsigned long long notrace __bswapdi2(unsigned long long u)
 {
 	return (((u) & 0xff00000000000000ull) >> 56) |
 	       (((u) & 0x00ff000000000000ull) >> 40) |
diff --git a/arch/mips/lib/bswapsi.c b/arch/mips/lib/bswapsi.c
index 2b302ff..530a8af 100644
--- a/arch/mips/lib/bswapsi.c
+++ b/arch/mips/lib/bswapsi.c
@@ -1,6 +1,6 @@
 #include <linux/module.h>
 
-unsigned int __bswapsi2(unsigned int u)
+unsigned int notrace __bswapsi2(unsigned int u)
 {
 	return (((u) & 0xff000000) >> 24) |
 	       (((u) & 0x00ff0000) >>  8) |
diff --git a/arch/mips/lib/cmpdi2.c b/arch/mips/lib/cmpdi2.c
index 8c13064..06857da 100644
--- a/arch/mips/lib/cmpdi2.c
+++ b/arch/mips/lib/cmpdi2.c
@@ -2,7 +2,7 @@
 
 #include "libgcc.h"
 
-word_type __cmpdi2(long long a, long long b)
+word_type notrace __cmpdi2(long long a, long long b)
 {
 	const DWunion au = {
 		.ll = a
diff --git a/arch/mips/lib/lshrdi3.c b/arch/mips/lib/lshrdi3.c
index dcf8d68..3645474 100644
--- a/arch/mips/lib/lshrdi3.c
+++ b/arch/mips/lib/lshrdi3.c
@@ -2,7 +2,7 @@
 
 #include "libgcc.h"
 
-long long __lshrdi3(long long u, word_type b)
+long long notrace __lshrdi3(long long u, word_type b)
 {
 	DWunion uu, w;
 	word_type bm;
diff --git a/arch/mips/lib/ucmpdi2.c b/arch/mips/lib/ucmpdi2.c
index bb4cb2f..bd599f5 100644
--- a/arch/mips/lib/ucmpdi2.c
+++ b/arch/mips/lib/ucmpdi2.c
@@ -2,7 +2,7 @@
 
 #include "libgcc.h"
 
-word_type __ucmpdi2(unsigned long long a, unsigned long long b)
+word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
 {
 	const DWunion au = {.ll = a};
 	const DWunion bu = {.ll = b};
-- 
2.8.3
