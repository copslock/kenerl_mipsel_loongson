Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Oct 2009 10:19:47 +0200 (CEST)
Received: from fanny.its.uu.se ([130.238.4.241]:48722 "EHLO fanny.its.uu.se"
	rhost-flags-OK-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492464AbZJTITk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Oct 2009 10:19:40 +0200
Received: by fanny.its.uu.se (Postfix, from userid 212)
	id 171EB6482; Tue, 20 Oct 2009 10:19:20 +0200 (MSZ)
Received: from pilspetsen.it.uu.se (pilspetsen.it.uu.se [130.238.18.39])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by fanny.its.uu.se (Postfix) with ESMTP id D38026459;
	Tue, 20 Oct 2009 10:19:13 +0200 (MSZ)
Received: (from mikpe@localhost)
	by pilspetsen.it.uu.se (8.13.8+Sun/8.13.8) id n9K8JChl014389;
	Tue, 20 Oct 2009 10:19:12 +0200 (MEST)
X-Authentication-Warning: pilspetsen.it.uu.se: mikpe set sender to mikpe@it.uu.se using -f
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <19165.29312.300540.500942@pilspetsen.it.uu.se>
Date:	Tue, 20 Oct 2009 10:19:12 +0200
From:	Mikael Pettersson <mikpe@it.uu.se>
To:	Thomas Gleixner <tglx@linutronix.de>
Cc:	Linus Walleij <linus.walleij@stericsson.com>,
	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Mikael Pettersson <mikpe@it.uu.se>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Make MIPS dynamic clocksource/clockevent clock code
	generic
In-Reply-To: <alpine.LFD.2.00.0910200454300.2863@localhost.localdomain>
References: <1255819715-19763-1-git-send-email-linus.walleij@stericsson.com>
	<alpine.LFD.2.00.0910200454300.2863@localhost.localdomain>
X-Mailer: VM 7.17 under Emacs 20.7.1
Return-Path: <mikpe@it.uu.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mikpe@it.uu.se
Precedence: bulk
X-list: linux-mips

Thomas Gleixner writes:
 > > +static inline void clockevent_set_clock(struct clock_event_device *dev, u32 hz)
 > > +{
 > > +	u64 temp;
 > > +	u32 shift;
 > > +
 > > +	/* Find a shift value */
 > > +	for (shift = 32; shift > 0; shift--) {
 > > +		temp = (u64) hz << shift;
 > > +		do_div(temp, NSEC_PER_SEC);
 > > +		if ((temp >> 32) == 0)
 > > +			break;
 > > +	}
 > > +	dev->shift = shift;
 > > +	dev->mult = (u32) temp;
 > > +}
 > > +
 > > +
 > > +static inline void clocksource_set_clock(struct clocksource *cs, u32 hz)
 > > +{
 > > +	u64 temp;
 > > +	u32 shift;
 > > +
 > > +	/* Find a shift value */
 > > +	for (shift = 32; shift > 0; shift--) {
 > > +		temp = (u64) NSEC_PER_SEC << shift;
 > > +		do_div(temp, hz);
 > > +		if ((temp >> 32) == 0)
 > > +			break;
 > > +	}
 > > +	cs->shift = shift;
 > > +	cs->mult = (u32) temp;
 > > +}
 > > +
 > 
 > So that's the same function twice, right ?

They are similar but not identical:

 > > +		temp = (u64) hz << shift;
 > > +		do_div(temp, NSEC_PER_SEC);

vs

 > > +		temp = (u64) NSEC_PER_SEC << shift;
 > > +		do_div(temp, hz);

I suppose both functions could be implemented by a suitably
parametric third function, but IMO that would just obscure things.

Making them non-inline I fully agree with.
