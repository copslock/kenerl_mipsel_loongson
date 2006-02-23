Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 22:07:26 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:2321 "EHLO sorrow.cyrius.com")
	by ftp.linux-mips.org with ESMTP id S8133545AbWBWWHR (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 23 Feb 2006 22:07:17 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 3D14F64D3D; Thu, 23 Feb 2006 22:14:06 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 8C6BE8F8D; Thu, 23 Feb 2006 22:13:50 +0000 (GMT)
Date:	Thu, 23 Feb 2006 22:13:50 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	jblache@debian.org, rmk+serial@arm.linux.org.uk
Subject: Re: IP22 doesn't shutdown properly
Message-ID: <20060223221350.GA5239@deprecation.cyrius.com>
References: <20060217225824.GE20785@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217225824.GE20785@deprecation.cyrius.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10629
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Martin Michlmayr <tbm@cyrius.com> [2006-02-17 22:58]:
> When you try to shutdown or reboot an IP22 with 2.6.15 or 2.6.16-rc2,
> you see that the TERM signal is sent but then nothing happens.  At the
> beginning, the light on the Indy is green but after about 20 seconds
> it turns red.  Nothing happens on the console and the machine doesn't
> turn off.  Seen on Indy and Indigo2.
[and, as mentioned later, this only happens on serial, not when using
the bf]

I've tracked down now while the old 2.6.12 Debian package shut down
correctly while no recent git does.  The following simple change to
the serial driver makes the difference for me:

--- a/drivers/serial/serial_core.c~	2006-02-23 21:58:51.000000000 +0000
+++ b/drivers/serial/serial_core.c	2006-02-23 21:59:14.000000000 +0000
@@ -108,7 +108,8 @@
 static void uart_tasklet_action(unsigned long data)
 {
 	struct uart_state *state = (struct uart_state *)data;
-	tty_wakeup(state->info->tty);
+	if (state->info->tty)
+		tty_wakeup(state->info->tty);
 }
 
 static inline void

I cannot easily check why this change was in Debian's 2.6.12 package
nor why it's not in Linus' git.  Russell, can you say whether this
change looks obviously good to you?  If not, I can dig some more and
see why this change was in our 2.6.12 package.

In any case, with this patch applied, the SGI Indy in serial mode
powers down correctly.  Without the patch, it stops as in the example
below and never turns off:

> sgi:~# shutdown -r now
> 
> Broadcast message from root (ttyS0) (Fri Feb 17 22:52:47 2006):
> 
> The system is going down for reboot NOW!
> INIT: Sending processes the TERM signal
> INIT: Sending proces

This is with:

CONFIG_SERIAL_IP22_ZILOG=y
CONFIG_SERIAL_IP22_ZILOG_CONSOLE=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y

-- 
Martin Michlmayr
http://www.cyrius.com/
