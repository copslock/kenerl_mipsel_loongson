Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id SAA682173 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Sep 1997 18:47:24 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA21282 for linux-list; Tue, 16 Sep 1997 18:46:56 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA21270; Tue, 16 Sep 1997 18:46:54 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA02773; Tue, 16 Sep 1997 18:46:52 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id VAA07688; Tue, 16 Sep 1997 21:41:47 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199709170141.VAA07688@neon.ingenia.ca>
Subject: Re: EFS question
In-Reply-To: <199709170133.SAA20782@fir.engr.sgi.com> from "William J. Earl" at "Sep 16, 97 06:33:19 pm"
To: wje@fir.engr.sgi.com (William J. Earl)
Date: Tue, 16 Sep 1997 21:41:47 -0400 (EDT)
Cc: linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Thus spake William J. Earl:
> When there are indirect extents,
> the offset field of the first indirect extent in the inode
> contains the number of indirect extents, not a file offset.

_Ah!_
That makes _much_ more sense, then.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>              Commando Developer - Whatever It Takes
#>                                                                     
#> "See, you not only have to be a good coder to create a system like
#>    Linux, you have to be a sneaky bastard too." - Linus Torvalds
