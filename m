Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f43HMSD09212
	for linux-mips-outgoing; Thu, 3 May 2001 10:22:28 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f43HMPF09209
	for <linux-mips@oss.sgi.com>; Thu, 3 May 2001 10:22:25 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f43HLEC06101;
	Thu, 3 May 2001 14:21:14 -0300
Date: Thu, 3 May 2001 14:21:14 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Insertion of die_if_kernel in unaligned.c
Message-ID: <20010503142114.A6081@bacchus.dhis.org>
References: <3AF13558.F26941EE@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF13558.F26941EE@mips.com>; from carstenl@mips.com on Thu, May 03, 2001 at 12:39:20PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, May 03, 2001 at 12:39:20PM +0200, Carsten Langgaard wrote:

> In the latest version of arch/mips/kernel/unaligned.c, there has been
> inserted some calls to the die_if_kernel, which check if we are running
> in kernel mode and if so dies.
> I'm not so sure this is the right thing to do, the floating point
> emulator will in some cases generate an address error (e.g. if emulating
> a swc1 to an unaligned address). The result is that an user application
> can crash the kernel.

They're wrong and what's worse, I knew about them.  The unaligned from
kernelspace case can also be triggered from the network stack so this
leaves machines open to remote DoS.

  Ralf
