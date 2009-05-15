Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 23:00:25 +0100 (BST)
Received: from wf-out-1314.google.com ([209.85.200.175]:16889 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023321AbZEOWAN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2009 23:00:13 +0100
Received: by wf-out-1314.google.com with SMTP id 28so1223406wfa.21
        for <multiple recipients>; Fri, 15 May 2009 15:00:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=ZZwgQsKcFy1enUDugO5kBVpoXZblkPYP33xmlafI/YU=;
        b=Wehcr/v5dmc/DMIoY0pON4DYgqPkebeELd2dx5OJnkOfCOd9Fpo6myxQM1fNivViGF
         IrxTFI2gHPRs0O4sneM9jPPfZWNsCa2Csf/AxMa77XWBuq9GK5bavKEMdN1P7TFdxqXV
         8hCb95bY/J6ENPPAIOfZ2o/R/yAqbdN9BQ388=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=HdWTDU7NStgMo7ksFsLUrtARevSbGSrf1qWrzymzCq0SMxhjXdLa3xZQgGjb2PbfXI
         M+UqIFMEaT6Hr3MFayupU5S+lAuXkZ3mnmzadQpDEO2+sLq+gi4nAE65kCkXL/L74POS
         fhvLJN0AYvVhfraEY58P20w56Ldkl0WAgW1EU=
Received: by 10.142.49.20 with SMTP id w20mr1228631wfw.330.1242424811087;
        Fri, 15 May 2009 15:00:11 -0700 (PDT)
Received: from ?172.16.2.101? ([222.92.8.142])
        by mx.google.com with ESMTPS id 29sm3505143wfg.28.2009.05.15.15.00.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 May 2009 15:00:10 -0700 (PDT)
Subject: [PATCH 03/30] fix error: incompatiable argument type of clear_user
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com, yanh@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sat, 16 May 2009 06:00:04 +0800
Message-Id: <1242424804.10164.142.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

>From c007d5f66af1b0134699644576f2d8994216057e Mon Sep 17 00:00:00 2001
From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Fri, 15 May 2009 20:36:20 +0800
Subject: [PATCH 03/30] fix error: incompatiable argument type of
clear_user

there are lots of warnings about the macro: clear_user in linux-mips.
in linux-2.6.29.3, it will come with errors, so, must be fixed.

the type of the second argument of access_ok should be (void __user *),
but there is an un-needed (unsigned long) conversion before __cl_addr,
so, remove the (unsigned long) will fix this problem.
---
 arch/mips/include/asm/uaccess.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h
b/arch/mips/include/asm/uaccess.h
index 42b9cec..cd32e9f 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -936,7 +936,7 @@ __clear_user(void __user *addr, __kernel_size_t
size)
 	void __user * __cl_addr = (addr);				\
 	unsigned long __cl_size = (n);					\
 	if (__cl_size && access_ok(VERIFY_WRITE,			\
-		((unsigned long)(__cl_addr)), __cl_size))		\
+					__cl_addr, __cl_size))		\
 		__cl_size = __clear_user(__cl_addr, __cl_size);		\
 	__cl_size;							\
 })
-- 
1.6.2.1
