Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0F0jmQ27841
	for linux-mips-outgoing; Mon, 14 Jan 2002 16:45:48 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g0F0jig27837
	for <linux-mips@oss.sgi.com>; Mon, 14 Jan 2002 16:45:44 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g0ENjgu30346;
	Mon, 14 Jan 2002 15:45:42 -0800
Date: Mon, 14 Jan 2002 15:45:42 -0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Matthew Dharm <mdharm@momenco.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: MIPS64 status?
Message-ID: <20020114154542.A29462@dea.linux-mips.net>
References: <20020114150554.A29242@dea.linux-mips.net> <NEBBLJGMNKKEEMNLHGAICENCCEAA.mdharm@momenco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBLJGMNKKEEMNLHGAICENCCEAA.mdharm@momenco.com>; from mdharm@momenco.com on Mon, Jan 14, 2002 at 03:25:44PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jan 14, 2002 at 03:25:44PM -0800, Matthew Dharm wrote:

> Thanks for the info.  Too bad "MIPS64" and "mips64" sound exactly the
> same on the telephone.
> 
> But, I need to be pedantic, just to be clear on a couple of
> questions...
> 
> So, the "mips64" kernel can use 64-bits of address, for RAM >4G?
> But, the apps running are always 32-bit?

In theory the kernel has the capability to run 64-bit applications.  In
practice that doesn't work due to the lack of 64-bit apps and stuff.

> Does this mean that any individual application can only use 4G of
> memory, tho you could have several applications in physical memory
> doing this? (i.e. multiple applications using 1G of RAM each, but not
> swapping to disk?)

In theory we don't limit the address space of 32-bit applications in 64-bit
mode so they could go and use all memory and syscalls on the 64-bit
address space also.  In practice that's just too ugly to be usable so
consider 32-bit apps on the 64-bit kernel as limited to 2gb as they are
currently.  You can however run an arbitrary number of these processes.

> Does this mean we could map PCI memory/IO addresses above 4G and have
> it work?

Sure.

  Ralf
