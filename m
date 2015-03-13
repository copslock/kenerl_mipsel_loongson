Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Mar 2015 18:37:33 +0100 (CET)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:46547 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013710AbbCMRfxSGDei (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Mar 2015 18:35:53 +0100
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id A54FB46062E
        for <linux-mips@linux-mips.org>; Fri, 13 Mar 2015 17:35:48 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4PR4LlOnUEQk; Fri, 13 Mar 2015 17:35:43 +0000 (GMT)
Received: from pm-laptop.codethink.co.uk (pm-laptop.dyn.ducie.codethink.co.uk [10.24.1.94])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id EE329460B46;
        Fri, 13 Mar 2015 17:35:39 +0000 (GMT)
Received: from pm by pm-laptop.codethink.co.uk with local (Exim 4.84)
        (envelope-from <paul.martin@codethink.co.uk>)
        id 1YWTUp-0000Qz-Ob; Fri, 13 Mar 2015 17:35:39 +0000
From:   Paul Martin <paul.martin@codethink.co.uk>
To:     linux-mips@linux-mips.org
Cc:     Paul Martin <paul.martin@codethink.co.uk>
Subject: [PATCH 5/6] MIPS: OCTEON: Reverse the order of register accesses to the FAU
Date:   Fri, 13 Mar 2015 17:34:57 +0000
Message-Id: <1426268098-1603-6-git-send-email-paul.martin@codethink.co.uk>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk>
References: <1426268098-1603-1-git-send-email-paul.martin@codethink.co.uk>
Return-Path: <paul.martin@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.martin@codethink.co.uk
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

64 bit access is unaffected but for 32 bit access, swap high and
low words.  Similarly for 16 bit access, reverse the order of the
four possible words, and for 8 bit access reverse the order of byte
accesses.
---
 arch/mips/include/asm/octeon/cvmx-fau.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/mips/include/asm/octeon/cvmx-fau.h b/arch/mips/include/asm/octeon/cvmx-fau.h
index ef98f7f..dafeae3 100644
--- a/arch/mips/include/asm/octeon/cvmx-fau.h
+++ b/arch/mips/include/asm/octeon/cvmx-fau.h
@@ -105,6 +105,16 @@ typedef union {
 	} s;
 } cvmx_fau_async_tagwait_result_t;
 
+#ifdef __BIG_ENDIAN_BITFIELD
+#define SWIZZLE_8  0
+#define SWIZZLE_16 0
+#define SWIZZLE_32 0
+#else
+#define SWIZZLE_8  0x7
+#define SWIZZLE_16 0x6
+#define SWIZZLE_32 0x4
+#endif
+
 /**
  * Builds a store I/O address for writing to the FAU
  *
@@ -175,6 +185,7 @@ static inline int64_t cvmx_fau_fetch_and_add64(cvmx_fau_reg_64_t reg,
 static inline int32_t cvmx_fau_fetch_and_add32(cvmx_fau_reg_32_t reg,
 					       int32_t value)
 {
+	reg ^= SWIZZLE_32;
 	return cvmx_read64_int32(__cvmx_fau_atomic_address(0, reg, value));
 }
 
@@ -189,6 +200,7 @@ static inline int32_t cvmx_fau_fetch_and_add32(cvmx_fau_reg_32_t reg,
 static inline int16_t cvmx_fau_fetch_and_add16(cvmx_fau_reg_16_t reg,
 					       int16_t value)
 {
+	reg ^= SWIZZLE_16;
 	return cvmx_read64_int16(__cvmx_fau_atomic_address(0, reg, value));
 }
 
@@ -201,6 +213,7 @@ static inline int16_t cvmx_fau_fetch_and_add16(cvmx_fau_reg_16_t reg,
  */
 static inline int8_t cvmx_fau_fetch_and_add8(cvmx_fau_reg_8_t reg, int8_t value)
 {
+	reg ^= SWIZZLE_8;
 	return cvmx_read64_int8(__cvmx_fau_atomic_address(0, reg, value));
 }
 
@@ -247,6 +260,7 @@ cvmx_fau_tagwait_fetch_and_add32(cvmx_fau_reg_32_t reg, int32_t value)
 		uint64_t i32;
 		cvmx_fau_tagwait32_t t;
 	} result;
+	reg ^= SWIZZLE_32;
 	result.i32 =
 	    cvmx_read64_int32(__cvmx_fau_atomic_address(1, reg, value));
 	return result.t;
@@ -270,6 +284,7 @@ cvmx_fau_tagwait_fetch_and_add16(cvmx_fau_reg_16_t reg, int16_t value)
 		uint64_t i16;
 		cvmx_fau_tagwait16_t t;
 	} result;
+	reg ^= SWIZZLE_16;
 	result.i16 =
 	    cvmx_read64_int16(__cvmx_fau_atomic_address(1, reg, value));
 	return result.t;
@@ -292,6 +307,7 @@ cvmx_fau_tagwait_fetch_and_add8(cvmx_fau_reg_8_t reg, int8_t value)
 		uint64_t i8;
 		cvmx_fau_tagwait8_t t;
 	} result;
+	reg ^= SWIZZLE_8;
 	result.i8 = cvmx_read64_int8(__cvmx_fau_atomic_address(1, reg, value));
 	return result.t;
 }
@@ -521,6 +537,7 @@ static inline void cvmx_fau_atomic_add64(cvmx_fau_reg_64_t reg, int64_t value)
  */
 static inline void cvmx_fau_atomic_add32(cvmx_fau_reg_32_t reg, int32_t value)
 {
+	reg ^= SWIZZLE_32;
 	cvmx_write64_int32(__cvmx_fau_store_address(0, reg), value);
 }
 
@@ -533,6 +550,7 @@ static inline void cvmx_fau_atomic_add32(cvmx_fau_reg_32_t reg, int32_t value)
  */
 static inline void cvmx_fau_atomic_add16(cvmx_fau_reg_16_t reg, int16_t value)
 {
+	reg ^= SWIZZLE_16;
 	cvmx_write64_int16(__cvmx_fau_store_address(0, reg), value);
 }
 
@@ -544,6 +562,7 @@ static inline void cvmx_fau_atomic_add16(cvmx_fau_reg_16_t reg, int16_t value)
  */
 static inline void cvmx_fau_atomic_add8(cvmx_fau_reg_8_t reg, int8_t value)
 {
+	reg ^= SWIZZLE_8;
 	cvmx_write64_int8(__cvmx_fau_store_address(0, reg), value);
 }
 
@@ -568,6 +587,7 @@ static inline void cvmx_fau_atomic_write64(cvmx_fau_reg_64_t reg, int64_t value)
  */
 static inline void cvmx_fau_atomic_write32(cvmx_fau_reg_32_t reg, int32_t value)
 {
+	reg ^= SWIZZLE_32;
 	cvmx_write64_int32(__cvmx_fau_store_address(1, reg), value);
 }
 
@@ -580,6 +600,7 @@ static inline void cvmx_fau_atomic_write32(cvmx_fau_reg_32_t reg, int32_t value)
  */
 static inline void cvmx_fau_atomic_write16(cvmx_fau_reg_16_t reg, int16_t value)
 {
+	reg ^= SWIZZLE_16;
 	cvmx_write64_int16(__cvmx_fau_store_address(1, reg), value);
 }
 
@@ -591,6 +612,7 @@ static inline void cvmx_fau_atomic_write16(cvmx_fau_reg_16_t reg, int16_t value)
  */
 static inline void cvmx_fau_atomic_write8(cvmx_fau_reg_8_t reg, int8_t value)
 {
+	reg ^= SWIZZLE_8;
 	cvmx_write64_int8(__cvmx_fau_store_address(1, reg), value);
 }
 
-- 
2.1.4
