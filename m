Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA83172 for <linux-archive@neteng.engr.sgi.com>; Thu, 28 Jan 1999 08:35:41 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA22645
	for linux-list;
	Thu, 28 Jan 1999 08:34:24 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA24662
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 28 Jan 1999 08:34:21 -0800 (PST)
	mail_from (rjh@pixel.maths.monash.edu.au)
Received: from pixel.maths.monash.edu.au (pixel.maths.monash.edu.au [130.194.160.20]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA02511
	for <linux@cthulhu.engr.sgi.com>; Thu, 28 Jan 1999 08:34:19 -0800 (PST)
	mail_from (rjh@pixel.maths.monash.edu.au)
Received: (from rjh@localhost)
	by pixel.maths.monash.edu.au (8.8.8/8.8.8-ajr) id DAA10412;
	Fri, 29 Jan 1999 03:34:00 +1100 (EDT)
From: Robin Humble <rjh@pixel.maths.monash.edu.au>
Message-Id: <199901281634.DAA10412@pixel.maths.monash.edu.au>
Subject: Re: Installing Linux on an Indy with 1 HD
To: rstone@vitelus.com (Robbie Stone)
Date: Fri, 29 Jan 1999 03:34:00 +1100 (EDT)
Cc: nachtfalke@usa.net, linux@cthulhu.engr.sgi.com
In-Reply-To: <Pine.LNX.4.05.9901281531560.9205-100000@vitelus.com> from "Robbie Stone" at Jan 28, 99 03:33:28 pm
X-Mailer: ELM [version 2.4 PL23]
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


>Er, you can use gcc for most all of your building, as a matter of fact it

Actually if you're talking about using gcc under IRIX then IRIX 5.3
doesn't come with the necessary header files to compile anything(*).
You need the IDO or IRIX >= 6.5 which Alexander does not posess. Also
just to clear up some apparent confusion (which may well be mine rather
than Alexanders) in order to install SGI-Linux for Indy you don't
actually need to compile anything...

I would also point out that Linux on Indy doesn't support any X11
graphics yet. Swapping from IRIX 5.3 to something text-only could be
a bit of a shock... But wait a few months and life could be all
xPeaches and xCream :-)

Personally I'd try to find a small (hyper-cheap/free) old SCSI drive
(erm, 300-500M would do?) and install on that. Or do like Richard
suggested and permanently run your Linux/Indy off a network root drive.

cheers,
robin

(*) except the IRIX kernel. It uses a weirdly lobotomised compiler
hidden well away...

--
He'd found that even the people whose job of work was, so to speak, the
Universe, didn't really believe in it and were actually quite proud of not
knowing what it really was or even if it could theoretically exist.
     Robin Humble     /      http://www.maths.monash.edu.au/~rjh/
