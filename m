Received:  by oss.sgi.com id <S305192AbQBEHBW>;
	Fri, 4 Feb 2000 23:01:22 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:58470 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305191AbQBEHBK>;
	Fri, 4 Feb 2000 23:01:10 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA28262; Thu, 3 Feb 2000 14:51:39 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA85876
	for linux-list;
	Thu, 3 Feb 2000 14:42:34 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA28191
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 3 Feb 2000 14:42:31 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA03248
	for <linux@cthulhu.engr.sgi.com>; Thu, 3 Feb 2000 14:42:30 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-20.uni-koblenz.de (cacc-20.uni-koblenz.de [141.26.131.20])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id XAA08463;
	Thu, 3 Feb 2000 23:42:23 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407893AbQBCWVC>;
	Thu, 3 Feb 2000 23:21:02 +0100
Date:   Thu, 3 Feb 2000 23:21:02 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Richard Dubrawsk <dubrawsk@nyquist.ece.uiuc.edu>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Howto compile kernel on indy
Message-ID: <20000203232102.D2999@uni-koblenz.de>
References: <Pine.LNX.3.96.1000202224621.26215A-100000@nyquist.ece.uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.LNX.3.96.1000202224621.26215A-100000@nyquist.ece.uiuc.edu>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Feb 02, 2000 at 10:52:30PM -0600, Richard Dubrawsk wrote:

> I have tried repeatedly to compile both the 2.1.100 and 2.2.1 kernel trees
> on an Indy with the hardhat installation.  I had to manually remove the
> ${CROSS_COMPILE} directives in the Makefile on the 2.2.1 tree since it was
> defaulting to cross compiling otherwise.  My questions are:

Cross compilation is a configuration option near the end of the
configuration dialog.  So no hacking of makefiles required.

> 1. Is it possible to natively compile a kernel on an indy running linux,
> or must it be cross compiled on another machine?

It is possible, however most of us Indy hackers consider it inconvenient
to reboot the machine on which we're doing the development.  This is the
core reason why I almost never do native kernel builds.

> 2. What ever happenned to rdev.  According to the linux-utils package it
> should have been installed in /usr/sbin, and it is noticably missing?

Rdev is only required on i386.  On the Indy use command line arguments at
the firmware like ``vmlinux root=/dev/sdc1''.

> 3. Where can I find updated ports of the basic tools like compiler and
> libraries?  

Updates versions are on oss.sgi.com.

  Ralf
