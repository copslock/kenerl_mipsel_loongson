Received:  by oss.sgi.com id <S305160AbQARDot>;
	Mon, 17 Jan 2000 19:44:49 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:7219 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305159AbQARDoe>;
	Mon, 17 Jan 2000 19:44:34 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id TAA21042; Mon, 17 Jan 2000 19:41:57 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA18002
	for linux-list;
	Mon, 17 Jan 2000 19:27:47 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA89503
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 17 Jan 2000 19:27:43 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA07366
	for <linux@cthulhu.engr.sgi.com>; Mon, 17 Jan 2000 19:27:26 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-8.uni-koblenz.de (cacc-8.uni-koblenz.de [141.26.131.8])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id EAA25928;
	Tue, 18 Jan 2000 04:27:16 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQARD0z>;
	Tue, 18 Jan 2000 04:26:55 +0100
Date:   Tue, 18 Jan 2000 04:26:55 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Andrew R. Baker" <andrewb@uab.edu>
Cc:     Linux SGI <linux@cthulhu.engr.sgi.com>,
        Ralf Baechle <ralf@oss.sgi.com>
Subject: Re: Floating point questions
Message-ID: <20000118042655.C10759@uni-koblenz.de>
References: <Pine.LNX.3.96.1000117204924.28191E-100000@mdk187.tucc.uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.3.96.1000117204924.28191E-100000@mdk187.tucc.uab.edu>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Jan 17, 2000 at 08:55:58PM -0600, Andrew R. Baker wrote:

> Whilst playing with floating point support I have noticed that the
> "Division By Zero" and "Overflow" Enable bits are set by default on Linux
> where they are not in IRIX.  Is there a reason we do this?  Or is this
> behaviour unintended?  

We've got two versions of libc circulating.  The one enables a number
of exceptions, same as an old libc 4 or 5 from ~95.  The current and
correct one just leaves all exceptions disabled.

Btw, C9x provides interfaces to manipulate the exception bits.

> Also, when we enter the floating point handler, the floating point
> registers have not been saved to the thread structure.  Currently, I get
> around this by querying the registers directly.  Unfortunately this won't
> work when we support SMP.

Why should this not be working with SMP?  Only when the FPU contains the
current' processes' fp context CP1 is enabled in the status register.
If not any attempt to execute the fp instruction will result in a
Coprocessor Unavailable exception which will be serviced by loading
the context into the FPU and setting the CU1 bit.

> What would the drawbacks be of a save and restore and the start and
> finish of the exception handler (well the unimplemented handler)?

Performance.

>  Or is there some other way?  I'm really only
> concerned about the case where we would run the soft-fp code on a
> processor other than the one that triggered the exception.

This cannot happen.

  Ralf
