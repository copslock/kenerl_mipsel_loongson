Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 16:40:59 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60135 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012309AbbA3PkmdADSb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 16:40:42 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 19CCDDC2D225C;
        Fri, 30 Jan 2015 15:40:34 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 30 Jan 2015 15:40:36 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 30 Jan 2015 15:40:34 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 1/2] MIPS: mipsregs.h: Add write_32bit_cp1_register()
Date:   Fri, 30 Jan 2015 15:40:19 +0000
Message-ID: <1422632420-4973-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
In-Reply-To: <1422632420-4973-1-git-send-email-james.hogan@imgtec.com>
References: <1422632420-4973-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45578
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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
---
 arch/mips/include/asm/mipsregs.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 5e4aef304b02..5b720d8c2745 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1386,12 +1386,27 @@ do {									\
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
-- 
2.0.5
