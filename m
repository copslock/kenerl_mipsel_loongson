Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Dec 2004 13:03:16 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:20242 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225210AbULJNDL>; Fri, 10 Dec 2004 13:03:11 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E3090F5944; Fri, 10 Dec 2004 14:03:02 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30765-07; Fri, 10 Dec 2004 14:03:02 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id F3281E1CC6; Fri, 10 Dec 2004 14:03:01 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id iBAD32lI028340;
	Fri, 10 Dec 2004 14:03:05 +0100
Date: Fri, 10 Dec 2004 13:02:55 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Thomas Petazzoni <thomas.petazzoni@enix.org>
Cc: Matthew Starzewski <mstarzewski@xes-inc.com>,
	linux-mips@linux-mips.org, Steve.Finney@SpirentCom.COM
Subject: Re: Using more than 256 MB of memory on SB1250 in 32-bit mode,
 revisited
In-Reply-To: <41B96281.2050806@enix.org>
Message-ID: <Pine.LNX.4.58L.0412101250160.15484@blysk.ds.pg.gda.pl>
References: <062301c4de41$5bf43cb0$0d00340a@matts> <41B96281.2050806@enix.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/617/Sun Dec  5 16:25:39 2004
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 10 Dec 2004, Thomas Petazzoni wrote:

> I'm still very surprised that Linux cannot handle strange physical 
> memory configuration simply (holes in physical memory, DMA memory at 
> higher addresses than normal memory).

 That's i386 legacy, later supported by other platforms using a similar
memory model -- starting at 0, mostly contiguous and only two DMA zones
for ISA and 32-bit PCI respectively, both starting at 0.  Remember, most
people working on Linux only have an i386 PC.  If you have something very
different, you need to write code to support it yourself.  If you do it
well enough, it'll be gladly accepted.

  Maciej
