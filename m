Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA24308 for <linux-archive@neteng.engr.sgi.com>; Sun, 14 Feb 1999 04:57:28 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA35853
	for linux-list;
	Sun, 14 Feb 1999 04:56:42 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA36803
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 14 Feb 1999 04:56:40 -0800 (PST)
	mail_from (nachtfalke@usa.net)
Received: from mail.urz.uni-wuppertal.de (mail.urz.uni-wuppertal.de [132.195.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA00466
	for <linux@cthulhu.engr.sgi.com>; Sun, 14 Feb 1999 04:56:39 -0800 (PST)
	mail_from (nachtfalke@usa.net)
Received: from ganymede.priv (root@isdn89.dialin.uni-wuppertal.de [132.195.23.89])
	by mail.urz.uni-wuppertal.de (8.9.1a/8.9.1) with ESMTP id NAA31155083
	for <linux@cthulhu.engr.sgi.com>; Sun, 14 Feb 1999 13:56:17 +0100 (MET)
Received: (from nachtfalke@localhost)
	by ganymede.priv (8.8.8/8.8.8) id NAA03619
	for linux@cthulhu.engr.sgi.com; Sun, 14 Feb 1999 13:25:59 +0100
From: Alexander Graefe <nachtfalke@usa.net>
Date: Sun, 14 Feb 1999 13:25:59 +0100
To: linux@cthulhu.engr.sgi.com
Subject: NFS-Boot Strangeness
Message-ID: <19990214132559.A3614@ganymede>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95i
X-Goddess: Willow
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi.

I think my Indy hates me :)
I now got as far as the Indy mounting / via NFS, but it stops with
"Freeing unused kernel memory"...
And then nothing more happens. No net traffic (checked with karpski),
and pings don't get returned.
Could it be that the NFS-server is too slow ? It's a 486/66 with 20 MB
RAM and a SMC Ultra 10 Mb/s ethernet card.

Bye,
	Lex, slowly getting there :)
-- 
Quidquid latine dictum sit, altum viditur.

Member #575 in the Order of Hannigan
