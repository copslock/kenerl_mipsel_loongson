Received:  by oss.sgi.com id <S305187AbQAEQ7Q>;
	Wed, 5 Jan 2000 08:59:16 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:45637 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305166AbQAEQ7M>; Wed, 5 Jan 2000 08:59:12 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id JAA02758; Wed, 5 Jan 2000 09:02:06 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA96980
	for linux-list;
	Wed, 5 Jan 2000 08:49:36 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA56884
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 5 Jan 2000 08:49:32 -0800 (PST)
	mail_from (adisaacs@mr-happy.com)
Received: from brainguy.tc.mtu.edu (brainguy.tc.mtu.edu [141.219.5.85]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA09224
	for <linux@cthulhu.engr.sgi.com>; Wed, 5 Jan 2000 08:49:25 -0800 (PST)
	mail_from (adisaacs@mr-happy.com)
Received: from crow.mr-happy.com (crow.mr-happy.com [172.19.3.81])
	by brainguy.tc.mtu.edu (8.8.8/8.8.7/mtumailer-1.2) with ESMTP id LAA29439
	for <linux@cthulhu.engr.sgi.com>; Wed, 5 Jan 2000 11:49:23 -0500 (EST)
Received: (from adisaacs@localhost)
	by crow.mr-happy.com (8.9.1b+Sun/HappyClient) id LAA24676
	for linux@cthulhu.engr.sgi.com; Wed, 5 Jan 2000 11:49:22 -0500 (EST)
Date:   Wed, 5 Jan 2000 11:49:22 -0500
From:   Andy Isaacson <adisaacs@mr-happy.com>
To:     linux@cthulhu.engr.sgi.com
Subject: Re: XFree86-FBDev and /dev/fb0
Message-ID: <20000105114922.B20983@mr-happy.com>
References: <38726C8D.D912DF94@detroit.sgi.com> <00010516082202.01432@pingu.kastner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00010516082202.01432@pingu.kastner.net>
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.mr-happy.com/~adisaacs/pgp.txt
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Jan 05, 2000 at 04:06:24PM +0100, Jiri Kastner jr. wrote:
> Dne Ut, 04 jan 2000 jste napsal(a):
>  
> > You have to enable it in your kernel. 
> 
> I have kernel with framebuffer (when I boot, I see linux-sgi.logo - 2.2.1)
> 
> I have no /dev/fb0.

You probably need to create the device node, then.  Look at the man
page for mknod, and Documentation/devices.txt in your kernel source
tree, for further info.

-andy
-- 
Andy Isaacson  http://web.mr-happy.com/~adisaacs/   Fight Spam, join CAUCE:
adi@acm.org adisaacs@mr-happy.com isaacson@cs.umn.edu   www.cauce.org
