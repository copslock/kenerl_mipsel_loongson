Received:  by oss.sgi.com id <S305160AbQAREGU>;
	Mon, 17 Jan 2000 20:06:20 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:16721 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305159AbQAREGJ>;
	Mon, 17 Jan 2000 20:06:09 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA06018; Mon, 17 Jan 2000 20:07:54 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA79811
	for linux-list;
	Mon, 17 Jan 2000 19:54:19 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA23825
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 17 Jan 2000 19:54:16 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA03458
	for <linux@cthulhu.engr.sgi.com>; Mon, 17 Jan 2000 19:54:13 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-8.uni-koblenz.de (cacc-8.uni-koblenz.de [141.26.131.8])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id EAA27604;
	Tue, 18 Jan 2000 04:54:09 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQARDxe>;
	Tue, 18 Jan 2000 04:53:34 +0100
Date:   Tue, 18 Jan 2000 04:53:34 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Andrew R. Baker" <andrewb@uab.edu>
Cc:     Ralf Baechle <ralf@oss.sgi.com>,
        Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Floating point questions
Message-ID: <20000118045334.A12762@uni-koblenz.de>
References: <20000118042655.C10759@uni-koblenz.de> <Pine.LNX.3.96.1000117213351.28191G-100000@mdk187.tucc.uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.3.96.1000117213351.28191G-100000@mdk187.tucc.uab.edu>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Jan 17, 2000 at 09:41:01PM -0600, Andrew R. Baker wrote:

> > correct one just leaves all exceptions disabled.
> > 
> > Btw, C9x provides interfaces to manipulate the exception bits.
> 
> OK, I'll just set my test progs to clear the enable bits.

It may be hairy but I think you'll have to deal with exception sooner
or later ...

> I was basing my assumptions on what the sparc fpu system looked like.  The
> code seems to infer that, in SMP, the fp emulator can be run for a process
> that is not 'current'.  I'll stick with the direct access method than (I
> like it better anyway).
> 
> I am going to try and add the rest of the ops this week and put something
> out for people to look at.  Then I will clean it up some.  Is there any
> disadvantage to leaving this as a module?

At least as in CVS the module doesn't make sense except for debugging -
we don't have a mechanism for loading it on demand.

  Ralf
