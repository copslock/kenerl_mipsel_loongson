Received:  by oss.sgi.com id <S305170AbQA1A15>;
	Thu, 27 Jan 2000 16:27:57 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:30793 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305158AbQA1A1a>; Thu, 27 Jan 2000 16:27:30 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id QAA09855; Thu, 27 Jan 2000 16:32:37 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA18516
	for linux-list;
	Thu, 27 Jan 2000 16:19:41 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA93827
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 27 Jan 2000 16:19:37 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA00153
	for <linux@cthulhu.engr.sgi.com>; Thu, 27 Jan 2000 16:19:33 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-7.uni-koblenz.de (cacc-7.uni-koblenz.de [141.26.131.7])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA01736;
	Fri, 28 Jan 2000 01:19:21 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQA1ADB>;
	Fri, 28 Jan 2000 01:03:01 +0100
Date:   Fri, 28 Jan 2000 01:03:01 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Charles Lepple <clepple@negativezero.org>
Cc:     Harald Koerfgen <Harald.Koerfgen@home.ivm.de>,
        Victor Wells <vwells@ti.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr
Subject: Re: Embedded system with RAM Disk
Message-ID: <20000128010301.B11868@uni-koblenz.de>
References: <XFMail.000126201529.Harald.Koerfgen@home.ivm.de> <388F9ECA.DBFCED9D@negativezero.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <388F9ECA.DBFCED9D@negativezero.org>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Wed, Jan 26, 2000 at 08:26:34PM -0500, Charles Lepple wrote:

> The PPC board that I used would not load ELF images with extra sections,
> so I resurrected some code that would convert the ramdisk (and gzipped
> vmlinux, actually -- I'm not sure if the MIPS code does anything like
> this) into assembly 'define word' statements, assemble the resulting
> file, and link it in. The file had symbols for initrd_start & _length,
> and the assembly was surprisingly quick. The ramdisk, in effect, became
> part of the data section of the kernel image (zImage, actually).

In which case the PPC's ELF loader is hopless broken.  An ELF loader is
a quite simple thing, it only needs to process all the PT_LOAD entries
in the programm header table, done.

  Ralf

PS: negativezero.org - I thought one's complement machines are dead
    by now ;-)
