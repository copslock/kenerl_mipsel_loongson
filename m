Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA16712
	for <pstadt@stud.fh-heilbronn.de>; Fri, 20 Aug 1999 23:52:21 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA05259; Fri, 20 Aug 1999 14:44:32 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA79175
	for linux-list;
	Fri, 20 Aug 1999 14:38:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA83420
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 20 Aug 1999 14:38:00 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA07429
	for <linux@cthulhu.engr.sgi.com>; Fri, 20 Aug 1999 14:37:45 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-29.uni-koblenz.de [141.26.131.29])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA16371
	for <linux@cthulhu.engr.sgi.com>; Fri, 20 Aug 1999 23:37:41 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id DAA25024;
	Fri, 20 Aug 1999 03:23:12 +0200
Date: Fri, 20 Aug 1999 03:23:12 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Cory Jon Hollingsworth <cory@real-time.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Hard Hat and Tandem.
Message-ID: <19990820032312.A25007@uni-koblenz.de>
References: <37B70CDF.D938EA0D@real-time.com> <19990818133932.A8965@uni-koblenz.de> <37BC8A94.289936FF@real-time.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <37BC8A94.289936FF@real-time.com>; from Cory Jon Hollingsworth on Thu, Aug 19, 1999 at 05:52:04PM -0500
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Aug 19, 1999 at 05:52:04PM -0500, Cory Jon Hollingsworth wrote:

>     Well the above is all that comes from a straight hinv.  I do get more if
> I do an 'hinv -t' or 'hinv -t -p' though.  Half of the 'hinv -t -p' scrolls
> off the screen and the information seems to be redundant anyway (4 lines to
> describe serial port 1 for instance).
> 
>     Here is the output of an 'hinv -t'.
> 
> system ARC SGI-IP22 key 0
>    processor CPU MIPS-R4400 key 0
>     processor FPU MIPS-R4400FPC key 0
>     cache primary icache 16 Kbytes (block 1 lines, line 16 bytes)
>     cache primary dcache 16 Kbytes (block 1 lines, line 16 bytes)
>     cache secondary cache 1024 Kbytes (block 1 lines, line 128 bytes)
>     memory main 256 Mbytes
>   controller network ec0 key 0
>     peripheral network key 0
>   adapter SCSI WD33C93B key 0
>     controller disk SGI SEAGATE ST31230N key 1
>       peripheral disk unit 0
>   controller serial IP22 tty key 0
>     peripheral line key 0
>   controller serial IP22 tty key 1
>     peripheral line key 0
>   controller keyboard pc kbd key 0
>   controller pointer pcms key 0
>     peripheral pointer key 0

This looks indeed very much like an Indy, less a Challenge S.  A Challenge S
usually has an additional WD33C95 SCSI controller as well as an extra
Ethernet.  Also, afaik the keyboard controller has been removed from
the Challenge.  So your machine looks like an Indy with the GFX removed.

> > Is it CMN B006S?  I'd like to document the fact that this machine is
> > (un?)supported in the Linux/MIPS docs.
> >
> 
>     I don't know to both questions.  The only identification the outside of
> the box is the above model name/number affixed to the bottom panel.  The box
> is jet black  and says TANDEM in the lower right corner.  I've opened it up
> and it has a copyright 1993 Silicon Graphics on one of the circuit boards,
> but the machine is absent of any obvious identification.

Too bad.  Guess for now I'll just use that ``CMN B006S'' ...

> > There are several kernels in exactly the directory you got the initrd
> > image from.
> >
> 
>     Cool.  Any idea which one I should use?  Or should I try them all until I
> find one that works?

Sorry, offhand I don't know which one is working.  Most of these
kernel binaries have been uploaded by others and since I roll my own
kernels ...

>     Well I could give you a bastardized history lesson.  Bastardized in the
> sense that I think I know the story, but could be wrong since I'm repeating
> info that has been passed to me through multiple sources.

I think it's called rumour ;-)

>     Tandem was a company situated in Texas that was in the business of
> selling business servers.  At the time this box was purchased, Tandem was
> repackaging SGI hardware and selling them as Tandem servers.  Since then
> Tandem has been bought by Compaq, which I believe where more or less bought
> Tandem in order to acquire the brand name.  Currently I believe Compaq sells
> industrial computers under the Tandem name.  I do not think those machines
> have a MIPS chip set though.

Tandem has a very interesting program of HA machines and software.  They
have more or less the only UNIX systems that guarantee like 99.99999%
availability.

>     I actually have a second Tandem box which is still a mystery box since it
> requires a 220 outlet and the power grid in my apartment needs to be
> customized to support it. 8-)  Once I get that monster up and running I'll
> have to run an hinv to see what it has for guts.

220 everywhere here.  But I fear that I'll soon need a 400V connector
for my next machine ...

  Ralf
