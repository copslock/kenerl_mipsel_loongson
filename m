Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Apr 2003 06:33:05 +0100 (BST)
Received: from kauket.visi.com ([IPv6:::ffff:209.98.98.22]:19861 "HELO
	mail-out.visi.com") by linux-mips.org with SMTP id <S8225072AbTDSFc7>;
	Sat, 19 Apr 2003 06:32:59 +0100
Received: from mahes.visi.com (mahes.visi.com [209.98.98.96])
	by mail-out.visi.com (Postfix) with ESMTP id 646E036CC
	for <linux-mips@linux-mips.org>; Sat, 19 Apr 2003 00:32:56 -0500 (CDT)
Received: from mahes.visi.com (localhost [127.0.0.1])
	by mahes.visi.com (8.12.9/8.12.5) with ESMTP id h3J5Wu9R012042
	for <linux-mips@linux-mips.org>; Sat, 19 Apr 2003 00:32:56 -0500 (CDT)
	(envelope-from erik@greendragon.org)
Received: (from www@localhost)
	by mahes.visi.com (8.12.9/8.12.5/Submit) id h3J5Wopv012041
	for linux-mips@linux-mips.org; Sat, 19 Apr 2003 05:32:50 GMT
X-Authentication-Warning: mahes.visi.com: www set sender to erik@greendragon.org using -f
Received: from 170-215-41-223.bras01.mnd.mn.frontiernet.net (170-215-41-223.bras01.mnd.mn.frontiernet.net [170.215.41.223]) 
	by my.visi.com (IMP) with HTTP 
	for <longshot@imap.visi.com>; Sat, 19 Apr 2003 05:32:50 +0000
Message-ID: <1050730370.3ea0df8263a21@my.visi.com>
Date: Sat, 19 Apr 2003 05:32:50 +0000
From: "Erik J. Green" <erik@greendragon.org>
To: linux-mips@linux-mips.org
Subject: TLB mapping questions
MIME-Version: 1.0
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 170.215.41.223
Return-Path: <erik@greendragon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: erik@greendragon.org
Precedence: bulk
X-list: linux-mips

Hello again, I have more newbie questions for you all.


I *think* I understand how the TLB translates addresses for ckseg2 in mips64. 
Can someone tell me if my understanding is correct?  

Given: Physical memory starts at 0x0000000020004000;

Therefore, an offset 0x2000 from the start of physical memory should be at 

0x0000000020006000, or 0xa000000020006000 as a 64 bit xkphys address.

So if I construct a TLB entry such that cp0_entryhi is 0xffffffffc0002000, and
cp0_entrylo0 has a PFN address of 0x0000000020006, giving it the correct ASID
(0) and valid bitflags(VG), I should be able to access the physical memory
offset above using the ckseg2 virtual address 0xffffffffc0002000?  

Again, if I understand this, the physical address to be referenced will be
constructed from the low order 12 bits of the ckseg2 address (in this case 000)
and the pfn address stored in the TLB entry giving 0x0000000020006000, which is
the physical RAM address.  This is provided that I've constructed the TLB entry
correctly so that it's matched for the address reference given.

Of course, the reason I discuss all this is that the above doesn't work. =)  



Erik 


-- 
Erik J. Green
erik@greendragon.org
