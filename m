Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1PJVt727269
	for linux-mips-outgoing; Mon, 25 Feb 2002 11:31:55 -0800
Received: from hell (buserror-extern.convergence.de [212.84.236.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1PJVm927266;
	Mon, 25 Feb 2002 11:31:48 -0800
Received: from js by hell with local (Exim 3.33 #1 (Debian))
	id 16fPuX-0000x8-00; Mon, 25 Feb 2002 19:31:41 +0100
Date: Mon, 25 Feb 2002 19:31:41 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: Hartvig Ekner <hartvige@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Setting up of GP in static, non-PIC version of glibc?
Message-ID: <20020225183141.GA3560@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Ralf Baechle <ralf@oss.sgi.com>, Hartvig Ekner <hartvige@mips.com>,
	linux-mips@oss.sgi.com
References: <200202251516.QAA22570@copsun18.mips.com> <20020225173433.B3680@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020225173433.B3680@dea.linux-mips.net>
User-Agent: Mutt/1.3.27i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Feb 25, 2002 at 05:34:33PM +0100, Ralf Baechle wrote:
> On Mon, Feb 25, 2002 at 04:16:20PM +0100, Hartvig Ekner wrote:
> 
> >         .globl ENTRY_POINT
> >         .type ENTRY_POINT,@function
> > ENTRY_POINT:
> > #ifdef __PIC__
> >         SET_GP
> > #else
> >         la  $28, _gp
> > #endif
> > 
> > Makes things work (this code ends in crt1.o). Is this the right place to 
> > fix it?
> 
> Non-PIC code doesn't use $gp, so any reference to $gp is a bug.  Note
> that we don't support global data optimization for ELF either that is,
> -G 0 is the default.

I recently experimented with dietlibc and tried to create
static, non-PIC binaries, with some success.
Contradicting the docs (gcc info), -G 0 is not the default but
has to be passed explicitely (even when using the GNU assembler).

BTW: Who is "we"? Do you mean global data optimization is broken
in gcc/binutils or just that no one at SGI is using it?


Regards,
Johannes
