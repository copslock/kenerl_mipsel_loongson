Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2007 17:43:52 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:32692 "EHLO
	the-village.bc.nu") by ftp.linux-mips.org with ESMTP
	id S20021694AbXEWQnu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 May 2007 17:43:50 +0100
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.13.8/8.13.8) with ESMTP id l4NGkeUC019812;
	Wed, 23 May 2007 17:46:40 +0100
Date:	Wed, 23 May 2007 17:46:40 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] mips: Enable arbitary speed tty support
Message-ID: <20070523174640.22ec3ddd@the-village.bc.nu>
X-Mailer: Claws Mail 2.9.1 (GTK+ 2.10.8; i386-redhat-linux-gnu)
Organization: Red Hat UK Cyf., Amberley Place, 107-111 Peascod Street,
 Windsor, Berkshire, SL4 1TE, Y Deyrnas Gyfunol. Cofrestrwyd yng Nghymru a
 Lloegr o'r rhif cofrestru 3798903
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

Add the defines and constants necessary to activate arbitary speed tty
support on this platform

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc1-mm1/include/asm-m68k/idiff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc1-mm1/include/asm-mips/ioctls.h linux-2.6.22-rc1-mm1/include/asm-mips/ioctls.h
--- linux.vanilla-2.6.22-rc1-mm1/include/asm-mips/ioctls.h	2007-04-30 10:48:17.000000000 +0100
+++ linux-2.6.22-rc1-mm1/include/asm-mips/ioctls.h	2007-05-23 16:36:53.285139968 +0100
@@ -77,6 +77,10 @@
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x7416  /* Return the session ID of FD */
+#define TCGETS2		_IOR('T',0x2A, struct termios2)
+#define TCSETS2		_IOW('T',0x2B, struct termios2)
+#define TCSETSW2	_IOW('T',0x2C, struct termios2)
+#define TCSETSF2	_IOW('T',0x2D, struct termios2)
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc1-mm1/include/asm-mips/termbits.h linux-2.6.22-rc1-mm1/include/asm-mips/termbits.h
--- linux.vanilla-2.6.22-rc1-mm1/include/asm-mips/termbits.h	2007-04-30 10:48:18.000000000 +0100
+++ linux-2.6.22-rc1-mm1/include/asm-mips/termbits.h	2007-05-23 16:36:23.788624120 +0100
@@ -153,6 +153,7 @@
 #define HUPCL	0002000		/* Hang up on last close.  */
 #define CLOCAL	0004000		/* Ignore modem status lines.  */
 #define CBAUDEX 0010000
+#define    BOTHER 0010000
 #define    B57600 0010001
 #define   B115200 0010002
 #define   B230400 0010003
@@ -168,9 +169,11 @@
 #define  B3000000 0010015
 #define  B3500000 0010016
 #define  B4000000 0010017
-#define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CIBAUD	  002003600000	/* input baud rate */
 #define CMSPAR    010000000000	/* mark or space (stick) parity */
-#define CRTSCTS	  020000000000		/* flow control */
+#define CRTSCTS	  020000000000	/* flow control */
+
+#define IBSHIFT	16		/* Shift from CBAUD to CIBAUD */
 
 /* c_lflag bits */
 #define ISIG	0000001		/* Enable signals.  */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc1-mm1/include/asm-mips/termios.h linux-2.6.22-rc1-mm1/include/asm-mips/termios.h
--- linux.vanilla-2.6.22-rc1-mm1/include/asm-mips/termios.h	2007-04-30 11:00:07.000000000 +0100
+++ linux-2.6.22-rc1-mm1/include/asm-mips/termios.h	2007-05-23 16:36:31.001527592 +0100
@@ -122,8 +122,10 @@
 	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
 })
 
-#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
-#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
+#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios2))
+#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios2))
+#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios))
+#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios))
 
 #endif /* defined(__KERNEL__) */
 
