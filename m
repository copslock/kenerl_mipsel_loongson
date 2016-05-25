From: Harvey Hunt <harvey.hunt@imgtec.com>
Date: Wed, 25 May 2016 11:06:35 +0100
Subject: MIPS: lib: Mark intrinsics notrace
Message-ID: <20160525100635.XM-8EPYbktLPqK6ATU6tFJSpa-jekp6W-bty-h7EUOM@z>

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
