Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 19:57:51 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35749 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027471AbbEKRzu1ho0F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:50 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A4FBEBB9;
        Mon, 11 May 2015 17:55:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 18/72] MIPS: kernel: entry.S: Set correct ISA level for mips_ihb
Date:   Mon, 11 May 2015 10:54:24 -0700
Message-Id: <20150511175437.661917362@linuxfoundation.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <20150511175437.112151861@linuxfoundation.org>
References: <20150511175437.112151861@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47318
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Markos Chandras <markos.chandras@imgtec.com>

Commit aebac99384f7a6d83a3dcd42bf2481eed2670083 upstream.

Commit 6ebb496ffc7e("MIPS: kernel: entry.S: Add MIPS R6 related
definitions") added the MIPSR6 definition but it did not update the
ISA level of the actual assembly code so a pre-MIPSR6 jr.hb instruction
was generated instead. Fix this by using the MISP_ISA_LEVEL_RAW macro.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Fixes: 6ebb496ffc7e("MIPS: kernel: entry.S: Add MIPS R6 related definitions")
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9386/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/entry.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -10,6 +10,7 @@
 
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
+#include <asm/compiler.h>
 #include <asm/regdef.h>
 #include <asm/mipsregs.h>
 #include <asm/stackframe.h>
@@ -185,7 +186,7 @@ syscall_exit_work:
  * For C code use the inline version named instruction_hazard().
  */
 LEAF(mips_ihb)
-	.set	mips32r2
+	.set	MIPS_ISA_LEVEL_RAW
 	jr.hb	ra
 	nop
 	END(mips_ihb)
