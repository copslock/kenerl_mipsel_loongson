Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Apr 2010 14:12:44 +0200 (CEST)
Received: from mail-pz0-f186.google.com ([209.85.222.186]:60848 "EHLO
        mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491997Ab0DJMMQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Apr 2010 14:12:16 +0200
Received: by mail-pz0-f186.google.com with SMTP id 16so2000855pzk.22
        for <multiple recipients>; Sat, 10 Apr 2010 05:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=BeZP6ErnTEdxAcr+23gDkE18bDfoDprD3+DXqpwkcNs=;
        b=L3Xbf1TUDQi8nUL6vu28ffNtiPu0vdGE/xS6Xu6THM3y6bedNjJSB/wOckq3Qvr+A2
         G6o1ia6xnOkxeFQSKAYBQnuVkqHrbd1LPJVHQok8hh1yC9vepcHrApsgkU9OGmrhmt7/
         1Ndl4EZejFFulJ5qmYBwGN7cSZ/7WKknU4vUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=IJFB6SZinccx3VDTunz715TnDowFGJGHADqLfRq2K7r2aEzn5KlIoZbIJ3FVwKKqCr
         +ajDCT1AdLYqL4lxn44PQnDjTcI9Jrs/2xNUvH0NISDOzQ+KAjapVvu5JesLUQCzhKZ0
         yDBsu+7+JykdMh1K2/U/G4t8DEMcghwVj9XmE=
Received: by 10.115.39.40 with SMTP id r40mr1474811waj.183.1270901535638;
        Sat, 10 Apr 2010 05:12:15 -0700 (PDT)
Received: from [192.168.2.212] ([202.201.14.140])
        by mx.google.com with ESMTPS id 23sm1916989pzk.14.2010.04.10.05.12.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Apr 2010 05:12:14 -0700 (PDT)
Subject: [PATCH v5 1/4] Loongson: Add CPU_LOONGSON2F_WORKAROUNDS
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <cover.1270882402.git.wuzhangjin@gmail.com>
References: <cover.1270882402.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1270882402.git.wuzhangjin@gmail.com>
References: <cover.1270882402.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Sat, 10 Apr 2010 20:05:20 +0800
Message-ID: <1270901120.14758.7.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26385
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
