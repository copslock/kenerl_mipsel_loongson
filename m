Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id SAA663800 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Sep 1997 18:34:02 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA18839 for linux-list; Tue, 16 Sep 1997 18:33:21 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA18826; Tue, 16 Sep 1997 18:33:19 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id SAA20782; Tue, 16 Sep 1997 18:33:19 -0700
Date: Tue, 16 Sep 1997 18:33:19 -0700
Message-Id: <199709170133.SAA20782@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Mike Shaver <shaver@neon.ingenia.ca>
Cc: linux@cthulhu.engr.sgi.com (Linux/SGI list)
Subject: Re: EFS question
In-Reply-To: <199709170058.UAA07380@neon.ingenia.ca>
References: <199709170058.UAA07380@neon.ingenia.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mike Shaver writes:
 > Just to make sure I understand this correctly:
 > - when an inode has <= EFS_DIRECTEXTENTS extents, they're stored directly
 > in the inode.
 > - when an inode has > EFS_DIRECTEXTENTS extents, the extents in the
 > inode refer to contiguous block regions that contain extents referring
 > to the real data.
 > 
 > The EFS code that Alan posted, in addition to having a curious
 > aversion to structures, seemed to think that the first 4 bytes of
 > dinode->di_u were the block number of a block containing extents, and
 > thus doesn't work very well with files with numext >
 > EFS_DIRECTEXTENTS.  I just want to ensure that I make a sane fix.
...

      The above is correct.  When there are indirect extents,
the offset field of the first indirect extent in the inode
contains the number of indirect extents, not a file offset.
