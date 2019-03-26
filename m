Return-Path: <SRS0=PETI=R5=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94631C43381
	for <linux-mips@archiver.kernel.org>; Tue, 26 Mar 2019 06:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6367F2070B
	for <linux-mips@archiver.kernel.org>; Tue, 26 Mar 2019 06:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582863;
	bh=Tihbc4Z6MF7F6RiRz4r4Qdr2HlBe995dTlbAHE1WZaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SGfXUE8ZFxr2EuPPgs/qN4cTelaWCz2+D+DQRFHfen9wWnvHOaJvIXWFD42i/2/SH
	 uRJF3NrxAQ0wBM1CIbnpn4sCr6rBmHDIkI3IRUZ6nOb/JNgm4idnfRIzrKUh/lbN2U
	 RWu2igCWrIh46Y4lK5usFQ+lCxVvxm+hFGwjA1G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbfCZGbl (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:31:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731088AbfCZGbi (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 26 Mar 2019 02:31:38 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C18E20866;
        Tue, 26 Mar 2019 06:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553581898;
        bh=Tihbc4Z6MF7F6RiRz4r4Qdr2HlBe995dTlbAHE1WZaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVrLt7KxKWb/sYD75FLqp/xzQ/YxzDvONk+ptMm9cT9zuHIVcbr4NNWf4mImBwzNq
         MwARlXw9oJePBer1vvmgLJlo+5wgtOrUvJU9lcwTgPjmZ4w8cT1qFg32FPfGJEZE9M
         /PuVcSW+og0XZrS0uWbvZcXyUpY8InllPd8clqJ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Archer Yan <ayan@wavecomp.com>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Subject: [PATCH 4.9 08/30] MIPS: Fix kernel crash for R6 in jump label branch function
Date:   Tue, 26 Mar 2019 15:29:47 +0900
Message-Id: <20190326042607.861704407@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
References: <20190326042607.558087893@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Archer Yan <ayan@wavecomp.com>

commit 47c25036b60f27b86ab44b66a8861bcf81cde39b upstream.

Insert Branch instruction instead of NOP to make sure assembler don't
patch code in forbidden slot. In jump label function, it might
be possible to patch Control Transfer Instructions(CTIs) into
forbidden slot, which will generate Reserved Instruction exception
in MIPS release 6.

Signed-off-by: Archer Yan <ayan@wavecomp.com>
Reviewed-by: Paul Burton <paul.burton@mips.com>
[paul.burton@mips.com:
  - Add MIPS prefix to subject.
  - Mark for stable from v4.0, which introduced r6 support, onwards.]
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: stable@vger.kernel.org # v4.0+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/jump_label.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/include/asm/jump_label.h
+++ b/arch/mips/include/asm/jump_label.h
@@ -21,15 +21,15 @@
 #endif
 
 #ifdef CONFIG_CPU_MICROMIPS
-#define NOP_INSN "nop32"
+#define B_INSN "b32"
 #else
-#define NOP_INSN "nop"
+#define B_INSN "b"
 #endif
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("1:\t" NOP_INSN "\n\t"
-		"nop\n\t"
+	asm_volatile_goto("1:\t" B_INSN " 2f\n\t"
+		"2:\tnop\n\t"
 		".pushsection __jump_table,  \"aw\"\n\t"
 		WORD_INSN " 1b, %l[l_yes], %0\n\t"
 		".popsection\n\t"


