Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1QCvNW14474
	for linux-mips-outgoing; Tue, 26 Feb 2002 04:57:23 -0800
Received: from dea.linux-mips.net (a1as04-p167.stg.tli.de [195.252.186.167])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1QCvE914469
	for <linux-mips@oss.sgi.com>; Tue, 26 Feb 2002 04:57:15 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1QBtXZ18135;
	Tue, 26 Feb 2002 12:55:33 +0100
Date: Tue, 26 Feb 2002 12:55:32 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jay Carlson <nop@nop.com>
Cc: Hartvig Ekner <hartvige@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Setting up of GP in static, non-PIC version of glibc?
Message-ID: <20020226125532.B7497@dea.linux-mips.net>
References: <20020225173433.B3680@dea.linux-mips.net> <334839BA-2A77-11D6-AB38-0030658AB11E@nop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <334839BA-2A77-11D6-AB38-0030658AB11E@nop.com>; from nop@nop.com on Tue, Feb 26, 2002 at 12:10:50AM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Feb 26, 2002 at 12:10:50AM -0500, Jay Carlson wrote:

> By default non-PIC code *does* use $gp due to the brain damage in gas; 
> gas defaults to -G 8 unless told otherwise (-KPIC implies -G0 so we 
> don't see this in PIC code.)  gcc won't know anything about this, of 
> course.
> 
> What I'm doing in SUBTARGET_ASM_SPEC is to write something like 
> "%{fno-pic: %{!G: -G0}}"--if we're not in PIC mode, pass -G0 to gas by 
> default.
> 
> Anyway, once that's straightened out, -G8 does appear to work the way 
> you'd expect, with the code that Hartvig pasted above---I had written a 
> byte-for-byte identical patch :-)

I agree on that one except that 64kB of small data no longer seem to be
sufficient for every common application in the world.  So I'd vote for a
more defensive choice of the -G value, that is 0.

  Ralf
