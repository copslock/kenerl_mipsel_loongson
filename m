Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76JJxm24442
	for linux-mips-outgoing; Mon, 6 Aug 2001 12:19:59 -0700
Received: from scsoftware.sc-software.com (mipsdev@[206.40.202.193])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76JJsV24436;
	Mon, 6 Aug 2001 12:19:54 -0700
Received: from localhost (mipsdev@localhost) by scsoftware.sc-software.com (8.8.3/8.8.3) with SMTP id MAA17908; Mon, 6 Aug 2001 12:13:29 GMT
Date: Mon, 6 Aug 2001 12:13:29 +0000 (   )
From: John Heil <mipsdev@scsoftware.sc-software.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: Re: Qube2 gcc 2.7.2 compiler error (fwd)
In-Reply-To: <20010806114556.A17179@bacchus.dhis.org>
Message-ID: <Pine.LNX.3.95.1010806120030.15505K-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 6 Aug 2001, Ralf Baechle wrote:

> Date: Mon, 6 Aug 2001 11:45:56 +0200
> From: Ralf Baechle <ralf@oss.sgi.com>
> To: John Heil <mipsdev@scsoftware.sc-software.com>
> Cc: cobalt-22@devel.alal.com, cobalt-developers@list.cobalt.com,
>     linux-mips@oss.sgi.com
> Subject: Re: Qube2 gcc 2.7.2 compiler error (fwd)
> 
> On Sun, Aug 05, 2001 at 12:59:23PM +0000, John Heil wrote:
> > Date: Sun, 5 Aug 2001 12:59:23 +0000 (   )
> > From: John Heil <mipsdev@scsoftware.sc-software.com>
> > To: cobalt-22@devel.alal.com, cobalt-developers@list.cobalt.com,
> >         linux-mips@oss.sgi.com
> > Subject: Qube2 gcc 2.7.2 compiler error (fwd)
> > 
> > 
> > On the Qube2, gcc 2.7.2, option -s, to generate MIPS assembler
> > corresponding to the input C code, generates invalid assembler
> > by virtue of generating duplicate labels. The resultant 
> > assembler will not assemble, of course, due to the duplicate
> > labels.  The code (linux kernel's printk.c) compiles cleanly
> > from C to object code.
> > 
> > Q: How do I get valid assembler from gcc on Qube2 ?
> > (My ultimate goal here is to be able to get listings out
> > of gas.)
> 
> gcc 2.7.2 creates a duplicate label for each function label.  That is no
> problem as both always have the same value.  But I assume you're talking

This is exactly the problem. The fact that the values are the same is
causing the assembler interface to GCC to fail. When gcc -S outputs a 
.s assembler file, the GNU as assembler errors out on 'duplicate label'.

Further, using the gcc -Wa,... without using -S, causes the compile to 
fail when the assembler is invoked and gives the same errors.


> about a different type of label?  Can you send a piece of small piece of
> source code and the assembler code generated from it to demonstrate the
> problem?
> 
> Anyway, these days gcc 2.7.2 is so old these days it's not even funny.  You
> really should upgrade.
> 
>   Ralf
> 

I'm happy to upgrade...

What is the recommended level for kernel compiles and where can I find it.
I am required to work on 2.0.34C53_SK using Qube2 for my build platform
so I need compatibility. If I could cross compile on x86 that would be 
cool too.

Thanx much
John
