Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 04:12:20 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:44214 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491069Ab0CKDMA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Mar 2010 04:12:00 +0100
Received: by mail-bw0-f215.google.com with SMTP id 7so6743579bwz.24
        for <multiple recipients>; Wed, 10 Mar 2010 19:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Op90jrXvfNgeLyTOb7jEkgGfxp0RHsZl8xhaeMbPWoQ=;
        b=RcyuveuyVyT1psbDRkDsjq1g0IJM92exyFTKgyoN5n5xVUi16twFRhSkIwXYfpLxic
         F2ol9OzKeB9dM1xdezJL/y1RjeuqgKVrRaSJ1UiScqT19JJz5PovG+rE0YW4dJjgq0W+
         7ltz6rhQwZuSUPpQFS9sk+buM4DJ+7QrwZyMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JTBp13OaVmPQ4c+nGX8zZjqaJOkD2q3xHg41sYWWcGWKP7RFLOVQ1hNG/KsRN9QCJy
         zEv/2vJZdLPqph/1TtgqSfkMzVFpMRrtN4+n09xNrZvKtC4GiZWDyj5w/5u21CXQDlW+
         n8VmCg/E3+uzvIRMM+7YLeObgBpFHdMIodbsI=
Received: by 10.204.9.23 with SMTP id j23mr2862185bkj.132.1268277116826;
        Wed, 10 Mar 2010 19:11:56 -0800 (PST)
Received: from localhost.localdomain ([202.201.12.142])
        by mx.google.com with ESMTPS id g18sm30688020bkw.13.2010.03.10.19.11.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 19:11:55 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Sergei Shtylyov <sshtylyov@mvista.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v2 1/3] Loongson-2F: Flush the branch target history such as BTB and RAS
Date:   Thu, 11 Mar 2010 11:05:02 +0800
Message-Id: <23a3955f40b7466a3e850ae32098591b1a6a5ad4.1268276417.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <cover.1268276417.git.wuzhangjin@gmail.com>
References: <cover.1268276417.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1268276417.git.wuzhangjin@gmail.com>
References: <cover.1268276417.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

As the Chapter 15: "Errata: Issue of Out-of-order in loongson"[1] shows, to
workaround the Issue of Loongson-2F，We need to do:

"When switching from user model to kernel model, you should flush the branch
target history such as BTB and RAS."

This patch did clear BTB(branch target buffer), forbid RAS(row address strobe)
via Loongson-2F's 64bit diagnostic register.

[1] Chinese Version: http://www.loongson.cn/uploadfile/file/200808211
[2] English Version of Chapter 15:
http://groups.google.com.hk/group/loongson-dev/msg/e0d2e220958f10a6?dmode=source

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/stackframe.h |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index 3b6da33..52a62f5 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -121,6 +121,25 @@
 		.endm
 #else
 		.macro	get_saved_sp	/* Uniprocessor variation */
+#ifdef CONFIG_CPU_LOONGSON2F
+		/*
+		 * Clear BTB (branch target buffer), forbid RAS (row address
+		 * strobe) to workaround the Out-of-order Issue in Loongson2F
+		 * via its diagnostic register.
+		 */
+		move	k0, ra
+		jal	1f
+		 nop
+1:		jal	1f
+		 nop
+1:		jal	1f
+		 nop
+1:		jal	1f
+		 nop
+1:		move	ra, k0
+		li	k0, 3
+		mtc0	k0, $22
+#endif /* CONFIG_CPU_LOONGSON2F */
 #if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
 		lui	k1, %hi(kernelsp)
 #else
-- 
1.7.0.1
