Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA2948087 for <linux-archive@neteng.engr.sgi.com>; Sat, 4 Apr 1998 02:42:16 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id CAA7701830
	for linux-list;
	Sat, 4 Apr 1998 02:41:10 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA7762686;
	Sat, 4 Apr 1998 02:41:08 -0800 (PST)
Received: from lorraine.loria.fr (lorraine.loria.fr [152.81.1.17]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id CAA20886; Sat, 4 Apr 1998 02:41:06 -0800 (PST)
	mail_from (Olivier.Galibert@loria.fr)
Received: from renaissance.loria.fr (renaissance.loria.fr [152.81.4.102])
	by lorraine.loria.fr (8.8.7/8.8.7/8.8.7/JCG) with ESMTP id MAA10078;
	Sat, 4 Apr 1998 12:40:38 +0200 (MET DST)
Received: (from galibert@localhost) by renaissance.loria.fr (8.8.2/8.8.2) id MAA27487; Sat, 4 Apr 1998 12:40:37 +0200 (MET DST)
Message-ID: <19980404124037.00257@loria.fr>
Date: Sat, 4 Apr 1998 12:40:37 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-mips@cthulhu.engr.sgi.com, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr
Subject: Re: EGCS on MIPS
Mail-Followup-To: linux-mips@fnet.fr
References: <19980404120554.31953@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88.14i
In-Reply-To: <19980404120554.31953@uni-koblenz.de>; from ralf@uni-koblenz.de on Sat, Apr 04, 1998 at 12:05:54PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Apr 04, 1998 at 12:05:54PM +0200, ralf@uni-koblenz.de wrote:
> people keep asking me about egcs / gcc 2.8.x for Linux/MIPS.  Before I
> even attempt to work on that I'd like to know if anybody has attempted
> to use one of these compilers on IRIX or another MIPS operating system.
> Experiences, especially reliability?  As I understand the problems people
> have with these compilers on their Linux/i386 machines are only mostly
> caused by the Intel backend?

I use it everyday. I  only have problems when  trying to compile  with
-g. The compilers  segfaults  from time  to time. Apart  from that, it
works nicely.

A bad point for linux/mips is that the generated code is n32/64.

  OG.
