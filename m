Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA84006 for <linux-archive@neteng.engr.sgi.com>; Tue, 21 Jul 1998 11:15:31 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA85420
	for linux-list;
	Tue, 21 Jul 1998 11:13:44 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id LAA95539
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 21 Jul 1998 11:13:43 -0700 (PDT)
	mail_from (eak@detroit.sgi.com)
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/930416.SGI)
	 id OAA18640; Tue, 21 Jul 1998 14:13:40 -0400
Received: from detroit.sgi.com (localhost [127.0.0.1]) by cygnus.detroit.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA03106; Tue, 21 Jul 1998 14:13:39 -0400 (EDT)
Message-ID: <35B4DA52.A17C32A7@detroit.sgi.com>
Date: Tue, 21 Jul 1998 14:13:38 -0400
From: Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.09C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Shaver <shaver@netscape.com>
CC: SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Subject: Re: Xwindows status?
References: <Pine.LNX.3.95.980721093249.5677D-100000@thebrain> <35B4D431.F77FB01B@detroit.sgi.com> <35B4D6A8.811A9941@netscape.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike Shaver wrote:
> 
> Eric Kimminau wrote:
> > Obviously we are missing the actual XServer binary.
> > ANy chance I can get it from someone?
> 
> I could give you a binary, but it'd lock your Indy up when you ran it.
> =/  I'm going to post in a bit with questions about the REX3, once I get
> my X tree back in place on bogomips.  (Alex's installation went very
> well, BTW.)

:)  Ive got someplace to install it when you have something you want to
pass out for testing.


> Someone might want to peek at the IRIX binary emulation stuff and see if
> we can resurrect Xsgi.
> 
> Mike
> 
> --
> 35083.88 29375.20

ANyone within SGI who would like an account on Linux to do development
work is welcome to it. Just send me a message with the userid/password
you want to use (and your UID if you have it).

P.S.

It appears as though we may have a problem with python as well:

[root@linux RPMS]# glint
Traceback (innermost last):
  File "./glint.py", line 22, in ?
    from Tkinter import *
  File "/usr/lib/python1.5/lib-tk/Tkinter.py", line 5, in ?
    import _tkinter # If this fails your Python is not configured for Tk
ImportError: /usr/X11R6/lib/libX11.so.6: undefined symbol:
_XcmsCIELab_prefix

and
[root@linux RPMS]# rpm -Uvh --force pythonlib-1.22-1.noarch.rpm 
package pythonlib-1.22-1 is for a different architecture
error: pythonlib-1.22-1.noarch.rpm cannot be installed

and

[root@linux RPMS]# rpm -Uvh --force tksysv-1.0-3.noarch.rpm 
package tksysv-1.0-3 is for a different architecture
error: tksysv-1.0-3.noarch.rpm cannot be installed

although I believe this last one might be intentional, is there a reason
to include it if it is unuseable?

Eric.



-- 
---------1---------2---------3---------4---------5---------6---------7
Eric Kimminau                           FTA/RSA
eak@detroit.sgi.com                     Silicon Graphics, Inc
Voice: (248) 848-4455                   39001 West 12 Mile Rd.
Fax:   (248) 848-5600                   Farmington, MI 48331-2903

                 VNet Extension - 6-327-4455
              "I speak my mind and no one else's."
       http://www.dcs.ex.ac.uk/~aba/rsa/perl-rsa-sig.html

    When confronted by a difficult problem, solve it by reducing 
    it to the question, "How would the Lone Ranger handle this?"

  "I am a bomb technician. If you see me running, try to keep up..."
	
         "I am the great supportfolio, do you have http?"

        Copyright 1998, Silicon Graphics Computer Systems
        Confidential to Silicon Graphics Computer Systems
                ** -- not for redistribution -- **
