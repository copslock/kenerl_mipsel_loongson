Received:  by oss.sgi.com id <S305239AbQCaQRz>;
	Fri, 31 Mar 2000 08:17:55 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:23570 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305238AbQCaQRi>;
	Fri, 31 Mar 2000 08:17:38 -0800
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA09895; Fri, 31 Mar 2000 08:12:54 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id IAA79910; Fri, 31 Mar 2000 08:17:33 -0800 (PST)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA83565
	for linux-list;
	Fri, 31 Mar 2000 08:08:58 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA84817
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 31 Mar 2000 08:08:56 -0800 (PST)
	mail_from (adisaacs@mr-happy.com)
Received: from brainguy.tc.mtu.edu (brainguy.tc.mtu.edu [141.219.5.85]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA01471
	for <linux@cthulhu.engr.sgi.com>; Fri, 31 Mar 2000 08:08:55 -0800 (PST)
	mail_from (adisaacs@mr-happy.com)
Received: from crow.mr-happy.com (crow.mr-happy.com [172.19.3.81])
	by brainguy.tc.mtu.edu (Postfix) with ESMTP id 01478F3C5
	for <linux@cthulhu.engr.sgi.com>; Fri, 31 Mar 2000 11:08:53 -0500 (EST)
Received: by crow.mr-happy.com (Postfix, from userid 22448)
	id D8D9FDF30; Fri, 31 Mar 2000 11:08:52 -0500 (EST)
Date:   Fri, 31 Mar 2000 11:08:52 -0500
From:   Andy Isaacson <adisaacs@mr-happy.com>
To:     linux@cthulhu.engr.sgi.com
Subject: Re: Linux on SGI 540
Message-ID: <20000331110852.A5489@mr-happy.com>
References: <38E4B368.1A4704B2@rl.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38E4B368.1A4704B2@rl.ac.uk>; from C.Krapichler@rl.ac.uk on Fri, Mar 31, 2000 at 03:17:12PM +0100
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.mr-happy.com/~adisaacs/pgp.txt
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Mar 31, 2000 at 03:17:12PM +0100, Christian Krapichler wrote:
> I tried to install Linux on our SGI 540, using the 28jul... kernel patch
> from a SGI web page. It went well and boots until the point where I
> should see the login screen - but all I get is a "noise" pattern. I am
> quite new to Linux, but it sounds like the XF86Config is not right. Does
> anyone have a XF86Config for a 21'' Monitor (GDM-5021-PT)? Any help and
> suggestions welcome!

Sounds like you've specified too much memory.  Try adding "mem=256M"
to the "loader options" box in the ARC firmware.

You might find some help on my VisWS web pages:
http://www.lcse.umn.edu/~adi/visws/

-andy
-- 
Andy Isaacson  http://web.mr-happy.com/~adisaacs/   Fight Spam, join CAUCE:
adi@acm.org adisaacs@mr-happy.com isaacson@cs.umn.edu   www.cauce.org
