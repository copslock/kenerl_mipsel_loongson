Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f98F3YK17808
	for linux-mips-outgoing; Mon, 8 Oct 2001 08:03:34 -0700
Received: from thor ([207.246.91.243])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f98F3UD17804
	for <linux-mips@oss.sgi.com>; Mon, 8 Oct 2001 08:03:30 -0700
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id LAA12486; Mon, 8 Oct 2001 11:01:33 -0400
Date: Mon, 8 Oct 2001 11:01:33 -0400
From: "J. Scott Kasten" <jsk@tetracon-eng.net>
To: Brian <signal@shreve.net>
cc: <linux-mips@oss.sgi.com>
Subject: Re: Password recovery on IRIX box
In-Reply-To: <Pine.LNX.4.33.0110080908260.8853-100000@mercury.shreve.net>
Message-ID: <Pine.SGI.4.33.0110081057250.12398-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


I'm saying this from memory, but here is a procedure that would work if
you have the Irix install CDs.  One of them is bootable.  You boot the
miniroot from the CD and instead of invoking the installation, you opt to
go to a shell prompt.  From there you can manually mount the partitions,
and have some minimal capability to do things like overwrite the password
file, archive a disk to tape, or up a network interface and rcp stuff off
if you don't have any other means.  I've used this before to manipulate
things on a marginally functional system.

Other's here may have better short cuts, but this will do it.

--

J. Scott Kasten
Email: jsk AT tetracon-eng DOT net

"Nearly all men can stand adversity,
 but if you want to test a man's
 charater, give him power. - A Lincoln"

On Mon, 8 Oct 2001, Brian wrote:

>
> I have an origin 200 I have been wanting to run linux on, its been sitting
> up for a while. Before I wipe out and install linux, I need to get in
> there to get some stuff of the drives.  But I do not know the root
> password.  Can anyone direct me to password recovery procedures for IRIX?
>
> Brian
>
>
> -----------------------------------------------
> Brian Feeny, CCIE #8036	   e: signal@shreve.net
> Network Engineer	   p: 318.222.2638x109
> ShreveNet Inc.		   f: 318.221.6612
>
>
>
