Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5E6N8q02695
	for linux-mips-outgoing; Wed, 13 Jun 2001 23:23:08 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5E6N7P02690
	for <linux-mips@oss.sgi.com>; Wed, 13 Jun 2001 23:23:07 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id BAB0B125BA; Wed, 13 Jun 2001 23:23:06 -0700 (PDT)
Date: Wed, 13 Jun 2001 23:23:06 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Ian Lance Taylor <ian@zembu.com>
Cc: gcc@gcc.gnu.org, binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Re: DWARF2 exception doesn't work with gcc and gas on MIPS.
Message-ID: <20010613232306.A24354@lucon.org>
References: <20010613212940.A22683@lucon.org> <sir8wnvcch.fsf@daffy.airs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <sir8wnvcch.fsf@daffy.airs.com>; from ian@zembu.com on Wed, Jun 13, 2001 at 10:50:54PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 13, 2001 at 10:50:54PM -0700, Ian Lance Taylor wrote:
> "H . J . Lu" <hjl@lucon.org> writes:
> 
> > In the MIPS gas, there is
> > 
> >     case M_JAL_A:
> 
> Not the relevant bit of code, not that it matters much.  The
> instruction
>       jal     $31,$25
> will be handled by the M_JAL_1 case in gas/config/tc-mips.c.
> 
> > Does anyone have any suggestions how to fix it?
> 
> Traditional MIPS assemblers try to make life easier by doing this sort
> of translation.  Modern MIPS compilers sidestep the translation
> because they can do better.  In this case gcc evidently needs to do
> better in order to makes it exception handling model work.  gcc should
> generate a jalr instruction, and should restore the GP register
> itself.
> 
> (I suppose that it would be theoretically possible for gas to
> recognize labels of the special form $LEHEn.  But that seems quite
> dreadful and quite fragile.)

The more I look at the problem, the more I doubt DAWRF2 exception will
ever work with the SVR4 MIPS ABI without the full support from gcc. The
problem is GP is a caller saved register in the SVR4 MIPS ABI. So every
caller has to do

	call foo
	restore gp

Given a piece of C++ code:

  try
    {
      foo (...);
      .....
    }
  catch (...)
    {
    }

When foo () throws an exception, it is gcc who has to make sure that
GP gets properly restored. Is there a way to teach the gcc exception
code that GP is a caller saved register?

BTW, in IRIX 6, GP is changed to callee saved so that it is not a
problem. 


H.J.
