Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9MBXck31768
	for linux-mips-outgoing; Mon, 22 Oct 2001 04:33:38 -0700
Received: from ns5.sony.co.jp (NS5.Sony.CO.JP [146.215.0.105])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9MBXRD31764
	for <linux-mips@oss.sgi.com>; Mon, 22 Oct 2001 04:33:28 -0700
Received: from mail2.sony.co.jp (GateKeeper8.Sony.CO.JP [146.215.0.71])
	by ns5.sony.co.jp (R8/Sony) with ESMTP id f9MBXQL34769;
	Mon, 22 Oct 2001 20:33:26 +0900 (JST)
Received: from mail2.sony.co.jp (localhost [127.0.0.1])
	by mail2.sony.co.jp (R8) with ESMTP id f9MBXQH11745;
	Mon, 22 Oct 2001 20:33:26 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail2.sony.co.jp (R8) with ESMTP id f9MBXPA11735;
	Mon, 22 Oct 2001 20:33:25 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.2.217.16]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id UAA00769; Mon, 22 Oct 2001 20:37:45 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.2.226.27]) by imail.sm.sony.co.jp (8.9.3+3.2W/3.7W) with ESMTP id UAA18717; Mon, 22 Oct 2001 20:33:24 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.11.0/8.11.0) with ESMTP id f9MBXOe12286; Mon, 22 Oct 2001 20:33:24 +0900 (JST)
To: alan@lxorguk.ukuu.org.uk, ralf@uni-koblenz.de
Cc: linux-mips@oss.sgi.com
Subject: Re: csum_ipv6_magic()
In-Reply-To: <20011022195619A.machida@sm.sony.co.jp>
References: <20011022151606V.machida@sm.sony.co.jp>
	<E15vZvr-000138-00@the-village.bc.nu>
	<20011022195619A.machida@sm.sony.co.jp>
X-Mailer: Mew version 1.94.2 on Emacs 19.28 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011022203324G.machida@sm.sony.co.jp>
Date: Mon, 22 Oct 2001 20:33:24 +0900
From: Machida Hiroyuki <machida@sm.sony.co.jp>
X-Dispatcher: imput version 20000228(IM140)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I found bugs in checksum.h. A sample fix is attached below.

I perfer to use generic csum_ipv6_magic() in net/checksum.h
than this fix. Please someone show me improvements for this asm
version of csum_ipv6_magic(). 

---
Hiroyuki Machida
Sony Corp.


ChangLog entry:

* (csum_ipv6_magic): Have same paramter types as net/checksum.h.
  Correct carry computation.  Add a final carry.


Index: checksum.h
===================================================================
RCS file: /cvs/linux/include/asm-mips/checksum.h,v
retrieving revision 1.12
diff -u -p -r1.12 checksum.h
--- checksum.h	2001/10/06 19:29:25	1.12
+++ checksum.h	2001/10/22 11:16:05
@@ -197,7 +197,7 @@ static inline unsigned short ip_compute_
 #define _HAVE_ARCH_IPV6_CSUM
 static __inline__ unsigned short int csum_ipv6_magic(struct in6_addr *saddr,
 						     struct in6_addr *daddr,
-						     __u32 len,
+						     unsigned short len,
 						     unsigned short proto,
 						     unsigned int sum) 
 {
@@ -211,49 +211,51 @@ static __inline__ unsigned short int csu
 	"addu\t%0, %6\t\t\t# csum\n\t"
 	"sltu\t$1, %0, %6\n\t"
 	"lw\t%1, 0(%2)\t\t\t# four words source address\n\t"
-	"addu\t%0, $1\n\t"
+	" addu\t%0, $1\n\t"
 	"addu\t%0, %1\n\t"
-	"sltu\t$1, %0, $1\n\t"
+	"sltu\t$1, %0, %1\n\t"
 
 	"lw\t%1, 4(%2)\n\t"
-	"addu\t%0, $1\n\t"
+	" addu\t%0, $1\n\t"
 	"addu\t%0, %1\n\t"
-	"sltu\t$1, %0, $1\n\t"
+	"sltu\t$1, %0, %1\n\t"
 
 	"lw\t%1, 8(%2)\n\t"
-	"addu\t%0, $1\n\t"
+	" addu\t%0, $1\n\t"
 	"addu\t%0, %1\n\t"
-	"sltu\t$1, %0, $1\n\t"
+	"sltu\t$1, %0, %1\n\t"
 
 	"lw\t%1, 12(%2)\n\t"
-	"addu\t%0, $1\n\t"
+	" addu\t%0, $1\n\t"
 	"addu\t%0, %1\n\t"
-	"sltu\t$1, %0, $1\n\t"
+	"sltu\t$1, %0, %1\n\t"
 
 	"lw\t%1, 0(%3)\n\t"
-	"addu\t%0, $1\n\t"
+	" addu\t%0, $1\n\t"
 	"addu\t%0, %1\n\t"
-	"sltu\t$1, %0, $1\n\t"
+	"sltu\t$1, %0, %1\n\t"
 
 	"lw\t%1, 4(%3)\n\t"
-	"addu\t%0, $1\n\t"
+	" addu\t%0, $1\n\t"
 	"addu\t%0, %1\n\t"
-	"sltu\t$1, %0, $1\n\t"
+	"sltu\t$1, %0, %1\n\t"
 
 	"lw\t%1, 8(%3)\n\t"
-	"addu\t%0, $1\n\t"
+	" addu\t%0, $1\n\t"
 	"addu\t%0, %1\n\t"
-	"sltu\t$1, %0, $1\n\t"
+	"sltu\t$1, %0, %1\n\t"
 
 	"lw\t%1, 12(%3)\n\t"
-	"addu\t%0, $1\n\t"
+	" addu\t%0, $1\n\t"
 	"addu\t%0, %1\n\t"
-	"sltu\t$1, %0, $1\n\t"
+	"sltu\t$1, %0, %1\n\t"
+	" addu\t%0, $1\n\t"
+
 	".set\tnoat\n\t"
 	".set\tnoreorder"
 	: "=r" (sum), "=r" (proto)
 	: "r" (saddr), "r" (daddr),
-	  "0" (htonl(len)), "1" (htonl(proto)), "r" (sum));
+	  "0" (htonl((__u32)len)), "1" (htonl(proto)), "r" (sum));
 
 	return csum_fold(sum);
 }
