Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id SAA660938 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Sep 1997 18:05:01 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA09063 for linux-list; Tue, 16 Sep 1997 18:03:32 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA09050 for <linux@engr.sgi.com>; Tue, 16 Sep 1997 18:03:27 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id SAA19431
	for <linux@engr.sgi.com>; Tue, 16 Sep 1997 18:03:25 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id UAA07380 for linux@engr.sgi.com; Tue, 16 Sep 1997 20:58:22 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199709170058.UAA07380@neon.ingenia.ca>
Subject: EFS question
To: linux@cthulhu.engr.sgi.com (Linux/SGI list)
Date: Tue, 16 Sep 1997 20:58:22 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Just to make sure I understand this correctly:
- when an inode has <= EFS_DIRECTEXTENTS extents, they're stored directly
in the inode.
- when an inode has > EFS_DIRECTEXTENTS extents, the extents in the
inode refer to contiguous block regions that contain extents referring
to the real data.

The EFS code that Alan posted, in addition to having a curious
aversion to structures, seemed to think that the first 4 bytes of
dinode->di_u were the block number of a block containing extents, and
thus doesn't work very well with files with numext >
EFS_DIRECTEXTENTS.  I just want to ensure that I make a sane fix.

Mike

-- 
#> Mike Shaver (shaver@ingenia.com) Ingenia Communications Corporation 
#>                 UNIX medicine man -- dark magick, cheap!            
#>                                                                     
#>  When the going gets tough, the tough give cryptic error messages.  
#>          "We believe in rough consensus and running code."          
