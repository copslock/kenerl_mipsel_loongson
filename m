Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA27017; Thu, 20 Jun 1996 04:03:16 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA24827 for linux-list; Thu, 20 Jun 1996 11:03:06 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA24816 for <linux@cthulhu.engr.sgi.com>; Thu, 20 Jun 1996 04:03:05 -0700
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [155.11.228.1]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id EAA27014 for <linux@neteng.engr.sgi.com>; Thu, 20 Jun 1996 04:03:02 -0700
Received: by soyuz.wellington.sgi.com (951211.SGI.8.6.12.PATCH1042/940406.SGI)
	for linux@neteng.engr.sgi.com id XAA02623; Thu, 20 Jun 1996 23:02:59 +1200
From: alambie@wellington.sgi.com (Alistair Lambie)
Message-Id: <199606201102.XAA02623@soyuz.wellington.sgi.com>
Subject: Kernel doesn't work on 200MHz Indy
To: linux@neteng.engr.sgi.com
Date: Thu, 20 Jun 1996 23:02:58 +1200 (NZT)
X-Mailer: ELM [version 2.4 PL23]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Just incase anyone is interested:

I was able to boot Davids kernel on my Indy when I only had a 100MHz R4600PC,
but know I've upgraded to a 200MHz R4400SC it dies!  Looks like something
to do with the memory controller...

Here goes a bit of what comes out:

Bad pmd in pte_alloc_kernel: 00000000
Double fault caused by invalid entries in pgd:
Double fault address   : ffffffffe4000000
c0_epc                 : ffffffff88093ebc

Of course there was heaps more, but I couldn't get cut and paste to work :-)

I haven't had time to have a look at what's going on yet.

Cheers, Alistair

PS - It only gives a BogoMIPS reading of 103.63, which is around what I got
     when it was a 100MHz chip.
