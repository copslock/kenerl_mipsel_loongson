Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Nov 2009 20:03:33 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:53698 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493202AbZKLTDa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Nov 2009 20:03:30 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nACJ3Q1f022630;
	Thu, 12 Nov 2009 20:03:27 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nACJ3L7i022627;
	Thu, 12 Nov 2009 20:03:21 +0100
Date:	Thu, 12 Nov 2009 20:03:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Pavel Machek <pavel@ucw.cz>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	yanh@lemote.com, huhb@lemote.com, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	linux-pm@lists.linux-foundation.org
Subject: Re: [PATCH -queue 1/2] [loongson] 2f: add suspend support framework
Message-ID: <20091112190321.GA2887@linux-mips.org>
References: <cover.1257922151.git.wuzhangjin@gmail.com> <1257922625.2922.97.camel@falcon.domain.org> <20091111103304.GB26423@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091111103304.GB26423@elf.ucw.cz>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 11, 2009 at 11:33:04AM +0100, Pavel Machek wrote:

> On Wed 2009-11-11 14:57:05, Wu Zhangjin wrote:
> > (Add CC to Rafael J. Wysocki, Len Brown and Pavel Machek)
> > 
> > This patch add basic suspend support for loongson2f family machines,
> > loongson2f have a specific feature: when we set it's frequency to ZERO,
> > it will go into a wait mode, and then can be waked up by the external
> > interrupt. so, if we setup suitable interrupts before putting it into
> > wait mode, we will be able wake it up whenever we want via sending the
> > relative interrupts to it.
> > 
> > These interrupts are board-specific, Yeeloong2F use the keyboard
> > interrupt and SCI interrupt, but LingLoong and Fuloong2F use the
> > interrupts connected to the processors directly. and BTW: some old
> > LingLoong and FuLoong2F have no such interrupts connected, so, there is
> > no way to wake them up from suspend mode. and therefore, please do not
> > enable the kernel support for them.
> > 
> > The board-specific support will be added in the coming patches.
> > 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Comments are slighlty "interesting", but otherwise it looks ok.
> 
> > +	/* stop all perf counters */
> > +	stop_perf_counters();
> 
> This is not exactly useful comment, right?
> 
> > +	/* mach specific suspend */
> > +	mach_suspend();
> ...
> > +	/* mach specific resume */
> > +	mach_resume();
> 
> 
> It is probably ok, but you may want to avoid them in future.
> 
> ACK.

Thanks.  Queued for 2.6.33 with the comments cleaned up.

  Ralf
