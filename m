Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3OMdQwJ023344
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Apr 2002 15:39:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3OMdQWd023343
	for linux-mips-outgoing; Wed, 24 Apr 2002 15:39:26 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3OMdNwJ023330
	for <linux-mips@oss.sgi.com>; Wed, 24 Apr 2002 15:39:23 -0700
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id g3OMdSj21195;
	Wed, 24 Apr 2002 18:39:28 -0400
Date: Wed, 24 Apr 2002 18:39:28 -0400
From: Jim Paris <jim@jtan.com>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Zhang Fuxin <fxzhang@ict.ac.cn>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: vga initialization
Message-ID: <20020424183928.A21149@neurosis.mit.edu>
References: <200204240111.g3O1BowJ006668@oss.sgi.com> <Pine.LNX.4.10.10204241520210.19194-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10204241520210.19194-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Wed, Apr 24, 2002 at 03:22:20PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> Yipes!!! It has been discussed before and no x86 emulator will go into the
> kernel. Now what I really love to ses is a way to trace threw the bios
> code so we can write video drivers that don't need the BIOS to work. 

If you mean "trace through" as in automatically, well, that's an x86
emulator. :) If you mean manually, there's a problem, because every
card is going to be entirely different.

-jim
