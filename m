Received:  by oss.sgi.com id <S305239AbQCaRE0>;
	Fri, 31 Mar 2000 09:04:26 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:62498 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305227AbQCaRDu>;
	Fri, 31 Mar 2000 09:03:50 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA16272; Fri, 31 Mar 2000 08:59:04 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA32485
	for linux-list;
	Fri, 31 Mar 2000 08:42:02 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA86822
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 31 Mar 2000 08:42:00 -0800 (PST)
	mail_from (C.Krapichler@rl.ac.uk)
Received: from nameserv.rl.ac.uk (nameserv.rl.ac.uk [130.246.135.129]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA02460
	for <linux@cthulhu.engr.sgi.com>; Fri, 31 Mar 2000 08:41:53 -0800 (PST)
	mail_from (C.Krapichler@rl.ac.uk)
Received: from rl.ac.uk (ilian.cis.rl.ac.uk [130.246.74.216])
	by nameserv.rl.ac.uk (8.8.8/8.8.8) with ESMTP id RAA13038;
	Fri, 31 Mar 2000 17:41:41 +0100
Message-ID: <38E4D553.23B2BF81@rl.ac.uk>
Date:   Fri, 31 Mar 2000 17:41:55 +0100
From:   Christian Krapichler <C.Krapichler@rl.ac.uk>
Organization: CLRC - Rutherford Appleton Laboratory
X-Mailer: Mozilla 4.51C-SGI [en] (X11; I; IRIX 6.5 IP32)
X-Accept-Language: en
MIME-Version: 1.0
To:     Andy Isaacson <adisaacs@mr-happy.com>
CC:     linux@cthulhu.engr.sgi.com
Subject: Re: Linux on SGI 540
References: <38E4B368.1A4704B2@rl.ac.uk> <20000331110852.A5489@mr-happy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Andy Isaacson wrote:

> On Fri, Mar 31, 2000 at 03:17:12PM +0100, Christian Krapichler wrote:
> > I tried to install Linux on our SGI 540, using the 28jul... kernel patch
> > from a SGI web page. It went well and boots until the point where I
> > should see the login screen - but all I get is a "noise" pattern. I am
> > quite new to Linux, but it sounds like the XF86Config is not right. Does
> > anyone have a XF86Config for a 21'' Monitor (GDM-5021-PT)? Any help and
> > suggestions welcome!
>
> Sounds like you've specified too much memory.  Try adding "mem=256M"
> to the "loader options" box in the ARC firmware.
>

yep, that works (had it set to 512M).

Thanks a lot!

Christian
