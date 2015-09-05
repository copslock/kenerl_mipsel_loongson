Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Sep 2015 18:47:32 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:44902 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013565AbbIEQrNcd4tO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Sep 2015 18:47:13 +0200
Received: from [37.162.190.121] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <aurelien@aurel32.net>)
        id 1ZYGcS-0007Ou-OY; Sat, 05 Sep 2015 18:47:12 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.84)
        (envelope-from <aurelien@aurel32.net>)
        id 1ZYGcK-0001TI-Jm; Sat, 05 Sep 2015 18:47:04 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-mips@linux-mips.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 2/2 for-4.3] MIPS: BPF: Fix build on pre-R2 little endian CPUs
Date:   Sat,  5 Sep 2015 18:46:57 +0200
Message-Id: <1441471618-5613-2-git-send-email-aurelien@aurel32.net>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1441471618-5613-1-git-send-email-aurelien@aurel32.net>
References: <1441471618-5613-1-git-send-email-aurelien@aurel32.net>
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

The rotr, seh and wsbh instructions have been introduced with the R2
ISA. Thus the current BPF code fails to build on pre-R2 little endian
CPUs:

    CC      arch/mips/net/bpf_jit.o
    AS      arch/mips/net/bpf_jit_asm.o
  /home/aurel32/linux-4.2/arch/mips/net/bpf_jit_asm.S: Assembler messages:
  /home/aurel32/linux-4.2/arch/mips/net/bpf_jit_asm.S:67: Error: opcode not supported on this processor: mips32 (mips32) `wsbh $8,$19'
  /home/aurel32/linux-4.2/arch/mips/net/bpf_jit_asm.S:68: Error: opcode not supported on this processor: mips32 (mips32) `rotr $19,$8,16'
  /home/aurel32/linux-4.2/arch/mips/net/bpf_jit_asm.S:83: Error: opcode not supported on this processor: mips32 (mips32) `wsbh $8,$19'
  /home/aurel32/linux-4.2/arch/mips/net/bpf_jit_asm.S:84: Error: opcode not supported on this processor: mips32 (mips32) `seh $19,$8'
  /home/aurel32/linux-4.2/arch/mips/net/bpf_jit_asm.S:151: Error: opcode not supported on this processor: mips32 (mips32) `wsbh $8,$12'
  /home/aurel32/linux-4.2/arch/mips/net/bpf_jit_asm.S:153: Error: opcode not supported on this processor: mips32 (mips32) `rotr $19,$8,16'
  /home/aurel32/linux-4.2/arch/mips/net/bpf_jit_asm.S:164: Error: opcode not supported on this processor: mips32 (mips32) `wsbh $19,$12'
  /home/aurel32/linux-4.2/scripts/Makefile.build:294: recipe for target 'arch/mips/net/bpf_jit_asm.o' failed

Fix that by providing equivalent code for these CPUs.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: stable@vger.kernel.org # v4.2+
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/mips/net/bpf_jit_asm.S | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/mips/net/bpf_jit_asm.S b/arch/mips/net/bpf_jit_asm.S
index 4f54cb1..dabf417 100644
--- a/arch/mips/net/bpf_jit_asm.S
+++ b/arch/mips/net/bpf_jit_asm.S
@@ -64,8 +64,20 @@ sk_load_word_positive:
 	PTR_ADDU t1, $r_skb_data, offset
 	lw	$r_A, 0(t1)
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
+# if defined(__mips_isa_rev) && (__mips_isa_rev >= 2)
 	wsbh	t0, $r_A
 	rotr	$r_A, t0, 16
+# else
+	sll	t0, $r_A, 24
+	srl	t1, $r_A, 24
+	srl	t2, $r_A, 8
+	or	t0, t0, t1
+	andi	t2, t2, 0xff00
+	andi	t1, $r_A, 0xff00
+	or	t0, t0, t2
+	sll	t1, t1, 8
+	or	$r_A, t0, t1
+# endif
 #endif
 	jr	$r_ra
 	 move	$r_ret, zero
@@ -80,8 +92,16 @@ sk_load_half_positive:
 	PTR_ADDU t1, $r_skb_data, offset
 	lh	$r_A, 0(t1)
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
+# if defined(__mips_isa_rev) && (__mips_isa_rev >= 2)
 	wsbh	t0, $r_A
 	seh	$r_A, t0
+# else
+	sll	t0, $r_A, 24
+	andi	t1, $r_A, 0xff00
+	sra	t0, t0, 16
+	srl	t1, t1, 8
+	or	$r_A, t0, t1
+# endif
 #endif
 	jr	$r_ra
 	 move	$r_ret, zero
@@ -148,9 +168,22 @@ sk_load_byte_positive:
 NESTED(bpf_slow_path_word, (6 * SZREG), $r_sp)
 	bpf_slow_path_common(4)
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
+# if defined(__mips_isa_rev) && (__mips_isa_rev >= 2)
 	wsbh	t0, $r_s0
 	jr	$r_ra
 	 rotr	$r_A, t0, 16
+# else
+	sll	t0, $r_s0, 24
+	srl	t1, $r_s0, 24
+	srl	t2, $r_s0, 8
+	or	t0, t0, t1
+	andi	t2, t2, 0xff00
+	andi	t1, $r_s0, 0xff00
+	or	t0, t0, t2
+	sll	t1, t1, 8
+	jr	$r_ra
+	 or	$r_A, t0, t1
+# endif
 #else
 	jr	$r_ra
 	 move	$r_A, $r_s0
@@ -161,8 +194,17 @@ NESTED(bpf_slow_path_word, (6 * SZREG), $r_sp)
 NESTED(bpf_slow_path_half, (6 * SZREG), $r_sp)
 	bpf_slow_path_common(2)
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
+# if defined(__mips_isa_rev) && (__mips_isa_rev >= 2)
 	jr	$r_ra
 	 wsbh	$r_A, $r_s0
+# else
+	sll	t0, $r_s0, 8
+	andi	t1, $r_s0, 0xff00
+	andi	t0, t0, 0xff00
+	srl	t1, t1, 8
+	jr	$r_ra
+	 or	$r_A, t0, t1
+# endif
 #else
 	jr	$r_ra
 	 move	$r_A, $r_s0
-- 
2.1.4
