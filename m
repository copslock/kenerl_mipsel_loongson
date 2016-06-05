Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jun 2016 23:46:17 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:59984 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042451AbcFEVmkUYTHp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Jun 2016 23:42:40 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BF0A2955;
        Sun,  5 Jun 2016 21:42:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harvey Hunt <harvey.hunt@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 22/99] MIPS: lib: Mark intrinsics notrace
Date:   Sun,  5 Jun 2016 14:40:55 -0700
Message-Id: <20160605213905.111476211@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160605213902.974592018@linuxfoundation.org>
References: <20160605213902.974592018@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53827
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lib/ashldi3.c |    2 +-
 arch/mips/lib/ashrdi3.c |    2 +-
 arch/mips/lib/bswapdi.c |    2 +-
 arch/mips/lib/bswapsi.c |    2 +-
 arch/mips/lib/cmpdi2.c  |    2 +-
 arch/mips/lib/lshrdi3.c |    2 +-
 arch/mips/lib/ucmpdi2.c |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

--- a/arch/mips/lib/ashldi3.c
+++ b/arch/mips/lib/ashldi3.c
@@ -2,7 +2,7 @@
 
 #include "libgcc.h"
 
-long long __ashldi3(long long u, word_type b)
+long long notrace __ashldi3(long long u, word_type b)
 {
 	DWunion uu, w;
 	word_type bm;
--- a/arch/mips/lib/ashrdi3.c
+++ b/arch/mips/lib/ashrdi3.c
@@ -2,7 +2,7 @@
 
 #include "libgcc.h"
 
-long long __ashrdi3(long long u, word_type b)
+long long notrace __ashrdi3(long long u, word_type b)
 {
 	DWunion uu, w;
 	word_type bm;
--- a/arch/mips/lib/bswapdi.c
+++ b/arch/mips/lib/bswapdi.c
@@ -1,6 +1,6 @@
 #include <linux/module.h>
 
-unsigned long long __bswapdi2(unsigned long long u)
+unsigned long long notrace __bswapdi2(unsigned long long u)
 {
 	return (((u) & 0xff00000000000000ull) >> 56) |
 	       (((u) & 0x00ff000000000000ull) >> 40) |
--- a/arch/mips/lib/bswapsi.c
+++ b/arch/mips/lib/bswapsi.c
@@ -1,6 +1,6 @@
 #include <linux/module.h>
 
-unsigned int __bswapsi2(unsigned int u)
+unsigned int notrace __bswapsi2(unsigned int u)
 {
 	return (((u) & 0xff000000) >> 24) |
 	       (((u) & 0x00ff0000) >>  8) |
--- a/arch/mips/lib/cmpdi2.c
+++ b/arch/mips/lib/cmpdi2.c
@@ -2,7 +2,7 @@
 
 #include "libgcc.h"
 
-word_type __cmpdi2(long long a, long long b)
+word_type notrace __cmpdi2(long long a, long long b)
 {
 	const DWunion au = {
 		.ll = a
--- a/arch/mips/lib/lshrdi3.c
+++ b/arch/mips/lib/lshrdi3.c
@@ -2,7 +2,7 @@
 
 #include "libgcc.h"
 
-long long __lshrdi3(long long u, word_type b)
+long long notrace __lshrdi3(long long u, word_type b)
 {
 	DWunion uu, w;
 	word_type bm;
--- a/arch/mips/lib/ucmpdi2.c
+++ b/arch/mips/lib/ucmpdi2.c
@@ -2,7 +2,7 @@
 
 #include "libgcc.h"
 
-word_type __ucmpdi2(unsigned long long a, unsigned long long b)
+word_type notrace __ucmpdi2(unsigned long long a, unsigned long long b)
 {
 	const DWunion au = {.ll = a};
 	const DWunion bu = {.ll = b};
