Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 16:09:27 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:51740 "EHLO
        mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493336Ab0AZPJE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 16:09:04 +0100
Received: by pzk35 with SMTP id 35so642640pzk.22
        for <multiple recipients>; Tue, 26 Jan 2010 07:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=s3WvVvD2P9LmvnLcPjtLcJ+92cIAdG0deW9M2Z6QYv4=;
        b=oakika8hAfsMZleOo9ZIZUs7CiJhtTUjZxDw6zPmysnQCagsDgtbaowzQuY4mcf9eg
         Fkwut/X38m1ML/lw1FgVXosFKxNG/qupbhOPX7ZXvfZ2pxT/sysU3F5xT3uyJvgbAY1n
         PSPNLgi+CAMA8tDYCpE8LLTE4CwiTk/Li3TUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aaseiyDOOMw0gLWknODm1NO4zT/Ity1MqilTgUk/VBKcYp/5xaPKAbqbq5FOViAG0L
         K8WXr+Hvavg/uUypJv0KrHaTPv1CXiqxrr70mOA9YdrF9haT7RnWYJNLYsxvFd+YEVqn
         e8uJggZtK6itDLKwDMxnawri484/HWPlUUb74=
Received: by 10.141.108.11 with SMTP id k11mr5212300rvm.120.1264518536134;
        Tue, 26 Jan 2010 07:08:56 -0800 (PST)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 22sm5859243pzk.2.2010.01.26.07.08.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 07:08:55 -0800 (PST)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -queue] MIPS: Simplify the weak annotation with __weak
Date:   Tue, 26 Jan 2010 23:02:34 +0800
Message-Id: <0dd2da661e29d1ba6ade77374c06a85011849b35.1264517876.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.6
In-Reply-To: <8c337354c30ac911207df81abd13197c897b2380.1264517495.git.wuzhangjin@gmail.com>
References: <8c337354c30ac911207df81abd13197c897b2380.1264517495.git.wuzhangjin@gmail.com>
X-archive-position: 25675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16747

From: Wu Zhangjin <wuzhangjin@gmail.com>

There was a __weak define as __attribute__((weak)) there, this patch
just use it to simplify the weak annotation.

I found them via the following command:

$ find arch/mips/ -name "*.c" | xargs -i grep -H weak {} | grep -v __weak

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/boot/compressed/dbg.c |    2 +-
 arch/mips/oprofile/common.c     |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/boot/compressed/dbg.c b/arch/mips/boot/compressed/dbg.c
index ff4dc7a..d5c5d9a 100644
--- a/arch/mips/boot/compressed/dbg.c
+++ b/arch/mips/boot/compressed/dbg.c
@@ -9,7 +9,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 
-void __attribute__ ((weak)) putc(char c)
+void __weak putc(char c)
 {
 }
 
diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index 7832ad2..ee46c82 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -14,9 +14,9 @@
 
 #include "op_impl.h"
 
-extern struct op_mips_model op_model_mipsxx_ops __attribute__((weak));
-extern struct op_mips_model op_model_rm9000_ops __attribute__((weak));
-extern struct op_mips_model op_model_loongson2_ops __attribute__((weak));
+extern struct op_mips_model op_model_mipsxx_ops __weak;
+extern struct op_mips_model op_model_rm9000_ops __weak;
+extern struct op_mips_model op_model_loongson2_ops __weak;
 
 static struct op_mips_model *model;
 
-- 
1.6.6
