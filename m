Received:  by oss.sgi.com id <S305160AbQCNTB1>;
	Tue, 14 Mar 2000 11:01:27 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:60764 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305156AbQCNTBN>; Tue, 14 Mar 2000 11:01:13 -0800
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA03762; Tue, 14 Mar 2000 11:04:35 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id LAA94582; Tue, 14 Mar 2000 11:01:11 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA13746
	for linux-list;
	Tue, 14 Mar 2000 10:51:38 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA25052
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 14 Mar 2000 10:51:29 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA07544
	for <linux@cthulhu.engr.sgi.com>; Tue, 14 Mar 2000 10:51:17 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from lithium (lithium.tucc.uab.edu [138.26.15.219])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id MAA07263;
	Tue, 14 Mar 2000 12:50:46 -0600
Date:   Tue, 14 Mar 2000 12:50:46 -0600 (CST)
From:   "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@lithium
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     "Kevin D. Kissell" <kevink@mips.com>,
        Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        linux-mips@vger.rutgers.edu, linux-mips@fnet.fr,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: FP emulation patch available
In-Reply-To: <20000313144657.E845@uni-koblenz.de>
Message-ID: <Pine.LNX.3.96.1000314123742.24923A-100000@lithium>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing



On Mon, 13 Mar 2000, Ralf Baechle wrote:
> On Mon, Mar 13, 2000 at 09:33:02AM +0100, Kevin D. Kissell wrote:
> 
> > Does anyone out there actually need/want an SMP
> > version of the emulator?   It's not completely trivial,
> > but it would not be all that difficult to do...
> 
> It should be fixed if it's going to be used as the base for the kernel
> fp support we need also for the Origins.

This should not be an issue for the design I am using for the hardware fp
support.  It will have a different entry point into the operation
emulation code that will use the hardware registers instead of the
software fpu struct.  It will also only handle operations that should
produce an unimplemented exception (this is not quite all of the fp ops).
Ralf, from discussing this with you earlier, this should be SMP safe, but
it should be checked anyway.  I will try and get some code out this week.

-Andrew
