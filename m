Received:  by oss.sgi.com id <S305188AbQAFBDE>;
	Wed, 5 Jan 2000 17:03:04 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:52310 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305186AbQAFBCx>;
	Wed, 5 Jan 2000 17:02:53 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA06184; Wed, 5 Jan 2000 17:03:33 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA60234
	for linux-list;
	Wed, 5 Jan 2000 16:55:50 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from liveoak.engr.sgi.com (liveoak.engr.sgi.com [163.154.5.24])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA54922;
	Wed, 5 Jan 2000 16:55:44 -0800 (PST)
	mail_from (wje@liveoak.engr.sgi.com)
Received: (from wje@localhost)
	by liveoak.engr.sgi.com (8.9.3/8.8.7) id QAA18962;
	Wed, 5 Jan 2000 16:55:23 -0800
X-Authentication-Warning: liveoak.engr.sgi.com: wje set sender to wje@liveoak.engr.sgi.com using -f
From:   "William J. Earl" <wje@cthulhu.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14451.59386.542889.13018@liveoak.engr.sgi.com>
Date:   Wed, 5 Jan 2000 16:55:22 -0800 (PST)
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Andy Isaacson <adisaacs@mr-happy.com>, linux@cthulhu.engr.sgi.com
Subject: Re: XFree86-FBDev and /dev/fb0
In-Reply-To: <20000106013723.A14707@uni-koblenz.de>
References: <38726C8D.D912DF94@detroit.sgi.com>
	<00010516082202.01432@pingu.kastner.net>
	<20000105114922.B20983@mr-happy.com>
	<20000106013723.A14707@uni-koblenz.de>
X-Mailer: VM 6.74 under Emacs 20.3.1
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Ralf Baechle writes:
 > On Wed, Jan 05, 2000 at 11:49:22AM -0500, Andy Isaacson wrote:
 > 
 > > > I have kernel with framebuffer (when I boot, I see linux-sgi.logo - 2.2.1)
 > > > 
 > > > I have no /dev/fb0.
 > > 
 > > You probably need to create the device node, then.  Look at the man
 > > page for mknod, and Documentation/devices.txt in your kernel source
 > > tree, for further info.
 > 
 > That alone won't help.
 > 
 > A system with the XL graphics will never have a real working framebuffer.

     Since the real graphics framebuffer is in memory which is not addressable
by the processor, the only way to fake a CPU-addressable framebuffer is
to reserve a chunk of main memory, and then DMA the contents into the
real framebuffer when the CPU-addressable framebuffer is changed (or
every vertical refresh interval, if there is no way to tell when the buffer
changes).  You could probably play with the PTE valid and mod bits to detect
when pages are changed.  It would in any case be relatively inefficient
compared to using the graphics pipeline as intended, since uncached writes
to the graphics pipeline are pretty cheap (better than cached or uncached
writes to large areas of main memory).
