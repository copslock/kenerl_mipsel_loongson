Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:24:28 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:35124 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041502AbcFIVTpwWMyE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:19:45 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bB7Mf-0005SF-0n; Thu, 09 Jun 2016 21:19:45 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bB7Mb-0006H0-OG; Thu, 09 Jun 2016 14:19:41 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Harvey Hunt <harvey.hunt@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 145/206] MIPS: lib: Mark intrinsics notrace
Date:   Thu,  9 Jun 2016 14:15:54 -0700
Message-Id: <1465507015-23052-146-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465507015-23052-1-git-send-email-kamal@canonical.com>
References: <1465507015-23052-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

4.2.8-ckt12 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: Harvey Hunt <harvey.hunt@imgtec.com>

commit aedcfbe06558a9f53002e82d5be64c6c94687726 upstream.

On certain MIPS32 devices, the ftrace tracer "function_graph" uses
__lshrdi3() during the capturing of trace data. ftrace then attempts to
trace __lshrdi3() which leads to infinite recursion and a stack overflow.
Fix this by marking __lshrdi3() as notrace. Mark the other compiler
intrinsics as notrace in case the compiler decides to use them in the
ftrace path.

Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
Cc: <linux-mips@linux-mips.org>
Cc: <linux-kernel@vger.kernel.org>
Patchwork: https://patchwork.linux-mips.org/patch/13354/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[ kamal: backport to 4.2-stable: no bswap[ds]i.c ]
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/lib/ashldi3.c | 2 +-
 arch/mips/lib/ashrdi3.c | 2 +-
 arch/mips/lib/cmpdi2.c  | 2 +-
 arch/mips/lib/lshrdi3.c | 2 +-
 arch/mips/lib/ucmpdi2.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

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
2.7.4
