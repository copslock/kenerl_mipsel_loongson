Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Sep 2002 22:04:37 +0200 (CEST)
Received: from jeeves.momenco.com ([64.169.228.99]:12810 "EHLO
	host099.momenco.com") by linux-mips.org with ESMTP
	id <S1122958AbSIFUEg>; Fri, 6 Sep 2002 22:04:36 +0200
Received: from beagle (natbox.momenco.com [64.169.228.98])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g86K4S617264
	for <linux-mips@linux-mips.org>; Fri, 6 Sep 2002 13:04:28 -0700
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@linux-mips.org>
Subject: LOADADDR and low physical addresses?
Date: Fri, 6 Sep 2002 13:04:28 -0700
Message-ID: <NEBBLJGMNKKEEMNLHGAIAENHCIAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Return-Path: <mdharm@momenco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 137
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mdharm@momenco.com
Precedence: bulk
X-list: linux-mips

So, I've got an interesting problem... which has forced me to look at
the use of the LOADADDR variable in the Makefile, and try (quickly) to
brush up on my linker scripting...

Basically I've got a processor with on-chip registers that need to be
located in the first 512MByte of _physical_ address.  To make things
difficult, they cannot be re-located once placed (configuration is
done by a hardware config stream at reset).  It's only 16KBytes of
address, but since I recall that linux on mips can't (well, probably
can't) handle discontiguous memory maps (we discussed this about a
year ago, I think), I was looking for a good place to put them.

Now, I think my problems are solved if the LOADADDR variable works the
way I think it does -- that the kernel loads at that address, and only
uses memory from that point upwards.  So, if my LOADADDR is
0x80100000, then the first 0x100000 won't get used.  Of course, the
exception vectors are there, but that doesn't take up that much space.
So there should be a chunk of address space I can use for other
things, like this register bank.

Yes? No?  Is my understanding even close?

Matt

P.S. Of course, if this is right, then I need to figure out the
proper/best way to use the add_memory_region() function....

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com
