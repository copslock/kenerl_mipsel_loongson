Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA57053 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Feb 1999 16:09:09 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA53280
	for linux-list;
	Tue, 16 Feb 1999 16:07:46 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA50895
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 Feb 1999 16:07:44 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA00868
	for <linux@cthulhu.engr.sgi.com>; Tue, 16 Feb 1999 16:07:41 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-14.uni-koblenz.de [141.26.131.14])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA14816
	for <linux@cthulhu.engr.sgi.com>; Wed, 17 Feb 1999 01:07:35 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id AAA25368;
	Wed, 17 Feb 1999 00:40:09 +0100
Message-ID: <19990217004009.O644@uni-koblenz.de>
Date: Wed, 17 Feb 1999 00:40:09 +0100
From: ralf@uni-koblenz.de
To: mkomiya@crossnet.co.jp, linux@cthulhu.engr.sgi.com
Subject: Re: cross-compile glibc2
References: <199902151615.BAA06063@cirrus.crossnet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <199902151615.BAA06063@cirrus.crossnet.co.jp>; from mkomiya@crossnet.co.jp on Tue, Feb 16, 1999 at 01:15:13AM +0900
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Feb 16, 1999 at 01:15:13AM +0900, mkomiya@crossnet.co.jp wrote:

> I'm trying to compile glibc2.0.6 from SGI's ftp site
> with egcs-1.0.2 as cross-compiler on Linux/Intel.
> 
> But I got following error messages on making shared lib stage.
> 
> Does any one suggest to me ?

The ld core dump bug in binutils 2.8.1 has been fixed in newer releases
of which we didn't yet publish crosscompiler binaries, mostly because those
of use who use crosscompilers only use it to build the kernel and kernel
build aren't affected.  Whatever, the solution is to rip the patches from
a current binutils-2.8.1 srpm package from linus.linux.sgi.com somewhere
in /pub/linux/redhat/5.2/ and use them for rebuilding the cross-binutils.

  Ralf
