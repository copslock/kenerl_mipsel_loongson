Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA02865 for <linux-archive@neteng.engr.sgi.com>; Wed, 29 Jul 1998 08:41:44 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA05599
	for linux-list;
	Wed, 29 Jul 1998 08:40:49 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id IAA37908;
	Wed, 29 Jul 1998 08:40:45 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id IAA20337; Wed, 29 Jul 1998 08:40:10 -0700
Date: Wed, 29 Jul 1998 08:40:10 -0700
Message-Id: <199807291540.IAA20337@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: 4819 <rmk@shell.mdc.net>, linux@cthulhu.engr.sgi.com
Subject: Re: sound, power button, volume buttons
In-Reply-To: <19980729090902.D1989@uni-koblenz.de>
References: <Pine.BSI.3.96.980729001735.24028A-100000@shell.mdc.net>
	<19980729090902.D1989@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
...
 > You won't find any Indy hardware / firmware programming interfaces online.
 > Myself and a few of other developers have received paper copies in exchange
 > against the promise to not pass them on to other people.  Maybe if the
 > electronic versions still exist (?) SGI would agree to spread these
 > documents - I expect more people to be interested in that documentation
 > in the future as the number of installation grows.
...

     So far, I have not found any of the electronic copies; Indy was
done before the software people persuaded the hardware people to be 
religious about source control.  :-)

     I can generally answer specific questions.  Also, I can arrange to send
a copy of the documentation to people who want to actively work on the
project.  (The informal limited distribution agreement was the basis on which
the management agreed to let us release the documentation.)  

     People have asked about documentation for other products.  In general,
I don't know where to find documentation for any of the SGI R3000-based systems.
I do have incomplete documentation for some of the MIPS systems.  SGI will
probably be reluctant to release Challenge, Origin, or Octane documentation
anytime soon, although that might change if we persuade the management to
embrace linux officially (which might happen if the linux commercial server
business on other platforms continues to expand rapidly).  I also have
not found much documentation for Indigo R4000, although it is fairly
similar to Indy and Indigo2.  Indigo2 is very close to Indy, although
XZ and better graphics differ from the base XL/Newport graphics on Indy
and some low-end Indigo2 systems; Indigo2 and Indy run the same IRIX kernel
binary.  O2 documentation is quite good, and the electronic versions are
readily available, but I do not have approval to release that documentation
at present; that might change if we agree to facilitate early linix ports
to our next generation workstations, and will likely change once O2 goes
out of production.
