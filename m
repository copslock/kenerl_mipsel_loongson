Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2009 13:35:52 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41352 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492410AbZKVMfp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Nov 2009 13:35:45 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAMCZIFA005685;
	Sun, 22 Nov 2009 12:35:20 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAMCZAuQ005683;
	Sun, 22 Nov 2009 12:35:10 GMT
Date:	Sun, 22 Nov 2009 12:35:09 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Ingo Molnar <mingo@elte.hu>, linux-mips@linux-mips.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Simek <monstr@monstr.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: Add a high resolution sched_clock() via
	cnt32_to_63().
Message-ID: <20091122123509.GA1941@linux-mips.org>
References: <dae45f23b5d34f64fc60a445015e7dfe05aa0d07.1258875717.git.wuzhangjin@gmail.com> <20091122081328.GB24558@elte.hu> <1258888086.4548.52.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1258888086.4548.52.camel@falcon.domain.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 22, 2009 at 07:08:05PM +0800, Wu Zhangjin wrote:

> > > +	data = (0xffffffffUL / tclk / 2 - 2) * HZ;
> 
> Because the MIPS c0 count's frequency is half of the cpu frequency(Hi,
> Ralf, does every MIPS c0 count meet this feature?), so, the above line
> should be:

There are processors which have no cp0 counter at all; these are mostly
very old pre-R4000 era 32-bit MIPS I and MIPS II cores.

Of those which have a cp0 counter most will clock it at "half the maximum
instruction issue rate" and a few at the full rate.  Finally for a few
such as the RM52xx either half or the full count the rate is selectable by
the reset initialization bitstream fed into the processor.  Too make this
feature suck nicely there is no way for software to find out which rate
was selected so software must know that or calibrate against a timer of
known frequency.

Platform-specific code does this by setting mips_hpt_frequency to the
count rate before calling init_r4k_clocksource; it's also the value being
passed into setup_sched_clock_update() so you don't need to count for the
half / full clock rate thing there.

I don't see why you need the -2 in your formula so the whole thing can
be simplified to:

	data = 0x80000000 / tclk * HZ;

  Ralf
