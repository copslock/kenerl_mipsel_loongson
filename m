Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA49786 for <linux-archive@neteng.engr.sgi.com>; Sun, 19 Jul 1998 07:20:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA04554
	for linux-list;
	Sun, 19 Jul 1998 07:19:33 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA94907
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 19 Jul 1998 07:19:31 -0700 (PDT)
	mail_from (mjhsieh@helix.life.nthu.edu.tw)
Received: from helix.life.nthu.edu.tw (helix.life.nthu.edu.tw [140.114.98.34]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA04806
	for <linux@cthulhu.engr.sgi.com>; Sun, 19 Jul 1998 07:19:30 -0700 (PDT)
	mail_from (mjhsieh@helix.life.nthu.edu.tw)
Received: (from mjhsieh@localhost)
	by helix.life.nthu.edu.tw (8.8.7/8.8.7) id WAA07710;
	Sun, 19 Jul 1998 22:18:58 +0800
Message-ID: <19980719221858.A7706@helix.life.nthu.edu.tw>
Date: Sun, 19 Jul 1998 22:18:58 +0800
From: "Francis M. J. Hsieh" <mjhsieh@helix.life.nthu.edu.tw>
To: linux@cthulhu.engr.sgi.com
Subject: Re: utmp.h
References: <19980719184144.26798@life.nthu.edu.tw> <19980719152050.B415@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19980719152050.B415@uni-koblenz.de>; from ralf@uni-koblenz.de on Sun, Jul 19, 1998 at 03:20:50PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jul 19, 1998 at 03:20:50PM +0200, ralf@uni-koblenz.de wrote:
> It's that way because changing the structure to what the other architectures
> are using would break the binary compatibility for not that much benefit.
> I did so because glibc has already been the only libc for MIPS when other
> architectures were still relying only on H.J. Lu's Linux Libc aka libc 5.
> 
> It's on the to do list for libc 7 and I think we've got still quite some
> time before we take that step.

hmmm... Okay, maybe i should change the source (seems to be a hard work)
to fit my need.

--
Francis
