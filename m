Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2006 23:54:09 +0100 (BST)
Received: from p549F51CF.dip.t-dialin.net ([84.159.81.207]:44770 "EHLO
	p549F51CF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20039720AbWHNWyH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Aug 2006 23:54:07 +0100
Received: from outmx014.isp.belgacom.be ([195.238.4.69]:23509 "EHLO
	outmx014.isp.belgacom.be") by lappi.linux-mips.net with ESMTP
	id S1099976AbWHNPvP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Aug 2006 17:51:15 +0200
Received: from outmx014.isp.belgacom.be (localhost [127.0.0.1])
        by outmx014.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id k7EFopAC022130;
	Mon, 14 Aug 2006 17:50:51 +0200
        (envelope-from <wim@iguana.be>)
Received: from infomag.iguana.be (134.12-200-80.adsl.skynet.be [80.200.12.134])
        by outmx014.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22) with ESMTP id k7EFokdI022074;
	Mon, 14 Aug 2006 17:50:47 +0200
        (envelope-from <wim@iguana.be>)
Received: from infomag.iguana.be (localhost.localdomain [127.0.0.1])
	by infomag.iguana.be (8.13.5/8.12.11) with ESMTP id k7EFoktP004121;
	Mon, 14 Aug 2006 17:50:46 +0200
Received: (from wim@localhost)
	by infomag.iguana.be (8.13.5/8.13.5/Submit) id k7EFojUL004119;
	Mon, 14 Aug 2006 17:50:45 +0200
Date:	Mon, 14 Aug 2006 17:50:45 +0200
From:	Wim Van Sebroeck <wim@iguana.be>
To:	Thomas Koeller <thomas@koeller.dyndns.org>
Cc:	Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20060814155045.GA4068@infomag.infomag.iguana.be>
References: <200608102319.13679.thomas@koeller.dyndns.org> <20060811205639.GK26930@redhat.com> <200608120149.23380.thomas@koeller.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608120149.23380.thomas@koeller.dyndns.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi All,

> >  > +#include <linux/config.h>
> >
> > not needed.
> 
> It is, otherwise I do not get CONFIG_WATCHDOG_NOWAYOUT.

We'll fix this in the watchdog.h include file.

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

This should be:
static int nowayout = WATCHDOG_NOWAYOUT;

Can you resent me your latest diff?

Thanks,
Wim.
