Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id GAA07730 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 06:01:36 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id FAA17898 for linux-list; Wed, 14 Jan 1998 05:58:49 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id FAA17879 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 05:58:39 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id FAA19835
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 05:58:27 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from zaphod (ralf@zaphod.uni-koblenz.de [141.26.4.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id OAA27301;
	Wed, 14 Jan 1998 14:58:22 +0100 (MET)
Received: by zaphod (SMI-8.6/KO-2.0)
	id OAA23229; Wed, 14 Jan 1998 14:58:20 +0100
Message-ID: <19980114145820.04564@uni-koblenz.de>
Date: Wed, 14 Jan 1998 14:58:20 +0100
From: ralf@uni-koblenz.de
To: Oliver Frommel <oliver@aec.at>
Cc: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: The world's worst RPM
References: <Pine.LNX.3.95.980114013153.10190J-100000@lager.engsoc.carleton.ca> <Pine.LNX.3.96.980114142642.12148A-100000@web.aec.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <Pine.LNX.3.96.980114142642.12148A-100000@web.aec.at>; from Oliver Frommel on Wed, Jan 14, 1998 at 02:28:32PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jan 14, 1998 at 02:28:32PM +0100, Oliver Frommel wrote:

> > Anyway, I kludged it into compiling, but I really had to guess on the
> > parameters for the disk operations.  Fdisk compiles and works, but I can't
> > really test it as I need both disks on my system.  Could somebody give it
> > a try?
> > 
> 
> i'll do that tomorrow (when i am back at my indy).
> i also wonder what you changed to not only make it compile but also work,
> but i guess i'll see .. :)
> anyway if there's still anything to work on, converning fdisk, i'd have some
> time to do so this weekend ..

As I understand Alex's words he only made fdisk running but it still doesn't
support IRIX style disklabels.  How about that?

That's aside of getting rid of sash one of the major thing we still need
to do in order to get fully self hosting.

  Ralf
