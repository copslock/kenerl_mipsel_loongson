Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id WAA857030; Fri, 25 Jul 1997 22:40:22 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA29129 for linux-list; Fri, 25 Jul 1997 22:39:18 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id WAA29120 for <linux@cthulhu.engr.sgi.com>; Fri, 25 Jul 1997 22:39:15 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id WAA22459
	for <linux@cthulhu.engr.sgi.com>; Fri, 25 Jul 1997 22:39:13 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id BAA30858 for <linux@cthulhu.engr.sgi.com>; Sat, 26 Jul 1997 01:38:50 -0400
Date: Sat, 26 Jul 1997 01:38:50 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: linux@cthulhu.engr.sgi.com
Subject: Tips on making yourself unpopular
In-Reply-To: <199707260245.VAA14779@athena.nuclecu.unam.mx>
Message-ID: <Pine.LNX.3.95.970726012303.22519A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I waited carefully until I was sure that everybody would be asleep, and
rearranged the FTP server.  This may not be a popular decision with some
of you, but I think this structure makes a lot more sense.

The first major change is that I've configured wu-ftpd instead of the
prepackaged ftpd that comes with Irix.

The next change is that I've moved everything to /src/ftp, so that people
aren't puzzled why we're distributing our web logs via FTP.

Also, I've shuffled some of the stuff under the former /pub/linux down
one, and put some source code (such as ktrace) where it belongs.

I've also uploaded my .rpm versions of Ralf's crossdev tools for i486
hosts.  If I had sources I could compile for binutils and gcc, I'd
generate ones for sparc-sun-linux hosted as well.

Anyway, if you don't like the FTP server structure, feel free to complain
to me.

In other news...

- the HOWTO will be seperated from the FAQ tomorrow, bringing both
  versions to 0.03. Plenty of technical details have been added

- I'm working on creating a smaller root.tar.gz package.  Having ps
  and fdisk would be very cool...

- Alex


      Alex deVries              Success is realizing 
  System Administrator          attainable dreams.
   The EngSoc Project     
