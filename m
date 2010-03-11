Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 04:12:43 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:44214 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491121Ab0CKDMH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Mar 2010 04:12:07 +0100
Received: by mail-bw0-f215.google.com with SMTP id 7so6743579bwz.24
        for <multiple recipients>; Wed, 10 Mar 2010 19:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=P2v0PzTZ8PcrOj5xc9fJWbeIzqwSM6dukdMjQ4UhZUY=;
        b=fizzoJF/ThTAq74JA5pU6dhM++z1FkFYOlPmGoKrQHvqg2SoJiNC9guPwdZcmXVLR4
         MbpMq6Fnl0EHqDa/t09p7hWWr9i0bh/JpU6egyg8COde5MPR9EFIUXKFPIgDigfSH+ER
         CULPHudKvklyGOwOK8FOrx2OC3w2HpHGvq7T4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pw9k8nKii1N9Co8/B9o+EBqEuD8u+qONQkYOPKzW4M4uJGMSVSZM2whISthGnxDUe7
         0emnu7wtJy9ZzF0SenQONppjwnkni3T2OH9aQ4NyB1MLr+uIJ/ZKB4aHPD47430Kf7io
         IS5zGuNknVjXiwwJskgJpR8AepJUIL36nkzF8=
Received: by 10.204.129.218 with SMTP id p26mr2801141bks.145.1268277124937;
        Wed, 10 Mar 2010 19:12:04 -0800 (PST)
Received: from localhost.localdomain ([202.201.12.142])
        by mx.google.com with ESMTPS id g18sm30688020bkw.13.2010.03.10.19.11.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 19:12:03 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Sergei Shtylyov <sshtylyov@mvista.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Zhang Le <r0bertz@gentoo.org>, Wu Zhangjin <wuzj@lemote.com>
Subject: [PATCH v2 2/3] Loongson-2F: Enable fixups of binutils 2.20.1
Date:   Thu, 11 Mar 2010 11:05:03 +0800
Message-Id: <d91664d39983b5a058e0918a266df2e0e34d1eba.1268276417.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <cover.1268276417.git.wuzhangjin@gmail.com>
References: <cover.1268276417.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1268276417.git.wuzhangjin@gmail.com>
References: <cover.1268276417.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

As the "Fixups of Loongson2F" patch[1] to binutils have been applied
into binutils 2.20.1. It's time to enable the options provided by the
patch to compile the kernel.

Without these fixups, the system will hang unexpectedly for the bug of
processor.

To learn more about these fixups, please refer to the following
references.

[1] "Fixups of Loongson2F" patch for binutils(actually for gas)
http://sourceware.org/ml/binutils/2009-11/msg00387.html
[2] Chapter 15 of "Loongson2F User Manual"(Chinese Version)
http://www.loongson.cn/uploadfile/file/200808211
[3] English Version of the above chapter 15
http://groups.google.com.hk/group/loongson-dev/msg/e0d2e220958f10a6?dmode=source

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 arch/mips/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 2f2eac2..5ae342e 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -135,7 +135,9 @@ cflags-$(CONFIG_CPU_LOONGSON2)	+= -Wa,--trap
 cflags-$(CONFIG_CPU_LOONGSON2E) += \
 	$(call cc-option,-march=loongson2e,-march=r4600)
 cflags-$(CONFIG_CPU_LOONGSON2F) += \
-	$(call cc-option,-march=loongson2f,-march=r4600)
+	$(call cc-option,-march=loongson2f,-march=r4600) \
+	$(call as-option,-Wa$(comma)-mfix-loongson2f-nop,) \
+	$(call as-option,-Wa$(comma)-mfix-loongson2f-jump,)
 
 cflags-$(CONFIG_CPU_MIPS32_R1)	+= $(call cc-option,-march=mips32,-mips32 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
 			-Wa,-mips32 -Wa,--trap
-- 
1.7.0.1
