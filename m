Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Mar 2010 05:46:22 +0100 (CET)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:44103 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491150Ab0CMEp7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Mar 2010 05:45:59 +0100
Received: by pvh11 with SMTP id 11so31060pvh.36
        for <multiple recipients>; Fri, 12 Mar 2010 20:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=P2v0PzTZ8PcrOj5xc9fJWbeIzqwSM6dukdMjQ4UhZUY=;
        b=bR/lVFy+U6gmgi5IHhWj5Onu6t8qGiXtdyNElfMez9OwXOmpR4m3/7s6ea9gu6lGR7
         RZ5ecqqp9Ythv++8edNYiJbsNPoMmp5OFfRZsmoG4aBcj3SwowNlCAs5NKW9Fe2ngon5
         fn55FpMcAOBZ22gCy0CRS3bEd6MJ3mcvRFnsw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IlCO7IcZOAgmuLAIv5WTYK3zgUPRNAYNz2L53m/z1t8OKjAraiLJ4oFZQ9GyiXxIGI
         IX0PjzNuiVCyHdFf3ChIwd+pVhRiBohZUzQldQZYsVZ7MN2n2gxjcVuFffDeJub3z4xc
         siKXO5lbxYx+YxjygX+8Q8wyZdpgheDiGjkak=
Received: by 10.142.119.26 with SMTP id r26mr961531wfc.320.1268455552048;
        Fri, 12 Mar 2010 20:45:52 -0800 (PST)
Received: from localhost.localdomain ([202.201.12.142])
        by mx.google.com with ESMTPS id 21sm2172318pzk.0.2010.03.12.20.45.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 20:45:51 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Shinya Kuribayashi <shinya.kuribayashi@necel.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Zhang Le <r0bertz@gentoo.org>, Wu Zhangjin <wuzj@lemote.com>
Subject: [PATCH v3 2/3] Loongson-2F: Enable fixups of binutils 2.20.1
Date:   Sat, 13 Mar 2010 12:34:16 +0800
Message-Id: <ecc51ee134ab84c95b6b02534544df3731bb9562.1268453720.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <cover.1268453720.git.wuzhangjin@gmail.com>
References: <cover.1268453720.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1268453720.git.wuzhangjin@gmail.com>
References: <cover.1268453720.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26226
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
