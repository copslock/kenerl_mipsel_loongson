Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2005 20:03:48 +0000 (GMT)
Received: from mail.alphastar.de ([IPv6:::ffff:194.59.236.179]:22533 "EHLO
	mail.alphastar.de") by linux-mips.org with ESMTP
	id <S8229673AbVCYUDc>; Fri, 25 Mar 2005 20:03:32 +0000
Received: by mail.alphastar.de with MERCUR Mailserver (v4.02.28 MTIxLTIxODAtNjY2OA==) for <linux-mips@linux-mips.org>; Fri, 25 Mar 2005 21:01:23 +0100
Received: from Opal.Peter (pf@Opal.Peter [192.168.1.1])
	by SNaIlmail.Peter (8.12.6/8.12.6/Sendmail/Linux 2.0.32) with ESMTP id j2PK0LrM000544;
	Fri, 25 Mar 2005 21:00:21 +0100
Received: from localhost (pf@localhost)
	by Opal.Peter (8.9.3/8.9.3/Sendmail/Linux 2.2.5-15) with ESMTP id UAA00787;
	Fri, 25 Mar 2005 20:59:59 +0100
Date:	Fri, 25 Mar 2005 20:59:59 +0100 (CET)
From:	peter fuerst <pf@net.alphadv.de>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: [PATCH] serial console (drivers/serial/ip22zilog.c)
Message-ID: <Pine.LNX.4.21.0503252056350.775-100000@Opal.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: pf@net.alphadv.de
Return-Path: <pf@net.alphadv.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7526
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pf@net.alphadv.de
Precedence: bulk
X-list: linux-mips



Hi,

here's a patch to make serial console work on IP2X machines.  I submitted
it already on Dec 20, Kaj-Michael Lang submitted it again on Feb 14, but
somehow it didn't find its way into CVS yet.  Please apply. Thank you.

with best regards

pf

--- snip ---------------------------------------------------------------

diff -Nau -b -B drivers/serial/ip22zilog.c.1.16 drivers/serial/ip22zilog.c
--- drivers/serial/ip22zilog.c.1.16	Fri Dec  3 06:07:38 2004
+++ drivers/serial/ip22zilog.c	Sat Feb 12 15:14:48 2005
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
