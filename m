Received:  by oss.sgi.com id <S305188AbQAFB3Y>;
	Wed, 5 Jan 2000 17:29:24 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:39262 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305186AbQAFB3J>;
	Wed, 5 Jan 2000 17:29:09 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA09259; Wed, 5 Jan 2000 17:29:54 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA71446
	for linux-list;
	Wed, 5 Jan 2000 17:17:42 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA82838
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 5 Jan 2000 17:17:36 -0800 (PST)
	mail_from (adisaacs@mr-happy.com)
Received: from brainguy.tc.mtu.edu (brainguy.tc.mtu.edu [141.219.5.85]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA00161
	for <linux@cthulhu.engr.sgi.com>; Wed, 5 Jan 2000 17:17:21 -0800 (PST)
	mail_from (adisaacs@mr-happy.com)
Received: from crow.mr-happy.com (crow.mr-happy.com [172.19.3.81])
	by brainguy.tc.mtu.edu (8.8.8/8.8.7/mtumailer-1.2) with ESMTP id UAA00527
	for <linux@cthulhu.engr.sgi.com>; Wed, 5 Jan 2000 20:17:19 -0500 (EST)
Received: (from adisaacs@localhost)
	by crow.mr-happy.com (8.9.1b+Sun/HappyClient) id UAA16838
	for linux@cthulhu.engr.sgi.com; Wed, 5 Jan 2000 20:17:19 -0500 (EST)
Date:   Wed, 5 Jan 2000 20:17:19 -0500
From:   Andy Isaacson <adisaacs@mr-happy.com>
To:     linux@cthulhu.engr.sgi.com
Subject: Re: XFree86-FBDev and /dev/fb0
Message-ID: <20000105201719.A16821@mr-happy.com>
References: <38726C8D.D912DF94@detroit.sgi.com> <00010516082202.01432@pingu.kastner.net> <20000105114922.B20983@mr-happy.com> <20000106013723.A14707@uni-koblenz.de> <14451.59386.542889.13018@liveoak.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14451.59386.542889.13018@liveoak.engr.sgi.com>
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.mr-happy.com/~adisaacs/pgp.txt
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Jan 05, 2000 at 04:55:22PM -0800, William J. Earl wrote:
> Ralf Baechle writes:
>  > A system with the XL graphics will never have a real working framebuffer.
> 
>      Since the real graphics framebuffer is in memory which is not addressable
> by the processor, the only way to fake a CPU-addressable framebuffer is
> to reserve a chunk of main memory, and then DMA the contents into the
> real framebuffer when the CPU-addressable framebuffer is changed (or
> every vertical refresh interval, if there is no way to tell when the buffer
> changes).  You could probably play with the PTE valid and mod bits to detect
> when pages are changed.  It would in any case be relatively inefficient
> compared to using the graphics pipeline as intended, since uncached writes
> to the graphics pipeline are pretty cheap (better than cached or uncached
> writes to large areas of main memory).

XFree86 has builtin support for this mode of operation in the latest
development snapshot (3.9.17).  They call it ShadowFB.  Of course that
would only work in X, not on console.  Apparently it's fairly easy to
write a driver that supports ShadowFB; all you have to be able to do
is update a rectangular area of the screen on demand.

-andy
-- 
Andy Isaacson  http://web.mr-happy.com/~adisaacs/   Fight Spam, join CAUCE:
adi@acm.org adisaacs@mr-happy.com isaacson@cs.umn.edu   www.cauce.org
