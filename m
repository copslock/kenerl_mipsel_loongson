Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA10570; Sat, 10 May 1997 17:30:43 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA17345 for linux-list; Sat, 10 May 1997 17:30:36 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA17340 for <linux@engr.sgi.com>; Sat, 10 May 1997 17:30:33 -0700
Received: from neon.ingenia.ca (neon.ingenia.ca [205.207.220.57]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA24921
	for <linux@engr.sgi.com>; Sat, 10 May 1997 17:30:26 -0700
	env-from (shaver@neon.ingenia.ca)
Received: (from shaver@localhost) by neon.ingenia.ca (8.8.5/8.7.3) id UAA04501 for linux@engr.sgi.com; Sat, 10 May 1997 20:39:45 -0400
From: Mike Shaver <shaver@neon.ingenia.ca>
Message-Id: <199705110039.UAA04501@neon.ingenia.ca>
Subject: .36 progresss
To: linux@cthulhu.engr.sgi.com
Date: Sat, 10 May 1997 20:39:45 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL28 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Well, I've "fixed up" (where "fixed up" means that they now compile
without error):
drivers/scsi/wd33c93.c
arch/mips/sgi/setup.c
arch/mips/indy_int.c
arch/mips/kernel/irixioctl.c
arch/mips/kernel/irixelf.c
arch/mips/kernel/irixsig.c

Left to do are:
entry.S
head.S
sysirix.c (boy, will _that_ be fun... =/)

The problems with entry.S are related to the BUILD_HANDLER macro set,
it seems, and the errors in question look like:
entry.S: Assembler messages:
entry.S:207: Error: .previous without corresponding .section; ignored
entry.S:207: Error: .previous without corresponding .section; ignored
entry.S:208: Error: .previous without corresponding .section; ignored
entry.S:208: Error: .previous without corresponding .section; ignored
entry.S:215: Error: .previous without corresponding .section; ignored
entry.S:215: Error: .previous without corresponding .section; ignored
entry.S:217: Error: .previous without corresponding .section; ignored
entry.S:217: Error: .previous without corresponding .section; ignored
entry.S:218: Error: .previous without corresponding .section; ignored
entry.S:218: Error: .previous without corresponding .section; ignored
entry.S:219: Error: .previous without corresponding .section; ignored
entry.S:219: Error: .previous without corresponding .section; ignored

head.S's problem gives an identical error, but the code doesn't seem
similar:
head.S: Assembler messages:
head.S:281: Error: .previous without corresponding .section; ignored

   278          LEAF(except_vec2_generic)
   279          /* Famous last words: unreached */
   280          mfc0    a1,CP0_ERROREPC
   281          PRINT("Cache error exception: c0_errorepc == %08x\n")
   282  1:
   283          j       1b

You all know how good I am with assembly, so I might have to wait for
Ralf to return. =)

In the meantime, I'll hack away at sysirix.c.  (Did it always give
piles of "control reaches end of non-void function" warnings?)

Mike

-- 
#> Mike Shaver (shaver@ingenia.com)      Information Warfare Division  
#> Chief Tactical and Strategic Officer         "Saepe fidelis"        
#>                                                                     
#> "I like your game, but we have to change the rules." -- Anon        
#>                                                                     
