Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Oct 2015 05:02:01 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:39678 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006994AbbJRDB7Z9dJd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Oct 2015 05:01:59 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 687A4360;
        Sun, 18 Oct 2015 03:01:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aurelien Jarno <aurelien@aurel32.net>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.2 205/258] MIPS: BPF: Avoid unreachable code on little endian
Date:   Sat, 17 Oct 2015 18:58:38 -0700
Message-Id: <20151018014739.714471752@linuxfoundation.org>
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
X-archive-position: 49583
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

commit faa9724a674e5e52316bb0d173aed16bd17d536c upstream.

On little endian, avoid generating the big endian version of the code
by using #else in addition to #ifdef #endif. Also fix one alignment
issue wrt delay slot.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/11097/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/net/bpf_jit_asm.S |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/arch/mips/net/bpf_jit_asm.S
+++ b/arch/mips/net/bpf_jit_asm.S
@@ -151,9 +151,10 @@ NESTED(bpf_slow_path_word, (6 * SZREG),
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
 
@@ -162,9 +163,10 @@ NESTED(bpf_slow_path_half, (6 * SZREG),
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 	jr	$r_ra
 	 wsbh	$r_A, $r_s0
-#endif
+#else
 	jr	$r_ra
 	 move	$r_A, $r_s0
+#endif
 
 	END(bpf_slow_path_half)
 
