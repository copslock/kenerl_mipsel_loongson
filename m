Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Mar 2004 23:26:19 +0000 (GMT)
Received: from Iris.Adtech-Inc.COM ([IPv6:::ffff:63.165.80.18]:8858 "EHLO
	iris.Adtech-Inc.COM") by linux-mips.org with ESMTP
	id <S8225547AbUCYX0S> convert rfc822-to-8bit; Thu, 25 Mar 2004 23:26:18 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
Subject: FW: 64 bit operations w/32 bit kernel
Date: Thu, 25 Mar 2004 13:25:57 -1000
Message-ID: <DC1BF43A8FAE654DA6B3FB7836DD3A56DEB879@iris.adtech-inc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 64 bit operations w/32 bit kernel
Thread-Index: AcOHjA7sF95D5e4BTSOKBvdhe6W5viLMoVcw
From: "Finney, Steve" <Steve.Finney@SpirentCom.COM>
To: <linux-mips@linux-mips.org>
Return-Path: <Steve.Finney@SpirentCom.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steve.Finney@SpirentCom.COM
Precedence: bulk
X-list: linux-mips

Back in September I was wrestling with the issue of how or
whether you could do atomic access to 64 bit memory mapped 
registers from user space running on a 32 bit kernel, and 
had pretty much concluded (on the basis of discussions here
and elsewhere) that it was impossible. However, Chris 
Demetriou from Broadcom provided me with a working solution, 
which turns out to match Maciej's suggestion below (which I 
wasn't smart enough to grok at the time). Here's the read, 
and you can do an equivalent with a write...

sf

-----------------------------------------------------

uint64_t
read64 (volatile uint64_t *addr)
{
     double d;
     uint64_t rv;
     __asm__ __volatile__ (".set push            \n\t"
                           ".set mips32          \n\t"
                           "ldc1 %0, 0(%2)       \n\t"
                           "sdc1 %0, %1          \n\t"
                           ".set pop"
                           : "=f"(d), "=m"(rv) : "r"(addr));
     return rv;
 }

------------------------------------------------------------------------

On Tue, 30 Sep 2003, Ralf Baechle wrote:

> What I called a bug is the necessity to access hardware registers with
> 64-bit loads and stores in some systems as opposed to of 32-bit
> instructions - that simply doesn't work from 32-bit universes.
> 
> To clarify, it was my understanding of Steve's problem he needs 64-bit
> loads and stores, not something in the 64-bit physical address space.
> The later problem obviously would get a different answer.

 I must have missed the detail.  Well, if 64-bit transfers are needed,
then going for the 64-bit kernel is about the only way.  Or, as a wild
hack, perhaps "ldc1" and "sdc1" can be used, if it's known the FP is
present.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
