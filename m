Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7QD6j432188
	for linux-mips-outgoing; Sun, 26 Aug 2001 06:06:45 -0700
Received: from dea.linux-mips.net (u-168-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.168])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7QD6fd32183
	for <linux-mips@oss.sgi.com>; Sun, 26 Aug 2001 06:06:41 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f7QD43w15016;
	Sun, 26 Aug 2001 15:04:03 +0200
Date: Sun, 26 Aug 2001 15:04:03 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: Patch against ac11
Message-ID: <20010826150403.A14665@dea.linux-mips.net>
References: <20010826010933.A8466@dea.linux-mips.net> <20010826024459.A8915@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010826024459.A8915@dea.linux-mips.net>; from ralf@oss.sgi.com on Sun, Aug 26, 2001 at 02:44:59AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Aug 26, 2001 at 02:44:59AM +0200, Ralf Baechle wrote:

> > For those who want to stay on the bleeding edge or maybe just want one of
> > the features not yet merged into Linus' codebase I've uploaded a patch
> > against 2.4.8-ac11 to oss.sgi.com:/pub/linux/mips/kernel/ac/.
> 
> The patch was generated on a corrupt XFS filesystem which did a few minutes
> after.  I'll re-create the patch once I finally fixed the fs problem
> and that looks tricky, IRIX keeps kernel core dumping ...

Turned out to be more fun than I initially though, reproducably crashing
IRIX and corrupting XFS at the price of just one  cvs update command.

The correct patch is 3829168 bytes long and has the following md5sum:

15b4d1c08d981326cf1490f35a810541  linux-2.4.8-ac11-rb1.diff.gz

The patch is meant to be applied on top of the current CVS kernel, not
on top of ac11.

  Ralf
