Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f76GOoH17039
	for linux-mips-outgoing; Mon, 6 Aug 2001 09:24:50 -0700
Received: from dea.waldorf-gmbh.de (u-243-21.karlsruhe.ipdial.viaginterkom.de [62.180.21.243])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f76GOlV17035
	for <linux-mips@oss.sgi.com>; Mon, 6 Aug 2001 09:24:47 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f769ju119673;
	Mon, 6 Aug 2001 11:45:56 +0200
Date: Mon, 6 Aug 2001 11:45:56 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: John Heil <mipsdev@scsoftware.sc-software.com>
Cc: cobalt-22@devel.alal.com, cobalt-developers@list.cobalt.com,
   linux-mips@oss.sgi.com
Subject: Re: Qube2 gcc 2.7.2 compiler error (fwd)
Message-ID: <20010806114556.A17179@bacchus.dhis.org>
References: <Pine.LNX.3.95.1010805125641.15505J-100000@scsoftware.sc-software.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1010805125641.15505J-100000@scsoftware.sc-software.com>; from mipsdev@scsoftware.sc-software.com on Sun, Aug 05, 2001 at 12:59:23PM +0000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Aug 05, 2001 at 12:59:23PM +0000, John Heil wrote:
> Date: Sun, 5 Aug 2001 12:59:23 +0000 (   )
> From: John Heil <mipsdev@scsoftware.sc-software.com>
> To: cobalt-22@devel.alal.com, cobalt-developers@list.cobalt.com,
>         linux-mips@oss.sgi.com
> Subject: Qube2 gcc 2.7.2 compiler error (fwd)
> 
> 
> On the Qube2, gcc 2.7.2, option -s, to generate MIPS assembler
> corresponding to the input C code, generates invalid assembler
> by virtue of generating duplicate labels. The resultant 
> assembler will not assemble, of course, due to the duplicate
> labels.  The code (linux kernel's printk.c) compiles cleanly
> from C to object code.
> 
> Q: How do I get valid assembler from gcc on Qube2 ?
> (My ultimate goal here is to be able to get listings out
> of gas.)

gcc 2.7.2 creates a duplicate label for each function label.  That is no
problem as both always have the same value.  But I assume you're talking
about a different type of label?  Can you send a piece of small piece of
source code and the assembler code generated from it to demonstrate the
problem?

Anyway, these days gcc 2.7.2 is so old these days it's not even funny.  You
really should upgrade.

  Ralf
