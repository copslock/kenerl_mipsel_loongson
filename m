Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 19:53:45 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:17916 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225413AbUA1Txo>;
	Wed, 28 Jan 2004 19:53:44 +0000
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id i0SJrCL06815;
	Wed, 28 Jan 2004 11:53:12 -0800
Date: Wed, 28 Jan 2004 11:53:12 -0800
From: Jun Sun <jsun@mvista.com>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Rajesh Palani <rpalani2@yahoo.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: SoftFloat implementation for MIPS in GCC
Message-ID: <20040128115312.B6210@mvista.com>
References: <20040128192636.32578.qmail@web21603.mail.yahoo.com> <20040128193355.GA14318@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040128193355.GA14318@nevyn.them.org>; from dan@debian.org on Wed, Jan 28, 2004 at 02:33:55PM -0500
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Wed, Jan 28, 2004 at 02:33:55PM -0500, Daniel Jacobowitz wrote:
> On Wed, Jan 28, 2004 at 11:26:36AM -0800, Rajesh Palani wrote:
> > Hi,
> >  
> >    We are using a gcc 2.96 20000731 (Red Hat Linux 7.1 2.96-99.1) GCC cross-compiler with -msoftfloat to use software floating point routines.
> >  
> >    When we profied an application using the Linux Trace Toolkit, we observed that  there were a lot of CpU (Co-processor unusable) exceptions.  Some of the floating point routines ( eg. __floatdidf) expect values to be passed in floating point registers and take FP exceptions even though the application has been built with -msoftfloat.  Is this a general MIPS/GCC issue?  What is the status of softfloat  for MIPS in GCC?
> 
> Try a more recent compiler, that one is ancient.  If you configure
> correctly, you should get no references to the floating point registers
> at all.
> 

If glibc is not compiled with -msoftfloat, I think you will get a few
FPU exceptions from glibc no matter how apps are compiled.  

Actually, will it be a problem if glibc and apps are compiled differently
(such as in longjump, sig handling area)?

Jun
