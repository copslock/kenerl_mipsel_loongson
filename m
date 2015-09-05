Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Sep 2015 18:47:14 +0200 (CEST)
Received: from hall.aurel32.net ([195.154.112.97]:44899 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007701AbbIEQrMzx1sO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 5 Sep 2015 18:47:12 +0200
Received: from [37.162.190.121] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84)
        (envelope-from <aurelien@aurel32.net>)
        id 1ZYGcR-0007Ot-J9; Sat, 05 Sep 2015 18:47:11 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.84)
        (envelope-from <aurelien@aurel32.net>)
        id 1ZYGcJ-0001TD-BI; Sat, 05 Sep 2015 18:47:03 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-mips@linux-mips.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 1/2 for-4.3] MIPS: BPF: Avoid unreachable code on little endian
Date:   Sat,  5 Sep 2015 18:46:56 +0200
Message-Id: <1441471618-5613-1-git-send-email-aurelien@aurel32.net>
X-Mailer: git-send-email 2.1.4
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49111
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

On little endian, avoid generating the big endian version of the code
by using #else in addition to #ifdef #endif. Also fix one alignment
issue wrt delay slot.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: stable@vger.kernel.org # v4.2+
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/mips/net/bpf_jit_asm.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/net/bpf_jit_asm.S b/arch/mips/net/bpf_jit_asm.S
index e927260..4f54cb1 100644
--- a/arch/mips/net/bpf_jit_asm.S
+++ b/arch/mips/net/bpf_jit_asm.S
@@ -151,9 +151,10 @@ NESTED(bpf_slow_path_word, (6 * SZREG), $r_sp)
 	wsbh	t0, $r_s0
 	jr	$r_ra
 	 rotr	$r_A, t0, 16
-#endif
+#else
 	jr	$r_ra
-	move	$r_A, $r_s0
+	 move	$r_A, $r_s0
+#endif
 
 	END(bpf_slow_path_word)
 
@@ -162,9 +163,10 @@ NESTED(bpf_slow_path_half, (6 * SZREG), $r_sp)
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 	jr	$r_ra
 	 wsbh	$r_A, $r_s0
-#endif
+#else
 	jr	$r_ra
 	 move	$r_A, $r_s0
+#endif
 
 	END(bpf_slow_path_half)
 
-- 
2.1.4
