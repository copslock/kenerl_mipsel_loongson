Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA08375; Tue, 27 May 1997 12:46:03 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA09449 for linux-list; Tue, 27 May 1997 12:45:55 -0700
Received: from heaven.newport.sgi.com (heaven.newport.sgi.com [169.238.102.134]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA09438 for <linux@cthulhu.engr.sgi.com>; Tue, 27 May 1997 12:45:53 -0700
Received: by heaven.newport.sgi.com (940816.SGI.8.6.9/940406.SGI)
	for linux@cthulhu.engr.sgi.com id MAA17125; Tue, 27 May 1997 12:45:52 -0700
From: "Christopher W. Carlson" <carlson@heaven.newport.sgi.com>
Message-Id: <9705271245.ZM17123@heaven.newport.sgi.com>
Date: Tue, 27 May 1997 12:45:52 -0700
In-Reply-To: Mike Shaver <shaver@neon.ingenia.ca>
        "strace/truss equiv?" (May 27,  3:19pm)
References: <199705271919.PAA21206@neon.ingenia.ca>
X-Mailer: Z-Mail-SGI (3.2S.2 10apr95 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: Re: strace/truss equiv?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On May 27,  3:19pm, Mike Shaver wrote:
> Subject: strace/truss equiv?
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
>-- End of excerpt from Mike Shaver


You can also do some interesting things with rld (see the man page)
which will cause it to print out the libraries it is loading as a
program is started.

-- 

		Chris Carlson

	+------------------------------------------------------+
	| Also, carlson@sgi.com                                |
	|   Work:       (714) 756-5976     SGI vmail: 678-4530 |
	|   FAX:        (714) 833-9503                         |
	|                                                      |
	| Trivia fact: an electroencephalogram shows that a    |
	| human brain and a bowl of quivering lime Jell-O have |
	| the same waves.  [Time Magazine, Mar 17, 1997]       |
	+------------------------------------------------------+
