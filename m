Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f391tAm24030
	for linux-mips-outgoing; Sun, 8 Apr 2001 18:55:10 -0700
Received: from dea.waldorf-gmbh.de (u-145-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.145])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f391t6M24027
	for <linux-mips@oss.sgi.com>; Sun, 8 Apr 2001 18:55:06 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f391sr500851;
	Mon, 9 Apr 2001 03:54:53 +0200
Date: Mon, 9 Apr 2001 03:54:53 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: John Tobey <jtobey@john-edwin-tobey.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: 64-bit on Cobalt?
Message-ID: <20010409035453.B774@bacchus.dhis.org>
References: <20010408184241.A3443@john-edwin-tobey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010408184241.A3443@john-edwin-tobey.org>; from jtobey@john-edwin-tobey.org on Sun, Apr 08, 2001 at 06:42:41PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sun, Apr 08, 2001 at 06:42:41PM -0400, John Tobey wrote:

> The CPU is a QED RM5231 (CONFIG_NEVADA) 150MHz.  May I assume that
> nobody has run a 64-bit kernel on this thing?  The RaQ has no video
> card but a serial console, PCI, IDE, Ethernet, and special LEDs, panel
> buttons, and LCD display.  If I can get a 64-bit kernel to boot and
> prove its existence through any of these devices, I will be drunk with
> power.

So far the only supported machine by the mips64 kernel is the SGI Origin
200 / 2000 series.

> The reason I want 64 bits is that I (a) want a challenge, (b) plan to
> write an application that uses a sparse address space (40 bits is
> better than 31), (c) plan to outlive the 31-bit time_t, and (d) am
> p.o.ed at having bought the thing based on misleading advertising that
> mentioned a 64-bit processor but not the 32-bit OS.

> Big/little endian macht nichts.  I guess big will be easier, and I'm
> not concerned with running any existing 32-bit binaries.

Go for little endian because the firmware is little endian; supporting
``other-endian'' for userspace would be unecessary extra pain.  We already
have suport for 32-bit binaries in the 64-bit kernel; in fact ALL
software we run on 64-bit kernels is 32-bit.

32-bit wasn't only the easy thing to do - it's also the more efficient
thing for most software which doesn't need 64-bit registers or 64-bit
address space.  For a system with a dog slow 32-bit memory bus such as
the Qube 64-bit kernels would mean a dramatic slowdown.

I admit it's interesting though, mostly for engineering reasons, not
as a platform.

> I imagine that I would start by grafting Cobalt's peripheral support
> code from arch/mips/cobalt (now defunct) and include/asm-mips/cobalt.h
> into the mips64 tree from cvs@oss.sgi.com:/cvs/linux.

Somebody else was already working on upgrading the Cobalt kernel to 2.4.

  Ralf
