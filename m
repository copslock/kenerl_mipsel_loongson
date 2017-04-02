Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Apr 2017 05:12:26 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49800 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991726AbdDBDKCMv1dH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Apr 2017 05:10:02 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuVtv-0003GP-RV; Sun, 02 Apr 2017 04:09:59 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1cuVtu-0004R1-Uo; Sun, 02 Apr 2017 04:09:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Paul Burton" <paul.burton@imgtec.com>,
        "James Hogan" <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "David Daney" <david.daney@cavium.com>
Date:   Sun, 02 Apr 2017 04:04:24 +0100
Message-ID: <lsq.1491102264.162199421@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 21/26] MIPS: mipsregs.h: Add write_32bit_cp1_register()
In-Reply-To: <lsq.1491102264.9835075@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.43-rc2 review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
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
