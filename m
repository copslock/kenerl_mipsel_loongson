Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2008 20:10:44 +0100 (BST)
Received: from astoria.ccjclearline.com ([64.235.106.9]:54940 "EHLO
	astoria.ccjclearline.com") by ftp.linux-mips.org with ESMTP
	id S20032811AbYENTKl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 May 2008 20:10:41 +0100
Received: from cpe001d60ad7267-cm001225dbafb6.cpe.net.cable.rogers.com ([99.236.100.208] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1JwMN2-0006Pr-99; Wed, 14 May 2008 15:10:36 -0400
Date:	Wed, 14 May 2008 15:10:33 -0400 (EDT)
From:	"Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:	linux-mips@linux-mips.org
cc:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] MIPS:  Remove ioctl.h content that is picked up from
 <asm-generic/ioctl.h>.
Message-ID: <alpine.LFD.1.10.0805141507170.22371@localhost.localdomain>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <rpjday@crashcourse.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
Precedence: bulk
X-list: linux-mips


Given that <asm-generic/ioctl.h> now allows overriding of the most
common changeable macro values, take advantage of that.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  i *think* this patch results in an equivalent ioctl.h file, but feel
free to verify that, and tweak if necessary.

diff --git a/include/asm-mips/ioctl.h b/include/asm-mips/ioctl.h
index 2036fcb..ff6c7e0 100644
--- a/include/asm-mips/ioctl.h
+++ b/include/asm-mips/ioctl.h
@@ -8,87 +8,22 @@
 #ifndef _ASM_IOCTL_H
 #define _ASM_IOCTL_H

-/*
- * The original linux ioctl numbering scheme was just a general
- * "anything goes" setup, where more or less random numbers were
- * assigned.  Sorry, I was clueless when I started out on this.
- *
- * On the alpha, we'll try to clean it up a bit, using a more sane
- * ioctl numbering, and also trying to be compatible with OSF/1 in
- * the process. I'd like to clean it up for the i386 as well, but
- * it's so painful recognizing both the new and the old numbers..
- *
- * The same applies for for the MIPS ABI; in fact even the macros
- * from Linux/Alpha fit almost perfectly.
- */
-
-#define _IOC_NRBITS	8
-#define _IOC_TYPEBITS	8
 #define _IOC_SIZEBITS	13
 #define _IOC_DIRBITS	3

-#define _IOC_NRMASK	((1 << _IOC_NRBITS)-1)
-#define _IOC_TYPEMASK	((1 << _IOC_TYPEBITS)-1)
-#define _IOC_SIZEMASK	((1 << _IOC_SIZEBITS)-1)
-#define _IOC_DIRMASK	((1 << _IOC_DIRBITS)-1)
-
-#define _IOC_NRSHIFT	0
-#define _IOC_TYPESHIFT	(_IOC_NRSHIFT+_IOC_NRBITS)
-#define _IOC_SIZESHIFT	(_IOC_TYPESHIFT+_IOC_TYPEBITS)
-#define _IOC_DIRSHIFT	(_IOC_SIZESHIFT+_IOC_SIZEBITS)
-
-/*
- * Direction bits _IOC_NONE could be 0, but OSF/1 gives it a bit.
- * And this turns out useful to catch old ioctl numbers in header
- * files for us.
- */
 #define _IOC_NONE	1U
 #define _IOC_READ	2U
 #define _IOC_WRITE	4U

+#include <asm-generic/ioctl.h>
+
 /*
  * The following are included for compatibility
  */
+
 #define _IOC_VOID	0x20000000
 #define _IOC_OUT	0x40000000
 #define _IOC_IN		0x80000000
 #define _IOC_INOUT	(IOC_IN|IOC_OUT)

-#define _IOC(dir,type,nr,size) \
-	(((dir)  << _IOC_DIRSHIFT) | \
-	 ((type) << _IOC_TYPESHIFT) | \
-	 ((nr)   << _IOC_NRSHIFT) | \
-	 ((size) << _IOC_SIZESHIFT))
-
-/* provoke compile error for invalid uses of size argument */
-extern unsigned int __invalid_size_argument_for_IOC;
-#define _IOC_TYPECHECK(t) \
-	((sizeof(t) == sizeof(t[1]) && \
-	  sizeof(t) < (1 << _IOC_SIZEBITS)) ? \
-	  sizeof(t) : __invalid_size_argument_for_IOC)
-
-/* used to create numbers */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOR_BAD(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW_BAD(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR_BAD(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
-
-
-/* used to decode them.. */
-#define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)
-#define _IOC_TYPE(nr)		(((nr) >> _IOC_TYPESHIFT) & _IOC_TYPEMASK)
-#define _IOC_NR(nr)		(((nr) >> _IOC_NRSHIFT) & _IOC_NRMASK)
-#define _IOC_SIZE(nr)		(((nr) >> _IOC_SIZESHIFT) & _IOC_SIZEMASK)
-
-/* ...and for the drivers/sound files... */
-
-#define IOC_IN		(_IOC_WRITE << _IOC_DIRSHIFT)
-#define IOC_OUT		(_IOC_READ << _IOC_DIRSHIFT)
-#define IOC_INOUT	((_IOC_WRITE|_IOC_READ) << _IOC_DIRSHIFT)
-#define IOCSIZE_MASK	(_IOC_SIZEMASK << _IOC_SIZESHIFT)
-#define IOCSIZE_SHIFT	(_IOC_SIZESHIFT)
-
 #endif /* _ASM_IOCTL_H */

========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
