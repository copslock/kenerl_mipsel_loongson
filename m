Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id KAA52018; Fri, 15 Aug 1997 10:15:40 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA03139 for linux-list; Fri, 15 Aug 1997 10:15:07 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA03104; Fri, 15 Aug 1997 10:15:05 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id KAA11927; Fri, 15 Aug 1997 10:15:03 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id NAA22391; Fri, 15 Aug 1997 13:09:36 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199708151709.NAA22391@neon.ingenia.ca>
Subject: Re: Local disk boot HOWTO
In-Reply-To: <9708150958.ZM1050@xtp.engr.sgi.com> from Greg Chesson at "Aug 15, 97 09:58:08 am"
To: greg@xtp.engr.sgi.com (Greg Chesson)
Date: Fri, 15 Aug 1997 13:09:36 -0400 (EDT)
Cc: eak@detroit.sgi.com, ralf@mailhost.uni-koblenz.de,
        linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake Greg Chesson:
> > > - put vmlinux on the IRIX /
> > > - boot into sash
> > > boot /vmlinux root=/dev/sdb1
> 
> seems to me you'd have to also patch vmlinux to get the device ID
> correct for the root disk.

The root= parameter tells it where its root device is.
(It magically parses the [hs]d[ab][0-8] part into major/minor.)

Mike

-- 
#> Mike Shaver (shaver@ingenia.com)      Information Warfare Division  
#> Chief Tactical and Strategic Officer         "Saepe fidelis"        
#>                                                                     
#> "I like your game, but we have to change the rules." -- Anon        
#>                                                                     
