Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6NNugg28416
	for linux-mips-outgoing; Mon, 23 Jul 2001 16:56:42 -0700
Received: from dea.waldorf-gmbh.de (u-223-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.223])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6NNuPO28407
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 16:56:26 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6NNuBq10012;
	Tue, 24 Jul 2001 01:56:11 +0200
Date: Tue, 24 Jul 2001 01:56:11 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Martin Schulze <joey@infodrom.north.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: Question about ioctls.h
Message-ID: <20010724015611.A10007@bacchus.dhis.org>
References: <20010724010342.R31470@finlandia.infodrom.north.de> <20010724012757.A4953@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010724012757.A4953@bacchus.dhis.org>; from ralf@oss.sgi.com on Tue, Jul 24, 2001 at 01:27:58AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jul 24, 2001 at 01:27:58AM +0200, Ralf Baechle wrote:

> > Could somebody try to explain this to me?  I'm especially interested
> > in the #if part.  Why isn't tIOC defined normally?  It is used later.
> > in the file - and it is used externally by rp-pppoe for example.
> 
> Overly paranoid attempt at keeping the namespace cleaner than Mr Proper
> himself.

Try the patch below.

  Ralf

Index: include/asm-mips64/ioctls.h
===================================================================
RCS file: /home/pub/cvs/linux/include/asm-mips64/ioctls.h,v
retrieving revision 1.2
diff -u -r1.2 ioctls.h
--- include/asm-mips64/ioctls.h	2001/07/09 00:25:38	1.2
+++ include/asm-mips64/ioctls.h	2001/07/23 23:55:09
@@ -3,17 +3,14 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1995, 1996, 1999 by Ralf Baechle
+ * Copyright (C) 1995, 1996, 2001 Ralf Baechle
+ * Copyright (C) 2001 MIPS Technologies, Inc.
  */
-#ifndef _ASM_IOCTLS_H
-#define _ASM_IOCTLS_H
+#ifndef __ASM_IOCTLS_H
+#define __ASM_IOCTLS_H
 
 #include <asm/ioctl.h>
 
-#if defined(__USE_MISC) || defined (__KERNEL__)
-#define tIOC		('t' << 8)
-#endif
-
 #define TCGETA		0x5401
 #define TCSETA		0x5402
 #define TCSETAW		0x5403
@@ -37,31 +34,27 @@
 #define TIOCMBIC	0x741c		/* bic modem bits */
 #define TIOCMSET	0x741a		/* set all modem bits */
 #define TIOCPKT		0x5470		/* pty: set/clear packet mode */
-#define		TIOCPKT_DATA		0x00	/* data packet */
-#define		TIOCPKT_FLUSHREAD	0x01	/* flush packet */
-#define		TIOCPKT_FLUSHWRITE	0x02	/* flush packet */
-#define		TIOCPKT_STOP		0x04	/* stop output */
-#define		TIOCPKT_START		0x08	/* start output */
-#define		TIOCPKT_NOSTOP		0x10	/* no more ^S, ^Q */
-#define		TIOCPKT_DOSTOP		0x20	/* now do ^S ^Q */
-#if 0
-#define		TIOCPKT_IOCTL		0x40	/* state change of pty driver */
-#endif
+#define	 TIOCPKT_DATA		0x00	/* data packet */
+#define	 TIOCPKT_FLUSHREAD	0x01	/* flush packet */
+#define	 TIOCPKT_FLUSHWRITE	0x02	/* flush packet */
+#define	 TIOCPKT_STOP		0x04	/* stop output */
+#define	 TIOCPKT_START		0x08	/* start output */
+#define	 TIOCPKT_NOSTOP		0x10	/* no more ^S, ^Q */
+#define	 TIOCPKT_DOSTOP		0x20	/* now do ^S ^Q */
+/* #define  TIOCPKT_IOCTL		0x40	state change of pty driver */
 #define TIOCSWINSZ	_IOW('t', 103, struct winsize)	/* set window size */
 #define TIOCGWINSZ	_IOR('t', 104, struct winsize)	/* get window size */
 #define TIOCNOTTY	0x5471		/* void tty association */
-#define TIOCSETD	(tIOC | 1)
-#define TIOCGETD	(tIOC | 0)
+#define TIOCSETD	0x7401
+#define TIOCGETD	0x7400
 
 #define FIOCLEX		0x6601
 #define FIONCLEX	0x6602		/* these numbers need to be adjusted. */
 #define FIOASYNC	0x667d
 #define FIONBIO		0x667e
 
-#if defined(__USE_MISC) || defined (__KERNEL__)
-#define TIOCGLTC	(tIOC | 116)		/* get special local chars */
-#define TIOCSLTC	(tIOC | 117)		/* set special local chars */
-#endif
+#define TIOCGLTC	0x7474			/* get special local chars */
+#define TIOCSLTC	0x7475			/* set special local chars */
 #define TIOCSPGRP	_IOW('t', 118, int)	/* set pgrp of tty */
 #define TIOCGPGRP	_IOR('t', 119, int)	/* get pgrp of tty */
 #define TIOCCONS	_IOW('t', 120, int)	/* become virtual console */
@@ -69,20 +62,16 @@
 #define FIONREAD	0x467f
 #define TIOCINQ		FIONREAD
 
-#if defined(__USE_MISC) || defined (__KERNEL__)
-#define TIOCGETP        (tIOC | 8)
-#define TIOCSETP        (tIOC | 9)
-#define TIOCSETN        (tIOC | 10)		/* TIOCSETP wo flush */
-#endif
+#define TIOCGETP        0x7408
+#define TIOCSETP        0x7409
+#define TIOCSETN        0x740a			/* TIOCSETP wo flush */
  
-#if 0
-#define	TIOCSETA	_IOW('t', 20, struct termios) /* set termios struct */
-#define	TIOCSETAW	_IOW('t', 21, struct termios) /* drain output, set */
-#define	TIOCSETAF	_IOW('t', 22, struct termios) /* drn out, fls in, set */
-#define	TIOCGETD	_IOR('t', 26, int)	/* get line discipline */
-#define	TIOCSETD	_IOW('t', 27, int)	/* set line discipline */
+/* #define TIOCSETA	_IOW('t', 20, struct termios) set termios struct */
+/* #define TIOCSETAW	_IOW('t', 21, struct termios) drain output, set */
+/* #define TIOCSETAF	_IOW('t', 22, struct termios) drn out, fls in, set */
+/* #define TIOCGETD	_IOR('t', 26, int)	get line discipline */
+/* #define TIOCSETD	_IOW('t', 27, int)	set line discipline */
 						/* 127-124 compat */
-#endif
 
 /* I hope the range from 0x5480 on is free ... */
 #define TIOCSCTTY	0x5480		/* become controlling tty */
@@ -114,4 +103,4 @@
 #define TIOCGHAYESESP	0x5493 /* Get Hayes ESP configuration */
 #define TIOCSHAYESESP	0x5494 /* Set Hayes ESP configuration */
 
-#endif /* _ASM_IOCTLS_H */
+#endif /* __ASM_IOCTLS_H */
Index: include/asm-mips/ioctls.h
===================================================================
RCS file: /home/pub/cvs/linux/include/asm-mips/ioctls.h,v
retrieving revision 1.8
diff -u -r1.8 ioctls.h
--- include/asm-mips/ioctls.h	1998/08/25 09:21:56	1.8
+++ include/asm-mips/ioctls.h	2001/07/23 23:55:09
@@ -1,20 +1,16 @@
-/* $Id: ioctls.h,v 1.5 1998/08/19 21:58:11 ralf Exp $
- *
+/*
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 1995, 1996 by Ralf Baechle
+ * Copyright (C) 1995, 1996, 2001 Ralf Baechle
+ * Copyright (C) 2001 MIPS Technologies, Inc.
  */
-#ifndef __ASM_MIPS_IOCTLS_H
-#define __ASM_MIPS_IOCTLS_H
+#ifndef __ASM_IOCTLS_H
+#define __ASM_IOCTLS_H
 
 #include <asm/ioctl.h>
 
-#if defined(__USE_MISC) || defined (__KERNEL__)
-#define tIOC		('t' << 8)
-#endif
-
 #define TCGETA		0x5401
 #define TCSETA		0x5402
 #define TCSETAW		0x5403
@@ -38,31 +34,27 @@
 #define TIOCMBIC	0x741c		/* bic modem bits */
 #define TIOCMSET	0x741a		/* set all modem bits */
 #define TIOCPKT		0x5470		/* pty: set/clear packet mode */
-#define		TIOCPKT_DATA		0x00	/* data packet */
-#define		TIOCPKT_FLUSHREAD	0x01	/* flush packet */
-#define		TIOCPKT_FLUSHWRITE	0x02	/* flush packet */
-#define		TIOCPKT_STOP		0x04	/* stop output */
-#define		TIOCPKT_START		0x08	/* start output */
-#define		TIOCPKT_NOSTOP		0x10	/* no more ^S, ^Q */
-#define		TIOCPKT_DOSTOP		0x20	/* now do ^S ^Q */
-#if 0
-#define		TIOCPKT_IOCTL		0x40	/* state change of pty driver */
-#endif
+#define	 TIOCPKT_DATA		0x00	/* data packet */
+#define	 TIOCPKT_FLUSHREAD	0x01	/* flush packet */
+#define	 TIOCPKT_FLUSHWRITE	0x02	/* flush packet */
+#define	 TIOCPKT_STOP		0x04	/* stop output */
+#define	 TIOCPKT_START		0x08	/* start output */
+#define	 TIOCPKT_NOSTOP		0x10	/* no more ^S, ^Q */
+#define	 TIOCPKT_DOSTOP		0x20	/* now do ^S ^Q */
+/* #define  TIOCPKT_IOCTL		0x40	state change of pty driver */
 #define TIOCSWINSZ	_IOW('t', 103, struct winsize)	/* set window size */
 #define TIOCGWINSZ	_IOR('t', 104, struct winsize)	/* get window size */
 #define TIOCNOTTY	0x5471		/* void tty association */
-#define TIOCSETD	(tIOC | 1)
-#define TIOCGETD	(tIOC | 0)
+#define TIOCSETD	0x7401
+#define TIOCGETD	0x7400
 
 #define FIOCLEX		0x6601
 #define FIONCLEX	0x6602		/* these numbers need to be adjusted. */
 #define FIOASYNC	0x667d
 #define FIONBIO		0x667e
 
-#if defined(__USE_MISC) || defined (__KERNEL__)
-#define TIOCGLTC	(tIOC | 116)		/* get special local chars */
-#define TIOCSLTC	(tIOC | 117)		/* set special local chars */
-#endif
+#define TIOCGLTC	0x7474			/* get special local chars */
+#define TIOCSLTC	0x7475			/* set special local chars */
 #define TIOCSPGRP	_IOW('t', 118, int)	/* set pgrp of tty */
 #define TIOCGPGRP	_IOR('t', 119, int)	/* get pgrp of tty */
 #define TIOCCONS	_IOW('t', 120, int)	/* become virtual console */
@@ -70,20 +62,16 @@
 #define FIONREAD	0x467f
 #define TIOCINQ		FIONREAD
 
-#if defined(__USE_MISC) || defined (__KERNEL__)
-#define TIOCGETP        (tIOC | 8)
-#define TIOCSETP        (tIOC | 9)
-#define TIOCSETN        (tIOC | 10)		/* TIOCSETP wo flush */
-#endif
+#define TIOCGETP        0x7408
+#define TIOCSETP        0x7409
+#define TIOCSETN        0x740a			/* TIOCSETP wo flush */
  
-#if 0
-#define	TIOCSETA	_IOW('t', 20, struct termios) /* set termios struct */
-#define	TIOCSETAW	_IOW('t', 21, struct termios) /* drain output, set */
-#define	TIOCSETAF	_IOW('t', 22, struct termios) /* drn out, fls in, set */
-#define	TIOCGETD	_IOR('t', 26, int)	/* get line discipline */
-#define	TIOCSETD	_IOW('t', 27, int)	/* set line discipline */
+/* #define TIOCSETA	_IOW('t', 20, struct termios) set termios struct */
+/* #define TIOCSETAW	_IOW('t', 21, struct termios) drain output, set */
+/* #define TIOCSETAF	_IOW('t', 22, struct termios) drn out, fls in, set */
+/* #define TIOCGETD	_IOR('t', 26, int)	get line discipline */
+/* #define TIOCSETD	_IOW('t', 27, int)	set line discipline */
 						/* 127-124 compat */
-#endif
 
 /* I hope the range from 0x5480 on is free ... */
 #define TIOCSCTTY	0x5480		/* become controlling tty */
@@ -115,4 +103,4 @@
 #define TIOCGHAYESESP	0x5493 /* Get Hayes ESP configuration */
 #define TIOCSHAYESESP	0x5494 /* Set Hayes ESP configuration */
 
-#endif /* __ASM_MIPS_IOCTLS_H */
+#endif /* __ASM_IOCTLS_H */
