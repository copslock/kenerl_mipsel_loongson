Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA53561 for <linux-archive@neteng.engr.sgi.com>; Wed, 1 Jul 1998 03:57:04 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA97489
	for linux-list;
	Wed, 1 Jul 1998 03:56:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA26510
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 1 Jul 1998 03:56:27 -0700 (PDT)
	mail_from (mjhsieh@sparc.life.nthu.edu.tw)
Received: from sparc.life.nthu.edu.tw (life.nthu.edu.tw [140.114.98.21]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA14996
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Jul 1998 03:56:26 -0700 (PDT)
	mail_from (mjhsieh@sparc.life.nthu.edu.tw)
Received: (from mjhsieh@localhost)
	by sparc.life.nthu.edu.tw (8.8.8/8.8.8) id SAA13758;
	Wed, 1 Jul 1998 18:54:20 +0800 (CST)
Message-ID: <19980701185419.41145@life.nthu.edu.tw>
Date: Wed, 1 Jul 1998 18:54:19 +0800
From: "Francis M.J. Hsieh" <mjhsieh@life.nthu.edu.tw>
To: linux@cthulhu.engr.sgi.com
Subject: Re: boot without irix?
References: <19980701134219.17360@life.nthu.edu.tw> <Pine.LNX.3.95.980701014723.5126G-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.79e
In-Reply-To: <Pine.LNX.3.95.980701014723.5126G-100000@lager.engsoc.carleton.ca>; from Alex deVries on Wed, Jul 01, 1998 at 01:48:17AM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jul 01, 1998 at 01:48:17AM -0400, Alex deVries wrote:
> On Wed, 1 Jul 1998, Francis M.J. Hsieh wrote:
> > Is there any way to boot linux without irix? I plan to boot from bootp
> > and set argument root=/dev/sda1, hope it works. :-)
> 
> In theory, that will work.  

Not so easy as I think, needed to change bootp setting.
If we didn't change bootp setting, it will boot to install mode.

(Finding what to change)
-- 
Francis M. J. Hsieh      | Email:   mjhsieh@life.nthu.edu.tw
Life Science Department, | Webpage: http://www.life.nthu.edu.tw/~mjhsieh/
National Tsing Hua Univ, | Voice:   +886 3 5715131 ext 3482
HsinChu, Taiwan Republic | 	    +886 3 5715649
