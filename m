Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id SAA476455 for <linux-archive@neteng.engr.sgi.com>; Sun, 18 Jan 1998 18:55:13 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA10112 for linux-list; Sun, 18 Jan 1998 18:49:44 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA10096 for <linux@cthulhu.engr.sgi.com>; Sun, 18 Jan 1998 18:49:39 -0800
Received: from mdhill.interlog.com (mdhill.interlog.com [199.212.154.112]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA22310
	for <linux@cthulhu.engr.sgi.com>; Sun, 18 Jan 1998 18:49:36 -0800
	env-from (mike@mdhill.interlog.com)
Received: (from mike@localhost) by mdhill.interlog.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id VAA05979; Sun, 18 Jan 1998 21:48:46 -0500
Date: Sun, 18 Jan 1998 21:48:46 -0500
Message-Id: <199801190248.VAA05979@mdhill.interlog.com>
From: Michael Hill <mdhill@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux@cthulhu.engr.sgi.com
Subject: binutils cross-compiler
X-Mailer: VM 6.34 under 20.3 "Vatican City" XEmacs  Lucid
Reply-To: mdhill@interlog.com
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I've re-installed IRIX gcc from Ariel's freeware page and I'm trying
to compile binutils with patch (2.8.1-1 24 Nov) according to Ralf's
Howto instructions.  Each time it quits at this point:

        gcc -O2 -c -D_GNU_SOURCE     -I. -I. -I./../include  -g ihex.c
        if [ -n "" ]; then \
          gcc -O2 -c  -D_GNU_SOURCE     -I. -I. -I./../include  -g stabs.c -o pic/stabs.o; \
        else true; fi
        gcc -O2 -c -D_GNU_SOURCE     -I. -I. -I./../include  -g stabs.c
gcc: Internal compiler error: program cc1 got fatal signal 10
*** Error code 1 (bu21)
*** Error code 1 (bu21)

Is this enough information for anyone to determine if I'm missing
anything? 

Thanks,

Mike
-- 
Michael Hill
Toronto, Canada
mdhill@interlog.com
