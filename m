Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1PJdjU27473
	for linux-mips-outgoing; Mon, 25 Feb 2002 11:39:45 -0800
Received: from dea.linux-mips.net (a1as07-p84.stg.tli.de [195.252.188.84])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1PJde927470
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 11:39:41 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1PIdSf04410;
	Mon, 25 Feb 2002 19:39:28 +0100
Date: Mon, 25 Feb 2002 19:39:28 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Johannes Stezenbach <js@convergence.de>, Hartvig Ekner <hartvige@mips.com>,
   linux-mips@oss.sgi.com
Subject: Re: Setting up of GP in static, non-PIC version of glibc?
Message-ID: <20020225193928.A4385@dea.linux-mips.net>
References: <200202251516.QAA22570@copsun18.mips.com> <20020225173433.B3680@dea.linux-mips.net> <20020225183141.GA3560@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020225183141.GA3560@convergence.de>; from js@convergence.de on Mon, Feb 25, 2002 at 07:31:41PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 25, 2002 at 07:31:41PM +0100, Johannes Stezenbach wrote:

> > 
> > Non-PIC code doesn't use $gp, so any reference to $gp is a bug.  Note
> > that we don't support global data optimization for ELF either that is,
> > -G 0 is the default.
> 
> I recently experimented with dietlibc and tried to create
> static, non-PIC binaries, with some success.
> Contradicting the docs (gcc info), -G 0 is not the default but
> has to be passed explicitely (even when using the GNU assembler).

It always was until somebody broke gcc.

> BTW: Who is "we"? Do you mean global data optimization is broken
> in gcc/binutils or just that no one at SGI is using it?

It's an ECOFF specific optimization that just has been forward ported into
the ELF world.  And what does this have to do with SGI anyway?

  Ralf
