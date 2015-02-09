Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Feb 2015 09:38:35 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:51458 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012976AbbBIIgw1s-Si (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Feb 2015 09:36:52 +0100
Received: from localhost (unknown [113.28.134.59])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BE3E9A6E;
        Mon,  9 Feb 2015 08:36:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3.18 14/39] MIPS: mipsregs.h: Add write_32bit_cp1_register()
Date:   Mon,  9 Feb 2015 16:33:57 +0800
Message-Id: <20150209083329.439292777@linuxfoundation.org>
X-Mailer: git-send-email 2.3.0
In-Reply-To: <20150209083328.753647350@linuxfoundation.org>
References: <20150209083328.753647350@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45776
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

commit 5e32033e14ca9c7f7341cb383f5a05699b0b5382 upstream.

Add a write_32bit_cp1_register() macro to compliment the
read_32bit_cp1_register() macro. This is to abstract whether .set
hardfloat needs to be used based on GAS_HAS_SET_HARDFLOAT.

The implementation of _read_32bit_cp1_register() .sets mips1 due to
failure of gas v2.19 to assemble cfc1 for Octeon (see commit
25c300030016 ("MIPS: Override assembler target architecture for
octeon.")). I haven't copied this over to _write_32bit_cp1_register() as
I'm uncertain whether it applies to ctc1 too, or whether anybody cares
about that version of binutils any longer.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9172/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/mipsregs.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1343,12 +1343,27 @@ do {									\
 	__res;								\
 })
 
+#define _write_32bit_cp1_register(dest, val, gas_hardfloat)		\
+do {									\
+	__asm__ __volatile__(						\
+	"	.set	push					\n"	\
+	"	.set	reorder					\n"	\
+	"	"STR(gas_hardfloat)"				\n"	\
+	"	ctc1	%0,"STR(dest)"				\n"	\
+	"	.set	pop					\n"	\
+	: : "r" (val));							\
+} while (0)
+
 #ifdef GAS_HAS_SET_HARDFLOAT
 #define read_32bit_cp1_register(source)					\
 	_read_32bit_cp1_register(source, .set hardfloat)
+#define write_32bit_cp1_register(dest, val)				\
+	_write_32bit_cp1_register(dest, val, .set hardfloat)
 #else
 #define read_32bit_cp1_register(source)					\
 	_read_32bit_cp1_register(source, )
+#define write_32bit_cp1_register(dest, val)				\
+	_write_32bit_cp1_register(dest, val, )
 #endif
 
 #ifdef HAVE_AS_DSP
