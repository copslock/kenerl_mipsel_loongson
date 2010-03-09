Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2010 18:20:13 +0100 (CET)
Received: from mail-fx0-f227.google.com ([209.85.220.227]:63765 "EHLO
        mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492263Ab0CIRTg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Mar 2010 18:19:36 +0100
Received: by mail-fx0-f227.google.com with SMTP id 27so3020549fxm.28
        for <multiple recipients>; Tue, 09 Mar 2010 09:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=P2v0PzTZ8PcrOj5xc9fJWbeIzqwSM6dukdMjQ4UhZUY=;
        b=RTZarxeffifNZA54oC1C7AsBCg/tZUEkRuS/Hk4uPXIagB5sibDYN3FNExCzbsRV0L
         dWYz4zTXYYvmg5MlfYjsC1gtNFqEUBFOoabWl5ZXeDk243GJsvxHk/72gxLPDuTqEPn4
         SR/61NZshyJLl98CW8BNXoMZTJ/cmsrcAyOT8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=O4b1L1zn0hEsqd9PqPfDUppr5b1vo/JqNCX6eKXzYwPipD8OO1BsrfhbNeGfs3L4w0
         +2K5W9NcTtUj290a5fXEcfnUj1qqYHDm+46sR6U6CfVyNfM5/4JOyN8FQ8QTCvduf3mE
         XWGRJNBA+Voi7c7BRxQlkjbBa7FmkK18D/o9E=
Received: by 10.223.5.71 with SMTP id 7mr90998fau.48.1268155175101;
        Tue, 09 Mar 2010 09:19:35 -0800 (PST)
Received: from localhost.localdomain ([202.201.12.142])
        by mx.google.com with ESMTPS id 31sm11418183fkt.47.2010.03.09.09.19.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Mar 2010 09:19:34 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, Greg KH <gregkh@suse.de>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Zhang Le <r0bertz@gentoo.org>, Wu Zhangjin <wuzj@lemote.com>
Subject: [PATCH 2/3] Loongson-2F: Enable fixups of binutils 2.20.1
Date:   Wed, 10 Mar 2010 01:12:32 +0800
Message-Id: <6ca9906a5469bc5cc4aafeac6f90ab3798a5a837.1268153722.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <cover.1268153722.git.wuzhangjin@gmail.com>
References: <cover.1268153722.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1268153722.git.wuzhangjin@gmail.com>
References: <cover.1268153722.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26160
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
