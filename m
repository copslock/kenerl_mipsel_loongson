Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 17:13:58 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:35434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990484AbdLKQNaz0xZu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Dec 2017 17:13:30 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8B122191B;
        Mon, 11 Dec 2017 16:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B122191B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     linux-mips@linux-mips.org
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W . Rozycki" <macro@mips.com>
Subject: [PATCH 1/2] MIPS: mipsregs.h: Add read const Cop0 macros
Date:   Mon, 11 Dec 2017 16:13:14 +0000
Message-Id: <ef35c68d24f8e93053e5271a58964cc5f598b6b3.1513004494.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.a0a46ee9377083562543020efa89accdc3760bbe.1513004494.git-series.jhogan@kernel.org>
References: <cover.a0a46ee9377083562543020efa89accdc3760bbe.1513004494.git-series.jhogan@kernel.org>
In-Reply-To: <cover.a0a46ee9377083562543020efa89accdc3760bbe.1513004494.git-series.jhogan@kernel.org>
References: <cover.a0a46ee9377083562543020efa89accdc3760bbe.1513004494.git-series.jhogan@kernel.org>
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

Some Cop0 registers are constant and have no side effects when read.
There is no need for the inline asm to read these to be marked
__volatile__, and doing so prevents them from being removed by the
compiler.

Add a few new accessor macros to handle these registers more efficiently
(especially for the sake of running in a guest where redundant access to
the register may trap to the hypervisor):
  __read_const_32bit_c0_register()
  __read_const_64bit_c0_register()
  __read_const_ulong_c0_register()

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@mips.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 37 ++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 6b1f1ad0542c..74c931104714 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1245,14 +1245,14 @@ do {								\
  * Macros to access the system control coprocessor
  */
 
-#define __read_32bit_c0_register(source, sel)				\
+#define ___read_32bit_c0_register(source, sel, vol)			\
 ({ unsigned int __res;							\
 	if (sel == 0)							\
-		__asm__ __volatile__(					\
+		__asm__ vol(						\
 			"mfc0\t%0, " #source "\n\t"			\
 			: "=r" (__res));				\
 	else								\
-		__asm__ __volatile__(					\
+		__asm__ vol(						\
 			".set\tmips32\n\t"				\
 			"mfc0\t%0, " #source ", " #sel "\n\t"		\
 			".set\tmips0\n\t"				\
@@ -1260,18 +1260,18 @@ do {								\
 	__res;								\
 })
 
-#define __read_64bit_c0_register(source, sel)				\
+#define ___read_64bit_c0_register(source, sel, vol)			\
 ({ unsigned long long __res;						\
 	if (sizeof(unsigned long) == 4)					\
-		__res = __read_64bit_c0_split(source, sel);		\
+		__res = __read_64bit_c0_split(source, sel, vol);	\
 	else if (sel == 0)						\
-		__asm__ __volatile__(					\
+		__asm__ vol(						\
 			".set\tmips3\n\t"				\
 			"dmfc0\t%0, " #source "\n\t"			\
 			".set\tmips0"					\
 			: "=r" (__res));				\
 	else								\
-		__asm__ __volatile__(					\
+		__asm__ vol(						\
 			".set\tmips64\n\t"				\
 			"dmfc0\t%0, " #source ", " #sel "\n\t"		\
 			".set\tmips0"					\
@@ -1279,6 +1279,18 @@ do {								\
 	__res;								\
 })
 
+#define __read_32bit_c0_register(source, sel)				\
+	___read_32bit_c0_register(source, sel, __volatile__)
+
+#define __read_const_32bit_c0_register(source, sel)			\
+	___read_32bit_c0_register(source, sel, )
+
+#define __read_64bit_c0_register(source, sel)				\
+	___read_64bit_c0_register(source, sel, __volatile__)
+
+#define __read_const_64bit_c0_register(source, sel)			\
+	___read_64bit_c0_register(source, sel, )
+
 #define __write_32bit_c0_register(register, sel, value)			\
 do {									\
 	if (sel == 0)							\
@@ -1316,6 +1328,11 @@ do {									\
 	(unsigned long) __read_32bit_c0_register(reg, sel) :		\
 	(unsigned long) __read_64bit_c0_register(reg, sel))
 
+#define __read_const_ulong_c0_register(reg, sel)			\
+	((sizeof(unsigned long) == 4) ?					\
+	(unsigned long) __read_const_32bit_c0_register(reg, sel) :	\
+	(unsigned long) __read_const_64bit_c0_register(reg, sel))
+
 #define __write_ulong_c0_register(reg, sel, val)			\
 do {									\
 	if (sizeof(unsigned long) == 4)					\
@@ -1346,14 +1363,14 @@ do {									\
  * These versions are only needed for systems with more than 38 bits of
  * physical address space running the 32-bit kernel.  That's none atm :-)
  */
-#define __read_64bit_c0_split(source, sel)				\
+#define __read_64bit_c0_split(source, sel, vol)				\
 ({									\
 	unsigned long long __val;					\
 	unsigned long __flags;						\
 									\
 	local_irq_save(__flags);					\
 	if (sel == 0)							\
-		__asm__ __volatile__(					\
+		__asm__ vol(						\
 			".set\tmips64\n\t"				\
 			"dmfc0\t%L0, " #source "\n\t"			\
 			"dsra\t%M0, %L0, 32\n\t"			\
@@ -1361,7 +1378,7 @@ do {									\
 			".set\tmips0"					\
 			: "=r" (__val));				\
 	else								\
-		__asm__ __volatile__(					\
+		__asm__ vol(						\
 			".set\tmips64\n\t"				\
 			"dmfc0\t%L0, " #source ", " #sel "\n\t"		\
 			"dsra\t%M0, %L0, 32\n\t"			\
-- 
git-series 0.9.1
