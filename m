Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2010 18:19:48 +0100 (CET)
Received: from mail-fx0-f227.google.com ([209.85.220.227]:63765 "EHLO
        mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492262Ab0CIRT2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Mar 2010 18:19:28 +0100
Received: by mail-fx0-f227.google.com with SMTP id 27so3020549fxm.28
        for <multiple recipients>; Tue, 09 Mar 2010 09:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Zhsk794ng9QQOuZI3ijPZPOhqctJa1+QjFi5slISCbo=;
        b=P+uFP4FrzoZFH8s75Td9RAqlWEPIOKgMmnt8OvUtPIjyo1LuH5x7V0E+Y4nydgr63c
         NCpdA6b8bNJC76SFvclfeHlvqa/5K4Zq0iYeQRpsAxCZN6xkuS7boiPieAR5Z/B0BSkf
         hU5/TP3+R4wjWipFPRfYCgLduzxyjDVPJnnOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uws2FXVvp60uh7KSEz2R5A8Q8PLpEBI38zyYfcrAYMP/nFb5otPiFBhN3XFPfwxUE5
         S+2fQ8gWZ1ePN9JBq2wJ8yU2HArwUqw+tg4ec5nFMPm8GuFBoL2s+3g6fxkOaJaxw+Yf
         K4NPDVIzS14AUh4r60Ln2VUK4W+hvSRHpnPUM=
Received: by 10.223.77.85 with SMTP id f21mr100743fak.40.1268155166516;
        Tue, 09 Mar 2010 09:19:26 -0800 (PST)
Received: from localhost.localdomain ([202.201.12.142])
        by mx.google.com with ESMTPS id 31sm11418183fkt.47.2010.03.09.09.19.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Mar 2010 09:19:25 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, Greg KH <gregkh@suse.de>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 1/3] Loongson-2F: Flush the branch target history such as BTB and RAS
Date:   Wed, 10 Mar 2010 01:12:31 +0800
Message-Id: <d513f16856e499e82f0b4e428c97fe06afb5a426.1268153722.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <cover.1268153722.git.wuzhangjin@gmail.com>
References: <cover.1268153722.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1268153722.git.wuzhangjin@gmail.com>
References: <cover.1268153722.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26159
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
index 3b6da33..b84cfda 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -121,6 +121,25 @@
 		.endm
 #else
 		.macro	get_saved_sp	/* Uniprocessor variation */
+#ifdef CONFIG_CPU_LOONGSON2F
+		/*
+		 * Clear BTB(branch target buffer), forbid RAS(row address
+		 * strobe) to workaround the Out-of-oder Issue in Loongson2F
+		 * via it's diagnostic register.
+		 */
+		move k0, ra
+		jal	1f
+		nop
+1:		jal	1f
+		nop
+1:		jal	1f
+		nop
+1:		jal	1f
+		nop
+1:		move	ra, k0
+		li	k0, 3
+		mtc0	k0, $22
+#endif /* CONFIG_CPU_LOONGSON2F */
 #if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
 		lui	k1, %hi(kernelsp)
 #else
-- 
1.7.0.1
