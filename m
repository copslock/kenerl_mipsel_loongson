Received:  by oss.sgi.com id <S305157AbQEMNcI>;
	Sat, 13 May 2000 13:32:08 +0000
Received: from deliverator.sgi.com ([204.94.214.10]:30271 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305154AbQEMNbu>;
	Sat, 13 May 2000 13:31:50 +0000
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id GAA29336; Sat, 13 May 2000 06:26:59 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id GAA44332; Sat, 13 May 2000 06:31:18 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA94284
	for linux-list;
	Sat, 13 May 2000 06:22:29 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA32245
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 13 May 2000 06:22:28 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from localhost (localhost [127.0.0.1])
	by calypso.engr.sgi.com (Postfix) with ESMTP id DE4C7A78D7
	for <linux@cthulhu.engr.sgi.com>; Sat, 13 May 2000 06:21:56 -0700 (PDT)
Date:   Sat, 13 May 2000 06:21:56 -0700 (PDT)
From:   Ulf Carlsson <ulfc@calypso.engr.sgi.com>
To:     linux@cthulhu.engr.sgi.com
Subject: Indy Documentation
Message-ID: <Pine.LNX.4.21.0005130609590.1061-100000@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi,

I have some happy news.  After writing up a 47-lines bash script that would
search every IRIX machine at SGI in parallel I managed to find most of the
Indy documentation in electronic form.  I tried about 6000 machines before I
found anything, and it took me almost 9 hours of hard work.  The biggest
problem I had was that I ran into the open file limit in Linux so I could only
search 250 machines at the same time.  Why is it so?

This is the contents of the directory:

-r--r--r--    1 guest    guest     427532 Sep 23  1998 dmux1.showcase
dr--r--r--    2 guest    guest       4096 Sep 23  1998 gio64
-r--r--r--    1 guest    guest     413144 Sep 23  1998 hpc3.showcase
-r--r--r--    1 guest    guest     260096 Sep 23  1998 ioc.spec.frame
-r--r--r--    1 guest    guest     411688 Sep 23  1998 mc.showcase
-r--r--r--    1 guest    guest     217662 Sep 23  1998 pbus.doc
-r--r--r--    1 guest    guest     197632 Sep 23  1998 rb2.spec.frame
-r--r--r--    1 guest    guest     852059 Sep 23  1998 rex3.spec.ps
-r--r--r--    1 guest    guest     169984 Sep 23  1998 ro1.spec.frame
-r--r--r--    1 guest    guest     552960 Sep 23  1998 vc2.spec.frame
dr--r--r--    2 guest    guest       4096 Sep 23  1998 vino
-r--r--r--    1 guest    guest     414720 Sep 23  1998 xmap9.spec.frame
-r--r--r--    1 guest    guest     176437 Sep 23  1998 xmap9.spec.ps

I don't know if I will be allowed to distribute this, but it's at least a huge
step from the paper documentation that we have now.  I'll convert it to
postscript so that we can read it..

Cheers,
Ulf
