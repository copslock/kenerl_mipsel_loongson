Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2003 17:09:14 +0100 (BST)
Received: from frigate.technologeek.org ([IPv6:::ffff:62.4.21.148]:64898 "EHLO
	frigate.technologeek.org") by linux-mips.org with ESMTP
	id <S8224861AbTGAQJH>; Tue, 1 Jul 2003 17:09:07 +0100
Received: by frigate.technologeek.org (Postfix, from userid 1000)
	id 2861F1C9140B; Tue,  1 Jul 2003 18:09:00 +0200 (CEST)
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: [PATCH] Fix include/asm-mips/io.h
From: Julien BLACHE <jb@jblache.org>
Date: Tue, 01 Jul 2003 18:08:59 +0200
Message-ID: <87d6guxm90.fsf@frigate.technologeek.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-Path: <jb@jblache.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2740
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jb@jblache.org
Precedence: bulk
X-list: linux-mips

--=-=-=

Hi,

Another small fix. In the latest change, writeb() and friends got
changed to use __ioswa*p*X(), and this is not defined
anywhere. Changed back to __ioswa*b*X().

Now let's see if I can boot this kernel :)

JB.

-- 
Julien BLACHE                                   <http://www.jblache.org> 
<jb@jblache.org> 


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=io.h.patch
Content-Description: include/asm-mips/io.h fix

--- io.h.orig	2003-07-01 16:05:46.000000000 +0000
+++ io.h	2003-07-01 16:05:09.000000000 +0000
@@ -295,10 +295,10 @@
 	local_irq_restore(flags);					\
 })
 
-#define writeb(b,addr)		__raw_writeb(__ioswap8(b),(addr))
-#define writew(w,addr)		__raw_writew(__ioswap16(w),(addr))
-#define writel(l,addr)		__raw_writel(__ioswap32(l),(addr))
-#define writeq(q,addr)		__raw_writeq(__ioswap64(q),(addr))
+#define writeb(b,addr)		__raw_writeb(__ioswab8(b),(addr))
+#define writew(w,addr)		__raw_writew(__ioswab16(w),(addr))
+#define writel(l,addr)		__raw_writel(__ioswab32(l),(addr))
+#define writeq(q,addr)		__raw_writeq(__ioswab64(q),(addr))
 
 #define memset_io(a,b,c)	memset((void *)(a),(b),(c))
 #define memcpy_fromio(a,b,c)	memcpy((a),(void *)(b),(c))

--=-=-=--
