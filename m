Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 22:36:48 +0000 (GMT)
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2579 "EHLO
	caramon.arm.linux.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133740AbWBWWgi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 22:36:38 +0000
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.52)
	id 1FCPBc-0003Rb-Ju; Thu, 23 Feb 2006 22:43:49 +0000
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.52)
	id 1FCPBa-00023Y-Lh; Thu, 23 Feb 2006 22:43:46 +0000
Date:	Thu, 23 Feb 2006 22:43:46 +0000
From:	Russell King <rmk@arm.linux.org.uk>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org, jblache@debian.org
Subject: Re: IP22 doesn't shutdown properly
Message-ID: <20060223224346.GA7536@flint.arm.linux.org.uk>
References: <20060217225824.GE20785@deprecation.cyrius.com> <20060223221350.GA5239@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060223221350.GA5239@deprecation.cyrius.com>
User-Agent: Mutt/1.4.1i
Return-Path: <rmk+linux-mips=linux-mips.org@arm.linux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmk@arm.linux.org.uk
Precedence: bulk
X-list: linux-mips

On Thu, Feb 23, 2006 at 10:13:50PM +0000, Martin Michlmayr wrote:
> I've tracked down now while the old 2.6.12 Debian package shut down
> correctly while no recent git does.  The following simple change to
> the serial driver makes the difference for me:
> 
> --- a/drivers/serial/serial_core.c~	2006-02-23 21:58:51.000000000 +0000
> +++ b/drivers/serial/serial_core.c	2006-02-23 21:59:14.000000000 +0000
> @@ -108,7 +108,8 @@
>  static void uart_tasklet_action(unsigned long data)
>  {
>  	struct uart_state *state = (struct uart_state *)data;
> -	tty_wakeup(state->info->tty);
> +	if (state->info->tty)
> +		tty_wakeup(state->info->tty);
>  }
>  
>  static inline void
> 
> I cannot easily check why this change was in Debian's 2.6.12 package
> nor why it's not in Linus' git.  Russell, can you say whether this
> change looks obviously good to you?  If not, I can dig some more and
> see why this change was in our 2.6.12 package.

This looks like a case of a fix to work around some bad behaviour in
a driver.

When serial_core calls the drivers shutdown() method, it expects that
will shut the driver up completely - no further interrupts from that
point in, no further calls from the driver into the tty or serial_core
subsystems for this port.

Once the drivers shutdown() method has returned, we ensure there are
no pending interrupts, and then kill off the tasklet.

Sometime later, we NULL state->info->tty.

Hence, if you're seeing a call into uart_tasklet_action() with a NULL
tty, that means some driver called uart_write_wakeup() _after_ its
shutdown method completed.  That's a driver bug, not a serial_core
bug - as I say above, the above patch is a workaround for a buggy
driver.

Looking at the ip22 driver, it seems that if shutdown() is called for
the console port, the driver does _nothing_.  That's the bug - it will
still call (eg) uart_write_wakeup() after shutdown(), which is a
violation of the assumptions (set out above).

I would not be surprised therefore if you got an oops.

What I might consider is a patch to add BUG_ON(!info->tty) in
uart_write_wakeup() to catch these cases earlier and to provide
folk with a better hint that the bug is _not_ in the core serial
driver.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
