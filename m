Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2003 02:59:19 +0000 (GMT)
Received: from cm19173.red.mundo-r.com ([IPv6:::ffff:213.60.19.173]:18563 "EHLO
	neno.mitica") by linux-mips.org with ESMTP id <S8225236AbTC0C4d>;
	Thu, 27 Mar 2003 02:56:33 +0000
Received: by neno.mitica (Postfix, from userid 501)
	id C2CF546A59; Thu, 27 Mar 2003 03:55:03 +0100 (CET)
To: Ralf Baechle <ralf@linux-mips.org>,
	mipslist <linux-mips@linux-mips.org>
Subject: [PATCH]: sgiserial 7/7: ->pendregs is a WOV
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
Date: Thu, 27 Mar 2003 03:55:03 +0100
Message-ID: <m2vfy5cyd4.fsf@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <quintela@mandrakesoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: quintela@mandrakesoft.com
Precedence: bulk
X-list: linux-mips


Hi

->peonages[] array is a WO variable.


 build/drivers/sgi/char/sgiserial.c |   49 ++++++-------------------------------
 build/drivers/sgi/char/sgiserial.h |    3 --
 2 files changed, 8 insertions(+), 44 deletions(-)

diff -puN build/drivers/sgi/char/sgiserial.c~sgiserial_remove_pendregs build/drivers/sgi/char/sgiserial.c
--- 24/build/drivers/sgi/char/sgiserial.c~sgiserial_remove_pendregs	2003-03-26 18:54:23.000000000 +0100
+++ 24-quintela/build/drivers/sgi/char/sgiserial.c	2003-03-26 18:54:23.000000000 +0100
@@ -223,11 +223,9 @@ static inline void zs_rtsdtr(struct sgi_
 {
 	if(set) {
 		ss->curregs[5] |= (RTS | DTR);
-		ss->pendregs[5] = ss->curregs[5];
 		write_zsreg(ss->zs_channel, 5, ss->curregs[5]);
 	} else {
 		ss->curregs[5] &= ~(RTS | DTR);
-		ss->pendregs[5] = ss->curregs[5];
 		write_zsreg(ss->zs_channel, 5, ss->curregs[5]);
 	}
 	return;
@@ -285,7 +283,6 @@ static void rs_stop(struct tty_struct *t
 	save_flags(flags); cli();
 	if (info->curregs[5] & TxENAB) {
 		info->curregs[5] &= ~TxENAB;
-		info->pendregs[5] &= ~TxENAB;
 		write_zsreg(info->zs_channel, 5, info->curregs[5]);
 	}
 	restore_flags(flags);
@@ -302,7 +299,6 @@ static void rs_start(struct tty_struct *
 	save_flags(flags); cli();
 	if (info->xmit_cnt && info->xmit_buf && !(info->curregs[5] & TxENAB)) {
 		info->curregs[5] |= TxENAB;
-		info->pendregs[5] = info->curregs[5];
 		write_zsreg(info->zs_channel, 5, info->curregs[5]);
 	}
 	restore_flags(flags);
@@ -527,13 +523,11 @@ static inline void status_handle(struct 
 		if((info->tty->termios->c_cflag & CRTSCTS) &&
 		   ((info->curregs[3] & AUTO_ENAB)==0)) {
 			info->curregs[3] |= AUTO_ENAB;
-			info->pendregs[3] |= AUTO_ENAB;
 			write_zsreg(info->zs_channel, 3, info->curregs[3]);
 		}
 	} else {
 		if((info->curregs[3] & AUTO_ENAB)) {
 			info->curregs[3] &= ~AUTO_ENAB;
-			info->pendregs[3] &= ~AUTO_ENAB;
 			write_zsreg(info->zs_channel, 3, info->curregs[3]);
 		}
 	}
@@ -699,14 +693,10 @@ static int startup(struct sgi_serial * i
 	 * Finally, enable sequencing and interrupts
 	 */
 	info->curregs[1] |= (info->curregs[1] & ~0x18) | (EXT_INT_ENAB|INT_ALL_Rx);
-	info->pendregs[1] = info->curregs[1];
 	info->curregs[3] |= (RxENABLE | Rx8);
-	info->pendregs[3] = info->curregs[3];
 	/* We enable Tx interrupts as needed. */
 	info->curregs[5] |= (TxENAB | Tx8);
-	info->pendregs[5] = info->curregs[5];
 	info->curregs[9] |= (NV | MIE);
-	info->pendregs[9] = info->curregs[9];
 	write_zsreg(info->zs_channel, 3, info->curregs[3]);
 	write_zsreg(info->zs_channel, 5, info->curregs[5]);
 	write_zsreg(info->zs_channel, 9, info->curregs[9]);
@@ -808,58 +798,44 @@ static void change_speed(struct sgi_seri
 	case CS5:
 		info->curregs[3] &= ~(0xc0);
 		info->curregs[3] |= Rx5;
-		info->pendregs[3] = info->curregs[3];
 		info->curregs[5] &= ~(0xe0);
 		info->curregs[5] |= Tx5;
-		info->pendregs[5] = info->curregs[5];
 		break;
 	case CS6:
 		info->curregs[3] &= ~(0xc0);
 		info->curregs[3] |= Rx6;
-		info->pendregs[3] = info->curregs[3];
 		info->curregs[5] &= ~(0xe0);
 		info->curregs[5] |= Tx6;
-		info->pendregs[5] = info->curregs[5];
 		break;
 	case CS7:
 		info->curregs[3] &= ~(0xc0);
 		info->curregs[3] |= Rx7;
-		info->pendregs[3] = info->curregs[3];
 		info->curregs[5] &= ~(0xe0);
 		info->curregs[5] |= Tx7;
-		info->pendregs[5] = info->curregs[5];
 		break;
 	case CS8:
 	default: /* defaults to 8 bits */
 		info->curregs[3] &= ~(0xc0);
 		info->curregs[3] |= Rx8;
-		info->pendregs[3] = info->curregs[3];
 		info->curregs[5] &= ~(0xe0);
 		info->curregs[5] |= Tx8;
-		info->pendregs[5] = info->curregs[5];
 		break;
 	}
 	info->curregs[4] &= ~(0x0c);
-	if (cflag & CSTOPB) {
+	if (cflag & CSTOPB)
 		info->curregs[4] |= SB2;
-	} else {
+	else
 		info->curregs[4] |= SB1;
-	}
-	info->pendregs[4] = info->curregs[4];
-	if (cflag & PARENB) {
+
+	if (cflag & PARENB)
 		info->curregs[4] |= PAR_ENA;
-		info->pendregs[4] |= PAR_ENA;
-	} else {
+	else
 		info->curregs[4] &= ~PAR_ENA;
-		info->pendregs[4] &= ~PAR_ENA;
-	}
-	if (!(cflag & PARODD)) {
+
+	if (!(cflag & PARODD))
 		info->curregs[4] |= PAR_EVEN;
-		info->pendregs[4] |= PAR_EVEN;
-	} else {
+	else
 		info->curregs[4] &= ~PAR_EVEN;
-		info->pendregs[4] &= ~PAR_EVEN;
-	}
 
 	/* Load up the new values */
 	load_zsregs(info->zs_channel, info->curregs);
@@ -1037,10 +1013,8 @@ static int rs_write(struct tty_struct * 
 	 */
 		/* Enable transmitter */
 		info->curregs[1] |= TxINT_ENAB|EXT_INT_ENAB;
-		info->pendregs[1] |= TxINT_ENAB|EXT_INT_ENAB;
 		write_zsreg(info->zs_channel, 1, info->curregs[1]);
 		info->curregs[5] |= TxENAB;
-		info->pendregs[5] |= TxENAB;
 		write_zsreg(info->zs_channel, 5, info->curregs[5]);
 
 	/*
@@ -1113,10 +1087,8 @@ static void rs_flush_chars(struct tty_st
 	/* Enable transmitter */
 	save_flags(flags); cli();
 	info->curregs[1] |= TxINT_ENAB|EXT_INT_ENAB;
-	info->pendregs[1] |= TxINT_ENAB|EXT_INT_ENAB;
 	write_zsreg(info->zs_channel, 1, info->curregs[1]);
 	info->curregs[5] |= TxENAB;
-	info->pendregs[5] |= TxENAB;
 	write_zsreg(info->zs_channel, 5, info->curregs[5]);
 
 	/*
@@ -1166,7 +1138,6 @@ static void rs_throttle(struct tty_struc
 	/* Turn off RTS line */
 	cli();
 	info->curregs[5] &= ~RTS;
-	info->pendregs[5] &= ~RTS;
 	write_zsreg(info->zs_channel, 5, info->curregs[5]);
 	sti();
 }
@@ -1194,7 +1165,6 @@ static void rs_unthrottle(struct tty_str
 	/* Assert RTS line */
 	cli();
 	info->curregs[5] |= RTS;
-	info->pendregs[5] |= RTS;
 	write_zsreg(info->zs_channel, 5, info->curregs[5]);
 	sti();
 }
@@ -1521,10 +1491,8 @@ static void rs_close(struct tty_struct *
 	 */
 	/** if (!info->iscons) ... **/
 	info->curregs[3] &= ~RxENABLE;
-	info->pendregs[3] = info->curregs[3];
 	write_zsreg(info->zs_channel, 3, info->curregs[3]);
 	info->curregs[1] &= ~(0x18);
-	info->pendregs[1] = info->curregs[1];
 	write_zsreg(info->zs_channel, 1, info->curregs[1]);
 	ZS_CLEARFIFO(info->zs_channel);
 
@@ -2245,7 +2213,6 @@ static int __init zs_console_setup(struc
 	zscons_regs[12] = brg & 0xff;
 	zscons_regs[13] = (brg >> 8) & 0xff;
 	memcpy(info->curregs, zscons_regs, sizeof(zscons_regs));
-	memcpy(info->pendregs, zscons_regs, sizeof(zscons_regs));
 	load_zsregs(info->zs_channel, zscons_regs);
 	ZS_CLEARERR(info->zs_channel);
 	ZS_CLEARFIFO(info->zs_channel);
diff -puN build/drivers/sgi/char/sgiserial.h~sgiserial_remove_pendregs build/drivers/sgi/char/sgiserial.h
--- 24/build/drivers/sgi/char/sgiserial.h~sgiserial_remove_pendregs	2003-03-26 18:54:23.000000000 +0100
+++ 24-quintela/build/drivers/sgi/char/sgiserial.h	2003-03-26 18:54:23.000000000 +0100
@@ -122,9 +122,6 @@ struct sgi_serial {
 	/* Current write register values */
 	unsigned char curregs[NUM_ZSREGS];
 
-	/* Values we need to set next opportunity */
-	unsigned char pendregs[NUM_ZSREGS];
-
 	char change_needed;
 
 	int			magic;

_


-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
