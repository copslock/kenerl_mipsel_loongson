Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2003 05:31:30 +0100 (BST)
Received: from janus.foobazco.org ([IPv6:::ffff:198.144.194.226]:45725 "EHLO
	mail.foobazco.org") by linux-mips.org with ESMTP
	id <S8225297AbTH1Eb2>; Thu, 28 Aug 2003 05:31:28 +0100
Received: from fallout.sjc.foobazco.org (fallout.sjc.foobazco.org [192.168.21.20])
	by mail.foobazco.org (Postfix) with ESMTP
	id 71394FA38; Wed, 27 Aug 2003 21:31:13 -0700 (PDT)
Received: by fallout.sjc.foobazco.org (Postfix, from userid 1014)
	id 18E5223; Wed, 27 Aug 2003 21:31:12 -0700 (PDT)
Date: Wed, 27 Aug 2003 21:31:12 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: PATCH: avoid glibc conflict
Message-ID: <20030828043112.GA11094@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Return-Path: <wesolows@foobazco.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wesolows@foobazco.org
Precedence: bulk
X-list: linux-mips

This is needed to avoid a conflict with glibc on bigendian platforms
when -O or higher is specified.  It's already in 2.6, and I'm not sure
why it hasn't been seen in 2.4.  The symptom is that this program will
not compile with -O2:

#include <asm/byteorder.h>
#include <netinet/in.h>
int main () { }

Here's the patch.

--- linux/include/linux/byteorder/generic.h.orig	2003-08-10 18:15:07.000000000 -0700
+++ linux/include/linux/byteorder/generic.h	2003-08-10 18:16:36.000000000 -0700
@@ -122,7 +122,7 @@
 #define be16_to_cpus __be16_to_cpus
 #endif
 
-
+#if defined(__KERNEL__)
 /*
  * Handle ntohl and suches. These have various compatibility
  * issues - like we want to give the prototype even though we
@@ -146,35 +146,26 @@
  * Do the prototypes. Somebody might want to take the
  * address or some such sick thing..
  */
-#if defined(__KERNEL__) || (defined (__GLIBC__) && __GLIBC__ >= 2)
 extern __u32			ntohl(__u32);
 extern __u32			htonl(__u32);
-#else
-extern unsigned long int	ntohl(unsigned long int);
-extern unsigned long int	htonl(unsigned long int);
-#endif
 extern unsigned short int	ntohs(unsigned short int);
 extern unsigned short int	htons(unsigned short int);
 
-
-#if defined(__GNUC__) && (__GNUC__ >= 2) && defined(__OPTIMIZE__) && !defined(__STRICT_ANSI__)
+#if defined(__GNUC__) && defined(__OPTIMIZE__)
 
 #define ___htonl(x) __cpu_to_be32(x)
 #define ___htons(x) __cpu_to_be16(x)
 #define ___ntohl(x) __be32_to_cpu(x)
 #define ___ntohs(x) __be16_to_cpu(x)
 
-#if defined(__KERNEL__) || (defined (__GLIBC__) && __GLIBC__ >= 2)
 #define htonl(x) ___htonl(x)
 #define ntohl(x) ___ntohl(x)
-#else
-#define htonl(x) ((unsigned long)___htonl(x))
-#define ntohl(x) ((unsigned long)___ntohl(x))
-#endif
 #define htons(x) ___htons(x)
 #define ntohs(x) ___ntohs(x)
 
 #endif /* OPTIMIZE */
 
+#endif /* KERNEL */
+
 
 #endif /* _LINUX_BYTEORDER_GENERIC_H */


-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
