Received:  by oss.sgi.com id <S305174AbQCAPrk>;
	Wed, 1 Mar 2000 07:47:40 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:58745 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbQCAPrU>; Wed, 1 Mar 2000 07:47:20 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id HAA07599; Wed, 1 Mar 2000 07:50:28 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA07281
	for linux-list;
	Wed, 1 Mar 2000 07:39:31 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA12934
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 1 Mar 2000 07:39:28 -0800 (PST)
	mail_from (adisaacs@mr-happy.com)
Received: from brainguy.tc.mtu.edu (brainguy.tc.mtu.edu [141.219.5.85]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA08597
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Mar 2000 07:39:23 -0800 (PST)
	mail_from (adisaacs@mr-happy.com)
Received: from crow.mr-happy.com (crow.mr-happy.com [172.19.3.81])
	by brainguy.tc.mtu.edu (8.8.8/8.8.7/mtumailer-1.2) with ESMTP id KAA13009
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Mar 2000 10:39:16 -0500 (EST)
Received: (from adisaacs@localhost)
	by crow.mr-happy.com (8.9.1b+Sun/HappyClient) id KAA12993
	for linux@cthulhu.engr.sgi.com; Wed, 1 Mar 2000 10:39:16 -0500 (EST)
Date:   Wed, 1 Mar 2000 10:39:16 -0500
From:   Andy Isaacson <adisaacs@mr-happy.com>
To:     linux@cthulhu.engr.sgi.com
Subject: Re: 2.3.47 success on Decstation 5000/150, problems with login
Message-ID: <20000301103916.B12964@mr-happy.com>
References: <20000301115053.A4608@paradigm.rfc822.org> <Pine.GSO.4.10.10003011222500.13477-100000@dandelion.sonytel.be> <20000301122329.B4608@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000301122329.B4608@paradigm.rfc822.org>; from flo@rfc822.org on Wed, Mar 01, 2000 at 12:23:29PM +0100
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.mr-happy.com/~adisaacs/pgp.txt
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Mar 01, 2000 at 12:23:29PM +0100, Florian Lohoff wrote:
> ping: Requesting shell.
> ping: Entering interactive session.
> Connection to repeat.rfc822.org closed by remote host.

Ooh ooh, I think I know this one.  Check that your tty baud rate on
the originating host is not set to 0.  ('stty 9600').  Otherwise maybe 
some other tty setting?

-andy
-- 
Andy Isaacson  http://web.mr-happy.com/~adisaacs/   Fight Spam, join CAUCE:
adi@acm.org adisaacs@mr-happy.com isaacson@cs.umn.edu   www.cauce.org
