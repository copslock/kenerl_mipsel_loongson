Received:  by oss.sgi.com id <S305188AbQAFBfO>;
	Wed, 5 Jan 2000 17:35:14 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:29019 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305186AbQAFBfB>;
	Wed, 5 Jan 2000 17:35:01 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id RAA15865; Wed, 5 Jan 2000 17:31:27 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA04510
	for linux-list;
	Wed, 5 Jan 2000 17:27:47 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA28741;
	Wed, 5 Jan 2000 17:27:39 -0800 (PST)
	mail_from (ulfc@engr.sgi.com)
Received: from localhost (localhost [127.0.0.1])
	by calypso.engr.sgi.com (Postfix) with ESMTP
	id 27E79105210; Wed,  5 Jan 2000 17:27:33 -0800 (PST)
Date:   Wed, 5 Jan 2000 17:27:33 -0800 (PST)
From:   Ulf Carlsson <ulfc@cthulhu.engr.sgi.com>
To:     Andy Isaacson <adisaacs@mr-happy.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: XFree86-FBDev and /dev/fb0
In-Reply-To: <20000105201719.A16821@mr-happy.com>
Message-ID: <Pine.LNX.4.10.10001051724470.1491-100000@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> On Wed, Jan 05, 2000 at 04:55:22PM -0800, William J. Earl wrote:
> > Ralf Baechle writes:
> >  > A system with the XL graphics will never have a real working framebuffer.
> > 
> >      Since the real graphics framebuffer is in memory which is not addressable
> > by the processor, the only way to fake a CPU-addressable framebuffer is
> > to reserve a chunk of main memory, and then DMA the contents into the
> > real framebuffer when the CPU-addressable framebuffer is changed (or
> > every vertical refresh interval, if there is no way to tell when the buffer
> > changes).  You could probably play with the PTE valid and mod bits to detect
> > when pages are changed.  It would in any case be relatively inefficient
> > compared to using the graphics pipeline as intended, since uncached writes
> > to the graphics pipeline are pretty cheap (better than cached or uncached
> > writes to large areas of main memory).
> 
> XFree86 has builtin support for this mode of operation in the latest
> development snapshot (3.9.17).  They call it ShadowFB.  Of course that
> would only work in X, not on console.  Apparently it's fairly easy to
> write a driver that supports ShadowFB; all you have to be able to do
> is update a rectangular area of the screen on demand.

Yeah, and that's what I tried to get working but I ran into other problems with
the dynamic loading of X modules and stuff so I never got the chance to
concentrate on the driver.  I have the early stages of a driver around though.

Ulf
