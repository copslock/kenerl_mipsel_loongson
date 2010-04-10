Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Apr 2010 14:12:20 +0200 (CEST)
Received: from mail-pz0-f186.google.com ([209.85.222.186]:60848 "EHLO
        mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492477Ab0DJML6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Apr 2010 14:11:58 +0200
Received: by mail-pz0-f186.google.com with SMTP id 16so2000855pzk.22
        for <multiple recipients>; Sat, 10 Apr 2010 05:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=39D3lx1KBDd3UluliAiQdprKo7n7w7ulj9Im38jDR2Q=;
        b=OgpifkOWRJuwCp82A3B0ggrnm4K8b73ORx+ks2zYP514vHROHLpT8zW9zxKCh91hti
         cyJsfDcg/EOVuTsxFTMmKeys4LKEiXAweFqxmlNwwxqgXL5I1PouINxVQgHj74TFalsv
         3SzulRE64IgWmHmo2uKQdo5z55d0qgoRTMOtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=XCeYbEHwuyFgduLaebz+2dQ4n3UGv5GR5U4WZdF6gBWv4NvNM8R3YBqCZaelraiW0c
         bzbVMNOPoLzUGzuu8R1WUmO2OQnHBl5rcK//MjTDfAIHqMAu4VZxronymt9ymSYYHqRT
         WwG3ON7Z4ViF/I5tHty57paJIKcm90xUnEzaE=
Received: by 10.141.105.16 with SMTP id h16mr1439470rvm.274.1270901517364;
        Sat, 10 Apr 2010 05:11:57 -0700 (PDT)
Received: from [192.168.2.212] ([202.201.14.140])
        by mx.google.com with ESMTPS id 23sm1925678pzk.6.2010.04.10.05.11.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Apr 2010 05:11:56 -0700 (PDT)
Subject: [PATCH v5 2/4] Loongson-2F: Enable fixups of the latest binutils
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>, Zhang Le <r0bertz@gentoo.org>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <cover.1270882402.git.wuzhangjin@gmail.com>
References: <cover.1270882402.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1270882402.git.wuzhangjin@gmail.com>
References: <cover.1270882402.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sat, 10 Apr 2010 20:05:01 +0800
Message-ID: <1270901101.14758.6.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Changes from old revision:
  o Clear the errror information as suggesttion from Zhang Le.

  o Incorporated with the feedbacks from Ralf and used the options
  introduced from "Loongson: Add CPU_LOONGSON2F_WORKAROUNDS".

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
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Makefile |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 2f2eac2..0b9c01a 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -136,6 +136,19 @@ cflags-$(CONFIG_CPU_LOONGSON2E) += \
 	$(call cc-option,-march=loongson2e,-march=r4600)
 cflags-$(CONFIG_CPU_LOONGSON2F) += \
 	$(call cc-option,-march=loongson2f,-march=r4600)
+# enable the workarounds for loongson2f
+ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
+  ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-nop,),)
+    $(error only binutils >= 2.20.2 have needed option -mfix-loongson2f-nop)
+  else
+    cflags-$(CONFIG_CPU_NOP_WORKAROUNDS) += -Wa$(comma)-mfix-loongson2f-nop
+  endif
+  ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-jump,),)
+    $(error only binutils >= 2.20.2 have needed option -mfix-loongson2f-jump)
+  else
+    cflags-$(CONFIG_CPU_JUMP_WORKAROUNDS) += -Wa$(comma)-mfix-loongson2f-jump
+  endif
+endif
 
 cflags-$(CONFIG_CPU_MIPS32_R1)	+= $(call cc-option,-march=mips32,-mips32 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
 			-Wa,-mips32 -Wa,--trap
-- 
1.7.0.1
