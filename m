Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6NHQhG12258
	for linux-mips-outgoing; Mon, 23 Jul 2001 10:26:43 -0700
Received: from dea.waldorf-gmbh.de (u-223-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.223])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6NHQda12249
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 10:26:39 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f6NEnG302140;
	Mon, 23 Jul 2001 16:49:16 +0200
Date: Mon, 23 Jul 2001 16:49:16 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
Cc: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: time_init() enables interrupt.
Message-ID: <20010723164916.B1245@bacchus.dhis.org>
References: <20010723190544N.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010723190544N.nemoto@toshiba-tops.co.jp>; from nemoto@toshiba-tops.co.jp on Mon, Jul 23, 2001 at 07:05:44PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jul 23, 2001 at 07:05:44PM +0900, Atsushi Nemoto wrote:

> arch/mips/kernel/time.c:time_init() in current CVS contains following codes:
> 
> 	/* setup xtime */
> 	write_lock_irq(&xtime_lock);
> 	xtime.tv_sec = rtc_get_time();
> 	xtime.tv_usec = 0;
> 	write_unlock_irq(&xtime_lock);
> 
> The write_unlock_irq() macro calls __sti(), but it is too early to
> enable interrupts.
> 
> I think this write_lock_irq/write_unlock_irq pair should be removed
> (or replaced with write_lock_irqsave/write_unlock_irqrestore pair).

There is no point in locking there.  This code is executed with interrupts
disabled on the boot cpu only.  I've removed the lock with no replacement.

  Ralf
