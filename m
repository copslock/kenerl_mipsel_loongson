Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1QDRkI15097
	for linux-mips-outgoing; Tue, 26 Feb 2002 05:27:46 -0800
Received: from dea.linux-mips.net (a1as04-p167.stg.tli.de [195.252.186.167])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1QDRe915093
	for <linux-mips@oss.sgi.com>; Tue, 26 Feb 2002 05:27:40 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1QCRCG18470;
	Tue, 26 Feb 2002 13:27:12 +0100
Date: Tue, 26 Feb 2002 13:27:12 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Dominic Sweetman <dom@algor.co.uk>
Cc: Jay Carlson <nop@nop.com>, mad-dev@lists.mars.org,
   Carlo Agostini <carlo.agostini@yacme.com>, linux-mips@oss.sgi.com
Subject: Re: Problems compiling . soft-float
Message-ID: <20020226132711.A18296@dea.linux-mips.net>
References: <20020225132559.A3500@dea.linux-mips.net> <F91731D8-2A73-11D6-AB38-0030658AB11E@nop.com> <20020226060236.A5293@dea.linux-mips.net> <15483.27029.29266.976139@gladsmuir.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15483.27029.29266.976139@gladsmuir.algor.co.uk>; from dom@algor.co.uk on Tue, Feb 26, 2002 at 10:55:17AM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 26, 2002 at 10:55:17AM +0000, Dominic Sweetman wrote:

> Incremental changes to the ABI are pretty bad news.  Isn't it
> avoidable in this case?
> 
> It seems to me that soft-float programs are either carefully
> controlled test cases, or used as part of a 100% soft-float system.
> 
> In the first case the programmer had better take care, and in the
> second the kernel should have been changed to kill any program with an
> FP op-code.

Experience shows that people will use every opportunity to shot themselfes
into their foot ...

Even a soft-fp system may still have the in-kernel emulator, so be able to
execute both soft-fp and hard-fp binaries correctly.  But it won't be able
to support a mix of both nor would the kernel know that an application is
just mixing hard and soft fp.

  Ralf
