Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2007 16:20:46 +0100 (BST)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17312 "EHLO
	the-village.bc.nu") by ftp.linux-mips.org with ESMTP
	id S20027192AbXFGPUn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Jun 2007 16:20:43 +0100
Received: from the-village.bc.nu (localhost.localdomain [127.0.0.1])
	by the-village.bc.nu (8.13.8/8.13.8) with ESMTP id l57FPtVH032670;
	Thu, 7 Jun 2007 16:25:55 +0100
Date:	Thu, 7 Jun 2007 16:25:55 +0100
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	akpm@osdl.org, linux-mips@linux-mips.org
Subject: [PATCH] tty: Add the new ioctls and definitionto the MIPS
 architecture
Message-ID: <20070607162555.3e09c8d0@the-village.bc.nu>
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
X-archive-position: 15336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

Same as all the others, just put in the constants for the existing kernel
code and termios2 structure

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc4-mm2/include/asm-mips/ioctls.h linux-2.6.22-rc4-mm2/include/asm-mips/ioctls.h
--- linux.vanilla-2.6.22-rc4-mm2/include/asm-mips/ioctls.h	2007-06-07 14:24:30.000000000 +0100
+++ linux-2.6.22-rc4-mm2/include/asm-mips/ioctls.h	2007-06-07 14:36:17.000000000 +0100
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
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc4-mm2/include/asm-mips/termbits.h linux-2.6.22-rc4-mm2/include/asm-mips/termbits.h
--- linux.vanilla-2.6.22-rc4-mm2/include/asm-mips/termbits.h	2007-06-07 14:26:10.000000000 +0100
+++ linux-2.6.22-rc4-mm2/include/asm-mips/termbits.h	2007-06-07 14:36:36.000000000 +0100
@@ -164,6 +164,7 @@
 #define HUPCL	0002000		/* Hang up on last close.  */
 #define CLOCAL	0004000		/* Ignore modem status lines.  */
 #define CBAUDEX 0010000
+#define    BOTHER 0010000
 #define    B57600 0010001
 #define   B115200 0010002
 #define   B230400 0010003
@@ -179,9 +180,11 @@
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
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc4-mm2/include/asm-mips/termios.h linux-2.6.22-rc4-mm2/include/asm-mips/termios.h
--- linux.vanilla-2.6.22-rc4-mm2/include/asm-mips/termios.h	2007-06-07 14:24:30.000000000 +0100
+++ linux-2.6.22-rc4-mm2/include/asm-mips/termios.h	2007-06-07 14:36:36.000000000 +0100
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
 
