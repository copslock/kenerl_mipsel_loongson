Received:  by oss.sgi.com id <S305161AbQANI7D>;
	Fri, 14 Jan 2000 00:59:03 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:54845 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305160AbQANI6r>;
	Fri, 14 Jan 2000 00:58:47 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA00486; Fri, 14 Jan 2000 01:00:09 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA04939
	for linux-list;
	Fri, 14 Jan 2000 00:46:30 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA12497;
	Fri, 14 Jan 2000 00:46:24 -0800 (PST)
	mail_from (geert@linux-m68k.org)
Received: from aeon.tvd.be (aeon.tvd.be [195.162.196.20]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA00067; Fri, 14 Jan 2000 00:46:22 -0800 (PST)
	mail_from (geert@linux-m68k.org)
Received: from callisto.of.borg (cable-195-162-216-83.customer.chello.be [195.162.216.83])
	by aeon.tvd.be (8.9.3/8.9.3/RELAY-1.1) with ESMTP id JAA23752;
	Fri, 14 Jan 2000 09:46:20 +0100 (MET)
Received: from localhost (geert@localhost)
	by callisto.of.borg (8.9.3/8.9.3/Debian/GNU) with ESMTP id JAA08723;
	Fri, 14 Jan 2000 09:46:19 +0100
X-Authentication-Warning: callisto.of.borg: geert owned process doing -bs
Date:   Fri, 14 Jan 2000 09:46:19 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "William J. Earl" <wje@cthulhu.engr.sgi.com>
cc:     John Michael Clemens <clemej@rpi.edu>, linux@cthulhu.engr.sgi.com
Subject: Re: XZ graphics specs...
In-Reply-To: <14462.24718.670816.841437@liveoak.engr.sgi.com>
Message-ID: <Pine.LNX.4.05.10001140944380.8548-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, 13 Jan 2000, William J. Earl wrote:
> the hardware.  Note that XZ, like Newport graphics on Indy, does not
> have a CPU-addressable frame buffer, so you have to use the rendering interface.

You can still write a frame buffer device for it, but you can't export the
frame buffer to userspace (smem_start and smem_len == 0). Just make sure you
fill in your own drawing routines in display->dispsw.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
