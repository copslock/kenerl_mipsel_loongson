Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA81597 for <linux-archive@neteng.engr.sgi.com>; Tue, 21 Jul 1998 10:48:38 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA10370
	for linux-list;
	Tue, 21 Jul 1998 10:47:39 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from dataserv.detroit.sgi.com (dataserv.detroit.sgi.com [169.238.128.2])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id KAA63144;
	Tue, 21 Jul 1998 10:47:35 -0700 (PDT)
	mail_from (eak@detroit.sgi.com)
Received: from cygnus.detroit.sgi.com by dataserv.detroit.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/930416.SGI)
	 id NAA18363; Tue, 21 Jul 1998 13:47:32 -0400
Received: from detroit.sgi.com (localhost [127.0.0.1]) by cygnus.detroit.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA03054; Tue, 21 Jul 1998 13:47:30 -0400 (EDT)
Message-ID: <35B4D431.F77FB01B@detroit.sgi.com>
Date: Tue, 21 Jul 1998 13:47:29 -0400
From: Eric Kimminau <eak@detroit.sgi.com>
Reply-To: eak@detroit.sgi.com
Organization: Silicon Graphics, Inc
X-Mailer: Mozilla 4.09C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To: ralf@uni-koblenz.de
CC: Ariel Faigon <ariel@cthulhu.engr.sgi.com>,
        SGI/Linux mailing list <linux@cthulhu.engr.sgi.com>
Subject: Xwindows status?
References: <Pine.LNX.3.95.980721093249.5677D-100000@thebrain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Good morning!

We have wonderful news! linux.detroit.sgi.com is now online!

We are ready to progress to Xwindows are we are meeting a roadblock.

/usr/X11R6/bin/X is a link to Xwrapper. There is no link to an X server
in /etc/X11. On  a startx execution only results in the foloowing
messages:

_X11TransSocketUNIXConnect: Can't connect: errno = 2
_X11TransSocketUNIXConnect: Can't connect: errno = 2
_X11TransSocketUNIXConnect: Can't connect: errno = 2
_X11TransSocketUNIXConnect: Can't connect: errno = 2
_X11TransSocketUNIXConnect: Can't connect: errno = 2
_X11TransSocketUNIXConnect: Can't connect: errno = 2

waiting for X server to begin accepting connections .
_X11TransSocketUNIXConnect: Can't connect: errno = 2
_X11TransSocketUNIXConnect: Can't connect: errno = 2
_X11TransSocketUNIXConnect: Can't connect: errno = 2
_X11TransSocketUNIXConnect: Can't connect: errno = 2
_X11TransSocketUNIXConnect: Can't connect: errno = 2
_X11TransSocketUNIXConnect: Can't connect: errno = 2
..

upon killing the process we receive:
xinit:  No such file or directory (errno 2):  unexpected signal 2

waiting for X server to shut down 

[root@linux /root]# 

Obviously we are missing the actual XServer binary.
ANy chance I can get it from someone?

Thanks!
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
