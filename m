Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Sep 2003 21:19:58 +0100 (BST)
Received: from Iris.Adtech-Inc.COM ([IPv6:::ffff:63.165.80.18]:52435 "EHLO
	iris.Adtech-Inc.COM") by linux-mips.org with ESMTP
	id <S8225530AbTIVUTz> convert rfc822-to-8bit; Mon, 22 Sep 2003 21:19:55 +0100
content-class: urn:content-classes:message
Subject: User-mode drivers and TLB
Date: Mon, 22 Sep 2003 10:19:47 -1000
Message-ID: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB750@iris.adtech-inc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: User-mode drivers and TLB
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Thread-Index: AcOBRuDKdEBlxua2SZqQUES1OY/Qig==
From: "Finney, Steve" <Steve.Finney@SpirentCom.COM>
To: <linux-mips@linux-mips.org>
Return-Path: <Steve.Finney@SpirentCom.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steve.Finney@SpirentCom.COM
Precedence: bulk
X-list: linux-mips

I am working on an app where I want to give one or more 
user processes access to a largish range of physical 
address space (specifically, this is a Broadcom 1125 
running a 32 bit kernel, and for now the region is 
accessible via KSEG0/1 (physical address < 512 MB)). 
mmap() on /dev/mem does this just fine, and setting 
(or not setting) O_SYNC on open seems to control caching. 
But I just realized a disadvantage to doing this in user 
space: the user process accesses have to be mapped (since a
user process can't, I believe, use KSEG0 or KSEG1 addresses),
so you have to go through the (64 entry) TLB, and if 
you had signficant non-locality of reference, you'd
possibly risk thrashing the TLB (which doesn't happen
in kernel space, since the region can be directly 
accessed). One approach would be to wire a TLB entry 
to handle the large region so you never get a TLB miss, 
but this might not work well for multi-process access,
since (normally) you can't guarantee that the multiple
processes doing mmap's will get the same virtual address.

Is this  correct? Is there some other clever approach I
haven't thought of? Should I even be worrying about TLB usage?

Thanks,
sf
