Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA11239; Tue, 27 May 1997 12:42:48 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA08505 for linux-list; Tue, 27 May 1997 12:42:33 -0700
Received: from machine.engr.sgi.com (machine.engr.sgi.com [150.166.75.20]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA08496; Tue, 27 May 1997 12:42:31 -0700
Received: (from jes@localhost) by machine.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA11080; Tue, 27 May 1997 12:42:31 -0700
From: jes@machine.engr.sgi.com (John E. Schimmel)
Message-Id: <199705271942.MAA11080@machine.engr.sgi.com>
Subject: Re: strace/truss equiv?
To: shaver@neon.ingenia.ca (Mike Shaver)
Date: Tue, 27 May 1997 12:42:30 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <199705271919.PAA21206@neon.ingenia.ca> from "Mike Shaver" at May 27, 97 03:19:29 pm
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

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
> 

The equivelant is par.  You may also want to take a look at
elfdump which will tell you what libraries you are linked with, etc.

--------------------------------------------------------------
John E. Schimmel                       Email:    jes@sgi.com         
KD6MNW				       Voice:    (415)933-4116
Silicon Graphics Inc.                  Fax:      (415)933-0513
http://reality.sgi.com/jes             Cellular: (209)988-1549
--------------------------------------------------------------
