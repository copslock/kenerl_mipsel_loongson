Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id XAA372356 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Sep 1997 23:55:29 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id XAA20384 for linux-list; Wed, 10 Sep 1997 23:54:52 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA20378 for <linux@cthulhu.engr.sgi.com>; Wed, 10 Sep 1997 23:54:50 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id XAA27293 for <linux@fir.engr.sgi.com>; Wed, 10 Sep 1997 23:54:50 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA20373 for <linux@fir.engr.sgi.com>; Wed, 10 Sep 1997 23:54:48 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id XAA03510
	for <linux@fir.engr.sgi.com>; Wed, 10 Sep 1997 23:54:44 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id AAA03150; Thu, 11 Sep 1997 00:52:56 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199709110452.AAA03150@neon.ingenia.ca>
Subject: Re: Linux/SGI: Xsgi Shmiq/Qcntl
In-Reply-To: <199709110303.WAA25810@athena.nuclecu.unam.mx> from Miguel de Icaza at "Sep 10, 97 10:03:09 pm"
To: miguel@nuclecu.unam.mx (Miguel de Icaza)
Date: Thu, 11 Sep 1997 00:52:56 -0400 (EDT)
Cc: linux@fir.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Miguel de Icaza:
>     The code does an open on /dev/shmiq and then opens: sprintf (buf,
> "/dev/qcntl%d", mistery_variable) I want to know how it computes
> mistery_variable.  I am obviously screwing something in the shmiq
> emulation code. 

If it's like the rest of the shmiq stuff, it's probably the minor
number.   Remind me to test that stuff better now that I have an
Indy. =)

Mike

-- 
#> Mike Shaver (shaver@ingenia.com)      Information Warfare Division  
#> Chief Tactical and Strategic Officer         "Saepe fidelis"        
#>                                                                     
#> "I like your game, but we have to change the rules." -- Anon        
#>                                                                     
