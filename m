Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 May 2004 15:24:55 +0100 (BST)
Received: from c2ce9fba.adsl.oleane.fr ([IPv6:::ffff:194.206.159.186]:13976
	"EHLO avalon.france.sdesigns.com") by linux-mips.org with ESMTP
	id <S8225576AbUEJOYy>; Mon, 10 May 2004 15:24:54 +0100
Received: from avalon.france.sdesigns.com (localhost.localdomain [127.0.0.1])
	by avalon.france.sdesigns.com (8.12.8/8.12.8) with ESMTP id i4AEOq1q009711
	for <linux-mips@linux-mips.org>; Mon, 10 May 2004 16:24:52 +0200
Received: (from michon@localhost)
	by avalon.france.sdesigns.com (8.12.8/8.12.8/Submit) id i4AEOpDo009709
	for linux-mips@linux-mips.org; Mon, 10 May 2004 16:24:51 +0200
X-Authentication-Warning: avalon.france.sdesigns.com: michon set sender to em@realmagic.fr using -f
Subject: new platform
From: Emmanuel Michon <em@realmagic.fr>
To: linux-mips@linux-mips.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: REALmagic France SAS
Message-Id: <1084199090.12536.1314.camel@avalon.france.sdesigns.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 10 May 2004 16:24:51 +0200
Return-Path: <em@realmagic.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4960
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: em@realmagic.fr
Precedence: bulk
X-list: linux-mips

Hi,

I plan to port linux-mips to a a 32bit 4KEc based (little endian)
hardware design.

I have three questions:

Q1- The nice book `see mips run' states that it's better that the
physical address map fits entirely in kseg1 (in 0x0-0x2000_0000).

I would not be the first to plan for a lot of RAM and I understand
HIGHMEM patch is ok if an extra RAM area is out of reach of kseg1.

But what if my PCI devices I/O do not lie in kseg1? I may program the
TLB to see them thru kseg2 (but kseg2 seems to be the place where page
tables are stored...)

Q2- Most hardware platforms have their SDRAM chips mapped at
physical address 0x0. Mine does not. Am I going ahead of problems?
It seems to be assumed at a lot of places (I have already ported YAMON).

Q3- I'd rather stick to a 2.4.x linux port. But... should I use:

a- the latest official 2.4.x kernel
b- the latest 2.4.x-preY kernel
c- the latest linux-mips.org 2.4.x kernel
d- cvs -z3 -d :pserver:cvs@ftp.linux-mips.org:/home/cvs co -r linux_2_4
?

Thanks for any useful advise.

Sincerely yours,

-- 
E.M.
key A1A84D4C
