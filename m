Received:  by oss.sgi.com id <S305173AbQA2DDC>;
	Fri, 28 Jan 2000 19:03:02 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:48242 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305169AbQA2DCo>;
	Fri, 28 Jan 2000 19:02:44 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id TAA28861; Fri, 28 Jan 2000 19:00:59 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA52019
	for linux-list;
	Fri, 28 Jan 2000 18:53:11 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA51965
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Jan 2000 18:53:08 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA04410
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Jan 2000 18:53:07 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-27.uni-koblenz.de (cacc-27.uni-koblenz.de [141.26.131.27])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id DAA05080;
	Sat, 29 Jan 2000 03:53:04 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407891AbQA2Cwd>;
	Sat, 29 Jan 2000 03:52:33 +0100
Date:   Sat, 29 Jan 2000 03:52:33 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jeff Harrell <jharrell@ti.com>
Cc:     sgi-mips <linux@cthulhu.engr.sgi.com>
Subject: Re: Question concerning memory configuration
Message-ID: <20000129035233.F13659@uni-koblenz.de>
References: <389218F6.7CAD27A5@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <389218F6.7CAD27A5@ti.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Fri, Jan 28, 2000 at 03:32:22PM -0700, Jeff Harrell wrote:

> I have question concerning the memory configuration variables in the
> MIPS/Linux codebase.  I am working on a board that has 64Mbytes
> (0x400 0000) of SDRAM.  We are using an R4000 core and have the memory
> map setup so that KSEG0 & KSEG1 both map to address 0x0 in physical
> memory.  On our embedded system we are going to hard code the variable
> mips_memory_upper (This eventually is stored in memory_end).  My
> question is what I should initialize the value to?  Do I treat the top
> of memory as KSEG1 + 64Mbytes? (i.e., 0xA400 0000) or do I initialize it
> realative to 0?  If anybody has any insights in this area, any
> information would be greatly appreciated.

I killed mips_memory_upper in 2.3.27.  Now the kernel uses the same
bootmem functions as the other machines to implement that functionality.
I suggest you take a look at arch/mips64/sgi-ip27/ip27-memory.c for
a simple example how to use this interface.

  Ralf
