Received:  by oss.sgi.com id <S305160AbQANOtx>;
	Fri, 14 Jan 2000 06:49:53 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:35633 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305155AbQANOtp>;
	Fri, 14 Jan 2000 06:49:45 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id GAA29422; Fri, 14 Jan 2000 06:46:51 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA47964
	for linux-list;
	Fri, 14 Jan 2000 06:40:48 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA02815
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 14 Jan 2000 06:40:28 -0800 (PST)
	mail_from (jsimmons@acsu.buffalo.edu)
Received: from joxer.acsu.buffalo.edu (joxer.acsu.buffalo.edu [128.205.7.120]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id GAA05054
	for <linux@cthulhu.engr.sgi.com>; Fri, 14 Jan 2000 06:40:17 -0800 (PST)
	mail_from (jsimmons@acsu.buffalo.edu)
Received: (qmail 10207 invoked by uid 9977); 14 Jan 2000 14:40:14 -0000
Date:   Fri, 14 Jan 2000 09:40:14 -0500 (EST)
From:   James A Simmons <jsimmons@acsu.buffalo.edu>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     "William J. Earl" <wje@cthulhu.engr.sgi.com>,
        John Michael Clemens <clemej@rpi.edu>,
        linux@cthulhu.engr.sgi.com
Subject: Re: XZ graphics specs...
In-Reply-To: <Pine.LNX.4.05.10001140944380.8548-100000@callisto.of.borg>
Message-ID: <Pine.GSO.4.05.10001140937580.8702-100000@joxer.acsu.buffalo.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


On Fri, 14 Jan 2000, Geert Uytterhoeven wrote:

> On Thu, 13 Jan 2000, William J. Earl wrote:
> > the hardware.  Note that XZ, like Newport graphics on Indy, does not
> > have a CPU-addressable frame buffer, so you have to use the rendering interface.
> 
> You can still write a frame buffer device for it, but you can't export the
> frame buffer to userspace (smem_start and smem_len == 0). Just make sure you
> fill in your own drawing routines in display->dispsw.

In the next few days I will be introducing fbcon-accel.c which are a set
of console functions wrapped around the accel features of a card. I hope
to have this go into the 2.3.x kernels soon.

Codito, ergo sum - "I code, therefore I am"
James Simmons                                                      (o_
fbdev/gfx developer                                      (o_  (o_ //\
http://www.linux-fbdev.org                              (/)_ (/)_ V_/_
http://linuxgfx.sourceforge.net
