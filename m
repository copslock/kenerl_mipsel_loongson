Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id CAA22213
	for <pstadt@stud.fh-heilbronn.de>; Sat, 21 Aug 1999 02:59:30 +0200
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA07702; Fri, 20 Aug 1999 17:57:26 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA96885
	for linux-list;
	Fri, 20 Aug 1999 17:50:43 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA01784
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 20 Aug 1999 17:50:40 -0700 (PDT)
	mail_from (cory@real-time.com)
Received: from paladin.real-time.com (paladin.real-time.com [206.10.252.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA03456
	for <linux@cthulhu.engr.sgi.com>; Fri, 20 Aug 1999 17:50:37 -0700 (PDT)
	mail_from (cory@real-time.com)
Received: from real-time.com (mondas.dalekchess.org [206.147.104.202])
	by paladin.real-time.com (8.8.8/8.8.8) with ESMTP id TAA12601;
	Fri, 20 Aug 1999 19:50:04 -0500 (CDT)
Message-ID: <37BDF6BA.DAFDC837@real-time.com>
Date: Fri, 20 Aug 1999 19:45:47 -0500
From: Cory Jon Hollingsworth <cory@real-time.com>
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.9 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@uni-koblenz.de>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: Hard Hat and Tandem.
References: <37B70CDF.D938EA0D@real-time.com> <19990818133932.A8965@uni-koblenz.de> <37BC8A94.289936FF@real-time.com> <19990820032312.A25007@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:

> On Thu, Aug 19, 1999 at 05:52:04PM -0500, Cory Jon Hollingsworth wrote:
>
> >     Well the above is all that comes from a straight hinv.  I do get more if
> > I do an 'hinv -t' or 'hinv -t -p' though.  Half of the 'hinv -t -p' scrolls
> > off the screen and the information seems to be redundant anyway (4 lines to
> > describe serial port 1 for instance).
> >
> >     Here is the output of an 'hinv -t'.
> >
> > system ARC SGI-IP22 key 0
> >    processor CPU MIPS-R4400 key 0
> >     processor FPU MIPS-R4400FPC key 0
> >     cache primary icache 16 Kbytes (block 1 lines, line 16 bytes)
> >     cache primary dcache 16 Kbytes (block 1 lines, line 16 bytes)
> >     cache secondary cache 1024 Kbytes (block 1 lines, line 128 bytes)
> >     memory main 256 Mbytes
> >   controller network ec0 key 0
> >     peripheral network key 0
> >   adapter SCSI WD33C93B key 0
> >     controller disk SGI SEAGATE ST31230N key 1
> >       peripheral disk unit 0
> >   controller serial IP22 tty key 0
> >     peripheral line key 0
> >   controller serial IP22 tty key 1
> >     peripheral line key 0
> >   controller keyboard pc kbd key 0
> >   controller pointer pcms key 0
> >     peripheral pointer key 0
>
> This looks indeed very much like an Indy, less a Challenge S.  A Challenge S
> usually has an additional WD33C95 SCSI controller as well as an extra
> Ethernet.  Also, afaik the keyboard controller has been removed from
> the Challenge.  So your machine looks like an Indy with the GFX removed.
>

    Actually it does have the second SCSI, but it is not showing up in the hinv
for some reason.

    I've opened up the box again to have another peak at the boards.  The top
board says this:
Silicon Graphics Inc.  Copyright 1994
SCSI-MEZZ CHALLENGE-S 030-8221-002 REV: D

    This board has the WD33C95 SCSI controller chip on it.  This board has two
wide SCSI ports out the back and an RJ45 which should be an ethernet.  It has the
little network symbol by it.  I initially tried that RJ45 port for bootp, but had
no success.  The main board below it has a female DB15 connector that I connect a
ethernet transceiver to in order to run bootp.

    The bottom board additionally has the two PS/2 like serial ports, one DB25
female (don't know what it is), and a thin SCSI port.

    It has no keyboard or mouse port even though the hinv claims it does.  I
wonder if this machine could be loaded with the incorrect boot prom?

<snip, snip>

>
> >     Tandem was a company situated in Texas that was in the business of
> > selling business servers.  At the time this box was purchased, Tandem was
> > repackaging SGI hardware and selling them as Tandem servers.  Since then
> > Tandem has been bought by Compaq, which I believe where more or less bought
> > Tandem in order to acquire the brand name.  Currently I believe Compaq sells
> > industrial computers under the Tandem name.  I do not think those machines
> > have a MIPS chip set though.
>
> Tandem has a very interesting program of HA machines and software.  They
> have more or less the only UNIX systems that guarantee like 99.99999%
> availability.
>

<snip, snip>

    Yeah it looks like Tandem is still around.  And it looks like you can still
buy MIPS based systems from them, although the sticker shock would probably kill
most of us mere mortals.  8-)  I think the claim they make is more spectacular
than the hardware they sell.  They were making this claim back when my Tandem was
made, and as you can see it is basically a Challenge S or Indy.

    Thanks.

    Cory
