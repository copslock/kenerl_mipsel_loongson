Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Feb 2005 13:53:14 +0000 (GMT)
Received: from gw01.mail.saunalahti.fi ([IPv6:::ffff:195.197.172.115]:38859
	"EHLO gw01.mail.saunalahti.fi") by linux-mips.org with ESMTP
	id <S8224934AbVBNNw6>; Mon, 14 Feb 2005 13:52:58 +0000
Received: from tori.tal.org (tori.tal.org [195.16.220.82])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id 375C0D906E;
	Mon, 14 Feb 2005 15:52:54 +0200 (EET)
Date:	Mon, 14 Feb 2005 15:56:41 +0000 (Local time zone must be set--see zic manual page)
From:	Kaj-Michael Lang <milang@tal.org>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] IP22 zilog timeout fix
Message-ID: <Pine.LNX.4.61.0502141555260.24829@tori.tal.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <milang@tal.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: milang@tal.org
Precedence: bulk
X-list: linux-mips

Peter Fuerst posted this fix sometime in December already, but
looks like it's not in CVS yet.
Without this fix, serial console is impossbile to use as login
never shows a prompt and output from userland is also slow.


Index: drivers/serial/ip22zilog.c
===================================================================
RCS file: /home/cvs/linux/drivers/serial/ip22zilog.c,v
retrieving revision 1.16
diff -u -r1.16 ip22zilog.c
--- drivers/serial/ip22zilog.c	3 Dec 2004 06:07:38 -0000	1.16
+++ drivers/serial/ip22zilog.c	14 Feb 2005 13:47:08 -0000
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



-- 
Kaj-Michael Lang, Turku, Finland
milang@tal.org http://www.tal.org/
