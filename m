Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Mar 2005 01:13:39 +0000 (GMT)
Received: from foothill.iad.idealab.com ([IPv6:::ffff:64.208.8.35]:60813 "EHLO
	foothill.iad.idealab.com") by linux-mips.org with ESMTP
	id <S8225803AbVCSBNY> convert rfc822-to-8bit; Sat, 19 Mar 2005 01:13:24 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: [patch] arch/mips/au1000/common/time.c
Date:	Fri, 18 Mar 2005 17:13:12 -0800
Message-ID: <BBB228F72FF00E4390479AC295FF4B350DE933@FOOTHILL.iad.idealab.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: time.c fix
Thread-Index: AcUsH6MMLEuw/udPSleoURTdhR92NwAAGYow
From:	"Joseph Chiu" <joseph@omnilux.net>
To:	<linux-mips@linux-mips.org>,
	"Ralf Baechle \(E-mail\)" <ralf@linux-mips.org>
Return-Path: <joseph@omnilux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@omnilux.net
Precedence: bulk
X-list: linux-mips

Hi,

I reported on this a few years ago on 2.4.18, but it never seemed to have been addressed...

in linux/arch/mips/au1000/common/time.c, mips_timer_interrupt calls irq_enter() *before*
checking if (r4k_offset == 0), and then exits the interrupt without calling irq_exit().

This problem was crashing our boards in some test cases...  Please apply.

Thanks,
Joseph

----

RCS file: /mnt/cvs/kernel-2.6/arch/mips/au1000/common/time.c,v
retrieving revision 1.1.1.1
diff -c -r1.1.1.1 time.c
*** time.c	13 Mar 2005 08:19:05 -0000	1.1.1.1
--- time.c	19 Mar 2005 01:04:19 -0000
***************
*** 86,96 ****
  	int irq = 63;
  	unsigned long count;
  
- 	irq_enter();
- 	kstat_this_cpu.irqs[irq]++;
- 
  	if (r4k_offset == 0)
  		goto null;
  
  	do {
  		count = read_c0_count();
--- 86,96 ----
  	int irq = 63;
  	unsigned long count;
  
  	if (r4k_offset == 0)
  		goto null;
+ 
+ 	irq_enter();
+ 	kstat_this_cpu.irqs[irq]++;
  
  	do {
  		count = read_c0_count();
