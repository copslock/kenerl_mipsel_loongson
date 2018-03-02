Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2018 09:54:29 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:36944 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992916AbeCBIyV22LbB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Mar 2018 09:54:21 +0100
Received: from localhost (clnet-b04-243.ikbnet.co.at [83.175.124.243])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D1461110C;
        Fri,  2 Mar 2018 08:54:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, linux-mips@linux-mips.org,
        linux-crypto@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 12/34] lib/mpi: Fix umul_ppmm() for MIPS64r6
Date:   Fri,  2 Mar 2018 09:51:08 +0100
Message-Id: <20180302084436.750827407@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62766
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

From: James Hogan <jhogan@kernel.org>


[ Upstream commit bbc25bee37d2b32cf3a1fab9195b6da3a185614a ]

Current MIPS64r6 toolchains aren't able to generate efficient
DMULU/DMUHU based code for the C implementation of umul_ppmm(), which
performs an unsigned 64 x 64 bit multiply and returns the upper and
lower 64-bit halves of the 128-bit result. Instead it widens the 64-bit
inputs to 128-bits and emits a __multi3 intrinsic call to perform a 128
x 128 multiply. This is both inefficient, and it results in a link error
since we don't include __multi3 in MIPS linux.

For example commit 90a53e4432b1 ("cfg80211: implement regdb signature
checking") merged in v4.15-rc1 recently broke the 64r6_defconfig and
64r6el_defconfig builds by indirectly selecting MPILIB. The same build
errors can be reproduced on older kernels by enabling e.g. CRYPTO_RSA:

lib/mpi/generic_mpih-mul1.o: In function `mpihelp_mul_1':
lib/mpi/generic_mpih-mul1.c:50: undefined reference to `__multi3'
lib/mpi/generic_mpih-mul2.o: In function `mpihelp_addmul_1':
lib/mpi/generic_mpih-mul2.c:49: undefined reference to `__multi3'
lib/mpi/generic_mpih-mul3.o: In function `mpihelp_submul_1':
lib/mpi/generic_mpih-mul3.c:49: undefined reference to `__multi3'
lib/mpi/mpih-div.o In function `mpihelp_divrem':
lib/mpi/mpih-div.c:205: undefined reference to `__multi3'
lib/mpi/mpih-div.c:142: undefined reference to `__multi3'

Therefore add an efficient MIPS64r6 implementation of umul_ppmm() using
inline assembly and the DMULU/DMUHU instructions, to prevent __multi3
calls being emitted.

Fixes: 7fd08ca58ae6 ("MIPS: Add build support for the MIPS R6 ISA")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-mips@linux-mips.org
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/mpi/longlong.h |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/lib/mpi/longlong.h
+++ b/lib/mpi/longlong.h
@@ -671,7 +671,23 @@ do {						\
 	**************  MIPS/64  **************
 	***************************************/
 #if (defined(__mips) && __mips >= 3) && W_TYPE_SIZE == 64
-#if (__GNUC__ >= 5) || (__GNUC__ >= 4 && __GNUC_MINOR__ >= 4)
+#if defined(__mips_isa_rev) && __mips_isa_rev >= 6
+/*
+ * GCC ends up emitting a __multi3 intrinsic call for MIPS64r6 with the plain C
+ * code below, so we special case MIPS64r6 until the compiler can do better.
+ */
+#define umul_ppmm(w1, w0, u, v)						\
+do {									\
+	__asm__ ("dmulu %0,%1,%2"					\
+		 : "=d" ((UDItype)(w0))					\
+		 : "d" ((UDItype)(u)),					\
+		   "d" ((UDItype)(v)));					\
+	__asm__ ("dmuhu %0,%1,%2"					\
+		 : "=d" ((UDItype)(w1))					\
+		 : "d" ((UDItype)(u)),					\
+		   "d" ((UDItype)(v)));					\
+} while (0)
+#elif (__GNUC__ >= 5) || (__GNUC__ >= 4 && __GNUC_MINOR__ >= 4)
 #define umul_ppmm(w1, w0, u, v) \
 do {									\
 	typedef unsigned int __ll_UTItype __attribute__((mode(TI)));	\
