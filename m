Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id GAA188564; Thu, 14 Aug 1997 06:16:09 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA13967 for linux-list; Thu, 14 Aug 1997 06:15:39 -0700
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA13950 for <linux@cthulhu.engr.sgi.com>; Thu, 14 Aug 1997 06:15:36 -0700
Received: from dormammu.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (940816.SGI.8.6.9/930416.SGI)
	 id JAA26962; Thu, 14 Aug 1997 09:15:32 -0400
Received: (from mjo@localhost) by dormammu.detroit.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA20926; Thu, 14 Aug 1997 09:15:30 -0400
Message-Id: <199708141315.JAA20926@dormammu.detroit.sgi.com>
Subject: Re: linus accessible from within SGI
To: eak@detroit.sgi.com
Date: Thu, 14 Aug 1997 09:15:30 -0400 (EDT)
Cc: ariel@sgi.com, linux@cthulhu.engr.sgi.com, comm-tech@rock.csd.sgi.com
In-Reply-To: <33F21CB2.7464B074@cygnus.detroit.sgi.com> from "Eric Kimminau" at Aug 13, 97 04:44:34 pm
From: mjo@sgi.com (Michael O'Connor)
X-Organization: Silicon Graphics/Cray Research
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


|Has anyone been able to get "mirror" work via socks through our
|firewall?

By 'mirror', I take it you mean the perl mirror program.  :)

The more general question is:  How do you get perl TCP/IP programs
to work over SOCKS?  It appears that Simon Cooper, sc@sgi.com, is
working on a perl module to do that.  Suggest you talk with him, or
use something else to mirror -- some of the nouveau FTP clients
do this, and could probably be easily SOCKSified.  

-- 
 Michael J. O'Connor   |  Phone:    +1 (248) 848-4481  |    "Do, or do not.
 39001 W. 12 Mile Rd   |  Fax:      +1 (248) 848-5600  |  There is no try."
 Farmington Hills, MI  |  Internet:       mjo@sgi.com  |
 48331-2903  DMR-225   |  http://reality.sgi.com/mjo/  |              -Yoda
