Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4JJVmnC010063
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 19 May 2002 12:31:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4JJVmxW010062
	for linux-mips-outgoing; Sun, 19 May 2002 12:31:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4JJVknC010052
	for <linux-mips@oss.sgi.com>; Sun, 19 May 2002 12:31:46 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g4JJWJT03189;
	Sun, 19 May 2002 12:32:19 -0700
Date: Sun, 19 May 2002 12:32:19 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Jun Sun <jsun@mvista.com>, Daniel Jacobowitz <dan@debian.org>,
   Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
Message-ID: <20020519123219.F20670@dea.linux-mips.net>
References: <3CE2DA46.3070402@mvista.com> <NEBBLJGMNKKEEMNLHGAIKEABCHAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIKEABCHAA.mdharm@momenco.com>; from mdharm@momenco.com on Wed, May 15, 2002 at 03:16:29PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 15, 2002 at 03:16:29PM -0700, Matthew Dharm wrote:

> Could someone give me an overview of how you're supposed to do a
> handoff between a 32-bit loader and a 64-bit app?  I'm guessing there
> has to be a way to do it, but what I do know about the 64-bit stuff
> doesn't show me how this is accomplished (I have visions of UX bits
> floating in my head...)

If you're placing the kernel in KSEG0 like all other current targets are
doing then your 32-bit pointers are valid 64-bit pointers, no magic,
no thinking necessary.

  Ralf
