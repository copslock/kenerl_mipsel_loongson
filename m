Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA09272 for <linux-archive@neteng.engr.sgi.com>; Sun, 4 Oct 1998 14:09:13 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA90596
	for linux-list;
	Sun, 4 Oct 1998 14:08:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA05942
	for <linux@engr.sgi.com>;
	Sun, 4 Oct 1998 14:08:17 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA07116
	for <linux@engr.sgi.com>; Sun, 4 Oct 1998 14:08:08 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from uni-koblenz.de (pmport-18.uni-koblenz.de [141.26.249.18])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA28088
	for <linux@engr.sgi.com>; Sun, 4 Oct 1998 23:08:03 +0200 (MET DST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id DAA01382;
	Sun, 4 Oct 1998 03:32:05 +0200
Message-ID: <19981004033205.E413@uni-koblenz.de>
Date: Sun, 4 Oct 1998 03:32:05 +0200
From: ralf@uni-koblenz.de
To: Jakub Jelinek <jj@sunsite.ms.mff.cuni.cz>, ANeuper@guug.de
Cc: aeb@cwi.nl, LeBlanc@mcc.ac.uk, fasten@informatik.uni-bonn.de,
        shaver@netscape.com, linux@cthulhu.engr.sgi.com
Subject: Re: SGI partitions / fdisk
References: <3616201D.FF28E181@antaris.de> <199810031957.VAA00861@sunsite.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <199810031957.VAA00861@sunsite.ms.mff.cuni.cz>; from Jakub Jelinek on Sat, Oct 03, 1998 at 09:57:47PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Oct 03, 1998 at 09:57:47PM +0200, Jakub Jelinek wrote:

I've got some more fdisk patches around which make fdisk work correctly
with PC style partitions on big endian machines.  So I can now partition
all auxilary disks on my Indy and move them with my PC and Indy/Linux.

  Ralf
