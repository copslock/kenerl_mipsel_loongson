Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id JAA51543; Fri, 15 Aug 1997 09:59:11 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA26581 for linux-list; Fri, 15 Aug 1997 09:58:16 -0700
Received: from xtp.engr.sgi.com (xtp.engr.sgi.com [150.166.75.34]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA26577 for <linux@cthulhu.engr.sgi.com>; Fri, 15 Aug 1997 09:58:13 -0700
Received: by xtp.engr.sgi.com (950413.SGI.8.6.12/911001.SGI)
	 id JAA01052; Fri, 15 Aug 1997 09:58:08 -0700
From: "Greg Chesson" <greg@xtp.engr.sgi.com>
Message-Id: <9708150958.ZM1050@xtp.engr.sgi.com>
Date: Fri, 15 Aug 1997 09:58:08 -0700
In-Reply-To: Eric Kimminau <eak@cygnus.detroit.sgi.com>
        "Re: Local disk boot HOWTO" (Aug 15,  9:38am)
References: <199708151322.JAA19960@neon.ingenia.ca> 
	<33F45BBC.84D44D8F@cygnus.detroit.sgi.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: eak@detroit.sgi.com, Mike Shaver <shaver@neon.ingenia.ca>
Subject: Re: Local disk boot HOWTO
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Aug 15,  9:38am, Eric Kimminau wrote:
> Subject: Re: Local disk boot HOWTO

> > Do you have a root-mountable filesystem on the second disk?
> > If so:
> > - put vmlinux on the IRIX /
> > - boot into sash
> > boot /vmlinux root=/dev/sdb1
> >


seems to me you'd have to also patch vmlinux to get the device ID
correct for the root disk.  On Irix you'd have to move /dev/root.
I'm not sure what the equivalent might be on linux.... but I'd like
to know what the recipe is.  I too would like to bring linux up on
a secondary disk.

g
