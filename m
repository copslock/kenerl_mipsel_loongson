Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4JJN9nC007751
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 19 May 2002 12:23:09 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4JJN9xF007750
	for linux-mips-outgoing; Sun, 19 May 2002 12:23:09 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4JJN5nC007739
	for <linux-mips@oss.sgi.com>; Sun, 19 May 2002 12:23:06 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g4JJNb902998;
	Sun, 19 May 2002 12:23:37 -0700
Date: Sun, 19 May 2002 12:23:37 -0700
From: Ralf Baechle <ralf@oss.sgi.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: MIPS 64?
Message-ID: <20020519122336.A20670@dea.linux-mips.net>
References: <NEBBLJGMNKKEEMNLHGAIOEPPCGAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAIOEPPCGAA.mdharm@momenco.com>; from mdharm@momenco.com on Wed, May 15, 2002 at 02:34:47PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, May 15, 2002 at 02:34:47PM -0700, Matthew Dharm wrote:

> So... I'm looking at porting Linux to a system with 1.5GiB of RAM.
> That kinda blows the 32-bit MIPS port option right out of the water...

Not really, there is still highmem though that certainly a sucky solution
as compared to a 64-bit kernel.

> What does it take to do a 64-bit port?  The first problem I see is the
> boot loader -- do I have to be in 64-bit mode when the kernel starts,
> or can I start in 32-bit mode and then transfer to 64-bit mode?

Same loader as before - the build procedure will result in a 32-bit kernel
binary which is loaded to the same old KSEG0 addresses.

> I looked in the arch/mips64/ directory, but I don't see much for
> specific boards there, but there are references to the Malta
> boards....

Exactly.  The aim is to support both kernels without replicating the board
support code.

  Ralf
