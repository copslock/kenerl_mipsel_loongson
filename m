Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Dec 2002 13:40:45 +0100 (CET)
Received: from p508B7FA8.dip.t-dialin.net ([80.139.127.168]:26003 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225196AbSLJMkp>; Tue, 10 Dec 2002 13:40:45 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gBACeUH23911;
	Tue, 10 Dec 2002 13:40:30 +0100
Date: Tue, 10 Dec 2002 13:40:30 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Dominic Sweetman <dom@algor.co.uk>,
	Dominic Sweetman <dom@mips.com>, chris@mips.com,
	kevink@mips.com, linux-mips@linux-mips.org
Subject: Re: The 64-bit version of __access_ok is broken.
Message-ID: <20021210134030.B17306@linux-mips.org>
References: <3DEF7087.B6DEA7EC@mips.com> <20021209051845.A31939@linux-mips.org> <3DF4629B.F377F711@mips.com> <15860.33900.117478.251574@gladsmuir.algor.co.uk> <20021209193808.B27999@linux-mips.org> <3DF59CDF.DC160221@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DF59CDF.DC160221@mips.com>; from carstenl@mips.com on Tue, Dec 10, 2002 at 08:50:55AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 10, 2002 at 08:50:55AM +0100, Carsten Langgaard wrote:

> I absolutely agree that we should go for an optimized solution, but we discuss
> this issue 1/2 year ago, none of us, had the time to come up with a better fix
> than the one I send. I'm going through my to-do list and came across this
> issue again, and I just wanted to reopen the case again.
> This time it annoyed you enough, so you came up with a better solution and
> I achieved what I came for, so that's great ;-)
> Thanks a lot. I will try you patch right away.

It's already in CVS.

Btw, a missconfigured firewall turned linux-mips.org into a heating for the
server room last night.  This should be fixed now.  The machine is now
hosted at MIPS UK, formerly Algorithmics.  There should be no user visible
changes.

  Ralf
