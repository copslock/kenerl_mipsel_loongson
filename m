Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA04203; Tue, 27 May 1997 12:42:01 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA08245 for linux-list; Tue, 27 May 1997 12:41:14 -0700
Received: from cat.montreal.sgi.com (cat.montreal.sgi.com [169.238.227.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA08225 for <linux@cthulhu.engr.sgi.com>; Tue, 27 May 1997 12:41:12 -0700
Received: from sax (sax.urbana.sgi.com [169.238.233.5]) by cat.montreal.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via SMTP id PAA25266; Tue, 27 May 1997 15:41:04 -0400
Message-ID: <338B37E3.6EEA@sgi.com>
Date: Tue, 27 May 1997 14:37:07 -0500
From: Luc Chouinard <lucc@sgi.com>
Organization: Silicon Graphics Inc.
X-Mailer: Mozilla 3.01SC-SGI (X11; I; IRIX 6.2 IP22)
MIME-Version: 1.0
To: Mike Shaver <shaver@neon.ingenia.ca>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: strace/truss equiv?
References: <199705271919.PAA21206@neon.ingenia.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

par -ilsSSN open <command>

Mike Shaver wrote:
> 
> OK, I'll bite.
> What's the strace/truss equivalent under IRIX?
> 
> I'm trying to figure out why my "dynamically-linked" hello world
> binaries are 115K, and I can't tell where the heck the linker is
> finding the static libs.
> 
> Mike
> 
> --
> #> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation
> #>              Linux: because every cycle counts.
> #>
> #> "I don't know what you do for a living[...]" -- perry@piermont.com
> #>        "I change the world." -- davem@caip.rutgers.edu

-- 
Luc
