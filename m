Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA18699; Thu, 3 Apr 1997 08:13:47 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA13894 for linux-list; Thu, 3 Apr 1997 08:13:10 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA13882 for <linux@engr.sgi.com>; Thu, 3 Apr 1997 08:13:08 -0800
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id IAA20328 for <linux@engr.sgi.com>; Thu, 3 Apr 1997 08:13:03 -0800
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id LAA16242 for linux@engr.sgi.com; Thu, 3 Apr 1997 11:12:27 -0500
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199704031612.LAA16242@neon.ingenia.ca>
Subject: The Indy has landed...
To: linux@cthulhu.engr.sgi.com
Date: Thu, 3 Apr 1997 11:12:26 -0500 (EST)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

[shaver@neon shaver]$ telnet bogomips
Trying 205.207.220.72...
Connected to bogomips.ingenia.com.
Escape character is '^]'.


IRIX (bogomips.ingenia.com)

login: root
Password:
IRIX Release 6.2 IP22 bogomips
Copyright 1987-1996 Silicon Graphics, Inc. All Rights Reserved.
Last login: Thu Apr  3 07:18:17 PST 1997 on :0
bogomips 1# w
  8:07am  up 50 mins,  2 users,  load average: 0.38, 0.25, 0.10
User     tty from            login@   idle   JCPU   PCPU  what
demos    q0  :0.0            8:02am      4                -csh
root     q1  205.207.220.57  8:06am                       w
bogomips 2# 

It would seem, ladies and gentlemen, that we're off to the races!
After the conference sessions tonight I'll see about setting up the
tftpboot stuff.  (Tips welcome!)

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#> Paranoid for money.                            Sarcastic for kicks. 
#>                                                                     
#> "They already *KNOW* I am a whacko, Karen.                          
#>                  That doesn't mean I am *WRONG*." -- mjr@clark.net  
