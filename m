Received:  by oss.sgi.com id <S554045AbRBBLiO>;
	Fri, 2 Feb 2001 03:38:14 -0800
Received: from sovereign.org ([209.180.91.170]:52352 "EHLO lux.homenet")
	by oss.sgi.com with ESMTP id <S554024AbRBBLh4>;
	Fri, 2 Feb 2001 03:37:56 -0800
Received: (from jfree@localhost)
	by lux.homenet (8.11.2/8.11.2/Debian 8.11.2-1) id f12Bbuq03913
	for linux-mips@oss.sgi.com; Fri, 2 Feb 2001 04:37:56 -0700
From:   Jim Freeman <jfree@sovereign.org>
Date:   Fri, 2 Feb 2001 04:37:56 -0700
To:     linux-mips@oss.sgi.com
Subject: hz_to_std(): parisc, etc.
Message-ID: <20010202043756.A3687@sovereign.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

asm-parisc/param.h is missing the hz_to_std() macro that the
other asm-*/param.h have.

For the other missing asm-arm/arch-*, something like the following
could catch laggards?  Or the test could be used in linux/param.h,
though I expect Linus wouldn't like crufting the toplevel .h
for a mips-ism (or is hz_to_std() a needed non-mips-centric
general mechanism)?

--- linux-mips.cvs/include/asm-arm/param.h	2001/02/02 11:14:40	1.1
+++ linux-mips.cvs/include/asm-arm/param.h	2001/02/02 11:27:18
@@ -16,9 +16,14 @@
 #ifndef HZ
 #define HZ 100
 #endif
-#if defined(__KERNEL__) && (HZ == 100)
+#ifdef __KERNEL__
+#if (HZ == 100)
 #define hz_to_std(a) (a)
-#endif
+#endif /* (HZ == 100) */
+#if !defined(hz_to_std)
+#error hz_to_std not defined	/* see asm-arm/arch-shark/param.h for details */
+#endif /* !defined(hz_to_std) */
+#endif /* def __KERNEL__ */
 
 #ifndef NGROUPS
 #define NGROUPS         32
--- linux-mips.cvs/include/asm-arm/arch-shark/param.h	2001/02/02 11:16:59	1.1
+++ linux-mips.cvs/include/asm-arm/arch-shark/param.h	2001/02/02 11:19:24
@@ -15,7 +15,7 @@
 
    is what has to be done, it just has overflow problems with the
    intermediate result of the multiply after a bit more than 7 days.
-   See include/asm-mips/param.h for a optized sample implementation
+   See include/asm-mips/param.h for an optimized sample implementation
    used on DECstations.
  */
 #error Provide a definiton for hz_to_std
