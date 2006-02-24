Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Feb 2006 18:58:26 +0000 (GMT)
Received: from verein.lst.de ([213.95.11.210]:2749 "EHLO mail.lst.de")
	by ftp.linux-mips.org with ESMTP id S8133576AbWBXS6R (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Feb 2006 18:58:17 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id k1OJ5KRT028138
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 24 Feb 2006 20:05:20 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id k1OJ5H7X028136;
	Fri, 24 Feb 2006 20:05:17 +0100
Date:	Fri, 24 Feb 2006 20:05:17 +0100
From:	Christoph Hellwig <hch@lst.de>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org, jblache@debian.org,
	rmk+serial@arm.linux.org.uk
Subject: Re: IP22 doesn't shutdown properly
Message-ID: <20060224190517.GA28013@lst.de>
References: <20060217225824.GE20785@deprecation.cyrius.com> <20060223221350.GA5239@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060223221350.GA5239@deprecation.cyrius.com>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10640
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Thu, Feb 23, 2006 at 10:13:50PM +0000, Martin Michlmayr wrote:
> * Martin Michlmayr <tbm@cyrius.com> [2006-02-17 22:58]:
> > When you try to shutdown or reboot an IP22 with 2.6.15 or 2.6.16-rc2,
> > you see that the TERM signal is sent but then nothing happens.  At the
> > beginning, the light on the Indy is green but after about 20 seconds
> > it turns red.  Nothing happens on the console and the machine doesn't
> > turn off.  Seen on Indy and Indigo2.
> [and, as mentioned later, this only happens on serial, not when using
> the bf]
> 
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

This patch was dropped when a real fix went into one of the sun serial
drivers with which this issue was seen before.  Please look through
the drivers/serial/sun* changelogs and see what fix needs to be
ported to the ip22zilog driver.
