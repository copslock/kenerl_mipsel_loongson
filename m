Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 21:36:11 +0000 (GMT)
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34017 "EHLO amd.ucw.cz")
	by ftp.linux-mips.org with ESMTP id S20039266AbXBBVgH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2007 21:36:07 +0000
Received: by amd.ucw.cz (Postfix, from userid 8)
	id 7E6E08060; Fri,  2 Feb 2007 22:35:23 +0100 (CET)
Date:	Fri, 2 Feb 2007 22:35:23 +0100
From:	Pavel Machek <pavel@ucw.cz>
To:	Rodolfo Giometti <giometti@enneenne.com>
Cc:	Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk, linux-mips@linux-mips.org
Subject: Re: Advice on battery support [was: Advice on APM-EMU reunion]
Message-ID: <20070202213523.GA5089@elf.ucw.cz>
References: <20070129230755.GA8705@enneenne.com> <20070130010055.GA15907@linux-sh.org> <20070201095904.GE8882@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070201095904.GE8882@enneenne.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13909
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

Hi!

> > However, it has since been reposted:
> > 
> > http://article.gmane.org/gmane.linux.kernel/485833
> > http://article.gmane.org/gmane.linux.kernel/485834
> > http://article.gmane.org/gmane.linux.kernel/485835
> > http://article.gmane.org/gmane.linux.kernel/485837
> > 
> > and merged back in to -mm. This is all post 2.6.20 stuff, though..
> 
> Ok, starting from these patches I'd like to add a "battery support" to
> the kernel.
> 
> What I suppose to do is a new class with a proper methods useful to
> collect several info on battery status, such as get_ac_line_status()
> get_battery_status(), get_battery_flags(),
> get_remaining_battery_life() and so on.
> 
> The output will be APM-like into file "/proc/apm" (one line per
> battery, or just the "main"/first one?) so that existing applications
> continue to work and under sysfs into "/sysfs/class/battery".
> 
> Is it sane? :)

Yep. Notice that designing /sysfs/class/battery is not going to be
easy, and that some work was already done in context of olpc
project. Search the mailing lists...
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
