Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 20:00:58 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:36256 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225535AbUA1UA5>;
	Wed, 28 Jan 2004 20:00:57 +0000
Received: from drow by nevyn.them.org with local (Exim 4.30 #1 (Debian))
	id 1Alvrg-00048J-1L; Wed, 28 Jan 2004 15:00:44 -0500
Date: Wed, 28 Jan 2004 15:00:44 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Jun Sun <jsun@mvista.com>
Cc: Rajesh Palani <rpalani2@yahoo.com>, linux-mips@linux-mips.org
Subject: Re: SoftFloat implementation for MIPS in GCC
Message-ID: <20040128200044.GA15794@nevyn.them.org>
References: <20040128192636.32578.qmail@web21603.mail.yahoo.com> <20040128193355.GA14318@nevyn.them.org> <20040128115312.B6210@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128115312.B6210@mvista.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 28, 2004 at 11:53:12AM -0800, Jun Sun wrote:
> On Wed, Jan 28, 2004 at 02:33:55PM -0500, Daniel Jacobowitz wrote:
> > On Wed, Jan 28, 2004 at 11:26:36AM -0800, Rajesh Palani wrote:
> > > Hi,
> > >  
> > >    We are using a gcc 2.96 20000731 (Red Hat Linux 7.1 2.96-99.1) GCC cross-compiler with -msoftfloat to use software floating point routines.
> > >  
> > >    When we profied an application using the Linux Trace Toolkit, we observed that  there were a lot of CpU (Co-processor unusable) exceptions.  Some of the floating point routines ( eg. __floatdidf) expect values to be passed in floating point registers and take FP exceptions even though the application has been built with -msoftfloat.  Is this a general MIPS/GCC issue?  What is the status of softfloat  for MIPS in GCC?
> > 
> > Try a more recent compiler, that one is ancient.  If you configure
> > correctly, you should get no references to the floating point registers
> > at all.
> > 
> 
> If glibc is not compiled with -msoftfloat, I think you will get a few
> FPU exceptions from glibc no matter how apps are compiled.  
> 
> Actually, will it be a problem if glibc and apps are compiled differently
> (such as in longjump, sig handling area)?

Yes, that will be a problem.  Nothing that takes or returns a floating
point value will work either.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
