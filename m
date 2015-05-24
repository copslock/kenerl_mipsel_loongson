Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 May 2015 17:32:35 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57160 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006902AbbEXPcMhtwRw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 24 May 2015 17:32:12 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B5AA5BA3E2392;
        Sun, 24 May 2015 16:32:05 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Sun, 24 May 2015 16:32:08 +0100
Received: from localhost (192.168.159.140) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Sun, 24 May
 2015 16:32:07 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MIPS: optimise non-EVA kernel user memory accesses
Date:   Sun, 24 May 2015 16:31:44 +0100
Message-ID: <1432481504-24698-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.4.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.140]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47638
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

Commits ac1d8590d3ae (MIPS: asm: uaccess: Use EVA instructions
wrappers), 05c6516005c4 (MIPS: asm: uaccess: Add EVA support to
copy_{in, to,from}_user) & e3a9b07a9caf (MIPS: asm: uaccess: Add EVA
support for str*_user operations) added checks to various user memory
access functions & macros in order to determine whether to perform
standard memory accesses or their EVA userspace equivalents. In kernels
built without support for EVA these checks are entirely redundant. Avoid
emitting them & allow the compiler to optimise out the EVA userspace
code in such kernels by checking config_enabled(CONFIG_EVA).

This reduces the size of a malta_defconfig kernel built using GCC 4.9.2
by approximately 33KB (from 5995072 to 5962304 bytes).

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---

 arch/mips/include/asm/uaccess.h | 47 +++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index bf8b324..6ed061d 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -78,6 +78,21 @@ extern u64 __ua_limit;
 
 #define segment_eq(a, b)	((a).seg == (b).seg)
 
+/*
+ * eva_kernel_access() - determine whether kernel memory access on an EVA system
+ *
+ * Determines whether memory accesses should be performed to kernel memory
+ * on a system using Extended Virtual Addressing (EVA).
+ *
+ * Return: true if a kernel memory access on an EVA system, else false.
+ */
+static inline bool eva_kernel_access(void)
+{
+	if (!config_enabled(CONFIG_EVA))
+		return false;
+
+	return segment_eq(get_fs(), get_ds());
+}
 
 /*
  * Is a address valid? This does a straighforward calculation rather
@@ -281,7 +296,7 @@ do {									\
 ({									\
 	int __gu_err;							\
 									\
-	if (segment_eq(get_fs(), get_ds())) {				\
+	if (eva_kernel_access()) {					\
 		__get_kernel_common((x), size, ptr);			\
 	} else {							\
 		__chk_user_ptr(ptr);					\
@@ -297,7 +312,7 @@ do {									\
 									\
 	might_fault();							\
 	if (likely(access_ok(VERIFY_READ,  __gu_ptr, size))) {		\
-		if (segment_eq(get_fs(), get_ds()))			\
+		if (eva_kernel_access())				\
 			__get_kernel_common((x), size, __gu_ptr);	\
 		else							\
 			__get_user_common((x), size, __gu_ptr);		\
@@ -422,7 +437,7 @@ do {									\
 	int __pu_err = 0;						\
 									\
 	__pu_val = (x);							\
-	if (segment_eq(get_fs(), get_ds())) {				\
+	if (eva_kernel_access()) {					\
 		__put_kernel_common(ptr, size);				\
 	} else {							\
 		__chk_user_ptr(ptr);					\
@@ -439,7 +454,7 @@ do {									\
 									\
 	might_fault();							\
 	if (likely(access_ok(VERIFY_WRITE,  __pu_addr, size))) {	\
-		if (segment_eq(get_fs(), get_ds()))			\
+		if (eva_kernel_access())				\
 			__put_kernel_common(__pu_addr, size);		\
 		else							\
 			__put_user_common(__pu_addr, size);		\
@@ -833,7 +848,7 @@ extern size_t __copy_user(void *__to, const void *__from, size_t __n);
 	__cu_from = (from);						\
 	__cu_len = (n);							\
 	might_fault();							\
-	if (segment_eq(get_fs(), get_ds()))				\
+	if (eva_kernel_access())					\
 		__cu_len = __invoke_copy_to_kernel(__cu_to, __cu_from,	\
 						   __cu_len);		\
 	else								\
@@ -853,7 +868,7 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
-	if (segment_eq(get_fs(), get_ds()))				\
+	if (eva_kernel_access())					\
 		__cu_len = __invoke_copy_to_kernel(__cu_to, __cu_from,	\
 						   __cu_len);		\
 	else								\
@@ -871,7 +886,7 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
-	if (segment_eq(get_fs(), get_ds()))				\
+	if (eva_kernel_access())					\
 		__cu_len = __invoke_copy_from_kernel_inatomic(__cu_to,	\
 							      __cu_from,\
 							      __cu_len);\
@@ -904,7 +919,7 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
-	if (segment_eq(get_fs(), get_ds())) {				\
+	if (eva_kernel_access()) {					\
 		__cu_len = __invoke_copy_to_kernel(__cu_to,		\
 						   __cu_from,		\
 						   __cu_len);		\
@@ -1126,7 +1141,7 @@ extern size_t __copy_in_user_eva(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
-	if (segment_eq(get_fs(), get_ds())) {				\
+	if (eva_kernel_access()) {					\
 		__cu_len = __invoke_copy_from_kernel(__cu_to,		\
 						     __cu_from,		\
 						     __cu_len);		\
@@ -1150,7 +1165,7 @@ extern size_t __copy_in_user_eva(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
-	if (segment_eq(get_fs(), get_ds())) {				\
+	if (eva_kernel_access()) {					\
 		__cu_len = ___invoke_copy_in_kernel(__cu_to, __cu_from,	\
 						    __cu_len);		\
 	} else {							\
@@ -1170,7 +1185,7 @@ extern size_t __copy_in_user_eva(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
-	if (segment_eq(get_fs(), get_ds())) {				\
+	if (eva_kernel_access()) {					\
 		__cu_len = ___invoke_copy_in_kernel(__cu_to,__cu_from,	\
 						    __cu_len);		\
 	} else {							\
@@ -1250,7 +1265,7 @@ __strncpy_from_user(char *__to, const char __user *__from, long __len)
 {
 	long res;
 
-	if (segment_eq(get_fs(), get_ds())) {
+	if (eva_kernel_access()) {
 		__asm__ __volatile__(
 			"move\t$4, %1\n\t"
 			"move\t$5, %2\n\t"
@@ -1299,7 +1314,7 @@ strncpy_from_user(char *__to, const char __user *__from, long __len)
 {
 	long res;
 
-	if (segment_eq(get_fs(), get_ds())) {
+	if (eva_kernel_access()) {
 		__asm__ __volatile__(
 			"move\t$4, %1\n\t"
 			"move\t$5, %2\n\t"
@@ -1343,7 +1358,7 @@ static inline long strlen_user(const char __user *s)
 {
 	long res;
 
-	if (segment_eq(get_fs(), get_ds())) {
+	if (eva_kernel_access()) {
 		__asm__ __volatile__(
 			"move\t$4, %1\n\t"
 			__MODULE_JAL(__strlen_kernel_asm)
@@ -1370,7 +1385,7 @@ static inline long __strnlen_user(const char __user *s, long n)
 {
 	long res;
 
-	if (segment_eq(get_fs(), get_ds())) {
+	if (eva_kernel_access()) {
 		__asm__ __volatile__(
 			"move\t$4, %1\n\t"
 			"move\t$5, %2\n\t"
@@ -1411,7 +1426,7 @@ static inline long strnlen_user(const char __user *s, long n)
 	long res;
 
 	might_fault();
-	if (segment_eq(get_fs(), get_ds())) {
+	if (eva_kernel_access()) {
 		__asm__ __volatile__(
 			"move\t$4, %1\n\t"
 			"move\t$5, %2\n\t"
-- 
2.4.1
