Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2006 16:30:48 +0100 (BST)
Received: from pasmtpb.tele.dk ([80.160.77.98]:7142 "EHLO pasmtp.tele.dk")
	by ftp.linux-mips.org with ESMTP id S20039633AbWHNPaq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Aug 2006 16:30:46 +0100
Received: from mars.ravnborg.org (0x535d98d8.hrnxx9.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtp.tele.dk (Postfix) with ESMTP id E98CEE30916;
	Mon, 14 Aug 2006 17:30:32 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 7041043C01F; Mon, 14 Aug 2006 17:30:33 +0200 (CEST)
Date:	Mon, 14 Aug 2006 17:30:33 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Thomas Koeller <thomas@koeller.dyndns.org>,
	Dave Jones <davej@redhat.com>, wim@iguana.be,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-ID: <20060814153033.GA25215@mars.ravnborg.org>
References: <200608102319.13679.thomas@koeller.dyndns.org> <20060811205639.GK26930@redhat.com> <200608120149.23380.thomas@koeller.dyndns.org> <20060814141445.GA10763@nineveh.rivenstone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060814141445.GA10763@nineveh.rivenstone.net>
User-Agent: Mutt/1.5.12-2006-07-14
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 14, 2006 at 10:14:45AM -0400, Joseph Fannin wrote:
> On Sat, Aug 12, 2006 at 01:49:23AM +0200, Thomas Koeller wrote:
> > On Friday 11 August 2006 22:56, Dave Jones wrote:
> > > On Thu, Aug 10, 2006 at 11:19:13PM +0200, thomas@koeller.dyndns.org wrote:
> > >  > +
> > >  > +#include <linux/config.h>
> > >
> > > not needed.
> >
> > It is, otherwise I do not get CONFIG_WATCHDOG_NOWAYOUT.
Yes you do - try it.
make V=1 tells you that -include include/linux/autoconf.h pulls in the
CONFIG_ definitions.

	Sam
