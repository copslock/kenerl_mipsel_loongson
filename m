Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Dec 2007 23:10:41 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:16567 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030483AbXLCXKj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 3 Dec 2007 23:10:39 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lB3N8U7u018763;
	Mon, 3 Dec 2007 23:08:55 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lB3N8S20018762;
	Mon, 3 Dec 2007 23:08:28 GMT
Date:	Mon, 3 Dec 2007 23:08:28 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andrew Sharp <andy.sharp@onstor.com>
Cc:	linux-mips@linux-mips.org, akpm@linux-foundation.org, wim@iguana.be
Subject: Re: [PATCH] Add support for SB1 hardware watchdog.
Message-ID: <20071203230828.GA17960@linux-mips.org>
References: <20071203181658.GA26631@onstor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20071203181658.GA26631@onstor.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Dec 03, 2007 at 10:17:04AM -0800, Andrew Sharp wrote:

> +	  Watchdog driver for the built in watchdog hardware in Sibyte
> +	  SoC processors.  There are apparently two watchdog timers
> +	  on such processors; this driver supports only the first one,
> +	  because currently Linux only supports exporting one watchdog
> +	  to userspace.

And even four watchdogs in the BCM1480.

You'd think they'd trust their hardware more than that ;-)

> + * This driver is intended to make the second of two hardware watchdogs
> + * on the Sibyte 12XX and 11XX SoCs available to the user.  There are two
> + * such devices available on the SoC, but it seems that there isn't an
> + * enumeration class for watchdogs in Linux like there is for RTCs.
> + * The second is used rather than the first because it uses IRQ 1,
> + * thereby avoiding all that IRQ 0 problematic nonsense.
> + *
> + * I have not tried this driver on a 1480 processor; it might work
> + * just well enough to really screw things up.

Four rather similar watchdogs using four interrupts also.

> + * It is a simple timer, and there is an interrupt that is raised the
> + * first time the timer expires.  The second time it expires, the chip
> + * is reset and there is no way to redirect that NMI.  Which could
> + * be problematic in some cases where this chip is sitting on the HT
> + * bus and has just taken responsibility for providing a cache block.
> + * Since the reset can't be redirected to the external reset pin, it is
> + * possible that other HT connected processors might hang and not reset.
> + * For Linux, a soft reset would probably be even worse than a hard reset.
> + * There you have it.

If read requests are never returned eventually the ZB bus HT host bridge will
run out of buffers after the 16th request.  The CPU has four more buffers
so the 21st read will stall the CPU's execution.  About a milisecond later
the machine check exception will make the CPU resume execution.  But at this
stage some registers are marked busy in the register scoreboard and any
reference to those CPU registers will cause the CPU to hang again ... until
the next machine check.  Game over, press button to continue.

> + * The timer takes 23 bits of a 64 bit register (?) as a count value,
> + * and decrements the count every microsecond, for a max value of
> + * 0x7fffff usec or about 8.3ish seconds.

One off - the maximum time is 0x800000µs.

  Ralf
