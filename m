Received:  by oss.sgi.com id <S553804AbRBHMeD>;
	Thu, 8 Feb 2001 04:34:03 -0800
Received: from noose.gt.owl.de ([62.52.19.4]:31763 "HELO noose.gt.owl.de")
	by oss.sgi.com with SMTP id <S553800AbRBHMdo>;
	Thu, 8 Feb 2001 04:33:44 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 63ED57DD; Thu,  8 Feb 2001 13:33:33 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 58601EEAC; Thu,  8 Feb 2001 13:33:39 +0100 (CET)
Date:   Thu, 8 Feb 2001 13:33:39 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: [RESUME] fpu emulator
Message-ID: <20010208133339.B6229@paradigm.rfc822.org>
References: <20010208122030.A5408@paradigm.rfc822.org> <005d01c091c4$69940620$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <005d01c091c4$69940620$0deca8c0@Ulysses>; from kevink@mips.com on Thu, Feb 08, 2001 at 12:43:30PM +0100
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Feb 08, 2001 at 12:43:30PM +0100, Kevin D. Kissell wrote:
> > Hi,
> > just to get it right - As i thought the FPU emulator is not really
> > optional - It is even required for fpu-enabled devices which means
> > we should clean the code in that way that if the user decides to 
> > compile in the fpu emulator into the kernel we do an autodetection 
> > upfront and change some of the entry/exit/lazy_fpu stuff.
> > If the user decides not to compile in the FPU Emulator he is on his
> > own and we ignore the whole FPU stuff and simply send SIGILL/SIGFPE
> > to the processes causing all fpu binarys to fail on non-fpu enabled
> > kernels.
> 
> Not quite.  Unless we create a variant of glibc that neither
> initializes the FP control register on program startup, nor
> saves/restores the FP registers in setjmp/longjmp, the
> model of "simply sending SIGILL/SIGFPE" will result
> in *all* processes being terminated with extreme prejudice,
> starting with init!

Which is exactly i was trying to establish as when the fpu emulator
is not enabled the user should build a complete fp less userspace. And
when we edstablish the SIGILL/SIGFPE he is forced to do so which is
a "good thing(tm)"

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
