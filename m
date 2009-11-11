Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Nov 2009 11:33:17 +0100 (CET)
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54907 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492580AbZKKKdL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Nov 2009 11:33:11 +0100
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
	id 02945F0326; Wed, 11 Nov 2009 11:33:10 +0100 (CET)
Date:	Wed, 11 Nov 2009 11:33:04 +0100
From:	Pavel Machek <pavel@ucw.cz>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	yanh@lemote.com, huhb@lemote.com, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	linux-pm@lists.linux-foundation.org
Subject: Re: [PATCH -queue 1/2] [loongson] 2f: add suspend support framework
Message-ID: <20091111103304.GB26423@elf.ucw.cz>
References: <cover.1257922151.git.wuzhangjin@gmail.com>
 <1257922625.2922.97.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257922625.2922.97.camel@falcon.domain.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <pavel@ucw.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pavel@ucw.cz
Precedence: bulk
X-list: linux-mips

On Wed 2009-11-11 14:57:05, Wu Zhangjin wrote:
> (Add CC to Rafael J. Wysocki, Len Brown and Pavel Machek)
> 
> This patch add basic suspend support for loongson2f family machines,
> loongson2f have a specific feature: when we set it's frequency to ZERO,
> it will go into a wait mode, and then can be waked up by the external
> interrupt. so, if we setup suitable interrupts before putting it into
> wait mode, we will be able wake it up whenever we want via sending the
> relative interrupts to it.
> 
> These interrupts are board-specific, Yeeloong2F use the keyboard
> interrupt and SCI interrupt, but LingLoong and Fuloong2F use the
> interrupts connected to the processors directly. and BTW: some old
> LingLoong and FuLoong2F have no such interrupts connected, so, there is
> no way to wake them up from suspend mode. and therefore, please do not
> enable the kernel support for them.
> 
> The board-specific support will be added in the coming patches.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Comments are slighlty "interesting", but otherwise it looks ok.

> +	/* stop all perf counters */
> +	stop_perf_counters();

This is not exactly useful comment, right?

> +	/* mach specific suspend */
> +	mach_suspend();
...
> +	/* mach specific resume */
> +	mach_resume();


It is probably ok, but you may want to avoid them in future.

ACK.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
