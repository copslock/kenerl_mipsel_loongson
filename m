Received:  by oss.sgi.com id <S305179AbQADB4p>;
	Mon, 3 Jan 2000 17:56:45 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:11794 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305166AbQADB4b>;
	Mon, 3 Jan 2000 17:56:31 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA04921; Mon, 3 Jan 2000 17:57:08 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA23299
	for linux-list;
	Mon, 3 Jan 2000 17:44:31 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA50701
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 3 Jan 2000 17:44:28 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA00264
	for <linux@cthulhu.engr.sgi.com>; Mon, 3 Jan 2000 17:44:26 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-28.uni-koblenz.de (cacc-28.uni-koblenz.de [141.26.131.28])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA22776;
	Tue, 4 Jan 2000 02:44:21 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQADBnx>;
	Tue, 4 Jan 2000 02:43:53 +0100
Date:   Tue, 4 Jan 2000 02:43:53 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jeff Harrell <jharrell@ti.com>
Cc:     linux@cthulhu.engr.sgi.com, bbrown@ti.com
Subject: Re: C/Assembler listing files
Message-ID: <20000104024353.B6063@uni-koblenz.de>
References: <38712453.B0BCE0CD@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <38712453.B0BCE0CD@ti.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Jan 03, 2000 at 03:36:03PM -0700, Jeff Harrell wrote:

> Has anyone tried to generate an interleaved C and Assembler listing file
> with the MIPS cross compilation tools?  I tried to pass the following flags
> to gcc
> (and the assembler):

I just tried this on my current version of the x-tools and it seemed
to work.  There is a number of other problems, mostly that 32-bit
static linking of PIC code is broken and then infinite 64-bit problems
which prevent me from making a real release and declaring them to be
``the'' official versions.  If that doesn't bother you, go ahead and
get the stuff from oss.sgi.com:/pub/linux/mips/crossdev/testing/.

  Ralf
