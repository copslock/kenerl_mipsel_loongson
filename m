Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2006 08:39:04 +0000 (GMT)
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33805 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133361AbWBJIiy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Feb 2006 08:38:54 +0000
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1F7TtE-0007pV-5i; Fri, 10 Feb 2006 08:44:28 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1F7TtV-0000Va-Pd; Fri, 10 Feb 2006 08:44:45 +0000
Date:	Fri, 10 Feb 2006 08:44:45 +0000
From:	Russell King <rmk+lkml@arm.linux.org.uk>
To:	Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org, pfg@sgi.com
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
Message-ID: <20060210084445.GA1947@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org, pfg@sgi.com
References: <20060121211407.GA19984@dyn-67.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060121211407.GA19984@dyn-67.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk+lkml@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Sat, Jan 21, 2006 at 09:14:07PM +0000, Russell King wrote:
> The ioc4_serial driver is worse.  It assumes that it can set/clear
> ASYNC_CTS_FLOW in the uart_info flags field, which is private to
> serial_core.  It also seems to set TTY_IO_ERROR followed by immediately
> clearing it (pointless), and then it writes to tty->alt_speed... which
> isn't used by the serial layer so is also pointless.

Okay, the only remaining part of this patch which hasn't been applied
is this - can anyone ack it?

diff --git a/drivers/serial/ioc4_serial.c b/drivers/serial/ioc4_serial.c
--- a/drivers/serial/ioc4_serial.c
+++ b/drivers/serial/ioc4_serial.c
@@ -1717,11 +1717,9 @@ ioc4_change_speed(struct uart_port *the_
 	}
 
 	if (cflag & CRTSCTS) {
-		info->flags |= ASYNC_CTS_FLOW;
 		port->ip_sscr |= IOC4_SSCR_HFC_EN;
 	}
 	else {
-		info->flags &= ~ASYNC_CTS_FLOW;
 		port->ip_sscr &= ~IOC4_SSCR_HFC_EN;
 	}
 	writel(port->ip_sscr, &port->ip_serial_regs->sscr);
@@ -1760,18 +1758,6 @@ static inline int ic4_startup_local(stru
 
 	info = the_port->info;
 
-	if (info->tty) {
-		set_bit(TTY_IO_ERROR, &info->tty->flags);
-		clear_bit(TTY_IO_ERROR, &info->tty->flags);
-		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
-			info->tty->alt_speed = 57600;
-		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
-			info->tty->alt_speed = 115200;
-		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_SHI)
-			info->tty->alt_speed = 230400;
-		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_WARP)
-			info->tty->alt_speed = 460800;
-	}
 	local_open(port);
 
 	/* set the speed of the serial port */

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
