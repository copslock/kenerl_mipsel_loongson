Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA81850 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Jun 1998 03:48:49 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA82915
	for linux-list;
	Fri, 26 Jun 1998 03:48:11 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA79028
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 26 Jun 1998 03:48:08 -0700 (PDT)
	mail_from (mjhsieh@sparc.life.nthu.edu.tw)
Received: from sparc.life.nthu.edu.tw (life.nthu.edu.tw [140.114.98.21]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id DAA27165
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Jun 1998 03:48:06 -0700 (PDT)
	mail_from (mjhsieh@sparc.life.nthu.edu.tw)
Received: (from mjhsieh@localhost)
	by sparc.life.nthu.edu.tw (8.8.8/8.8.8) id SAA08405;
	Fri, 26 Jun 1998 18:46:03 +0800 (CST)
Message-ID: <19980626184602.13818@life.nthu.edu.tw>
Date: Fri, 26 Jun 1998 18:46:02 +0800
From: "Francis M.J. Hsieh" <mjhsieh@life.nthu.edu.tw>
To: ralf@uni-koblenz.de, linux@cthulhu.engr.sgi.com
Subject: Re: ssh binaries
References: <19980614192346.B7551@uni-koblenz.de> <19980627015217.A454@helix.life.nthu.edu.tw> <19980626123507.B570@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.79e
In-Reply-To: <19980626123507.B570@uni-koblenz.de>; from ralf@uni-koblenz.de on Fri, Jun 26, 1998 at 12:35:07PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jun 26, 1998 at 12:35:07PM +0200, ralf@uni-koblenz.de wrote:
> On Sat, Jun 27, 1998 at 01:52:17AM +0800, Francis M. J. Hsieh wrote:
> >   I am sorry if it was discussed before. I can't install the client
> > and server, rpm told me "libz.so.1" needed even if I downloaded the
> > actual file libz.so.1 from ftp.linux.sgi.com.
> > How can I fix it up? Thanx for your help.
> 
> Just dowloading the libz.so.1 file won't do the job, you should get the
> zlib package and install it, it's apparently missing from your system.

I actually installed zlib before, so, I solve it by force it install. :-)
rpm -i --nodeps .....

:-) happy linuxing!
-- 
Francis M. J. Hsieh      | Email:   mjhsieh@life.nthu.edu.tw
Life Science Department, | Webpage: http://www.life.nthu.edu.tw/~mjhsieh/
National Tsing Hua Univ, | Voice:   +886 3 5715131 ext 3482
HsinChu, Taiwan Republic | 	    +886 3 5715649
