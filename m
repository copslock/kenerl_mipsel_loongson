Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2010 15:20:22 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:62138 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492116Ab0DGNT6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Apr 2010 15:19:58 +0200
Received: by pvc30 with SMTP id 30so297049pvc.36
        for <multiple recipients>; Wed, 07 Apr 2010 06:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=ccLDHo8YL/CFeFz74yy3p7YGpPDZlJTgdHodFdiH4PE=;
        b=OmsIMh2AFStdJkng0GL0rKfZHP77SezpGNWzeDucKMPsLstx3iYIiQfdsvPNvCpBQD
         NzzjD+sgZ2zqkZi/6DdUY55CItAcoQYj40PRoNpt09VxxeZS61qMH1BWSUPfx/fqdp+C
         d/OqVvFqqgPd6H5UF7CcEImSHIIay7grdy0Io=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HFop5Uf1eH8bXIByy+dYnf27TTunFq5lj+VNwWOiZNIFUjakyYTelEzbzQX0eVgUwl
         jeW9a5R0GcFtkHTd8U8kx+McQ8dzeUVr+KWHUN8dOFs70EAgi7J3kRe5HiavHstE/+ZZ
         HeQmXnIJAZKGbZg/Deg7ZD8BeEVV+pwe3CvUk=
Received: by 10.115.66.26 with SMTP id t26mr8420776wak.210.1270646389464;
        Wed, 07 Apr 2010 06:19:49 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 20sm3753168pzk.15.2010.04.07.06.19.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 06:19:49 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>,
        Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH v4 2/4] Loongson-2F: Enable fixups of the latest binutils
Date:   Wed,  7 Apr 2010 21:11:52 +0800
Message-Id: <cf5a00449fa910daf1d1313d6b4d1df1e7a85a24.1270645413.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <cover.1270645413.git.wuzhangjin@gmail.com>
References: <cover.1270645413.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1270645413.git.wuzhangjin@gmail.com>
References: <cover.1270645413.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

Changes from old revision:

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
index 2f2eac2..14f12bc 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -136,6 +136,19 @@ cflags-$(CONFIG_CPU_LOONGSON2E) += \
 	$(call cc-option,-march=loongson2e,-march=r4600)
 cflags-$(CONFIG_CPU_LOONGSON2F) += \
 	$(call cc-option,-march=loongson2f,-march=r4600)
+# enable the workarounds for loongson2f
+ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
+  ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-nop,),)
+    $(error gcc does not support needed option -mfix-loongson2f-nop)
+  else
+    cflags-$(CONFIG_CPU_NOP_WORKAROUNDS) += -Wa$(comma)-mfix-loongson2f-nop
+  endif
+  ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-jump,),)
+    $(error gcc does not support needed option -mfix-loongson2f-jump)
+  else
+    cflags-$(CONFIG_CPU_JUMP_WORKAROUNDS) += -Wa$(comma)-mfix-loongson2f-jump
+  endif
+endif
 
 cflags-$(CONFIG_CPU_MIPS32_R1)	+= $(call cc-option,-march=mips32,-mips32 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS32) \
 			-Wa,-mips32 -Wa,--trap
-- 
1.7.0.1
