Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2006 15:11:42 +0100 (BST)
Received: from ms-smtp-04.ohiordc.rr.com ([65.24.5.138]:14836 "EHLO
	ms-smtp-04.ohiordc.rr.com") by ftp.linux-mips.org with ESMTP
	id S20039563AbWHNOLk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Aug 2006 15:11:40 +0100
Received: from nineveh.rivenstone.net (cpe-24-95-33-25.columbus.res.rr.com [24.95.33.25])
	by ms-smtp-04.ohiordc.rr.com (8.13.6/8.13.6) with ESMTP id k7EEBJS8026545;
	Mon, 14 Aug 2006 10:11:22 -0400 (EDT)
Received: by nineveh.rivenstone.net (Postfix, from userid 1000)
	id CF317DE681; Mon, 14 Aug 2006 10:14:45 -0400 (EDT)
Date:	Mon, 14 Aug 2006 10:14:45 -0400
To:	Thomas Koeller <thomas@koeller.dyndns.org>
Cc:	Dave Jones <davej@redhat.com>, wim@iguana.be,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org, sam@ravnborg.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20060814141445.GA10763@nineveh.rivenstone.net>
Mail-Followup-To: Thomas Koeller <thomas@koeller.dyndns.org>,
	Dave Jones <davej@redhat.com>, wim@iguana.be,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org, sam@ravnborg.org
References: <200608102319.13679.thomas@koeller.dyndns.org> <20060811205639.GK26930@redhat.com> <200608120149.23380.thomas@koeller.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608120149.23380.thomas@koeller.dyndns.org>
User-Agent: Mutt/1.5.11
From:	jhf@columbus.rr.com (Joseph Fannin)
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Return-Path: <jhf@columbus.rr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhf@columbus.rr.com
Precedence: bulk
X-list: linux-mips

On Sat, Aug 12, 2006 at 01:49:23AM +0200, Thomas Koeller wrote:
> On Friday 11 August 2006 22:56, Dave Jones wrote:
> > On Thu, Aug 10, 2006 at 11:19:13PM +0200, thomas@koeller.dyndns.org wrote:
> >  > +
> >  > +#include <linux/config.h>
> >
> > not needed.
>
> It is, otherwise I do not get CONFIG_WATCHDOG_NOWAYOUT.

    It shouldn't be necessary, so it's probably a bug.  I could not
begin to tell you where.

    I've CC'd the Kbuild maintainer -- apologies if I'm way off base
here.

    Still, if this #include is to stay, you'd probably better comment
it, or it's likely someone will rip it out in a cleanup:

http://www.gossamer-threads.com/lists/linux/kernel/663918

>
> >
> >  > +static int locked = 0;
> >
> > unneeded initialisation.
>
> Not strictly needed, that's true, but does not do any harm either
> and expresses the intention clearly.

    My meager understanding is that it makes the kernel image bigger.

> >
> >  > +static int nowayout =
> >  > +#if defined(CONFIG_WATCHDOG_NOWAYOUT)
> >  > +	1;
> >  > +#else
> >  > +	0;
> >  > +#endif
> >
> > static int nowayout = CONFIG_WATCHDOG_NOWAYOUT;
> >
> > should work.
>
> Does not work. If the option is not selected, CONFIG_WATCHDOG_NOWAYOUT
> is undefined, not zero.


    Possibly related?


--
Joseph Fannin
jhf@columbus.rr.com || jfannin@gmail.com
