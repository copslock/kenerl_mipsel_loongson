Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f399cjt32598
	for linux-mips-outgoing; Mon, 9 Apr 2001 02:38:45 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f399cgM32593;
	Mon, 9 Apr 2001 02:38:42 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id CAA27903;
	Mon, 9 Apr 2001 02:38:45 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id CAA24516;
	Mon, 9 Apr 2001 02:38:42 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id LAA22234;
	Mon, 9 Apr 2001 11:38:00 +0200 (MEST)
Message-ID: <3AD182F7.FF740CA6@mips.com>
Date: Mon, 09 Apr 2001 11:37:59 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: John Tobey <jtobey@john-edwin-tobey.org>, linux-mips@oss.sgi.com
Subject: Re: 64-bit on Cobalt?
References: <20010408184241.A3443@john-edwin-tobey.org> <20010409035453.B774@bacchus.dhis.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Sun, Apr 08, 2001 at 06:42:41PM -0400, John Tobey wrote:
>
> > The CPU is a QED RM5231 (CONFIG_NEVADA) 150MHz.  May I assume that
> > nobody has run a 64-bit kernel on this thing?  The RaQ has no video
> > card but a serial console, PCI, IDE, Ethernet, and special LEDs, panel
> > buttons, and LCD display.  If I can get a 64-bit kernel to boot and
> > prove its existence through any of these devices, I will be drunk with
> > power.
>
> So far the only supported machine by the mips64 kernel is the SGI Origin
> 200 / 2000 series.

I have a QED RM5261 running a bigendian 64-bit kernel on our Malta board (it
got a serial console, PCI, IDE, Ethernet).
I haven't send the patch to Ralf yet, but you can get a snapshot at our
kernel sources at
ftp://ftp.mips.com/pub/linux/mips/kernel/2.4/src/linux-2.4.1.mips-src-01.00.tar.gz

Hope it helps you.

>
> > The reason I want 64 bits is that I (a) want a challenge, (b) plan to
> > write an application that uses a sparse address space (40 bits is
> > better than 31), (c) plan to outlive the 31-bit time_t, and (d) am
> > p.o.ed at having bought the thing based on misleading advertising that
> > mentioned a 64-bit processor but not the 32-bit OS.
>
> > Big/little endian macht nichts.  I guess big will be easier, and I'm
> > not concerned with running any existing 32-bit binaries.
>
> Go for little endian because the firmware is little endian; supporting
> ``other-endian'' for userspace would be unecessary extra pain.  We already
> have suport for 32-bit binaries in the 64-bit kernel; in fact ALL
> software we run on 64-bit kernels is 32-bit.
>
> 32-bit wasn't only the easy thing to do - it's also the more efficient
> thing for most software which doesn't need 64-bit registers or 64-bit
> address space.  For a system with a dog slow 32-bit memory bus such as
> the Qube 64-bit kernels would mean a dramatic slowdown.
>
> I admit it's interesting though, mostly for engineering reasons, not
> as a platform.
>
> > I imagine that I would start by grafting Cobalt's peripheral support
> > code from arch/mips/cobalt (now defunct) and include/asm-mips/cobalt.h
> > into the mips64 tree from cvs@oss.sgi.com:/cvs/linux.
>
> Somebody else was already working on upgrading the Cobalt kernel to 2.4.
>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
