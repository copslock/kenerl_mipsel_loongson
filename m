Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 19:59:37 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35749 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027480AbbEKRzvCIuOY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:51 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4502CBC3;
        Mon, 11 May 2015 17:55:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Mans Rullgard <mans@mansr.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 28/72] MIPS: asm: elf: Set O32 default FPU flags
Date:   Mon, 11 May 2015 10:54:34 -0700
Message-Id: <20150511175437.952729401@linuxfoundation.org>
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
X-archive-position: 47324
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

Commit 48f8eaee3f59848809644507fc47363b37e54450 upstream.

Set good default FPU flags (FR0) for O32 binaries similar to what the
kernel does for the N64/N32 ones. This also fixes a regression
introduced in commit 46490b572544 ("MIPS: kernel: elf: Improve the
overall ABI and FPU mode checks") when MIPS_O32_FP64_SUPPORT is
disabled. In that case, the mips_set_personality_fp() did not set the
FPU mode at all because it assumed that the FPU mode was already set
properly. That led to O32 userland problems.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Reported-by: Mans Rullgard <mans@mansr.com>
Fixes: 46490b572544 ("MIPS: kernel: elf: Improve the overall ABI and FPU mode checks")
Tested-by: Mans Rullgard <mans@mansr.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Matthew Fortune <Matthew.Fortune@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: http://patchwork.linux-mips.org/patch/9344/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/elf.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -294,6 +294,9 @@ do {									\
 	if (personality(current->personality) != PER_LINUX)		\
 		set_personality(PER_LINUX);				\
 									\
+	clear_thread_flag(TIF_HYBRID_FPREGS);				\
+	set_thread_flag(TIF_32BIT_FPREGS);				\
+									\
 	mips_set_personality_fp(state);					\
 									\
 	current->thread.abi = &mips_abi;				\
@@ -319,6 +322,8 @@ do {									\
 	do {								\
 		set_thread_flag(TIF_32BIT_REGS);			\
 		set_thread_flag(TIF_32BIT_ADDR);			\
+		clear_thread_flag(TIF_HYBRID_FPREGS);			\
+		set_thread_flag(TIF_32BIT_FPREGS);			\
 									\
 		mips_set_personality_fp(state);				\
 									\
