Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2003 21:17:02 +0100 (BST)
Received: from mail3.efi.com ([IPv6:::ffff:192.68.228.90]:34061 "HELO
	fcexgw03.efi.internal") by linux-mips.org with SMTP
	id <S8225195AbTFLURA> convert rfc822-to-8bit; Thu, 12 Jun 2003 21:17:00 +0100
Received: from 10.3.12.12 by fcexgw03.efi.internal (InterScan E-Mail VirusWall NT); Thu, 12 Jun 2003 13:16:53 -0700
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Subject: do_IRQ query
Date: Thu, 12 Jun 2003 13:16:51 -0700
Message-ID: <D9F6B9DABA4CAE4B92850252C52383AB07968330@ex-eng-corp.efi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: do_IRQ query
Thread-Index: AcMxH49Edll4GTSjQ4mW6Nj3aEzQTQ==
From: "Ranjan Parthasarathy" <ranjanp@efi.com>
To: <linux-mips@linux-mips.org>
Return-Path: <ranjanp@efi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2616
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ranjanp@efi.com
Precedence: bulk
X-list: linux-mips

Is it safe to call do_IRQ directly inside interrupt handlers without doing a irq_enter. I have seen ksoftirqd_CPUX crashes when I call the do_IRQ routines directly instead of the following sequence.

irq_enter()
do_IRQ
irq_exit()

Some code use it while some do not. The timer code in arch/mips/kernel/time.c uses it in ll_timer_interrupt. Some ports call this function directly in their interrupt handlers.

Any information would be greatly appreciated.

Thank you

Ranjan
