Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Oct 2015 05:02:36 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:39681 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007135AbbJRDB7y73bd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Oct 2015 05:01:59 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C0778267;
        Sun, 18 Oct 2015 03:01:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aurelien Jarno <aurelien@aurel32.net>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.2 206/258] MIPS: BPF: Fix build on pre-R2 little endian CPUs
Date:   Sat, 17 Oct 2015 18:58:39 -0700
Message-Id: <20151018014739.758874666@linuxfoundation.org>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <20151018014729.976101177@linuxfoundation.org>
References: <20151018014729.976101177@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49585
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

4.2-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aurelien Jarno <aurelien@aurel32.net>

commit b259e51f2e29390518021f9b8df55a3de42f371b upstream.

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

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11098/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/net/bpf_jit_asm.S |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

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
@@ -161,8 +194,17 @@ NESTED(bpf_slow_path_word, (6 * SZREG),
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
