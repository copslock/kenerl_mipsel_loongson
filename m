Received:  by oss.sgi.com id <S553848AbQKCSIa>;
	Fri, 3 Nov 2000 10:08:30 -0800
Received: from rotor.chem.unr.edu ([134.197.32.176]:2318 "EHLO
        rotor.chem.unr.edu") by oss.sgi.com with ESMTP id <S553830AbQKCSIP>;
	Fri, 3 Nov 2000 10:08:15 -0800
Received: (from wesolows@localhost)
	by rotor.chem.unr.edu (8.9.3/8.9.3) id KAA08341;
	Fri, 3 Nov 2000 10:07:28 -0800
Date:   Fri, 3 Nov 2000 10:07:28 -0800
From:   Keith M Wesolowski <wesolows@chem.unr.edu>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
Cc:     linux-mips@oss.sgi.com
Subject: Re: More GCC problems
Message-ID: <20001103100728.A8133@chem.unr.edu>
References: <20001103143725.A2123@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20001103143725.A2123@woody.ichilton.co.uk>; from mailinglist@ichilton.co.uk on Fri, Nov 03, 2000 at 02:37:25PM +0000
X-Complaints-To: postmaster@chem.unr.edu
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Nov 03, 2000 at 02:37:25PM +0000, Ian Chilton wrote:

> Hello,
> 
> > /tmp/cca08866.s: Assembler messages:
> > /tmp/cca08866.s:27593: Error: Branch out of range
> > /tmp/cca08866.s:27632: Error: Branch out of range
> > /tmp/cca08866.s:27637: Error: Branch out of range
> 
> I get this same thing, when doing this:

Don't blame the compiler. This is a gas problem. You should be able to
get around it by using optimization; -O2 is sufficient I believe. If
not, you may have to use -Os.

> PLEASE someone help me out here.... I have spent the last 2 days
> trying to compile GCC. I have tried every version I can find, from
> 07072000 to 1707200 which suposidly work, to the lastest CVS
> version. I have tried native and cross compiling....  I need a 2.97
> native build, static, to compile glibc 2.2, then build a 2.97
> dynamic.

I have no idea how to build a static compiler. The approach I took to
get my working native 1019 compiler was to cross-build it with the
same version. Since it was built against glibc 2.2, I simply installed
both glibc 2.2 and the new native compiler on my system.

-- 
Keith M Wesolowski			wesolows@chem.unr.edu
University of Nevada			http://www.chem.unr.edu
Chemistry Department Systems and Network Administrator
