Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 May 2017 16:25:39 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:49490 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992143AbdEKOZb3p3Ls (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 May 2017 16:25:31 +0200
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F0D23B5A;
        Thu, 11 May 2017 14:25:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Nikola.Veljkovic@imgtec.com, paul.burton@imgtec.com,
        yamada.masahiro@socionext.com, akpm@linux-foundation.org,
        andrea.gelmini@gelma.net, macro@imgtec.com,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 43/60] MIPS: R2-on-R6 MULTU/MADDU/MSUBU emulation bugfix
Date:   Thu, 11 May 2017 16:13:06 +0200
Message-Id: <20170511141238.925449454@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170511141237.094835992@linuxfoundation.org>
References: <20170511141237.094835992@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57873
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

commit d65e5677ad5b3a49c43f60ec07644dc1f87bbd2e upstream.

MIPS instructions MULTU, MADDU and MSUBU emulation requires registers HI/LO
to be converted to signed 32bits before 64bit sign extension on MIPS64.

Bug was found on running MIPS32 R2 test application on MIPS64 R6 kernel.

Fixes: b0a668fb2038 ("MIPS: kernel: mips-r2-to-r6-emul: Add R2 emulator for MIPS R6")
Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Reported-by: Nikola.Veljkovic@imgtec.com
Cc: paul.burton@imgtec.com
Cc: yamada.masahiro@socionext.com
Cc: akpm@linux-foundation.org
Cc: andrea.gelmini@gelma.net
Cc: macro@imgtec.com
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14043/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/mips-r2-to-r6-emul.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -434,8 +434,8 @@ static int multu_func(struct pt_regs *re
 	rs = regs->regs[MIPSInst_RS(ir)];
 	res = (u64)rt * (u64)rs;
 	rt = res;
-	regs->lo = (s64)rt;
-	regs->hi = (s64)(res >> 32);
+	regs->lo = (s64)(s32)rt;
+	regs->hi = (s64)(s32)(res >> 32);
 
 	MIPS_R2_STATS(muls);
 
@@ -671,9 +671,9 @@ static int maddu_func(struct pt_regs *re
 	res += ((((s64)rt) << 32) | (u32)rs);
 
 	rt = res;
-	regs->lo = (s64)rt;
+	regs->lo = (s64)(s32)rt;
 	rs = res >> 32;
-	regs->hi = (s64)rs;
+	regs->hi = (s64)(s32)rs;
 
 	MIPS_R2_STATS(dsps);
 
@@ -729,9 +729,9 @@ static int msubu_func(struct pt_regs *re
 	res = ((((s64)rt) << 32) | (u32)rs) - res;
 
 	rt = res;
-	regs->lo = (s64)rt;
+	regs->lo = (s64)(s32)rt;
 	rs = res >> 32;
-	regs->hi = (s64)rs;
+	regs->hi = (s64)(s32)rs;
 
 	MIPS_R2_STATS(dsps);
 
