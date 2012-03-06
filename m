Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Mar 2012 21:27:20 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54391 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903662Ab2CFU1P (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Mar 2012 21:27:15 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id q26KRD2L029705;
        Tue, 6 Mar 2012 21:27:13 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id q26KRC1L029704;
        Tue, 6 Mar 2012 21:27:12 +0100
Date:   Tue, 6 Mar 2012 21:27:12 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <ffainelli@freebox.fr>
Cc:     loody <miloody@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: some questions about mips timer
Message-ID: <20120306202712.GM4519@linux-mips.org>
References: <CANudz+ugY7NfCSGh-_kS4pzC91p02ZtYpxXMdCOKsM+spAt37g@mail.gmail.com>
 <160192556.459513.1331042510355.JavaMail.root@zmc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160192556.459513.1331042510355.JavaMail.root@zmc>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32609
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Mar 06, 2012 at 03:01:50PM +0100, Florian Fainelli wrote:

> > hi all:
> > I have some questions about mips_hpt_frequency:
> > 1. is mips_hpt_frequency == mips cpu frequency?
> 
> No, it is usually cpu frequency / 2.

The architecture specification leaves the counter clock rate up up to the
implementation and only says the clock rate is a function of the pipeline
clock.  In all reality this means the counter is running at the full or
half frequency.  Just don't build on it,

  clock := pipeline_clock * next_weeks_lottery_number % 42

would by compliant ;-)

On some CPUs the frequency can even be selected through a configuration
bitstream at reset time so you can't always count on a fixed relation
between CPU clock and count rate.

Some older CPU manuals contain a confusing wording saying the counter
increments at half (or full) instruction issue rate.  That just means the
pipeline clock, no reason to be confused.

  Ralf
