Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id RAA150591 for <linux-archive@neteng.engr.sgi.com>; Wed, 24 Sep 1997 17:51:46 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA27721 for linux-list; Wed, 24 Sep 1997 17:51:25 -0700
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA27714 for <linux@cthulhu.engr.sgi.com>; Wed, 24 Sep 1997 17:51:18 -0700
Received: from sgi.com by soyuz.wellington.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI)
	 id MAA19223; Thu, 25 Sep 1997 12:50:18 +1200
Message-ID: <3429B54A.ADFC1795@sgi.com>
Date: Thu, 25 Sep 1997 12:50:18 +1200
From: Alistair Lambie <alambie@sgi.com>
X-Mailer: Mozilla 4.02 [en] (X11; I; IRIX 6.5-ALPHA-1274090336 IP22)
MIME-Version: 1.0
To: clepple@foo.org
CC: linux@cthulhu.engr.sgi.com
Subject: Re: Indy netboot problems
References: <199709242137.RAA00921@mug.foo.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Charles Lepple wrote:
> 
> Hello all,
> Sorry to bother you if this is a routine question, but I read the FAQ, and
> therein lies my problem.
> 
> I'm trying to make an Indy netboot, but I'm not too familiar with the new
> monitor (let's just say that I knew sifex much better...Anyone remember the
> IRIS 3130s?). I need a way to correct the HW address, since it appears to be
> set to '0:0:FF:FF:0:0', and it is complaining about it.
> 
> Is there any other way to change nvram settings except through the
> setenv/printenv commands?
> 

You can not change this with setenv.  If it is '0:0:FF:FF:0:0' there is
a fault and you need to get the motherboard replaced.  It is probably
the 'Dallas Chip' that is the problem.  I have twice seen where a pin
gets bent on this and it returns funny MAC adresses....so if you have
some hardware knowledge it may be worth checking that it is seated
correctly and the pins are not bent.

Cheers, Alistair

-- 
Alistair Lambie					    alambie@wellington.sgi.com
Silicon Graphics New Zealand				  SGI Voicemail: 56791
Level 5, Walsh Wrightson Tower,				    Ph: +64-4-802 1455
94-96 Dixon St, Wellington, NZ			  	   Fax: +64-4-802 1459
