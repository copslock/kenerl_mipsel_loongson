Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA05435; Wed, 9 Apr 1997 10:16:38 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA10956 for linux-list; Wed, 9 Apr 1997 10:15:29 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA10931 for <linux@relay.engr.SGI.COM>; Wed, 9 Apr 1997 10:15:26 -0700
Received: from alles.intern.julia.de (loehnberg1.core.julia.de [194.221.49.2]) by sgi.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id JAA22350 for <linux@relay.engr.SGI.COM>; Wed, 9 Apr 1997 09:46:19 -0700
Received: from kernel.panic.julia.de (kernel.panic.julia.de [194.221.49.153])
	by alles.intern.julia.de (8.8.5/8.8.5) with ESMTP id HAA15076;
	Wed, 9 Apr 1997 07:26:44 +0200
From: Ralf Baechle <ralf@Julia.DE>
Received: (from ralf@localhost)
          by kernel.panic.julia.de (8.8.4/8.8.4)
	  id HAA06508; Wed, 9 Apr 1997 07:25:46 +0200
Message-Id: <199704090525.HAA06508@kernel.panic.julia.de>
Subject: Re: It booooooooooots!
To: wje@fir.esd.sgi.com (William J. Earl)
Date: Wed, 9 Apr 1997 07:25:46 +0200 (MET DST)
Cc: shaver@neon.ingenia.ca, linux@cthulhu.engr.sgi.com,
        kneedham@ottawa.sgi.com
In-Reply-To: <199704082337.QAA14690@fir.esd.sgi.com> from "William J. Earl" at Apr 8, 97 04:37:49 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> ...
>  > Checking for 'wait' instruction...  unavailable.
> ...
> 
>      This appears to be a bug.  The R5000 does have the wait instruction.

Linux doesn't really check; instead it has encoded which CPU types
have a wait instruction.  I add the R500 to that list.

  Ralf
