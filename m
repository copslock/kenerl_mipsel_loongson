Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76JXmU25666
	for linux-mips-outgoing; Mon, 6 Aug 2001 12:33:48 -0700
Received: from dea.waldorf-gmbh.de (u-145-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.145])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76JXhV25659
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 12:33:44 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f76JWnt22002;
	Mon, 6 Aug 2001 21:32:49 +0200
Date: Mon, 6 Aug 2001 21:32:49 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: John Heil <mipsdev@scsoftware.sc-software.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Qube2 gcc 2.7.2 compiler error (fwd)
Message-ID: <20010806213249.A21984@bacchus.dhis.org>
References: <20010806114556.A17179@bacchus.dhis.org> <Pine.LNX.3.95.1010806120030.15505K-100000@scsoftware.sc-software.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010806120030.15505K-100000@scsoftware.sc-software.com>; from mipsdev@scsoftware.sc-software.com on Mon, Aug 06, 2001 at 12:13:29PM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 06, 2001 at 12:13:29PM +0000, John Heil wrote:

> > gcc 2.7.2 creates a duplicate label for each function label.  That is no
> > problem as both always have the same value.  But I assume you're talking
> 
> This is exactly the problem. The fact that the values are the same is
> causing the assembler interface to GCC to fail. When gcc -S outputs a 
> .s assembler file, the GNU as assembler errors out on 'duplicate label'.

Since when that?  Gas used to accept that for just more than half a decade.
You seem to be using some non-standard gas version?

> I'm happy to upgrade...
> 
> What is the recommended level for kernel compiles and where can I find it.
> I am required to work on 2.0.34C53_SK using Qube2 for my build platform
> so I need compatibility. If I could cross compile on x86 that would be 
> cool too.

You may want to try H.J. Lu's latest tools from oss.  I should mention that
nobody is testing on such old systems any more and I suspect some minor
changes may be required to get these tools to work in such an environment.

  Ralf
