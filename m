Received:  by oss.sgi.com id <S305188AbQAFCbE>;
	Wed, 5 Jan 2000 18:31:04 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:62308 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305186AbQAFCaq>;
	Wed, 5 Jan 2000 18:30:46 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id SAA19580; Wed, 5 Jan 2000 18:27:12 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA69874
	for linux-list;
	Wed, 5 Jan 2000 18:24:26 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA76476
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 5 Jan 2000 18:24:22 -0800 (PST)
	mail_from (adisaacs@mr-happy.com)
Received: from brainguy.tc.mtu.edu (brainguy.tc.mtu.edu [141.219.5.85]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA09240
	for <linux@cthulhu.engr.sgi.com>; Wed, 5 Jan 2000 18:24:20 -0800 (PST)
	mail_from (adisaacs@mr-happy.com)
Received: from crow.mr-happy.com (crow.mr-happy.com [172.19.3.81])
	by brainguy.tc.mtu.edu (8.8.8/8.8.7/mtumailer-1.2) with ESMTP id VAA00631
	for <linux@cthulhu.engr.sgi.com>; Wed, 5 Jan 2000 21:24:18 -0500 (EST)
Received: (from adisaacs@localhost)
	by crow.mr-happy.com (8.9.1b+Sun/HappyClient) id VAA16932
	for linux@cthulhu.engr.sgi.com; Wed, 5 Jan 2000 21:24:18 -0500 (EST)
Date:   Wed, 5 Jan 2000 21:24:18 -0500
From:   Andy Isaacson <adisaacs@mr-happy.com>
To:     linux@cthulhu.engr.sgi.com
Subject: Re: XFree86-FBDev and /dev/fb0
Message-ID: <20000105212418.A16875@mr-happy.com>
References: <20000105201719.A16821@mr-happy.com> <Pine.LNX.4.10.10001051724470.1491-100000@calypso.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10001051724470.1491-100000@calypso.engr.sgi.com>
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.mr-happy.com/~adisaacs/pgp.txt
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Jan 05, 2000 at 05:27:33PM -0800, Ulf Carlsson wrote:
> > XFree86 has builtin support for this mode of operation in the latest
> > development snapshot (3.9.17).  They call it ShadowFB.  Of course that
> > would only work in X, not on console.  Apparently it's fairly easy to
> > write a driver that supports ShadowFB; all you have to be able to do
> > is update a rectangular area of the screen on demand.
> 
> Yeah, and that's what I tried to get working but I ran into other problems with
> the dynamic loading of X modules and stuff so I never got the chance to
> concentrate on the driver.  I have the early stages of a driver around though.

You're probably the first person to try the XFree86 loader code on
MIPS so it's not suprising you had trouble.  Try putting
"#define DoLoadableServer NO" in xc/config/cf/host.def; that way it'll
not try to use the loader at all.

-andy
-- 
Andy Isaacson  http://web.mr-happy.com/~adisaacs/   Fight Spam, join CAUCE:
adi@acm.org adisaacs@mr-happy.com isaacson@cs.umn.edu   www.cauce.org
