Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA26715 for <linux-archive@neteng.engr.sgi.com>; Sat, 18 Jul 1998 17:36:01 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA92705
	for linux-list;
	Sat, 18 Jul 1998 17:35:24 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA91955
	for <linux@engr.sgi.com>;
	Sat, 18 Jul 1998 17:35:13 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA10333
	for <linux@engr.sgi.com>; Sat, 18 Jul 1998 17:35:10 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-13.uni-koblenz.de [141.26.249.13])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA18481
	for <linux@engr.sgi.com>; Sun, 19 Jul 1998 02:35:02 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id CAA00553;
	Sun, 19 Jul 1998 02:34:23 +0200
Message-ID: <19980719023421.A489@uni-koblenz.de>
Date: Sun, 19 Jul 1998 02:34:21 +0200
To: Michael Engel <engel@numerik.math.uni-siegen.de>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: ext2fs corruptions and other things ...
References: <199807182253.AAA10366@jordan.numerik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199807182253.AAA10366@jordan.numerik>; from Michael Engel on Sun, Jul 19, 1998 at 12:53:14AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jul 19, 1998 at 12:53:14AM +0200, Michael Engel wrote:

> sorry for all the delays and everything ... it were two very busy weeks :-(.
> Following Ralfs proposal, how about a MIPS hackers' BBQ now that it looks
> like the eternal rain in Germany has stopped ;) ?

Clear sky for the first time since ...  can't remember ...

> Back to hacking ... I just got 2.1.100 running on my RM200 and noticed
> two things:
> 
> - Automatic IRQ detection of ISA cards doesn't work. Does it work on any
>   other MIPS machines ? Setting a fixed irq line makes my NE2000 and IDE
>   controller work in the ISA slots. 

I remember getting strange messages from the interrupt probing code on the
RM200C but aside that IDE was working just fine.  It's very, very long
since I last tried some other isa-ish periphery in the machine.

Quite some time Thomas commited a patch to arch/mips/kernel/irc.c which was
actually supposed to fix the probing problem, maybe he can comment.

> - NFS root works fine, I'm up and running multi user with the old rootfs-0.01 -
>   fine ! However, I suspect quite some problems with these binaries ... 

Since the release of root-0.01 (little endian) I had to break the binary
compatibility in two important points.  These binaries aren't any longer
supposed to be really useable.

> - Whenever I try to untar rootfs-0.01.tar.gz on my IDE hard disk, I get
>   a fs corrution (usually after creating the second directory):
> 
>   EXT2-fs error (device 03:00):
>   ext2_readdir: bad entry in directory #2: 
>   rec_len is smaller than minimal - offset=896, inode=0, rec_len=0, 
>   name_len=0
> 
>   [Note that I'm using the raw disk /dev/hda as fdisk doesn't seem to 
>    create correct partition information]

I've used a newer build of fdisk (< 1 year :-) and there is no problem at
all with partitioning.  IDE is prefectly reliable for me.

We actually had more reports about problems with filesystems on /dev/sdx
on Indys.  There seems to be a clear pattern of a bug, but for now I
classify that one as lower priority.

>   Has anyone seen similar effects on MIPS machines ?
>   
> Off to read the intel 82596 ethernet controller docs ...

Btw, Linux supports two 82596 based Ethernet adapters.

  Ralf
