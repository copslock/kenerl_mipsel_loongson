Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id MAA812529 for <linux-archive@neteng.engr.sgi.com>; Fri, 9 Jan 1998 12:10:26 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA24218 for linux-list; Fri, 9 Jan 1998 12:07:18 -0800
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA24200 for <linux@cthulhu.engr.sgi.com>; Fri, 9 Jan 1998 12:07:13 -0800
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/930416.SGI)
	 id PAA03701; Fri, 9 Jan 1998 15:07:12 -0500
Received: from detroit.sgi.com (localhost [127.0.0.1]) by cygnus.detroit.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id PAA09408; Fri, 9 Jan 1998 15:07:10 -0500
Message-ID: <34B6836E.1F366317@detroit.sgi.com>
Date: Fri, 09 Jan 1998 15:07:10 -0500
From: Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.04C-SGI [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: Alex deVries <adevries@engsoc.carleton.ca>
CC: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: RedHat 5.0 RPMs for SGI...
References: <Pine.LNX.3.95.980109143918.55A-100000@lager.engsoc.carleton.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries wrote:
> Some odd problems I'm encountering:
> - the bare system which runs nothing consumes 20MB of RAM.  I'm using
> Ralf's 2.1.67 kernel.  Perhaps I'm reading it wrong, but 'free' gives me
> 20MB used, 16MB which is unaccounted for.  Does this mean the kernel is
> using 16MB? Wow. It explains the 'memory exhausted' problems I get.
> - gcc occasionally segfaults.
> 
> But, I have a functional system I can telnet into with virtual consoles
> and most things II need to get boot strapped.  It looks good.
> 
> - A

Linux always reports all of your memory used. At least it always has on
my PC at home.

-- 
---------1---------2---------3---------4---------5---------6---------7---------8
Eric Kimminau                           RTA/RSA
eak@detroit.sgi.com                     Silicon Graphics, Inc
Voice: (248) 848-4455                   39001 West 12 Mile Rd.
Fax:   (248) 848-5600                   Farmington, MI 48331-2903

                 VNet Extension - 6-327-4455
              "I speak my mind and no one else's."
       http://www.dcs.ex.ac.uk/~aba/rsa/perl-rsa-sig.html

    When confronted by a difficult problem, solve it by reducing 
    it to the question, "How would the Lone Ranger handle this?"
	
         "I am the great supportfolio, do you have http?"
