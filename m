Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA02458 for <linux-archive@neteng.engr.sgi.com>; Wed, 29 Jul 1998 09:52:39 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA26926
	for linux-list;
	Wed, 29 Jul 1998 09:51:00 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA72455;
	Wed, 29 Jul 1998 09:50:32 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA06629; Wed, 29 Jul 1998 09:50:18 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-14.uni-koblenz.de [141.26.249.14])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id SAA12307;
	Wed, 29 Jul 1998 18:50:12 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id SAA02295;
	Wed, 29 Jul 1998 18:50:07 +0200
Message-ID: <19980729185007.K771@uni-koblenz.de>
Date: Wed, 29 Jul 1998 18:50:07 +0200
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: 4819 <rmk@shell.mdc.net>, linux@cthulhu.engr.sgi.com
Subject: Re: sound, power button, volume buttons
References: <Pine.BSI.3.96.980729001735.24028A-100000@shell.mdc.net> <19980729090902.D1989@uni-koblenz.de> <199807291540.IAA20337@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199807291540.IAA20337@fir.engr.sgi.com>; from William J. Earl on Wed, Jul 29, 1998 at 08:40:10AM -0700
X-Mutt-References: <199807291540.IAA20337@fir.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jul 29, 1998 at 08:40:10AM -0700, William J. Earl wrote:

>      I can generally answer specific questions.  Also, I can arrange to send
> a copy of the documentation to people who want to actively work on the
> project.  (The informal limited distribution agreement was the basis on which
> the management agreed to let us release the documentation.)  
> 
>      People have asked about documentation for other products.  In general,
> I don't know where to find documentation for any of the SGI R3000-based systems.

Do you think a ``Call for dusty Paper'' CfdP (TM) on the Usenet in groups
like comp.sys.mips or comp.sys.sgi.* might make sense?  I bet there are
still people out there, maybe former SGI employees in the meantime which
have helpful data around.

> I do have incomplete documentation for some of the MIPS systems.

I'm currently doing some brain surgery on some OEM machine which identifies
itself as RS3230 and is running RISC/os 4.50 :-)

>                                                                   SGI will
> probably be reluctant to release Challenge, Origin, or Octane documentation
> anytime soon, although that might change if we persuade the management to
> embrace linux officially (which might happen if the linux commercial server
> business on other platforms continues to expand rapidly).  I also have
> not found much documentation for Indigo R4000, although it is fairly
> similar to Indy and Indigo2.  Indigo2 is very close to Indy, although
> XZ and better graphics differ from the base XL/Newport graphics on Indy
> and some low-end Indigo2 systems; Indigo2 and Indy run the same IRIX kernel
> binary.  O2 documentation is quite good, and the electronic versions are
> readily available, but I do not have approval to release that documentation
> at present; that might change if we agree to facilitate early linix ports
> to our next generation workstations, and will likely change once O2 goes
> out of production.

As I already wrote to Richard Masoner - it's not uncommon that people
write GPL software while being under NDA.  The company reviews the code
when it is finished and gives it's ok to publish it but the documentation
(whatever it consists of - paper, code, electronic files, drawings ...)
will stay undisclosed.  In many cases this is a way to keep both sides
happy.

Since you mentioned the various graphic subsystems above - do you think
the implementation of a ARC firmware text only based console might be
sensible?  I've got several requests for Linux from people who have a
XZ graphic which we don't support yet - and there is quite a number of
graphic options for SGI's out there so this might be somewhat helpful.

  Ralf
