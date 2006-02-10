Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2006 20:54:54 +0000 (GMT)
Received: from omx1-ext.sgi.com ([192.48.179.11]:28119 "EHLO
	omx1.americas.sgi.com") by ftp.linux-mips.org with ESMTP
	id S8133592AbWBJUyp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Feb 2006 20:54:45 +0000
Received: from imr2.americas.sgi.com (imr2.americas.sgi.com [198.149.16.18])
	by omx1.americas.sgi.com (8.12.10/8.12.9/linux-outbound_gateway-1.1) with ESMTP id k1AL0EOX003774;
	Fri, 10 Feb 2006 15:00:15 -0600
Received: from poppy-e236.americas.sgi.com (poppy-e236.americas.sgi.com [128.162.236.207])
	by imr2.americas.sgi.com (8.12.9/8.12.10/SGI_generic_relay-1.2) with ESMTP id k1ALH0a513825180;
	Fri, 10 Feb 2006 13:17:00 -0800 (PST)
Received: from eagdhcp-232-152.americas.sgi.com (eagdhcp-232-152.americas.sgi.com [128.162.232.152]) by poppy-e236.americas.sgi.com (8.12.9/ASC-news-1.4) with ESMTP id k1AL0BSQ682424; Fri, 10 Feb 2006 15:00:13 -0600 (CST)
From:	Pat Gefre <pfg@sgi.com>
Organization: SGI
To:	Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
Date:	Fri, 10 Feb 2006 14:57:45 -0600
User-Agent: KMail/1.7.1
Cc:	Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org
References: <20060121211407.GA19984@dyn-67.arm.linux.org.uk> <20060210084445.GA1947@flint.arm.linux.org.uk>
In-Reply-To: <20060210084445.GA1947@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602101457.45847.pfg@sgi.com>
Return-Path: <pfg@sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pfg@sgi.com
Precedence: bulk
X-list: linux-mips

 
Yeah this is something I should've fixed up... thanks

Acked-by: pfg@sgi.com



On Fri February 10 2006 2:44 am, Russell King wrote:
> On Sat, Jan 21, 2006 at 09:14:07PM +0000, Russell King wrote:
> > The ioc4_serial driver is worse.  It assumes that it can set/clear
> > ASYNC_CTS_FLOW in the uart_info flags field, which is private to
> > serial_core.  It also seems to set TTY_IO_ERROR followed by immediately
> > clearing it (pointless), and then it writes to tty->alt_speed... which
> > isn't used by the serial layer so is also pointless.
>
> Okay, the only remaining part of this patch which hasn't been applied
> is this - can anyone ack it?
>
> diff --git a/drivers/serial/ioc4_serial.c b/drivers/serial/ioc4_serial.c
> --- a/drivers/serial/ioc4_serial.c
> +++ b/drivers/serial/ioc4_serial.c
> @@ -1717,11 +1717,9 @@ ioc4_change_speed(struct uart_port *the_
>  	}
>
>  	if (cflag & CRTSCTS) {
> -		info->flags |= ASYNC_CTS_FLOW;
>  		port->ip_sscr |= IOC4_SSCR_HFC_EN;
>  	}
>  	else {
> -		info->flags &= ~ASYNC_CTS_FLOW;
>  		port->ip_sscr &= ~IOC4_SSCR_HFC_EN;
>  	}
>  	writel(port->ip_sscr, &port->ip_serial_regs->sscr);
> @@ -1760,18 +1758,6 @@ static inline int ic4_startup_local(stru
>
>  	info = the_port->info;
>
> -	if (info->tty) {
> -		set_bit(TTY_IO_ERROR, &info->tty->flags);
> -		clear_bit(TTY_IO_ERROR, &info->tty->flags);
> -		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
> -			info->tty->alt_speed = 57600;
> -		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
> -			info->tty->alt_speed = 115200;
> -		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_SHI)
> -			info->tty->alt_speed = 230400;
> -		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_WARP)
> -			info->tty->alt_speed = 460800;
> -	}
>  	local_open(port);
>
>  	/* set the speed of the serial port */
