Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0F060U26798
	for linux-mips-outgoing; Mon, 14 Jan 2002 16:06:00 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g0F05vg26795
	for <linux-mips@oss.sgi.com>; Mon, 14 Jan 2002 16:05:57 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g0EN5sX29314;
	Mon, 14 Jan 2002 15:05:54 -0800
Date: Mon, 14 Jan 2002 15:05:54 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: MIPS64 status?
Message-ID: <20020114150554.A29242@dea.linux-mips.net>
References: <20020113211323.A7115@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020113211323.A7115@momenco.com>; from mdharm@momenco.com on Sun, Jan 13, 2002 at 09:13:23PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Jan 13, 2002 at 09:13:23PM -0800, Matthew Dharm wrote:

> As I understand it, 64-bit support is really two different things:  64-bit
> data path (i.e. unsigned long long) and 64-bit addressing (for more than 4G
> of RAM).

Right but due to the CPU architecture of pre-MIPS64 CPUs they always come
together unless the software does funny attempts at truncating OS support
to just 32-bit.  So the 32-bit kernel gives you none of the two, the mips64
kernel both.

> My understanding is that "MIPS64" generally refers to a kernel which
> supports a 64-bit data path, but we're still limited to 32-bit addressing.
> Is that correct?

MIPS64 is MIPS's MIPS64 processor architecture, mips64 is the 64-bit kernel.
That may sound like nitpicking but it's important to understand that both
are not the same.

> I suspect that this is very much a toolchain issue, as I don't think gcc
> will generate 64-bit addressing code.

Gcc is fine; the problem are binutils, that is as and ld.  As a result of
the gcc problems we don't have a 64-bit userspace either so all software
running on 64-bit kernels is currently old 32-bit software running in
compatibility mode.

  Ralf
