Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA93540 for <linux-archive@neteng.engr.sgi.com>; Tue, 8 Sep 1998 08:54:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA90696
	for linux-list;
	Tue, 8 Sep 1998 08:53:09 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sguk.reading.sgi.com (sguk.reading.sgi.com [144.253.64.2])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id IAA20602
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 8 Sep 1998 08:53:07 -0700 (PDT)
	mail_from (leon@reading.sgi.com)
Received: from wintermute.reading.sgi.com (wintermute.reading.sgi.com [144.253.74.171]) by sguk.reading.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF+cray) via ESMTP id QAA28785; Tue, 8 Sep 1998 16:53:15 +0100
Received: from localhost (localhost [127.0.0.1]) by wintermute.reading.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id QAA04576; Tue, 8 Sep 1998 16:52:50 +0100 (BST)
Date: Tue, 8 Sep 1998 16:52:50 +0100 (BST)
From: Leon Verrall <leon@reading.sgi.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Success at last...
In-Reply-To: <Pine.LNX.3.96.980904130745.26347A-100000@lager.engsoc.carleton.ca>
Message-ID: <Pine.SGI.3.96.980908164809.4502A-100000@wintermute.reading.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, 4 Sep 1998, Alex deVries wrote:

> > FInally got rid of the "Warning, unable to open console" message. I think I
> > managed it by not letting IRIX anywhere near the tarball of hard hat.
> > Downloaded and extracted entirely on Debian Linux.
> 
> This is really weird.  Can you explain in greater detail what you changed
> to make sure that it worked?

Erm. not really I'm afraid... Thinking about it the only real difference
that I can think of was I had a keyboard/mouse installed. Before I was using
a vt100 terminal. I realise that should work but maybe a missing keyboard
caused it to barf? 

I could have untearred the tarfile from an nfs mount onto the linux box
before but I can't see that having an effect... 

Any ideas on the console size thing? This could just be a cofiguration thing
I've never bothered to look at before on linux but I can't see where... 

Leon

-- 
Leon Verrall - 01189 307734  \ "Don't cut your losses too soon,
Secondline Software Support  / 'cos you'll only be cutting your throat.
Silicon Graphics, Forum 1,   \ And answer a call while you still care at all
Station Rd., Theale, RG7 4RA / 'cos nobody will if you wont" (6:00 - DT)
