Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id UAA523265; Mon, 18 Aug 1997 20:25:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA13775 for linux-list; Mon, 18 Aug 1997 20:24:15 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA13756 for <linux@cthulhu.engr.sgi.com>; Mon, 18 Aug 1997 20:24:11 -0700
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA01326
	for <linux@relay.engr.sgi.com>; Mon, 18 Aug 1997 20:24:10 -0700
	env-from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
          by lager.engsoc.carleton.ca (8.8.5/8.8.4) with SMTP
	  id XAA24325; Mon, 18 Aug 1997 23:23:38 -0400
Date: Mon, 18 Aug 1997 23:23:38 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Stephen Gass <stepheng@zephyr.sydney.sgi.com>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: Current problems.
In-Reply-To: <9708191304.ZM1251@zephyr.sydney.sgi.com>
Message-ID: <Pine.LNX.3.95.970818231357.23809A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


(Stephen, excuse me for reposting your mail to a public list, but I think
there is some value in it)

On Tue, 19 Aug 1997, Stephen Gass wrote:
> fx only supports the following types of partition types :
> volhdr,raw,volume,rlvol,xlv,trkrepl,bsd,efs,xfs,secrepl,sysv,lvol,xfslog
<snip>

> I don't know if the supported partition types are compatible in any way with
> linux. The regular partition tools in  root-be-0.00.cpio.gz seem to be missing
> ( mke2fs, fdisk(?) etc ) 

Actually, mke2fs is in /sbin.  Fdisk isn't.

> Hopefully some kind soul will let me know how to either :
> (a) Extract rpms

That's not too tough... it's a matter of over-ruling the architecture
checking of the rpm command line, or rewriting something that uses rpmlib.
I will hack something together.

> (b) tell me where I can pick up mke2fs

It's there for SGI Linux already.

I've stolen (with the help of Mike Shaver) from Alistair Lambie a .tar.gz
of e2fs tools fo Irix.  It's in ftp://ftp.linux.sgi.com/pub/mips-linux/ . 
I had quite a bit of problems getting the raw source to compile under Irix
myself, so this was a blessing.  Alistair, if you mind, I'll take it down.

Let me tack on a big question here:

(c) How should I in fact be setting up a disk?  Do I even need to
partition?  If I'm formatting from within Irix, what device should I be
mke2fs'ing?

- Alex 
