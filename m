Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB6IIQN23211
	for linux-mips-outgoing; Thu, 6 Dec 2001 10:18:26 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id fB6IILo23208
	for <linux-mips@oss.sgi.com>; Thu, 6 Dec 2001 10:18:22 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id fB6HHxZ05110;
	Thu, 6 Dec 2001 15:17:59 -0200
Date: Thu, 6 Dec 2001 15:17:59 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: ldavies@agile.tv
Cc: linux-mips@oss.sgi.com
Subject: Re: [PATCH] mips_atomic_set fixups (with LLSC)
Message-ID: <20011206151759.H3325@dea.linux-mips.net>
References: <3C0F059A.30709@agile.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C0F059A.30709@agile.tv>; from ldavies@agile.tv on Thu, Dec 06, 2001 at 03:43:54PM +1000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Dec 06, 2001 at 03:43:54PM +1000, Liam Davies wrote:

> The kernel can be caused to crash when making the following syscall
> sysmips(MIPS_ATOMIC_SET, [unaligned addr], value, 0);
> 
> The latest mips_atomic_set does not use the fixups that are defined
> for the ll/sc instructions.
> 
> If an unaligned address is passed in we take the exception and
> unaligned.c:emulate_load_store_insn ignores the fixups for the
> ll/sc and sends a SIGBUS instead, thus causing the kernel to die.

An unaligned ll/sc instruction in the kernel is a bug in itself as such
it's not unaligned.c that is to blame.  As such I'm going to checkin
a patch that is close but not identical to your patch.

Blame me for this bug, I *knew* and forgot about it ...

  Ralf
