Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA04358 for <linux-archive@neteng.engr.sgi.com>; Mon, 22 Jun 1998 02:12:27 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA69027
	for linux-list;
	Mon, 22 Jun 1998 02:12:13 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA70886
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 22 Jun 1998 02:12:11 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id CAA26795
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 Jun 1998 02:12:01 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-03.uni-koblenz.de [141.26.249.3])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id LAA11880
	for <linux@cthulhu.engr.sgi.com>; Mon, 22 Jun 1998 11:11:59 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id LAA01353;
	Mon, 22 Jun 1998 11:11:54 +0200
Message-ID: <19980622111154.I418@uni-koblenz.de>
Date: Mon, 22 Jun 1998 11:11:54 +0200
To: LetherGlov@aol.com, linux@cthulhu.engr.sgi.com
Subject: Re: Running Linux on Linus
References: <f48fe728.358c76bd@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <f48fe728.358c76bd@aol.com>; from LetherGlov@aol.com on Sat, Jun 20, 1998 at 10:58:04PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Jun 20, 1998 at 10:58:04PM -0400, LetherGlov@aol.com wrote:

>        In response to the ideas floating around about running Linux on Linus,
> I think that before you give Bob Mende and William Earl tons of work
> configuring it (and rebooting), that If I understand things correctly it is a
> good idea to enable the Watchdog features of the Dallas 1386 clock, so that if
> there are any kernel panics or troubles or whatever may occur that the
> watchdog would automatically restart linus in the event that the kernel was
> no-longer updating the timer.

Talking about the Dallas chip, we still don't have proper Dallas RTC
support (/proc/rtc rsp. /dev/rtc), so we currently cannot even adjust
the rtc under Linux.  Definately a must before we switch.

I had my headaches about the stability of the kernel - I should probably 
given them up.  I'm running crashless and hickupless since two weeks
even though I've been trying hard to stress the system and trigger the
one known problem causing a bus error.  Probably time for wider testing.

> If I am just completely off on the whole general concept of a Watchdog please
> tell me, but I think that(if I'm right) it might be a good idea for everybody
> to have that feature available to them :-) The documentation that I was
> reading at Dallas' website implied that the only thing involved was to have
> the clock stuff to reset, or update, the reset time of the timer every xxx
> seconds to prevent it from restarting an out-of-control processor.

The idea of a software watchdog is good, it's somewhere on the bottom of
my to do list since quite some time.

  Ralf
