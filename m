Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id GAA46133; Fri, 15 Aug 1997 06:38:34 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA13469 for linux-list; Fri, 15 Aug 1997 06:38:20 -0700
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA13455 for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 06:38:10 -0700
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (940816.SGI.8.6.9/930416.SGI)
	 id JAA10572; Fri, 15 Aug 1997 09:38:04 -0400
Message-ID: <33F45BBC.84D44D8F@cygnus.detroit.sgi.com>
Date: Fri, 15 Aug 1997 09:38:04 -0400
From: Eric Kimminau <eak@cygnus.detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.02 [en] (X11; I; IRIX 6.3 IP32)
MIME-Version: 1.0
To: Mike Shaver <shaver@neon.ingenia.ca>
CC: eak@detroit.sgi.com, ralf@mailhost.uni-koblenz.de,
        linux@cthulhu.engr.sgi.com
Subject: Re: Local disk boot HOWTO
References: <199708151322.JAA19960@neon.ingenia.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike Shaver wrote:
> 
> Thus spake Eric Kimminau:
> > Has anyone completed a HOWTO for booting from a second local disk yet?
> 
> Do you have a root-mountable filesystem on the second disk?
> If so:
> - put vmlinux on the IRIX /
> - boot into sash
> boot /vmlinux root=/dev/sdb1
> 
> (This is from memory, but it was pretty simple.  Once Miguel told me
> how simple it was, of course. =) )
> 
> Mike

OK, this IS simple enough. Does anyone have a tar of a functional Linux
installation I can snag and uncompress on my second disk?

My assumption would be I would then just modify
/dev/sdb1/etc/hosts,hostname, etc. for networking and then reboot into
Linux? 

If someone can throw up a tar somewhere Ill come get it and
linux.detroit will be online today.

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
