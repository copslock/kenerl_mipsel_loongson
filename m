Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Nov 2002 23:37:53 +0100 (CET)
Received: from mms1.broadcom.com ([63.70.210.58]:47890 "EHLO mms1.broadcom.com")
	by linux-mips.org with ESMTP id <S1123920AbSKHWhw>;
	Fri, 8 Nov 2002 23:37:52 +0100
Received: from 63.70.210.1mms1.broadcom.com with ESMTP (Broadcom MMS1
 SMTP Relay (MMS v5.0)); Fri, 08 Nov 2002 14:37:17 -0800
X-Server-Uuid: C4EEB3B0-84E7-41AF-B685-DDB6986D9F7C
Received: from mail-sj1-5.sj.broadcom.com (mail-sj1-5.sj.broadcom.com
 [10.16.128.236]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP
 id OAA11216; Fri, 8 Nov 2002 14:37:39 -0800 (PST)
Received: from dt-sj3-158.sj.broadcom.com (dt-sj3-158 [10.21.64.158]) by
 mail-sj1-5.sj.broadcom.com (8.12.4/8.12.4/SSF) with ESMTP id
 gA8MbcER013067; Fri, 8 Nov 2002 14:37:38 -0800 (PST)
Received: from broadcom.com (IDENT:kwalker@localhost [127.0.0.1]) by
 dt-sj3-158.sj.broadcom.com (8.9.3/8.9.3) with ESMTP id PAA02158; Fri, 8
 Nov 2002 15:37:38 -0800
Message-ID: <3DCC4AC2.EC7BD4E1@broadcom.com>
Date: Fri, 08 Nov 2002 15:37:38 -0800
From: "Kip Walker" <kwalker@broadcom.com>
Organization: Broadcom Corp. BPBU
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.5-beta4va3.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: 64-bit little endian semaphore bug
X-WSS-ID: 11D2E317282156-01-01
Content-Type: multipart/mixed;
 boundary=------------83C663DB61E0A3DB4B796614
Return-Path: <kwalker@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 617
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kwalker@broadcom.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------83C663DB61E0A3DB4B796614
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit

In the 64-bit kernel, the semaphore structure (like the 32-bit kernel)
has waking and count fields swizzled so they line up the same in a
64-bit double word for either endian.  However, the semaphore-helper.h
function waking_non_zero_interruptible still has specialized code for
little-endian manipulation of the fields as though they are swapped.

Patch is attached, and fixes a pipe deadlock I was seeing (both the
reader and writer were down'ing the semaphore).

patch is against 2.5, but should be clean against 2.4 also.

Kip
--------------83C663DB61E0A3DB4B796614
Content-Type: text/plain;
 charset=us-ascii;
 name=semhelp.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=semhelp.patch

Index: include/asm-mips64/semaphore-helper.h
===================================================================
RCS file: /home/cvs/linux/include/asm-mips64/semaphore-helper.h,v
retrieving revision 1.10
diff -u -r1.10 semaphore-helper.h
--- include/asm-mips64/semaphore-helper.h	19 Aug 2002 23:25:28 -0000	1.10
+++ include/asm-mips64/semaphore-helper.h	8 Nov 2002 22:32:46 -0000
@@ -66,8 +66,6 @@
 {
 	long ret, tmp;
 
-#ifdef __MIPSEB__
-
         __asm__ __volatile__(
 	".set\tpush\t\t\t# waking_non_zero_interruptible\n\t"
 	".set\tnoat\n\t"
@@ -87,38 +85,6 @@
 	".set\tpop"
 	: "=&r" (ret), "=&r" (tmp), "=m" (*sem)
 	: "r" (signal_pending(tsk)), "i" (-EINTR));
-
-#elif defined(__MIPSEL__)
-
-	__asm__ __volatile__(
-	".set\tpush\t\t\t# waking_non_zero_interruptible\n\t"
-	".set\t	noat\n"
-	"0:\tlld\t%1, %2\n\t"
-	"li\t%0, 0\n\t"
-	"blez\t%1, 1f\n\t"
-	"dli\t$1, 0x0000000100000000\n\t"
-	"dsubu\t%1, %1, $1\n\t"
-	"li\t%0, 1\n\t"
-	"b\t2f\n"
-	"1:\tbeqz\t%3, 2f\n\t"
-	"li\t%0, %4\n\t"
-	/*
-	 * It would be nice to assume that sem->count
-	 * is != -1, but we will guard against that case
-	 */
-	"daddiu\t$1, %1, 1\n\t"
-	"dsll32\t$1, $1, 0\n\t"
-	"dsrl32\t$1, $1, 0\n\t"
-	"dsrl32\t%1, %1, 0\n\t"
-	"dsll32\t%1, %1, 0\n\t"
-	"or\t%1, %1, $1\n"
-	"2:\tscd\t%1, %2\n\t"
-	"beqz\t	%1, 0b\n\t"
-	".set\tpop"
-	: "=&r" (ret), "=&r" (tmp), "=m" (*sem)
-	: "r" (signal_pending(tsk)), "i" (-EINTR));
-
-#endif
 
 	return ret;
 }

--------------83C663DB61E0A3DB4B796614--
