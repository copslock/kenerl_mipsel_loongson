Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f98H74m21293
	for linux-mips-outgoing; Mon, 8 Oct 2001 10:07:04 -0700
Received: from mercury.shreve.net (IDENT:root@mercury.shreve.net [208.206.76.23])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f98H6xD21288
	for <linux-mips@oss.sgi.com>; Mon, 8 Oct 2001 10:06:59 -0700
Received: from mercury.shreve.net (IDENT:signal@mercury.shreve.net [208.206.76.23])
	by mercury.shreve.net (8.11.6/8.11.6) with ESMTP id f98H6vP03183;
	Mon, 8 Oct 2001 12:06:57 -0500
Date: Mon, 8 Oct 2001 12:06:57 -0500 (CDT)
From: Brian <signal@shreve.net>
To: "J. Scott Kasten" <jsk@tetracon-eng.net>
cc: <linux-mips@oss.sgi.com>
Subject: Re: Password recovery on IRIX box
In-Reply-To: <Pine.SGI.4.33.0110081057250.12398-100000@thor.tetracon-eng.net>
Message-ID: <Pine.LNX.4.33.0110081206220.28005-100000@mercury.shreve.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


that sounds like a good way...........the root partition is usually what?
/dev/sda1? /dev/c0d0t0?

On Mon, 8 Oct 2001, J. Scott Kasten wrote:

>
> I'm saying this from memory, but here is a procedure that would work if
> you have the Irix install CDs.  One of them is bootable.  You boot the
> miniroot from the CD and instead of invoking the installation, you opt to
> go to a shell prompt.  From there you can manually mount the partitions,
> and have some minimal capability to do things like overwrite the password
> file, archive a disk to tape, or up a network interface and rcp stuff off
> if you don't have any other means.  I've used this before to manipulate
> things on a marginally functional system.
>
> Other's here may have better short cuts, but this will do it.
>
> --
>
> J. Scott Kasten
> Email: jsk AT tetracon-eng DOT net
>
> "Nearly all men can stand adversity,
>  but if you want to test a man's
>  charater, give him power. - A Lincoln"
>
> On Mon, 8 Oct 2001, Brian wrote:
>
> >
> > I have an origin 200 I have been wanting to run linux on, its been sitting
> > up for a while. Before I wipe out and install linux, I need to get in
> > there to get some stuff of the drives.  But I do not know the root
> > password.  Can anyone direct me to password recovery procedures for IRIX?
> >
> > Brian
> >
> >
> > -----------------------------------------------
> > Brian Feeny, CCIE #8036	   e: signal@shreve.net
> > Network Engineer	   p: 318.222.2638x109
> > ShreveNet Inc.		   f: 318.221.6612
> >
> >
> >
>

-----------------------------------------------
Brian Feeny, CCIE #8036	   e: signal@shreve.net
Network Engineer	   p: 318.222.2638x109
ShreveNet Inc.		   f: 318.221.6612
