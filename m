Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id NAA17546; Wed, 13 Aug 1997 13:45:08 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA23529 for linux-list; Wed, 13 Aug 1997 13:44:43 -0700
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA23511 for <linux@cthulhu.engr.sgi.com>; Wed, 13 Aug 1997 13:44:40 -0700
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (940816.SGI.8.6.9/930416.SGI)
	 id QAA19531; Wed, 13 Aug 1997 16:44:34 -0400
Message-ID: <33F21CB2.7464B074@cygnus.detroit.sgi.com>
Date: Wed, 13 Aug 1997 16:44:34 -0400
From: Eric Kimminau <eak@cygnus.detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.02 [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: Ariel Faigon <ariel@sgi.com>
CC: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>,
        comm-tech@rock.csd.sgi.com
Subject: Re: linus accessible from within SGI
References: <199708132022.NAA27369@oz.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ariel Faigon wrote:
> 
> Good news:
> 
> Looks like the routing problem that prevented many outside .engr
> to access linus is now fixed.
> 
> guest@sgigate 3% traceroute linus.linux.sgi.com
> traceroute to linus.linux.sgi.com (192.48.153.197), 30 hops max, 40 byte packets
>  1  purgatory.SGI.COM (204.94.209.2)  2 ms  5 ms  3 ms
>  2  forbidden (204.94.211.38)  4 ms  14 ms  7 ms
>  3  paloalto-cr6.bbnplanet.net (131.119.26.57)  90 ms  105 ms  63 ms
>  4  paloalto-cr4.bbnplanet.net (131.119.0.148)  684 ms  113 ms  75 ms
>  5  paloalto-cr34.bbnplanet.net (131.119.0.109)  11 ms  15 ms  22 ms
>  6  sgi.bbnplanet.net (131.119.16.6)  27 ms  16 ms  24 ms
>  7  linus.linux.sgi.com (192.48.153.197)  16 ms  18 ms  18 ms
> 
> Roundabout, but working.
> 
> --
> Peace, Ariel

Ive been able to rftp to it, and Ive now surf'ed to it but Im still
having a hard time getting mirror to work to it.

Has anyone been able to get "mirror" work via socks through our
firewall?

I would like to mirror linus.linux on an internal SGI, linux.detroit,
which is currntly up and running.

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
