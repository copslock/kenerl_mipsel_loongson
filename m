Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 16:49:59 +0100 (BST)
Received: from UX3.SP.CS.CMU.EDU ([IPv6:::ffff:128.2.198.103]:46209 "HELO
	ux3.sp.cs.cmu.edu") by linux-mips.org with SMTP id <S8225268AbTDOPt6>;
	Tue, 15 Apr 2003 16:49:58 +0100
Received: from GS256.SP.CS.CMU.EDU ([128.2.199.27]) by ux3.sp.cs.cmu.edu
          id aa01769; 15 Apr 2003 11:49 EDT
Subject: Re: Soft floating point on 5K
From: Justin Carlson <justinca@cs.cmu.edu>
To: Dennis Castleman <DennisCastleman@oaktech.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <16027.58679.576152.853200@gladsmuir.mips.com>
References: <56BEF0DBC8B9D611BFDB00508B5E2634102F07@TLEXMAIL>
	 <16027.58679.576152.853200@gladsmuir.mips.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050421778.1988.23.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 15 Apr 2003 11:49:38 -0400
Content-Transfer-Encoding: 7bit
Return-Path: <justinca@cs.cmu.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2062
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinca@cs.cmu.edu
Precedence: bulk
X-list: linux-mips

On Tue, 2003-04-15 at 06:55, Dominic Sweetman wrote:
> Dennis Castleman (DennisCastleman@oaktech.com) writes:
> 
> > I'm trying to run soft-floating point functions on a r5000 core with
> > a FPU. Without having to take the overhead of using a trap.  Using
> > the files fp-bit.c and dp-bit.c from the gcc source as a floating
> > point lib.  This implementation lack in accuracy in the least
> > signeficant bit multiplication in division operations.
> 
> There's an IEEE-compatible set of software floating point routines in
> the Linux kernel, invoked by the trap handler.  The routines were
> donated by Algorithmics (now part of MIPS Technologies).
>
> If you wrapped them in the appropriate GCC skins, they should give you
> a soft-float library which works better.
> 

I've found John Hauser's softfloat package to be an excellent resource
for such applications.  It's under a BSD licence, and can be found here:

http://www.jhauser.us/arithmetic/SoftFloat.html

I've been very happy with it in a couple of projects.  

-Justin
