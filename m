Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Apr 2010 15:19:57 +0200 (CEST)
Received: from mail-pz0-f180.google.com ([209.85.222.180]:33542 "EHLO
        mail-pz0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491195Ab0DGNTx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Apr 2010 15:19:53 +0200
Received: by pzk10 with SMTP id 10so883406pzk.21
        for <multiple recipients>; Wed, 07 Apr 2010 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=BeZP6ErnTEdxAcr+23gDkE18bDfoDprD3+DXqpwkcNs=;
        b=F2XeFAhaK2lzQVBszCd7Boiv6W7/6CeaIHfSNwzvo305sG5yN5nuu7NqrF3ZFkB+Eh
         FB0cacDaAFeHSJqD9HTBNHNEWTvYe05HHoVTCIyjLury8R733qGWWVUczxIPuRe+fxzf
         QE+L5yreoXMQ8N6YavRbTKjy/5pojigWYTEhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UeFagZzk2vD3R96m+UXKL5qq3Ks06PN5V6hN9fluW+0yfWE8cgxjA1gAK1pIyPfl6d
         VgD3+K4qo9yffRheLS6FVD9fC/k5bwPwyW5pZvNMVGp9mdbJeUmCAXNeSUsreRzIxa7N
         O1LJ7nNVITIGjYhzeRMfKfO1dVfDnxqb5sSGw=
Received: by 10.141.124.16 with SMTP id b16mr7128585rvn.91.1270646385367;
        Wed, 07 Apr 2010 06:19:45 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id 20sm3753168pzk.15.2010.04.07.06.19.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Apr 2010 06:19:45 -0700 (PDT)
From:   Wu Zhangjin <wuzhangjin@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH v4 1/4] Loongson: Add CPU_LOONGSON2F_WORKAROUNDS
Date:   Wed,  7 Apr 2010 21:11:51 +0800
Message-Id: <f0277725680d16b6a2945a9aaedbacfc5dce353e.1270645413.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <cover.1270645413.git.wuzhangjin@gmail.com>
References: <cover.1270645413.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1270645413.git.wuzhangjin@gmail.com>
References: <cover.1270645413.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26356
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

As the Loongson2F User Manual[2,3] shows, the old Loongson2F series(2F01/02)
have the NOP & JUMP issues, need the related workarounds in the kernel and
binutils, but the new Loongson2F series(2F03 and laters) have no such issues,
so, none of the workarounds is needed.

Currently, the workaround[1] with the -mfix-loongson2f-nop,
-mfix-loongson2f-jump options have been added into the latest binutils(in the
cvs repository), it's time to add the workarounds in the kernel.

The workarounds have no big side effect on the system, but may decrease the
performance, therefore, this patch adds a new CPU_LOONGSON2F_WORKAROUNDS config
option to allow the users to only enable it for the necessary processor series.

[1] "Fixups of Loongson2F" patch for binutils(actually for gas)
http://sourceware.org/ml/binutils/2009-11/msg00387.html
[2] Chapter 15 of "Loongson2F User Manual"(Chinese Version)
http://www.loongson.cn/uploadfile/file/200808211
[3] English Version of the above chapter 15
http://groups.google.com.hk/group/loongson-dev/msg/e0d2e220958f10a6?dmode=source

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 29e8692..f2ead53 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1305,6 +1305,32 @@ config CPU_CAVIUM_OCTEON
 
 endchoice
 
+if CPU_LOONGSON2F
+config CPU_NOP_WORKAROUNDS
+	bool
+
+config CPU_JUMP_WORKAROUNDS
+	bool
+
+config CPU_LOONGSON2F_WORKAROUNDS
+	bool "Loongson 2F Workarounds"
+	default y
+	select CPU_NOP_WORKAROUNDS
+	select CPU_JUMP_WORKAROUNDS
+	help
+	  The Loongson 2F01/02 processor has the NOP & JUMP issues, needs the
+	  related workarounds, without workarounds, the system will hang
+	  unexpectedly. to get more information about them, please refer to the
+	  -mfix-loongson2f-nop and -mfix-loongson2f-jump options of gas.
+
+	  For Loongson 2F03 and the later batches have fixed the issues, none
+	  of these workarounds needed for them. These workarounds have no big
+	  side effect on them but may decrease the performance of the system,
+	  therefore, it's better to disable this config for them.
+
+	  If unsure, please say Y.
+endif # CPU_LOONGSON2F
+
 config SYS_SUPPORTS_ZBOOT
 	bool
 	select HAVE_KERNEL_GZIP
-- 
1.7.0.1
