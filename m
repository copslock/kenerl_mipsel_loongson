Received:  by oss.sgi.com id <S305160AbQARD6t>;
	Mon, 17 Jan 2000 19:58:49 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:49720 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305159AbQARD6b>;
	Mon, 17 Jan 2000 19:58:31 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id TAA21898; Mon, 17 Jan 2000 19:55:53 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA41510
	for linux-list;
	Mon, 17 Jan 2000 19:42:54 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA58802
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 17 Jan 2000 19:42:51 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA06713
	for <linux@cthulhu.engr.sgi.com>; Mon, 17 Jan 2000 19:42:49 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id VAA23385;
	Mon, 17 Jan 2000 21:42:43 -0600
Date:   Mon, 17 Jan 2000 21:41:01 -0600 (CST)
From:   "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Floating point questions
In-Reply-To: <20000118042655.C10759@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.1000117213351.28191G-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing



On Tue, 18 Jan 2000, Ralf Baechle wrote:
> On Mon, Jan 17, 2000 at 08:55:58PM -0600, Andrew R. Baker wrote:
> 
> > Whilst playing with floating point support I have noticed that the
> > "Division By Zero" and "Overflow" Enable bits are set by default on Linux
> > where they are not in IRIX.  Is there a reason we do this?  Or is this
> > behaviour unintended?  
> 
> We've got two versions of libc circulating.  The one enables a number
> of exceptions, same as an old libc 4 or 5 from ~95.  The current and
> correct one just leaves all exceptions disabled.
> 
> Btw, C9x provides interfaces to manipulate the exception bits.

OK, I'll just set my test progs to clear the enable bits.

> > Also, when we enter the floating point handler, the floating point
> > registers have not been saved to the thread structure.  Currently, I get
> > around this by querying the registers directly.  Unfortunately this won't
> > work when we support SMP.
> 
> Why should this not be working with SMP?  Only when the FPU contains the
> current' processes' fp context CP1 is enabled in the status register.
> If not any attempt to execute the fp instruction will result in a
> Coprocessor Unavailable exception which will be serviced by loading
> the context into the FPU and setting the CU1 bit.

I was basing my assumptions on what the sparc fpu system looked like.  The
code seems to infer that, in SMP, the fp emulator can be run for a process
that is not 'current'.  I'll stick with the direct access method than (I
like it better anyway).

I am going to try and add the rest of the ops this week and put something
out for people to look at.  Then I will clean it up some.  Is there any
disadvantage to leaving this as a module?

-Andrew
