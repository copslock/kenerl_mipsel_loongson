Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA12624; Sat, 8 Jun 1996 11:23:39 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA20038 for linux-list; Sat, 8 Jun 1996 18:23:29 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA20033 for <linux@cthulhu.engr.sgi.com>; Sat, 8 Jun 1996 11:23:28 -0700
Received: (from ariel@localhost) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA01539; Sat, 8 Jun 1996 11:22:46 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199606081822.LAA01539@yon.engr.sgi.com>
Subject: Re: Are you satisfied now Mr. McVoy? ;-)
To: dm@neteng.engr.sgi.com (David S. Miller)
Date: Sat, 8 Jun 1996 11:22:46 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199606081123.EAA07860@neteng.engr.sgi.com> from "David S. Miller" at Jun 8, 96 04:23:33 am
Reply-To: ariel@cthulhu.engr.sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

>
>
>Calibrating delay loop.. ok - 91.96 BogoMIPS
>
Will a Triton CPU (R5000) make this better ? :-)

For those who are not familiar with bogomips, my Pentium-100
at home does 39.94 bogomips. And the best number I've seen
for a desktop is almost 300 bogomips for an  Alpha 21064
overclocked to 300MHz. The 91.96 number for a 150MHz Indy
sounds pretty good. 

Still, I would like to know, David:
What clock factor are you using? The DEC Alphas do one
clock pre instruction, so their factor is 1, why is
the Indy at less than two-thirds of its clock rate?


Fr more details:
	http://sunsite.unc.edu/linux/HOWTO/mini/BogoMips

It would be nice to send them the new data...

-- 
Peace, Ariel
