Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Feb 2015 09:38:51 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:51463 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012982AbbBIIgxnQp6x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Feb 2015 09:36:53 +0100
Received: from localhost (unknown [113.28.134.59])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 76A06AD2;
        Mon,  9 Feb 2015 08:36:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: [PATCH 3.18 15/39] MIPS: traps: Fix inline asm ctc1 missing .set hardfloat
Date:   Mon,  9 Feb 2015 16:33:58 +0800
Message-Id: <20150209083329.490624378@linuxfoundation.org>
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
X-archive-position: 45777
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

commit d76e9b9fc5de7e8fc4fd0e72a94e8c723929ffea upstream.

Commit 842dfc11ea9a ("MIPS: Fix build with binutils 2.24.51+") in v3.18
enabled -msoft-float and sprinkled ".set hardfloat" where necessary to
use FP instructions. However it missed enable_restore_fp_context() which
since v3.17 does a ctc1 with inline assembly, causing the following
assembler errors on Mentor's 2014.05 toolchain:

{standard input}: Assembler messages:
{standard input}:2913: Error: opcode not supported on this processor: mips32r2 (mips32r2) `ctc1 $2,$31'
scripts/Makefile.build:257: recipe for target 'arch/mips/kernel/traps.o' failed

Fix that to use the new write_32bit_cp1_register() macro so that ".set
hardfloat" is automatically added when -msoft-float is in use.

Fixes 842dfc11ea9a ("MIPS: Fix build with binutils 2.24.51+")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9173/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/traps.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1184,7 +1184,8 @@ static int enable_restore_fp_context(int
 
 		/* Restore the scalar FP control & status register */
 		if (!was_fpu_owner)
-			asm volatile("ctc1 %0, $31" : : "r"(current->thread.fpu.fcr31));
+			write_32bit_cp1_register(CP1_STATUS,
+						 current->thread.fpu.fcr31);
 	}
 
 out:
