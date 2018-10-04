Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2018 00:30:23 +0200 (CEST)
Received: from mga12.intel.com ([192.55.52.136]:59835 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994617AbeJDWaUAt43v (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Oct 2018 00:30:20 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 15:30:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,341,1534834800"; 
   d="scan'208";a="94741764"
Received: from hanvin-mobl2.amr.corp.intel.com ([10.254.189.220])
  by fmsmga004.fm.intel.com with ESMTP; 04 Oct 2018 15:30:03 -0700
From:   "H. Peter Anvin (Intel)" <hpa@zytor.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 3/5] arch/mips, termios: use <asm-generic/termbits.h>
Date:   Thu,  4 Oct 2018 15:29:51 -0700
Message-Id: <20181004222953.2229-4-hpa@zytor.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181004222953.2229-1-hpa@zytor.com>
References: <20181004222953.2229-1-hpa@zytor.com>
Return-Path: <hpa@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66700
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The MIPS definition of termbits.h is almost identical to the generic
one, so use the generic one and only redefine a handful of constants.

Move TIOCSER_TEMT to ioctls.h where it lives for all other
architectures.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <linux-mips@linux-mips.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
---
 arch/mips/include/uapi/asm/ioctls.h   |   2 +
 arch/mips/include/uapi/asm/termbits.h | 213 +++-------------------------------
 2 files changed, 15 insertions(+), 200 deletions(-)

diff --git a/arch/mips/include/uapi/asm/ioctls.h b/arch/mips/include/uapi/asm/ioctls.h
index 890245a9f0c4..a4e11e1438b5 100644
--- a/arch/mips/include/uapi/asm/ioctls.h
+++ b/arch/mips/include/uapi/asm/ioctls.h
@@ -114,4 +114,6 @@
 #define TIOCMIWAIT	0x5491 /* wait for a change on serial input line(s) */
 #define TIOCGICOUNT	0x5492 /* read serial port inline interrupt counts */
 
+#define TIOCSER_TEMT	0x01	/* Transmitter physically empty */
+
 #endif /* __ASM_IOCTLS_H */
diff --git a/arch/mips/include/uapi/asm/termbits.h b/arch/mips/include/uapi/asm/termbits.h
index dfeffba729b7..a08fa0a697f5 100644
--- a/arch/mips/include/uapi/asm/termbits.h
+++ b/arch/mips/include/uapi/asm/termbits.h
@@ -11,218 +11,31 @@
 #ifndef _ASM_TERMBITS_H
 #define _ASM_TERMBITS_H
 
-#include <linux/posix_types.h>
+#define NCCS 23
+#include <asm-generic/termbits.h>
 
-typedef unsigned char cc_t;
-typedef unsigned int speed_t;
-typedef unsigned int tcflag_t;
-
-/*
- * The ABI says nothing about NCC but seems to use NCCS as
- * replacement for it in struct termio
- */
-#define NCCS	23
-struct termios {
-	tcflag_t c_iflag;		/* input mode flags */
-	tcflag_t c_oflag;		/* output mode flags */
-	tcflag_t c_cflag;		/* control mode flags */
-	tcflag_t c_lflag;		/* local mode flags */
-	cc_t c_line;			/* line discipline */
-	cc_t c_cc[NCCS];		/* control characters */
-};
-
-struct termios2 {
-	tcflag_t c_iflag;		/* input mode flags */
-	tcflag_t c_oflag;		/* output mode flags */
-	tcflag_t c_cflag;		/* control mode flags */
-	tcflag_t c_lflag;		/* local mode flags */
-	cc_t c_line;			/* line discipline */
-	cc_t c_cc[NCCS];		/* control characters */
-	speed_t c_ispeed;		/* input speed */
-	speed_t c_ospeed;		/* output speed */
-};
-
-struct ktermios {
-	tcflag_t c_iflag;		/* input mode flags */
-	tcflag_t c_oflag;		/* output mode flags */
-	tcflag_t c_cflag;		/* control mode flags */
-	tcflag_t c_lflag;		/* local mode flags */
-	cc_t c_line;			/* line discipline */
-	cc_t c_cc[NCCS];		/* control characters */
-	speed_t c_ispeed;		/* input speed */
-	speed_t c_ospeed;		/* output speed */
-};
-
-/* c_cc characters */
-#define VINTR		 0		/* Interrupt character [ISIG].	*/
-#define VQUIT		 1		/* Quit character [ISIG].  */
-#define VERASE		 2		/* Erase character [ICANON].  */
-#define VKILL		 3		/* Kill-line character [ICANON].  */
+/* c_cc characters that differ from the generic ABI */
+#undef VMIN
 #define VMIN		 4		/* Minimum number of bytes read at once [!ICANON].  */
-#define VTIME		 5		/* Time-out value (tenths of a second) [!ICANON].  */
+#undef VEOL2
 #define VEOL2		 6		/* Second EOL character [ICANON].  */
-#define VSWTC		 7		/* ??? */
-#define VSWTCH		VSWTC
-#define VSTART		 8		/* Start (X-ON) character [IXON, IXOFF].  */
-#define VSTOP		 9		/* Stop (X-OFF) character [IXON, IXOFF].  */
-#define VSUSP		10		/* Suspend character [ISIG].  */
-#if 0
-/*
- * VDSUSP is not supported
- */
-#define VDSUSP		11		/* Delayed suspend character [ISIG].  */
-#endif
-#define VREPRINT	12		/* Reprint-line character [ICANON].  */
-#define VDISCARD	13		/* Discard character [IEXTEN].	*/
-#define VWERASE		14		/* Word-erase character [ICANON].  */
-#define VLNEXT		15		/* Literal-next character [IEXTEN].  */
+#undef VEOF
 #define VEOF		16		/* End-of-file character [ICANON].  */
+#undef VEOL
 #define VEOL		17		/* End-of-line character [ICANON].  */
 
-/* c_iflag bits */
-#define IGNBRK	0000001		/* Ignore break condition.  */
-#define BRKINT	0000002		/* Signal interrupt on break.  */
-#define IGNPAR	0000004		/* Ignore characters with parity errors.  */
-#define PARMRK	0000010		/* Mark parity and framing errors.  */
-#define INPCK	0000020		/* Enable input parity check.  */
-#define ISTRIP	0000040		/* Strip 8th bit off characters.  */
-#define INLCR	0000100		/* Map NL to CR on input.  */
-#define IGNCR	0000200		/* Ignore CR.  */
-#define ICRNL	0000400		/* Map CR to NL on input.  */
-#define IUCLC	0001000		/* Map upper case to lower case on input.  */
-#define IXON	0002000		/* Enable start/stop output control.  */
-#define IXANY	0004000		/* Any character will restart after stop.  */
-#define IXOFF	0010000		/* Enable start/stop input control.  */
-#define IMAXBEL 0020000		/* Ring bell when input queue is full.	*/
-#define IUTF8	0040000		/* Input is UTF-8 */
-
-/* c_oflag bits */
-#define OPOST	0000001		/* Perform output processing.  */
-#define OLCUC	0000002		/* Map lower case to upper case on output.  */
-#define ONLCR	0000004		/* Map NL to CR-NL on output.  */
-#define OCRNL	0000010
-#define ONOCR	0000020
-#define ONLRET	0000040
-#define OFILL	0000100
-#define OFDEL	0000200
-#define NLDLY	0000400
-#define	  NL0	0000000
-#define	  NL1	0000400
-#define CRDLY	0003000
-#define	  CR0	0000000
-#define	  CR1	0001000
-#define	  CR2	0002000
-#define	  CR3	0003000
-#define TABDLY	0014000
-#define	  TAB0	0000000
-#define	  TAB1	0004000
-#define	  TAB2	0010000
-#define	  TAB3	0014000
-#define	  XTABS 0014000
-#define BSDLY	0020000
-#define	  BS0	0000000
-#define	  BS1	0020000
-#define VTDLY	0040000
-#define	  VT0	0000000
-#define	  VT1	0040000
-#define FFDLY	0100000
-#define	  FF0	0000000
-#define	  FF1	0100000
-/*
-#define PAGEOUT ???
-#define WRAP	???
- */
-
-/* c_cflag bit meaning */
-#define CBAUD	0010017
-#define	 B0	0000000		/* hang up */
-#define	 B50	0000001
-#define	 B75	0000002
-#define	 B110	0000003
-#define	 B134	0000004
-#define	 B150	0000005
-#define	 B200	0000006
-#define	 B300	0000007
-#define	 B600	0000010
-#define	 B1200	0000011
-#define	 B1800	0000012
-#define	 B2400	0000013
-#define	 B4800	0000014
-#define	 B9600	0000015
-#define	 B19200 0000016
-#define	 B38400 0000017
-#define EXTA B19200
-#define EXTB B38400
-#define CSIZE	0000060		/* Number of bits per byte (mask).  */
-#define	  CS5	0000000		/* 5 bits per byte.  */
-#define	  CS6	0000020		/* 6 bits per byte.  */
-#define	  CS7	0000040		/* 7 bits per byte.  */
-#define	  CS8	0000060		/* 8 bits per byte.  */
-#define CSTOPB	0000100		/* Two stop bits instead of one.  */
-#define CREAD	0000200		/* Enable receiver.  */
-#define PARENB	0000400		/* Parity enable.  */
-#define PARODD	0001000		/* Odd parity instead of even.	*/
-#define HUPCL	0002000		/* Hang up on last close.  */
-#define CLOCAL	0004000		/* Ignore modem status lines.  */
-#define CBAUDEX 0010000
-#define	   BOTHER 0010000
-#define	   B57600 0010001
-#define	  B115200 0010002
-#define	  B230400 0010003
-#define	  B460800 0010004
-#define	  B500000 0010005
-#define	  B576000 0010006
-#define	  B921600 0010007
-#define	 B1000000 0010010
-#define	 B1152000 0010011
-#define	 B1500000 0010012
-#define	 B2000000 0010013
-#define	 B2500000 0010014
-#define	 B3000000 0010015
-#define	 B3500000 0010016
-#define	 B4000000 0010017
-#define CIBAUD	  002003600000	/* input baud rate */
-#define CMSPAR	  010000000000	/* mark or space (stick) parity */
-#define CRTSCTS	  020000000000	/* flow control */
-
-#define IBSHIFT 16		/* Shift from CBAUD to CIBAUD */
-
-/* c_lflag bits */
-#define ISIG	0000001		/* Enable signals.  */
-#define ICANON	0000002		/* Do erase and kill processing.  */
-#define XCASE	0000004
-#define ECHO	0000010		/* Enable echo.	 */
-#define ECHOE	0000020		/* Visual erase for ERASE.  */
-#define ECHOK	0000040		/* Echo NL after KILL.	*/
-#define ECHONL	0000100		/* Echo NL even if ECHO is off.	 */
-#define NOFLSH	0000200		/* Disable flush after interrupt.  */
+/* c_lflag bits that differ from the generic ABI */
+#undef IEXTEN
 #define IEXTEN	0000400		/* Enable DISCARD and LNEXT.  */
-#define ECHOCTL 0001000		/* Echo control characters as ^X.  */
-#define ECHOPRT 0002000		/* Hardcopy visual erase.  */
-#define ECHOKE	0004000		/* Visual erase for KILL.  */
-#define FLUSHO	0020000
-#define PENDIN	0040000		/* Retype pending input (state).  */
+#undef TOSTOP
 #define TOSTOP	0100000		/* Send SIGTTOU for background output.	*/
-#define ITOSTOP TOSTOP
-#define EXTPROC 0200000		/* External processing on pty */
-
-/* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
-#define TIOCSER_TEMT	0x01	/* Transmitter physically empty */
-
-/* tcflow() and TCXONC use these */
-#define TCOOFF		0	/* Suspend output.  */
-#define TCOON		1	/* Restart suspended output.  */
-#define TCIOFF		2	/* Send a STOP character.  */
-#define TCION		3	/* Send a START character.  */
-
-/* tcflush() and TCFLSH use these */
-#define TCIFLUSH	0	/* Discard data received but not yet read.  */
-#define TCOFLUSH	1	/* Discard data written but not yet sent.  */
-#define TCIOFLUSH	2	/* Discard all pending data.  */
 
 /* tcsetattr uses these */
+#undef TCSANOW
 #define TCSANOW		TCSETS	/* Change immediately.	*/
+#undef TCSADRAIN
 #define TCSADRAIN	TCSETSW /* Change when pending output is written.  */
+#undef TCSAFLUSH
 #define TCSAFLUSH	TCSETSF /* Flush pending input before changing.	 */
 
 #endif /* _ASM_TERMBITS_H */
-- 
2.14.4
