Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id GAA45613; Fri, 15 Aug 1997 06:17:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA10475 for linux-list; Fri, 15 Aug 1997 06:17:36 -0700
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA10465 for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 06:17:33 -0700
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (940816.SGI.8.6.9/930416.SGI)
	 id JAA10373; Fri, 15 Aug 1997 09:17:25 -0400
Message-ID: <33F456E5.D83E32F8@cygnus.detroit.sgi.com>
Date: Fri, 15 Aug 1997 09:17:25 -0400
From: Eric Kimminau <eak@cygnus.detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.02 [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: daviddb@johannesburg.sgi.com
CC: linux@cthulhu.engr.sgi.com, Ariel Faigon <ariel@sgi.com>
Subject: Re: linus accessible from within SGI
References: <199708141832.LAA29943@oz.engr.sgi.com> <33F44FBA.60321898@johannesburg.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

David S. de Beer wrote:
> 
> Ariel Faigon wrote:
> 
> > In the case of perl it is easy to cross the firewall by simply
> > using a proxy. i.e. you don't need to SOCSify you perl since
> > the proxy (which is SOCKsified) does the job for you.
> >
> > Enclosed below is a (http) 'GET' script that uses one possible
> > SGI proxy when given the -e option. The method uses is the name
> > of the script so you may symlink it to 'HEAD' for example.
> >
> > --
> > Peace, Ariel
> >
> >
> 
> Ariel,
> 
> Wow, great :) Do you perhaps have a perl script for ftp as well?
> 
> Also, I've looked around for a xftp client that works with socks and can also copy
> recursive directories. Is there something like this available?
> 
> Thank you kindly.
> 
> David


ncftp will do this David. You need the latest version though. The dist
on dist.engr:/sgi/hacks is NOT up to date and has problems going through
a SOCKS proxy.

-- 
Eric Kimminau                           System Engineer/RSA
eak@detroit.sgi.com                     Silicon Graphics, Inc
Voice: (248) 848-4455                   39001 West 12 Mile Rd.
Fax:   (248) 848-5600                   Farmington, MI 48331-2903

                 VNet Extension - 6-327-4455
              "I speak my mind and no one else's."
       http://www.dcs.ex.ac.uk/~aba/rsa/perl-rsa-sig.html

    When confronted by a difficult problem, solve it by reducing 
    it to the question, "How would the Lone Ranger handle this?"

Windows 95: n.
    32 bit extensions and a graphical shell for a 16 bit patch to an
    8 bit operating system originally coded for a 4 bit microprocessor,
    written by a 2 bit company that can't stand 1 bit of competition.

    Author unknown.
