Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8HGL2X07830
	for linux-mips-outgoing; Mon, 17 Sep 2001 09:21:02 -0700
Received: from mcp.csh.rit.edu (mcp.csh.rit.edu [129.21.60.9])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8HGL0e07826
	for <linux-mips@oss.sgi.com>; Mon, 17 Sep 2001 09:21:00 -0700
Received: from fury.csh.rit.edu (fury.csh.rit.edu [129.21.60.5])
	by mcp.csh.rit.edu (Postfix) with ESMTP
	id 0BB37E6; Mon, 17 Sep 2001 12:20:57 -0400 (EDT)
Date: Mon, 17 Sep 2001 12:20:54 -0400 (EDT)
From: George Gensure <werkt@csh.rit.edu>
To: Soeren Laursen <soeren.laursen@scrooge.dk>
Cc: <linux-mips@oss.sgi.com>
Subject: Re: openssh probs
In-Reply-To: <3BA63E02.20088.2100546@localhost>
Message-ID: <Pine.SOL.4.31.0109171218020.15630-100000@fury.csh.rit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Yeah, should've mentioned the version.  I'm already running 2.9p2.  The
ssh server I'm testing on, I KNOW works.  I connect to it from my i686 box
all the time.  I looked at the packet dump, and it doesn't look like the
MAC is getting sent correctly.  I wasn't able to find the string anywhere
in there (assuming it gets sent unencrypted, of course).

George

On Mon, 17 Sep 2001, Soeren Laursen wrote:

> > Has anyone had any success running openssh on an Indy r5000? Currently
> > running 2.4.8 #4, and the error I get when running ssh is "Disconnecting:
> > Corrupted MAC on input."
> Yep, upgraded to openssh 2.x and the vanished.
>
> I guess it was an implementation error because I got it as well on
> i386 running openssh 1.x.
>
> It depended on the client software as well. Other systems running
> openssh could connect. Client from www.ssh.com could not
> connect.
>
> Best regards,
>
> Soeren,
>

-- 
George R. Gensure       Computer Science House Member
werkt@csh.rit.edu       Sophomore, Rochester Institute of Technology
Computer Science Major
