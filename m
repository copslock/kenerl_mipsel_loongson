Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Oct 2016 23:47:55 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:19860 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990509AbcJHVrryTZj4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Oct 2016 23:47:47 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id 78C5CBD33A2DE;
        Sat,  8 Oct 2016 22:47:37 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 8 Oct 2016
 22:47:41 +0100
Received: from localhost (10.100.200.86) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sat, 8 Oct
 2016 22:47:40 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] MIPS: Enable hardened usercopy
Date:   Sat, 8 Oct 2016 22:47:14 +0100
Message-ID: <20161008214714.5375-1-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.10.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.86]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55375
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

Enable CONFIG_HARDENED_USERCOPY checks for MIPS, calling check_object
size in all of copy_{to,from}_user(), __copy_{to,from}_user() &
__copy_{to,from}_user_inatomic().

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Kees Cook <keescook@chromium.org>
---

 arch/mips/Kconfig               |  1 +
 arch/mips/include/asm/uaccess.h | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1a322c8..87d7a1f3 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -65,6 +65,7 @@ config MIPS
 	select HANDLE_DOMAIN_IRQ
 	select HAVE_EXIT_THREAD
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_ARCH_HARDENED_USERCOPY
 
 menu "Machine selection"
 
diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 21a2aab..c65707d 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -858,7 +858,10 @@ extern size_t __copy_user(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
+									\
+	check_object_size(__cu_from, __cu_len, true);			\
 	might_fault();							\
+									\
 	if (eva_kernel_access())					\
 		__cu_len = __invoke_copy_to_kernel(__cu_to, __cu_from,	\
 						   __cu_len);		\
@@ -879,6 +882,9 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
+									\
+	check_object_size(__cu_from, __cu_len, true);			\
+									\
 	if (eva_kernel_access())					\
 		__cu_len = __invoke_copy_to_kernel(__cu_to, __cu_from,	\
 						   __cu_len);		\
@@ -897,6 +903,9 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
+									\
+	check_object_size(__cu_to, __cu_len, false);			\
+									\
 	if (eva_kernel_access())					\
 		__cu_len = __invoke_copy_from_kernel_inatomic(__cu_to,	\
 							      __cu_from,\
@@ -931,6 +940,9 @@ extern size_t __copy_user_inatomic(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
+									\
+	check_object_size(__cu_from, __cu_len, true);			\
+									\
 	if (eva_kernel_access()) {					\
 		__cu_len = __invoke_copy_to_kernel(__cu_to,		\
 						   __cu_from,		\
@@ -1123,6 +1135,9 @@ extern size_t __copy_in_user_eva(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
+									\
+	check_object_size(__cu_to, __cu_len, false);			\
+									\
 	if (eva_kernel_access()) {					\
 		__cu_len = __invoke_copy_from_kernel(__cu_to,		\
 						     __cu_from,		\
@@ -1161,6 +1176,9 @@ extern size_t __copy_in_user_eva(void *__to, const void *__from, size_t __n);
 	__cu_to = (to);							\
 	__cu_from = (from);						\
 	__cu_len = (n);							\
+									\
+	check_object_size(__cu_to, __cu_len, false);			\
+									\
 	if (eva_kernel_access()) {					\
 		__cu_len = __invoke_copy_from_kernel(__cu_to,		\
 						     __cu_from,		\
-- 
2.10.0
