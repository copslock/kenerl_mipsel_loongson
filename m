Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0P2jSr21861
	for linux-mips-outgoing; Thu, 24 Jan 2002 18:45:28 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g0P2jOP21852
	for <linux-mips@oss.sgi.com>; Thu, 24 Jan 2002 18:45:24 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g0P1jLX15571;
	Thu, 24 Jan 2002 17:45:21 -0800
Date: Thu, 24 Jan 2002 17:45:21 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Girish Gulawani <girishvg@yahoo.com>
Cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: MIPS/Linux NonSGI
Message-ID: <20020124174521.B8860@dea.linux-mips.net>
References: <3C505900.9685DDE3@cotw.com> <003901c1a532$d01576e0$de920dd3@gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <003901c1a532$d01576e0$de920dd3@gol.com>; from girishvg@yahoo.com on Fri, Jan 25, 2002 at 08:41:10AM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jan 25, 2002 at 08:41:10AM +0900, Girish Gulawani wrote:

> i'm trying to bringup linux 2.4.[2|9] on our board based on LSI mips r4k
> core.
> right now the kernel compiled with gcc-3.0, boots up & can only work with

There are known bugs in older kernels that will crash them when compiled
with gcc 3.0.  Even with current 2.4 kernels it's still playing with the
fire.

> statically linked commands. hence the root file system mounted from
> ramdisk,nfs, & de-dream ide-disk can show some-prompt only if ash.static is
> invoked.
> this is seen with 2.4.3 & ditto with 2.4.9. the kernel is in un-cached
> mode,since we have page-size problem with our core in cached, write
> through/back
> both, modes. so question is WHY THE COMMANDS WITH SHARED LIBRARY DONOT WORK.
> FAILS TO LOAD SHARED LIBRARIES.
> 
> the problem no.2 is root on ide-disk. the disk is paritioned & formatted
> using a linux pentium-pc. using a master disk the above said statically
> linked commands are downloaded to slave disk. the board boots up. however
> the bdflush/update process corrupts file-system. the UPDATE PROCESS CORRUPTS
> SUPERBLOCK AND INODES WHILE FLUSHING THE DIRTY BUFERS.
> 
> PLEASE! PLEASE!! HELP ME ON THIS. THIS NEWSGROUP IS MY LAST HOPE.

Seems pretty obvious that cacheflushing for your system is broken.
Verify that arch/mips/mm/c-r4k.c knows how to handle your system.

  Ralf

PS: Seems your caps lock key occasionally gets stuck ;-)
