Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Nov 2006 19:27:15 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:28876 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038472AbWKLT1N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 12 Nov 2006 19:27:13 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kACJRZdr018924;
	Sun, 12 Nov 2006 19:27:36 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kACJRVK5018923;
	Sun, 12 Nov 2006 19:27:31 GMT
Date:	Sun, 12 Nov 2006 19:27:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mips hpt cleanup: make clocksource_mips public
Message-ID: <20061112192731.GA16599@linux-mips.org>
References: <20061112.001028.41198601.anemo@mba.ocn.ne.jp> <455774BD.6010706@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455774BD.6010706@ru.mvista.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 12, 2006 at 10:23:41PM +0300, Sergei Shtylyov wrote:

> > 	if (!cpu_has_counter && IOASIC)
> > 		/* For pre-R4k systems we use the I/O ASIC's counter.  */
> >-		mips_hpt_read = dec_ioasic_hpt_read;
> >+		clocksource_mips.read = dec_ioasic_hpt_read;
> 
>    I'd like to see clocksource_mips.name overriden there as well.

> > #endif
> > static void __init jmr3927_time_init(void)
> > {
> >-	mips_hpt_read = jmr3927_hpt_read;
> >+	clocksource_mips.read = jmr3927_hpt_read;
> 
>    And the same here as well as this is TX3927-specific timer.
...

The whole MIPS clocksource is only a stop gap solution until all platforms
have provided their own clocksource drivers.

  Ralf
