Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1Q63xh02092
	for linux-mips-outgoing; Mon, 25 Feb 2002 22:03:59 -0800
Received: from dea.linux-mips.net (a1as07-p84.stg.tli.de [195.252.188.84])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1Q63q902085
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 22:03:54 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1Q52bK05330;
	Tue, 26 Feb 2002 06:02:37 +0100
Date: Tue, 26 Feb 2002 06:02:37 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Jay Carlson <nop@nop.com>
Cc: mad-dev@lists.mars.org, Carlo Agostini <carlo.agostini@yacme.com>,
   linux-mips@oss.sgi.com
Subject: Re: Problems compiling . soft-float
Message-ID: <20020226060236.A5293@dea.linux-mips.net>
References: <20020225132559.A3500@dea.linux-mips.net> <F91731D8-2A73-11D6-AB38-0030658AB11E@nop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <F91731D8-2A73-11D6-AB38-0030658AB11E@nop.com>; from nop@nop.com on Mon, Feb 25, 2002 at 11:47:44PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 25, 2002 at 11:47:44PM -0500, Jay Carlson wrote:

> Ralf is right that the kernel emulator is the supported route.  But if 
> you're willing to go to the trouble of building everything from scratch, 
> this does work.

It's really a major pain.  Softfp isn't defined in the ABI which assumes
an FPU is available.  As the result there is no provision for mixing
softfp and fp-less code.

Something for the binutils to-do list - ld should make mixing hard-fp
and soft-fp binaries impossible.

  Ralf
