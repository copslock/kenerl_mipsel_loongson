Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA48244 for <linux-archive@neteng.engr.sgi.com>; Wed, 2 Jun 1999 21:25:00 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA30843
	for linux-list;
	Wed, 2 Jun 1999 21:23:20 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA77836
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 2 Jun 1999 21:23:17 -0700 (PDT)
	mail_from (adisaacs@mr-happy.com)
Received: from brainguy.tc.mtu.edu (brainguy.tc.mtu.edu [141.219.5.85]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA09324
	for <linux@cthulhu.engr.sgi.com>; Wed, 2 Jun 1999 21:23:16 -0700 (PDT)
	mail_from (adisaacs@mr-happy.com)
Received: from crow.mr-happy.com (crow.mr-happy.com [172.19.3.81])
	by brainguy.tc.mtu.edu (8.8.7/8.8.7/mtumailer-1.2) with ESMTP id AAA25438;
	Thu, 3 Jun 1999 00:23:10 -0400 (EDT)
Received: (from adisaacs@localhost)
	by crow.mr-happy.com (8.9.1b+Sun/HappyClient) id AAA11312;
	Thu, 3 Jun 1999 00:23:10 -0400 (EDT)
Message-ID: <19990603002310.A11295@mr-happy.com>
Date: Thu, 3 Jun 1999 00:23:10 -0400
From: Andy Isaacson <adisaacs@mr-happy.com>
To: linux@cthulhu.engr.sgi.com
Subject: Re: Linux process scheduler
References: <4B9D2663B893D211B7DC0004ACE83FB80B06@abq-amsa003e--n.albuquerque.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B9D2663B893D211B7DC0004ACE83FB80B06@abq-amsa003e--n.albuquerque.sgi.com>; from Wayne Vieira on Wed, Jun 02, 1999 at 04:15:43PM -0600
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.mr-happy.com/~adisaacs/pgp.txt
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Jun 02, 1999, on the sgi-linux mailing list, Wayne Vieira wrote:
> 
> Are there any other schedulers (fairshare, gang, etc.) available for
> linux, other than the standard sched.c that comes with the kernel?  IHAC
> who is asking about the availability of Fairshare.  If its not
> available, what is?

There's not much out there as far as production-level stuff.  There's
a fair number of research-type projects out there.  For a class, I and
another student did the work available at
http://pirx.candyland.cx/~adisaacs/cs520/lottery.patch.txt

It's not actually usable in a production context (I don't use it, for
example) but it's a reasonable proof of concept.  I'd be glad to
answer any questions... I might even be able to dig up some of our
documentation if there's demand.

(BTW, I just started at SGI Eagan this week.)

-andy
-- 
Andy Isaacson adi@acm.org adisaacs@mr-happy.com  Fight Spam, join CAUCE:
http://web.mr-happy.com/~adisaacs/               http://www.cauce.org/
