Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0UBdYx21038
	for linux-mips-outgoing; Wed, 30 Jan 2002 03:39:34 -0800
Received: from smtp010.mail.yahoo.com (smtp010.mail.yahoo.com [216.136.173.30])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0UBdQd21033
	for <linux-mips@oss.sgi.com>; Wed, 30 Jan 2002 03:39:26 -0800
Received: from e144193.ppp.asahi-net.or.jp (HELO nazneen) (211.13.144.193)
  by smtp.mail.vip.sc5.yahoo.com with SMTP; 30 Jan 2002 10:39:13 -0000
Message-ID: <007001c1a97a$6e52a9e0$c1900dd3@gol.com>
From: "Girish Gulawani" <girishvg@yahoo.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>
References: <3C505900.9685DDE3@cotw.com> <003901c1a532$d01576e0$de920dd3@gol.com> <20020124174521.B8860@dea.linux-mips.net>
Subject: Re: MIPS/Linux NonSGI
Date: Wed, 30 Jan 2002 19:39:41 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


hello, ralf.

could solve the disk corruption problem, thanks to you. it was due to my
over-confident source code for bus mastering device. while re-targeting the
driver from vxworks to linux i had introduced a bug. its all working great
now. thanks again. while this problem is solved  i have one more query.

as i mentioned earlier, our core supports page size of 16K. hence the mmu
code is changed accordingly, for kernel 2.4.9. but any command load fails
giving page alignment error. seems some problem from binfmt_elf.c file. i
have build the command, ash, using egcc-2.91.66. to change the page
alignment the option given was "--n16384". this option is surely wrong,
hence could you tell me what is correct option? HOW TO CHANGE PAGE ALIGNMENT
TO 16K WHILE LINKING USER COMMANDS??

many thanks in advance & best regards,
girish.


----- Original Message -----
From: "Ralf Baechle" <ralf@oss.sgi.com>
To: "Girish Gulawani" <girishvg@yahoo.com>
Cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Sent: Friday, January 25, 2002 10:45 AM
Subject: Re: MIPS/Linux NonSGI


> On Fri, Jan 25, 2002 at 08:41:10AM +0900, Girish Gulawani wrote:
>
> > i'm trying to bringup linux 2.4.[2|9] on our board based on LSI mips r4k
> > core.
> > right now the kernel compiled with gcc-3.0, boots up & can only work
with
>
> There are known bugs in older kernels that will crash them when compiled
> with gcc 3.0.  Even with current 2.4 kernels it's still playing with the
> fire.
>
> > statically linked commands. hence the root file system mounted from
> > ramdisk,nfs, & de-dream ide-disk can show some-prompt only if ash.static
is
> > invoked.
> > this is seen with 2.4.3 & ditto with 2.4.9. the kernel is in un-cached
> > mode,since we have page-size problem with our core in cached, write
> > through/back
> > both, modes. so question is WHY THE COMMANDS WITH SHARED LIBRARY DONOT
WORK.
> > FAILS TO LOAD SHARED LIBRARIES.
> >
> > the problem no.2 is root on ide-disk. the disk is paritioned & formatted
> > using a linux pentium-pc. using a master disk the above said statically
> > linked commands are downloaded to slave disk. the board boots up.
however
> > the bdflush/update process corrupts file-system. the UPDATE PROCESS
CORRUPTS
> > SUPERBLOCK AND INODES WHILE FLUSHING THE DIRTY BUFERS.
> >
> > PLEASE! PLEASE!! HELP ME ON THIS. THIS NEWSGROUP IS MY LAST HOPE.
>
> Seems pretty obvious that cacheflushing for your system is broken.
> Verify that arch/mips/mm/c-r4k.c knows how to handle your system.
>
>   Ralf
>
> PS: Seems your caps lock key occasionally gets stuck ;-)


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com
