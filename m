Received:  by oss.sgi.com id <S305156AbQAQEcy>;
	Sun, 16 Jan 2000 20:32:54 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:21550 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305155AbQAQEc2>;
	Sun, 16 Jan 2000 20:32:28 -0800
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id UAA26915; Sun, 16 Jan 2000 20:29:46 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA79940
	for linux-list;
	Sun, 16 Jan 2000 20:14:47 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA56649
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 16 Jan 2000 20:14:41 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA05041
	for <linux@cthulhu.engr.sgi.com>; Sun, 16 Jan 2000 20:14:38 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-25.uni-koblenz.de (cacc-25.uni-koblenz.de [141.26.131.25])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id FAA06745;
	Mon, 17 Jan 2000 05:14:34 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQAQEGC>;
	Mon, 17 Jan 2000 05:06:02 +0100
Date:   Mon, 17 Jan 2000 05:06:02 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jeff Harrell <jharrell@ti.com>
Cc:     Conrad Parker <conradp@cse.unsw.edu.au>, linux@cthulhu.engr.sgi.com
Subject: Re: question concerning serial console setup
Message-ID: <20000117050602.C16920@uni-koblenz.de>
References: <386A5F9B.50B4AFEF@ti.com> <19991230114736.C18261@cse.unsw.edu.au> <38828F72.F0FA585@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <38828F72.F0FA585@ti.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sun, Jan 16, 2000 at 08:41:38PM -0700, Jeff Harrell wrote:

> Unfortunately I am working on an embedded platform, only using this code
> as a starting point for our design.  If possible I would like to initialize
> the console w/o the use of command line parameters.

A simple solution is to hardwire the commmand line in arch/mips/kernel/setup.c.

  Ralf
