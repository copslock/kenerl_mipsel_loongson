Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2009 07:24:11 +0100 (BST)
Received: from mail-px0-f119.google.com ([209.85.216.119]:40602 "EHLO
	mail-px0-f119.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021723AbZELGYD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2009 07:24:03 +0100
Received: by pxi17 with SMTP id 17so97694pxi.22
        for <multiple recipients>; Mon, 11 May 2009 23:23:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=UXwFrAENSB2+LD1YM5LN13QGfcVUr7sm1QgUNAkzRoc=;
        b=gAnJ/ixnoH4gvGamCXvCwVwRbVOUrhUsnDrLcntKr1x7T7X+QWbTJ3vLh4Qdp+RuSD
         CeJLpdDRLGqS6rUQFC3zrA9paOaVe6KB33bsTTursh8fJ2uXAly4d3PyoZqEJpZyYOtV
         2iXAmLFAhzLY9IldVAA7YIZuB0ZHWhn0FIU4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=C81898hQAKrMVGwXixJ2ShUciD4AtoEz1XZtWDKON8dk7ywLPc2v7Tm3PkJMS/IUIU
         yB/8x2RDjvqAbBOAMCFc2xEwTVCN/MjLqm25l/VqTmZgJ5hfiPIta/+bftTBUqS3wI52
         8BuQZo3zLELYdNEcVbsmchVO0RsadLc8TwP/4=
Received: by 10.114.210.2 with SMTP id i2mr6055552wag.44.1242109436736;
        Mon, 11 May 2009 23:23:56 -0700 (PDT)
Received: from ?172.16.18.144? ([222.92.8.142])
        by mx.google.com with ESMTPS id a8sm21244729poa.17.2009.05.11.23.23.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 23:23:56 -0700 (PDT)
Subject: [PATCH] fix warning: incompatiable argument type of clear_user
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Linux MIPS List <linux-mips@linux-mips.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, zhangfx@lemote.com,
	yanh@lemote.com
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Tue, 12 May 2009 14:22:32 +0800
Message-Id: <1242109352.4890.11.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

hi, Ralf

there are lots of warnings about the macro: clear_user in linux-mips.
in linux-2.6.29.3, it will come with errors, so, must be fixed.

the type of the second argument of access_ok should be void __user *,
but there is an un-needed (unsigned long) conversion before __cl_addr,
so remove the (unsigned long) will fix this problem.

       best regards, 
       Wu Zhangjin

--
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
