Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Dec 2004 16:40:57 +0000 (GMT)
Received: from mail.alphastar.de ([IPv6:::ffff:194.59.236.179]:50194 "EHLO
	mail.alphastar.de") by linux-mips.org with ESMTP
	id <S8225233AbULTQkv>; Mon, 20 Dec 2004 16:40:51 +0000
Received: from Snailmail (212.144.142.207)
          by mail.alphastar.de with MERCUR Mailserver (v4.02.28 MTIxLTIxODAtNjY2OA==)
          for <linux-mips@linux-mips.org>; Mon, 20 Dec 2004 17:38:52 +0100
Received: from Opal.Peter (pf@Opal.Peter [192.168.1.1])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id iBKGcvYY000543;
	Mon, 20 Dec 2004 17:38:58 +0100
Received: from localhost (pf@localhost)
	by Opal.Peter (8.9.3/8.9.3/Sendmail/Linux 2.2.5-15) with ESMTP id RAA01203;
	Mon, 20 Dec 2004 17:38:42 +0100
Date: Mon, 20 Dec 2004 17:38:41 +0100 (CET)
From: peter fuerst <pf@net.alphadv.de>
To: linux-mips@linux-mips.org
cc: Ralf Baechle <ralf@linux-mips.org>
Subject: ip22zilog serial console
Message-ID: <Pine.LNX.4.21.0412201728440.1170-100000@Opal.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: pf@net.alphadv.de
Return-Path: <pf@net.alphadv.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@net.alphadv.de
Precedence: bulk
X-list: linux-mips



Hi,

there are two lines, which should be inserted into ip22zilog.c, to make
the serial-console work on IP2[82] as expected:

--- snip ---------------------------------------------------------------

--- ip22zilog.c	Fri Dec  3 06:07:38 2004
+++ ip22zilog.c	Mon Dec 20 02:07:42 2004
@@ -881,6 +881,7 @@
 	up->cflag = termios->c_cflag;
 
 	ip22zilog_maybe_update_regs(up, ZILOG_CHANNEL_FROM_PORT(port));
+	uart_update_timeout(port, termios->c_cflag, baud);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
@@ -1047,6 +1048,8 @@
 	}
 
 	con->cflag = cflag | CS8;			/* 8N1 */
+
+	uart_update_timeout(&ip22zilog_port_table[con->index].port, cflag, baud);
 }
 
 static int __init ip22zilog_console_setup(struct console *con, char *options)


--- snap ---------------------------------------------------------------

The reason for this can be found in drivers/serial/serial_core.c and
drivers/char/tty_ioctl.c (at least up to 2.6.10-rc2 / Rev. 1.13 and 1.20
respective):

1) serial_core.c: If port->timeout is less than HZ/50, a huge per
   character timeout 'char_time' will be calculated in
   uart_wait_until_sent(struct tty_struct*, int timeout).

2) (64bit only)
   tty_ioctl.c: tty_wait_until_sent(struct tty_struct*, long timeout) will
   call tty->driver->wait_until_sent() (->uart_wait_until_sent()) with a
   long timeout argument. So far, this is not critical, as long as all
   other relevant variables in uart_wait_until_sent() are unsigned...

Whenever port->ops->tx_empty() (ip22zilog_tx_empty()) doesn't succeed in
the first attempt, a msleep_interruptible(jiffies_to_msecs(char_time))
will be done (yes, this case isn't negligibly rare) ...
Two consequences could be observed:

1) 'timeout' is in the positive int range (here 30000) and will override
   the huge 'char_time' value. This leads to (e.g.) some nice 30sec delays
   in init.

2) ioctl(0,TCSETSF,...) makes tty_wait_until_sent() call
   tty->driver->wait_until_sent(tty,MAX_SCHEDULE_TIMEOUT),
   i.e.  uart_wait_until_sent(tty,-1).
   Now the huge 'char_time' takes effect, sending login to sleep, until
   it receives a SIGALRM, thus making a console-login impossible.

Since the majority of the serial drivers do not uart_update_timeout(), it
might be preferable to make uart_wait_until_sent() fool-proof (only a couple
of additional statements), instead of changing ip22zilog.c (alone), but i'm
in doubt, whether these changes would find their way.


with kind regards

pf


PS: in general, 2.6.10-rc2 + current linux-mips.org/arch/mips seems to be
far less hostile to IP28, than 2.6-version(s), i toiled with before :-)
