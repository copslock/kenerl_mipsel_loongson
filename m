Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA10136; Sat, 14 Jun 1997 08:40:16 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA16633 for linux-list; Sat, 14 Jun 1997 08:39:33 -0700
Received: from heaven.newport.sgi.com (heaven.newport.sgi.com [169.238.102.134]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA16611 for <linux@engr.sgi.com>; Sat, 14 Jun 1997 08:39:30 -0700
Received: by heaven.newport.sgi.com (940816.SGI.8.6.9/940406.SGI)
	for linux@engr id IAA21080; Sat, 14 Jun 1997 08:39:28 -0700
From: "Christopher W. Carlson" <carlson@heaven.newport.sgi.com>
Message-Id: <9706140839.ZM21078@heaven.newport.sgi.com>
Date: Sat, 14 Jun 1997 08:39:28 -0700
In-Reply-To: "William J. Earl" <wje@fir.engr.sgi.com>
        "Re: gcc for Irix." (Jun 13,  1:37pm)
References: <199706131654.JAA28555@fir.engr.sgi.com> 
	<199706131750.KAA09670@yon.engr.sgi.com> 
	<199706132037.NAA29267@fir.engr.sgi.com>
X-Mailer: Z-Mail-SGI (3.2S.2 10apr95 MediaMail)
To: linux@cthulhu.engr.sgi.com
Subject: Re: gcc for Irix.
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Jun 13,  1:37pm, William J. Earl wrote:
> 
>        If the old headers do not work on the new system, that is a
> bug, not a feature.  There had better not be any subtle
> incompatibilities.  (New headers will not work on an old system, but
> that is a different problem.)
>-- End of excerpt from William J. Earl


Actually, it isn't a bug because there was a major version change.
Anything can change between 5.3 and 6.2.  I know we try to maintain
backwards compatibility but sometimes ANSI requires changes in the
number of parameters, there's a change in the values used to pass to
functions, etc.

I believe our promise is that code compiled on 5.3 will run on 6.2,
not that it will still compile.

-- 

		Chris Carlson

	+------------------------------------------------------+
	| Also, carlson@sgi.com                                |
	|   Work:   (714) 224-4530                             |
	|   Vnet:       6-678-4530     FAX:    (714) 833-9503  |
	|                                                      |
	| Trivia fact: an electroencephalogram shows that a    |
	| human brain and a bowl of quivering lime Jell-O have |
	| the same waves.  [Time Magazine, Mar 17, 1997]       |
	+------------------------------------------------------+
