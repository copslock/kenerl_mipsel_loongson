Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA09859 for <linux-archive@neteng.engr.sgi.com>; Thu, 27 May 1999 11:55:02 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA19058
	for linux-list;
	Thu, 27 May 1999 11:53:46 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA63661
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 May 1999 11:53:44 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA08902
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 May 1999 11:53:41 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-18.uni-koblenz.de [141.26.131.18])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id UAA28064
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 May 1999 20:53:13 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id MAA03204;
	Thu, 27 May 1999 12:18:41 +0200
Date: Thu, 27 May 1999 12:18:40 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Robert Keller <rck@corp.home.net>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: after the kernel seems to live
Message-ID: <19990527121840.T866@uni-koblenz.de>
References: <4.1.19990526115716.03f65930@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <4.1.19990526115716.03f65930@mail>; from Robert Keller on Wed, May 26, 1999 at 12:05:33PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, May 26, 1999 at 12:05:33PM -0700, Robert Keller wrote:

> It looks like I've finally been able to get the 2.2.1 kernel booting
> and trying to access its root filesystem over NFS on an NEC
> DDB-VRC5074 development board.  I'm at the point where the
> kernel is trying to run /sbin/init and things die because of illegal
> instructions in init (I'm using the little endian mips root from
> linux.sgi.com)

What CPU is being used on that eval board?  If it's one that isn't yet
supported in our sources then I suspect you have a problem either with the
cacheflushing routines themselfes or the calls to them in the network
driver.  What NIC are you using, btw?  We've got patches around for a
couple of those which are most often being used with MIPS machines.

> Where do I get the code for init, ld.so and all those vital root 
> filesystem friends so that I can be sure that they are compiled
> the way I want them?

Unless you're using extremly old binaries I'm highly confident that the
binaries which you are using are ok.

  Ralf
