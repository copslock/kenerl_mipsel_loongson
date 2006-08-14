Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Aug 2006 23:52:40 +0100 (BST)
Received: from p549F51CF.dip.t-dialin.net ([84.159.81.207]:44770 "EHLO
	p549F51CF.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20039085AbWHNWwh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 14 Aug 2006 23:52:37 +0100
Received: from xenotime.net ([66.160.160.81]:58512 "HELO xenotime.net")
	by lappi.linux-mips.net with SMTP id S1100025AbWHNQTC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 14 Aug 2006 18:19:02 +0200
Received: from midway.site ([71.117.253.75]) by xenotime.net for <linux-mips@linux-mips.org>; Mon, 14 Aug 2006 09:18:36 -0700
Date:	Mon, 14 Aug 2006 09:21:24 -0700
From:	"Randy.Dunlap" <rdunlap@xenotime.net>
To:	Sam Ravnborg <sam@ravnborg.org>
Cc:	Thomas Koeller <thomas@koeller.dyndns.org>,
	Dave Jones <davej@redhat.com>, wim@iguana.be,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Added MIPS RM9K watchdog driver
Message-Id: <20060814092124.84f7ff3e.rdunlap@xenotime.net>
In-Reply-To: <20060814153033.GA25215@mars.ravnborg.org>
References: <200608102319.13679.thomas@koeller.dyndns.org>
	<20060811205639.GK26930@redhat.com>
	<200608120149.23380.thomas@koeller.dyndns.org>
	<20060814141445.GA10763@nineveh.rivenstone.net>
	<20060814153033.GA25215@mars.ravnborg.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <rdunlap@xenotime.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdunlap@xenotime.net
Precedence: bulk
X-list: linux-mips

On Mon, 14 Aug 2006 17:30:33 +0200 Sam Ravnborg wrote:

> On Mon, Aug 14, 2006 at 10:14:45AM -0400, Joseph Fannin wrote:
> > On Sat, Aug 12, 2006 at 01:49:23AM +0200, Thomas Koeller wrote:
> > > On Friday 11 August 2006 22:56, Dave Jones wrote:
> > > > On Thu, Aug 10, 2006 at 11:19:13PM +0200,
> > > > thomas@koeller.dyndns.org wrote:
> > > >  > +
> > > >  > +#include <linux/config.h>
> > > >
> > > > not needed.
> > >
> > > It is, otherwise I do not get CONFIG_WATCHDOG_NOWAYOUT.
> Yes you do - try it.
> make V=1 tells you that -include include/linux/autoconf.h pulls in
> the CONFIG_ definitions.

Sure, autoconf.h is included, but I think his point is that
CONFIG_WATCHDOG_NOWAYOUT may not be defined there at all,
as in my 2.6.18-rc4 autoconf.h file, since my .config file says:
# CONFIG_WATCHDOG_NOWAYOUT is not set

---
~Randy
