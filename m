Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA15635; Tue, 17 Jun 1997 04:32:16 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id EAA12443 for linux-list; Tue, 17 Jun 1997 04:31:56 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA12439 for <linux@relay.engr.SGI.COM>; Tue, 17 Jun 1997 04:31:54 -0700
Received: from caipfs.rutgers.edu (caipfs.rutgers.edu [128.6.155.100]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id EAA20185
	for <linux@relay.engr.SGI.COM>; Tue, 17 Jun 1997 04:31:53 -0700
	env-from (davem@caipfs.rutgers.edu)
Received: from jenolan.caipgeneral (jenolan.rutgers.edu [128.6.111.5])
	by caipfs.rutgers.edu (8.8.5/8.8.5) with SMTP id HAA20612
	for <linux@relay.engr.SGI.COM>; Tue, 17 Jun 1997 07:28:07 -0400 (EDT)
Received: by jenolan.caipgeneral (SMI-8.6/SMI-SVR4)
	id HAA04952; Tue, 17 Jun 1997 07:26:01 -0400
Date: Tue, 17 Jun 1997 07:26:01 -0400
Message-Id: <199706171126.HAA04952@jenolan.caipgeneral>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: linux@cthulhu.engr.sgi.com
Subject: [jim@geog.ubc.ca: Meta-FAQ: IMPORTANT UPDATE]
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Thank heavens SGI isn't as bad as Sun and SparcInternational...

The EFF and various others have been contacted on this, it is a real
shame and quite frankly, I hope SI and Sun both rot for this stunt...

------- Start of forwarded message -------
From: Jim Mintha <jim@geog.ubc.ca>
Subject: Meta-FAQ: IMPORTANT UPDATE
To: sparclinux@vger.rutgers.edu, sparc-list@redhat.com,
        debian-sparc@lists.debian.org
Date: 	Tue, 17 Jun 1997 03:47:50 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk


ANNOUNCEMENT:
- -------------

SPARC International's lawyers have the view that the terms SPARC/Linux
or Linux/SPARC (or most other variations) constitute an infringement
of SI's trademark.  They would deem "Linux for SPARC Processors" as
acceptable.  They also object to the use of the word "sparc" in any
part of a URL.  So for example the url:
"http://www.geog.ubc.ca/sparc/howto/netboot.html" is a trademark
infringement.  

So while I feel that they have absolutely no right to dictate what I
can call my subdirectories, I don't really have the time to argue
legal issues with a bunch of lawyers, nor do I own the equipment so
ultimately the decision isn't mine anyway.

I will be changing the reference on the web pages, as well as changing
any URLs to avoid using the word "sparc".  For convenience I will
refer to "Linux for SPARC Processors" as S/Linux (The "S" of course,
standing for "Super")  The main URL for the web page is now:

http://www.geog.ubc.ca/s_linux.html

If you happen to type the old URL my web server will get confused and
redirect you to the new URL. (I have no idea why :^)  The same for any
of the other pages.

Jim

- -------------

Linux for SPARC Processors Meta-FAQ
Last Updated: 97/06/17
Send comments/corrections to:
Jim Mintha (mintha@geog.ubc.ca)

This is the Meta-FAQ for the Linux for SPARC Processors project
(hereafter referred to as S/Linux - "S" for "Super").  It is mainly a
list of pointers to other sources of information, FTP sites, etc.

1. What is S/Linux?

     S/Linux is a port of the Linux operating system to the SPARC
     platform, specifically to Sun SPARCstations.  This is not a "new"
     version of Linux, it is a port that is integrated into the normal
     distribution kernel tree.  The user level interface and most of
     the kernel is still the same.  Only machine-dependent parts of the
     kernel have changed.

     Also - MOST IMPORTANT - this effort is a work-in-progress.  Its
     current status is still beta!  Sure a lot of the time it seems
     more stable than Sun's OS but there are NO GUARANTEES.  There now
     is a ready made distribution, but there are no toll-free support
     lines, or 300 page installation manuals!  If you want to get
     involved you have to expect to work through some problems on your
     own!

2. Where can I find more information about the project?

     The best place to start is the S/Linux WWW Home Page:
      - http://www.geog.ubc.ca/s_linux.html

     It has:
      - Pointers to the FAQ and HOW-TOs
      - Mailing List info and archives
      - Recent news and announcements
      - List of FTP sites, mirrors, etc.

     Information on the RedHat S/Linux Distribution can be found:
      - http://www.redhat.com/products/rhl-sparc.html

     Addition information can be found at:
      - http://sunsite.mff.cuni.cz/linux/
     
3. How do I boot Linux on my Sparc Computer?

     Right now the easiest way is to install the RedHat S/Linux
     distribution.  This is a full release of the RedHat distribution
     which you can purchase on CD or install via FTP.  For more
     information see found at:

      - http://www.redhat.com/products/rhl-sparc.html

4. How do I solve problems booting/installing/running S/Linux?

     You should first look at the FAQ:
      - http://www.geog.ubc.ca/s_linux/faq.html
     
     For problems booting you can look at the HOWTOs:
      - http://www.geog.ubc.ca/s_linux/howto.html

     For problems with the RedHat distribution, there is an errata page:
      - http://www.redhat.com/RedHat-Errata

     That failing join one of the mailing lists and ask for some help.

4. What are the main FTP sites:
 
     RedHat Distribution:
     --------------------

     Main RedHat FTP site: ftp://ftp.redhat.com/pub/redhat/redhat-4.1

     Some mirrors: (see ftp://ftp.redhat.com/pub/MIRRORS)
      - ftp://ftp.xtn.net/pub/linux/redhat/redhat-4.1
      - ftp://sunsite.unc.edu/pub/Linux/distributions/redhat/redhat-4.1
      - ftp://sunsite.mff.cuni.cz/OS/Linux/Redhat/redhat-4.1
      - ftp://ftp-nog.rutgers.edu/pub/linux/distributions/redhat/redhat-4.1

     S/Linux Development:
     ------------------------

     The main FTP site for the project which has the recent kernel
     snapshots, libc development, and some utilities is:
      - ftp://vger.rutgers.edu/pub/linux/Sparc/

     The Red Hat people have been porting their RPM packages to the sparc.
     These (as well as mirrors if 'vger' and 'sunsite.cz')
     are available at:
      - ftp://ftp.redhat.com/pub/redhat/devel/sparc/RedHat/RPMS/

     Jakub Jelinek has various X11 and Openwin stuff packaged (and a
     lot of other stuff including mirrors of 'vger' and 'redhat'):
      - ftp://sunsite.mff.cuni.cz/OS/Linux/Sparc/

     Current site for Debian development:
      - ftp://ftp.debian.org/pub/debian/hamm

     The latest X11 rpms, libc, dynamic linker and some extra tools
     are available in:
      - ftp://ftp.nuclecu.unam.mx/linux/Sparc-miguel/

     An additional mirror of the first four sites above is:
      - ftp://ftp.geog.ubc.ca/pub/s_linux

     European Mirror Sites 
      - ftp://sunsite.cnlab-switch.ch/mirror/linux/Sparc (mirror of vger & redhat)
      - ftp://ftp.uni-trier.de/pub/unix/systems/linux/Sparc (mirror of first three)

5. What Mailing Lists are available for the project?

     There are three mailing lists devoted to the S/Linux project:

     sparclinux@vger.rutgers.edu (main mailing list)
     sparc-list@redhat.com (RedHat related issues)
     debian-sparc@lists.debian.org (Debian related issues)

     For information on subscribing see:
      - http://www.geog.ubc.ca/s_linux/maillist.html


Jim Mintha (mintha@geog.ubc.ca)    Home: (604) 731-7240
Geography System Administrator     Work: (604) 822-2174 Fax: 822-6150
                              Home Page: http://www.geog.ubc.ca/~jim/
>>> SARCAST \'sar-kast\ v.  1. To engage in the art of sarcasm <<<
------- End of forwarded message -------
