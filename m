Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Feb 2008 22:26:42 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:38800 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28580878AbYB1W0k (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Feb 2008 22:26:40 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m1SMQdaW032400;
	Thu, 28 Feb 2008 22:26:39 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m1SMQdGm032399;
	Thu, 28 Feb 2008 22:26:39 GMT
Date:	Thu, 28 Feb 2008 22:26:38 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Daniel Laird <daniel.j.laird@nxp.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: PNX8550 Broken on Linux 2.6.24 - Interrupt issues?
Message-ID: <20080228222638.GB25013@linux-mips.org>
References: <64660ef00802280457i3eef020chd70f85c011c5a770@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64660ef00802280457i3eef020chd70f85c011c5a770@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18321
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 28, 2008 at 12:57:47PM +0000, Daniel Laird wrote:

> I have been happily using Linux 2.6.22.1 for ages on PNX8550 (STB810).
>  I have recently decided to step up and move onto Linux 2.6.24 series.
> However I am not getting very far. :-(
> It seems that all the clock stuff has changed again (since 2.6.22.1)
> and this is causing issues.

Yes, it's a bit special and I don't have any possibility to test the
PNX code so I left it mostly untouched when rewriting the timer code.
Sorry about that but eventually I had to go ahead.  Vitaly Wool
eventually submitted a few patches to fix things but as your testing
seems to show that wasn't quite enough.  That far about the history
of the changes.

> The board crashes as soon as local_irq_enable is called in main.c
> 
> I was wondering if anyone out there might also be running on an
> STB810/JBS PNX8550 based system and have any ideas as to why I am
> crashing.
> I know that PNX8550 does not enable the R4K Clock source stuff as the
> chip is a bit 'special' and requires the two timers to be used instead
> of one.

csrc-r4k.c and cevt-r4k.c assume a standard compliant R4000-style
c0_count and c0_compare register.  The PNX chips violate the expected
behaviour badly so can't use these functions.

But that's not very much of a problem.  The timer code is module and
it is easy to write something like csrc-pnx.c and cevt-pnx.c to drive
a PNX style count/compare timer.

Will look over the code to see if I can spot what crashes the PNXes.

  Ralf
