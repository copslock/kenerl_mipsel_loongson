Received:  by oss.sgi.com id <S553761AbQJMKQb>;
	Fri, 13 Oct 2000 03:16:31 -0700
Received: from u-70.karlsruhe.ipdial.viaginterkom.de ([62.180.19.70]:31496
        "EHLO u-70.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553678AbQJMKQM>; Fri, 13 Oct 2000 03:16:12 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869815AbQJMJ40>;
        Fri, 13 Oct 2000 11:56:26 +0200
Date:   Fri, 13 Oct 2000 11:56:26 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Randy Sartin <randys@ridgerun.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: rs_ioctl() in sgiserial.c info/help needed
Message-ID: <20001013115626.A26588@bacchus.dhis.org>
References: <NEBBLGAKILMAGOFHJDNNGEJMCAAA.randys@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <NEBBLGAKILMAGOFHJDNNGEJMCAAA.randys@ridgerun.com>; from randys@ridgerun.com on Wed, Oct 11, 2000 at 01:28:05PM -0600
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Oct 11, 2000 at 01:28:05PM -0600, Randy Sartin wrote:

> Background:
> I am trying to get the Indy's serial port to drive a dongle and am having
> some trouble getting the dongle to work. The problem seems to be in
> rs_ioctl() in sgiserial.c - it doesn't handle the TIOCMSET command. The
> TIOCMSET command allows control over the DTR and RTS lines.
> 
> The "standard" rs_ioctl() in serial.c does support TIOCMSET. It calls
> set_modem_info() to control the UART (I think) to then control DTR and RTS.
> 
> So - my question is...
> Can I control DTR and RTS on Indy or is this a software feature that hasn't
> been implemented yet?

Not implemented yet.  The Indy serial driver is derived from a prehistoric
version of the Sparc zs driver which didn't have that feature yet.  It
looked easy to transplant it into sgiserial, so here we go.

I'm attaching a a untested kernel patch agaist a current 2.4.0-test9 kernel
which will add this feature.  Untested because my Indy powersupply seems to
have died.

  Ralf

diff -ur orion.work/drivers/sgi/char/sgiserial.c linux-sgi/drivers/sgi/char/sgiserial.c
--- orion.work/drivers/sgi/char/sgiserial.c	Sat Jul  8 05:02:25 2000
+++ linux-sgi/drivers/sgi/char/sgiserial.c	Fri Oct 13 11:27:49 2000
@@ -147,7 +147,7 @@
 	static const char *badmagic =
 		"Warning: bad magic number for serial struct (%d, %d) in %s\n";
 	static const char *badinfo =
-		"Warning: null sun_serial for (%d, %d) in %s\n";
+		"Warning: null sgi_serial for (%d, %d) in %s\n";
 
 	if (!info) {
 		printk(badinfo, MAJOR(device), MINOR(device), routine);
@@ -178,7 +178,8 @@
  * interrupts are enabled. Therefore we have to check ioc_iocontrol before we
  * access it.
  */
-static inline unsigned char read_zsreg(struct sgi_zschannel *channel, unsigned char reg)
+static inline unsigned char read_zsreg(struct sgi_zschannel *channel,
+                                       unsigned char reg)
 {
 	unsigned char retval;
 	volatile unsigned char junk;
@@ -192,7 +193,8 @@
 	return retval;
 }
 
-static inline void write_zsreg(struct sgi_zschannel *channel, unsigned char reg, unsigned char value)
+static inline void write_zsreg(struct sgi_zschannel *channel,
+                               unsigned char reg, unsigned char value)
 {
 	volatile unsigned char junk;
 
@@ -1302,6 +1304,59 @@
 	junk = ioc_icontrol->istat0;
 	sti();
 	return put_user(status,value);
+} 
+
+static int get_modem_info(struct sgi_serial * info, unsigned int *value)
+{
+	unsigned char status;
+	unsigned int result;
+
+	cli();
+	status = info->zs_channel->control;
+	udelay(2);
+	sti();
+	result =  ((info->curregs[5] & RTS) ? TIOCM_RTS : 0)
+		| ((info->curregs[5] & DTR) ? TIOCM_DTR : 0)
+		| ((status  & DCD) ? TIOCM_CAR : 0)
+		| ((status  & SYNC) ? TIOCM_DSR : 0)
+		| ((status  & CTS) ? TIOCM_CTS : 0);
+	if (put_user(result, value))
+		return -EFAULT;
+	return 0;
+}
+
+static int set_modem_info(struct sgi_serial * info, unsigned int cmd,
+			  unsigned int *value)
+{
+	unsigned int arg;
+
+	if (get_user(arg, value))
+		return -EFAULT;
+	switch (cmd) {
+	case TIOCMBIS: 
+		if (arg & TIOCM_RTS)
+			info->curregs[5] |= RTS;
+		if (arg & TIOCM_DTR)
+			info->curregs[5] |= DTR;
+		break;
+	case TIOCMBIC:
+		if (arg & TIOCM_RTS)
+			info->curregs[5] &= ~RTS;
+		if (arg & TIOCM_DTR)
+			info->curregs[5] &= ~DTR;
+		break;
+	case TIOCMSET:
+		info->curregs[5] = ((info->curregs[5] & ~(RTS | DTR))
+			     | ((arg & TIOCM_RTS) ? RTS : 0)
+			     | ((arg & TIOCM_DTR) ? DTR : 0));
+		break;
+	default:
+		return -EINVAL;
+	}
+	cli();
+	write_zsreg(info->zs_channel, 5, info->curregs[5]);
+	sti();
+	return 0;
 }
 
 /*
@@ -1322,11 +1377,10 @@
 static int rs_ioctl(struct tty_struct *tty, struct file * file,
 		    unsigned int cmd, unsigned long arg)
 {
-	int error;
-	struct sgi_serial * info = (struct sgi_serial *)tty->driver_data;
+	struct sgi_serial * info = (struct sgi_serial *) tty->driver_data;
 	int retval;
 
-	if (serial_paranoia_check(info, tty->device, "rs_ioctl"))
+	if (serial_paranoia_check(info, tty->device, "zs_ioctl"))
 		return -ENODEV;
 
 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
@@ -1353,45 +1407,36 @@
 			send_break(info, arg ? arg*(HZ/10) : HZ/4);
 			return 0;
 		case TIOCGSOFTCAR:
-			error = verify_area(VERIFY_WRITE, (void *) arg,sizeof(long));
-			if (error)
-				return error;
-			put_user(C_CLOCAL(tty) ? 1 : 0,
-			         (unsigned long *) arg);
+			if (put_user(C_CLOCAL(tty) ? 1 : 0,
+				     (unsigned long *) arg))
+				return -EFAULT;
 			return 0;
 		case TIOCSSOFTCAR:
-			error = get_user(arg, (unsigned long *)arg);
-			if (error)
-				return error;
+			if (get_user(arg, (unsigned long *) arg))
+				return -EFAULT;
 			tty->termios->c_cflag =
 				((tty->termios->c_cflag & ~CLOCAL) |
 				 (arg ? CLOCAL : 0));
 			return 0;
+		case TIOCMGET:
+			return get_modem_info(info, (unsigned int *) arg);
+		case TIOCMBIS:
+		case TIOCMBIC:
+		case TIOCMSET:
+			return set_modem_info(info, cmd, (unsigned int *) arg);
 		case TIOCGSERIAL:
-			error = verify_area(VERIFY_WRITE, (void *) arg,
-						sizeof(struct serial_struct));
-			if (error)
-				return error;
 			return get_serial_info(info,
 					       (struct serial_struct *) arg);
 		case TIOCSSERIAL:
 			return set_serial_info(info,
 					       (struct serial_struct *) arg);
 		case TIOCSERGETLSR: /* Get line status register */
-			error = verify_area(VERIFY_WRITE, (void *) arg,
-				sizeof(unsigned int));
-			if (error)
-				return error;
-			else
-			    return get_lsr_info(info, (unsigned int *) arg);
+			return get_lsr_info(info, (unsigned int *) arg);
 
 		case TIOCSERGSTRUCT:
-			error = verify_area(VERIFY_WRITE, (void *) arg,
-						sizeof(struct sgi_serial));
-			if (error)
-				return error;
-			copy_to_user((struct sun_serial *) arg,
-				    info, sizeof(struct sgi_serial));
+			if (copy_to_user((struct sgi_serial *) arg,
+				    info, sizeof(struct sgi_serial)))
+				return -EFAULT;
 			return 0;
 			
 		default:
diff -ur orion.work/drivers/sgi/char/sgiserial.h linux-sgi/drivers/sgi/char/sgiserial.h
--- orion.work/drivers/sgi/char/sgiserial.h	Thu Jun 17 15:29:04 1999
+++ linux-sgi/drivers/sgi/char/sgiserial.h	Fri Oct 13 11:34:22 2000
@@ -359,7 +359,7 @@
 #define	ZCOUNT		0x2	/* Zero count */
 #define	Tx_BUF_EMP	0x4	/* Tx Buffer empty */
 #define	DCD		0x8	/* DCD */
-#define	SYNC_HUNT	0x10	/* Sync/hunt */
+#define	SYNC		0x10	/* Sync/hunt */
 #define	CTS		0x20	/* CTS */
 #define	TxEOM		0x40	/* Tx underrun */
 #define	BRK_ABRT	0x80	/* Break/Abort */
