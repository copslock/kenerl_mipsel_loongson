Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:19:57 +0100 (BST)
Received: from mail-px0-f119.google.com ([209.85.216.119]:52814 "EHLO
	mail-px0-f119.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023149AbZEOWTv (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:19:51 +0100
Received: by pxi17 with SMTP id 17so1369919pxi.22
        for <multiple recipients>; Fri, 15 May 2009 15:19:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=arXqj3HMeRroHuttz0ycR/pYHF1O0TQukbpF/x7uDIk=;
        b=uH5BFSD5sFs17+KmWonpt+zTzCHI9zu/qa9hp0/GVl++12CEbFJW7LA5OBlwO/D1Uo
         u6WjOA65NMAMArAEldbSbKyq8btNv+li5b0C3LcKQZPM8KU/K+uHq4OJFaDALltXzID3
         DfxxU2G09RxDk2u1CE2fM5cghqNtb+TDbnEhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=XHI9CqyPgEBPQ9LDZz7GS2PjW+0P2ZwDmHxGwQSMK9vgl/uC2dW0ZDdXzZX4oHx308
         7DVlxEcqU66lL5+vC/TTqBcer4CIAYULO5Ljd7VWwGr65yZidjB33g+tbikDHGaJD6yz
         MThoa89ota+XV5b2CCICt+CZf9Kr+TfzfpkKk=
Received: by 10.115.60.2 with SMTP id n2mr5615598wak.183.1242425983840;
        Fri, 15 May 2009 15:19:43 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id j15sm1979745waf.64.2009.05.15.15.19.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:19:43 -0700 (PDT)
Subject: [PATCH 20/30] loongson: Flush RAS and BTB for CPU predictively
 execution
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:19:37 +0800
Message-Id: <1242425977.10164.163.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From b023ba02ea5c0983ffb33ff486b3b4f8b5d972e6 Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Sat, 16 May 2009 04:32:13 +0800
Subject: [PATCH 20/30] loongson: Flush RAS and BTB for CPU predictively
execution

---
 arch/mips/include/asm/stackframe.h |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h
b/arch/mips/include/asm/stackframe.h
index db0fa7b..204286e 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -117,6 +117,24 @@
 		.endm
 #else
 		.macro	get_saved_sp	/* Uniprocessor variation */
+#ifdef CONFIG_CPU_LOONGSON2
+		move k0,ra
+		jal 2008f
+		nop
+		2008:
+		jal 2008f
+		nop
+		2008:
+		jal 2008f
+		nop
+		2008:
+		jal 2008f
+		nop
+		2008:
+		move ra,k0
+		li k0,3
+		mtc0 k0,$22
+#endif
 #if defined(CONFIG_32BIT) || defined(KBUILD_64BIT_SYM32)
 		lui	k1, %hi(kernelsp)
 #else
-- 
1.6.2.1
