Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id GAA45343; Fri, 15 Aug 1997 06:30:34 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA11909 for linux-list; Fri, 15 Aug 1997 06:28:52 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA11900 for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 06:28:46 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id GAA14084
	for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 06:28:45 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id JAA19960; Fri, 15 Aug 1997 09:22:40 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199708151322.JAA19960@neon.ingenia.ca>
Subject: Re: Local disk boot HOWTO
In-Reply-To: <33F45614.3939AFBA@cygnus.detroit.sgi.com> from Eric Kimminau at "Aug 15, 97 09:13:56 am"
To: eak@detroit.sgi.com
Date: Fri, 15 Aug 1997 09:22:40 -0400 (EDT)
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Eric Kimminau:
> Has anyone completed a HOWTO for booting from a second local disk yet?

Do you have a root-mountable filesystem on the second disk?
If so:
- put vmlinux on the IRIX /
- boot into sash
boot /vmlinux root=/dev/sdb1

(This is from memory, but it was pretty simple.  Once Miguel told me
how simple it was, of course. =) )

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>       Chief System Architect -- Head geek -- System exorcist        
#>                                                                     
#>   "Have you considered a life?  I hear they're quite affordable     
#>          these days." --- shields@tembel.org                        
