Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8OFsl202587
	for linux-mips-outgoing; Mon, 24 Sep 2001 08:54:47 -0700
Received: from gandalf.physik.uni-konstanz.de (gandalf.physik.uni-konstanz.de [134.34.144.69])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8OFsie02584
	for <linux-mips@oss.sgi.com>; Mon, 24 Sep 2001 08:54:44 -0700
Received: from agx by gandalf.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 15lY49-0001N8-00; Mon, 24 Sep 2001 17:54:41 +0200
Date: Mon, 24 Sep 2001 17:54:41 +0200
From: Guido Guenther <agx@debian.org>
To: debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Subject: Re: Need an account on a Linux/Mips box
Message-ID: <20010924175441.A5175@gandalf.physik.uni-konstanz.de>
Mail-Followup-To: debian-mips@lists.debian.org, linux-mips@oss.sgi.com
References: <1f05gge.7bt3xkxllentM@[10.0.12.137]> <vzay9n46373.fsf@false.linpro.no> <20010924173723.A2203@bunny.shuttle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010924173723.A2203@bunny.shuttle.de>; from borenius@shuttle.de on Mon, Sep 24, 2001 at 05:37:23PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Sep 24, 2001 at 05:37:23PM +0200, Raoul Borenius wrote:
> Does it run without any problems? What kernel (with what patches?) are you
> running. I'm having troubles running our R4600-Indy:
> 
> - Perl is seg-faulting (especially when a perl-script is calling another)
I'm seeing the same here. The gdb output of these segfaults is rather
weird too(gotta look that one up though). Never found time to look
deeper into this.
> 
> I'm using kernel-image-2.4.5 from debian but we've had these problems
> all through 2.4.x.
Hmm...I'm sure that very early 2.4.x kernels worked quiet well on R4600.
One way to hunt the problem down, would be to roll back to 2.4.0 and
spot the point in cvs where things break.
Could it be possible that things fail since glibc uses sysmips?
 -- Guido

-- 
This kind of limitation can lead administrators to do irrational things,
      like install Windows. Clearly a fix was required. (lwn.net)
