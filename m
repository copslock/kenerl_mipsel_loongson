Received:  by oss.sgi.com id <S305188AbQAFA7O>;
	Wed, 5 Jan 2000 16:59:14 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:29455 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305186AbQAFA7A>; Wed, 5 Jan 2000 16:59:00 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id RAA04735; Wed, 5 Jan 2000 17:01:56 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA05360
	for linux-list;
	Wed, 5 Jan 2000 16:40:50 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA97344
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 5 Jan 2000 16:40:36 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA06498
	for <linux@cthulhu.engr.sgi.com>; Wed, 5 Jan 2000 16:40:19 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-29.uni-koblenz.de (cacc-29.uni-koblenz.de [141.26.131.29])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA08979;
	Thu, 6 Jan 2000 01:40:06 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQAFAhX>;
	Thu, 6 Jan 2000 01:37:23 +0100
Date:   Thu, 6 Jan 2000 01:37:23 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Andy Isaacson <adisaacs@mr-happy.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: XFree86-FBDev and /dev/fb0
Message-ID: <20000106013723.A14707@uni-koblenz.de>
References: <38726C8D.D912DF94@detroit.sgi.com> <00010516082202.01432@pingu.kastner.net> <20000105114922.B20983@mr-happy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20000105114922.B20983@mr-happy.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Jan 05, 2000 at 11:49:22AM -0500, Andy Isaacson wrote:

> > I have kernel with framebuffer (when I boot, I see linux-sgi.logo - 2.2.1)
> > 
> > I have no /dev/fb0.
> 
> You probably need to create the device node, then.  Look at the man
> page for mknod, and Documentation/devices.txt in your kernel source
> tree, for further info.

That alone won't help.

A system with the XL graphics will never have a real working framebuffer.

  Ralf
