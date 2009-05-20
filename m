Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 22:50:31 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.180]:8889 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025167AbZETVuS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2009 22:50:18 +0100
Received: by wa-out-1112.google.com with SMTP id n4so119407wag.0
        for <multiple recipients>; Wed, 20 May 2009 14:50:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7GLYgYkPVMqlFOYAg0mBhsTUdUm3NMkeOoXKoKbSbZc=;
        b=KyWTbKXB95Tz4bbXCrg67KCnQqz9YuTd8hN5s7ZJkXSC8slCKjQFOmB3fnc5qY4wCY
         znkdcCfjAqjlu7ZQY30hBo5Y36RPPvFHeLBu8J/Q7tM1jQfJphPpooKncARe4Dst+OBU
         9d3FSQ3d2dsynnEL3PUw7A/L0cltAaUrXgRI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FuTvYVwgf2Xyq4EzL5iEFgfU3Ki/WYLaVMzKQAlugmqll1NgFljSLIHq8tR9cWLIPK
         4r0ABBH8i8ykAsKMBs20F/2O6rloxcsz7vmhrdHuEmkA3s1CAB5A84inOsc3bwrqPsFv
         NkJQk4kjA9nBJsYw4F+cslOe0vTiUIkwOw5DA=
Received: by 10.115.46.10 with SMTP id y10mr3553361waj.121.1242856216766;
        Wed, 20 May 2009 14:50:16 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id l37sm3996436waf.40.2009.05.20.14.50.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 14:50:15 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, Yan hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>
Subject: [loongson-PATCH-v1 03/27] fix-error: incompatiable argument type of clear_user
Date:	Thu, 21 May 2009 05:50:01 +0800
Message-Id: <8f44bd7169af8d4fdafa42ce4750943ef4da439f.1242855716.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <cover.1242855716.git.wuzhangjin@gmail.com>
References: <cover.1242855716.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

there are lots of warnings about the macro: clear_user in linux-mips.

the type of the second argument of access_ok should be (void __user *),
but there is an un-needed (unsigned long) conversion before __cl_addr,
so, remove the (unsigned long) will fix this problem.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/include/asm/uaccess.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 42b9cec..cd32e9f 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -936,7 +936,7 @@ __clear_user(void __user *addr, __kernel_size_t size)
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
