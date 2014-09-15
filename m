Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Sep 2014 21:37:19 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:38146 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008996AbaIOThPReWTn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Sep 2014 21:37:15 +0200
Received: from localhost (c-24-22-230-10.hsd1.wa.comcast.net [24.22.230.10])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 09212B14;
        Mon, 15 Sep 2014 19:37:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Smith <alex.smith@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.14 043/114] MIPS: O32/32-bit: Fix bug which can cause incorrect system call restarts
Date:   Mon, 15 Sep 2014 12:25:43 -0700
Message-Id: <20140915192642.791025744@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <20140915192641.428509513@linuxfoundation.org>
References: <20140915192641.428509513@linuxfoundation.org>
User-Agent: quilt/0.63-1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42587
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

3.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Smith <alex.smith@imgtec.com>

commit e90e6fddc57055c4c6b57f92787fea1c065d440b upstream.

On 32-bit/O32, pt_regs has a padding area at the beginning into which the
syscall arguments passed via the user stack are copied. 4 arguments
totalling 16 bytes are copied to offset 16 bytes into this area, however
the area is only 24 bytes long. This means the last 2 arguments overwrite
pt_regs->regs[{0,1}].

If a syscall function returns an error, handle_sys stores the original
syscall number in pt_regs->regs[0] for syscall restart. signal.c checks
whether regs[0] is non-zero, if it is it will check whether the syscall
return value is one of the ERESTART* codes to see if it must be
restarted.

Should a syscall be made that results in a non-zero value being copied
off the user stack into regs[0], and then returns a positive (non-error)
value that matches one of the ERESTART* error codes, this can be mistaken
for requiring a syscall restart.

While the possibility for this to occur has always existed, it is made
much more likely to occur by commit 46e12c07b3b9 ("MIPS: O32 / 32-bit:
Always copy 4 stack arguments."), since now every syscall will copy 4
arguments and overwrite regs[0], rather than just those with 7 or 8
arguments.

Since that commit, booting Debian under a 32-bit MIPS kernel almost
always results in a hang early in boot, due to a wait4 syscall returning
a PID that matches one of the ERESTART* codes, which then causes an
incorrect restart of the syscall.

The problem is fixed by increasing the size of the padding area so that
arguments copied off the stack will not overwrite pt_regs->regs[{0,1}].

Signed-off-by: Alex Smith <alex.smith@imgtec.com>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7454/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/ptrace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -23,7 +23,7 @@
 struct pt_regs {
 #ifdef CONFIG_32BIT
 	/* Pad bytes for argument save space on the stack. */
-	unsigned long pad0[6];
+	unsigned long pad0[8];
 #endif
 
 	/* Saved main processor registers. */
