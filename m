Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Sep 2005 21:59:30 +0100 (BST)
Received: from web31515.mail.mud.yahoo.com ([IPv6:::ffff:68.142.198.144]:53384
	"HELO web31515.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8225479AbVIOU7L>; Thu, 15 Sep 2005 21:59:11 +0100
Received: (qmail 16382 invoked by uid 60001); 15 Sep 2005 20:59:04 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Bqn2fwTTrYcAZGn3ViQDf7313JRRIfRNJ6ioZHLrosObxE9GLrxKdSWRFm9ay+JoIgCUJCDcBcL/dOS+9Fs9HhGwty9+1sxGvCnMVAzmIKOagbgePV1SI2oC2fZf6layNDEoCuEEY2Q4IHt2J+ro6Wd2aELfQqhfZtwZ+wIKEN8=  ;
Message-ID: <20050915205904.16380.qmail@web31515.mail.mud.yahoo.com>
Received: from [208.187.37.98] by web31515.mail.mud.yahoo.com via HTTP; Thu, 15 Sep 2005 13:59:04 PDT
Date:	Thu, 15 Sep 2005 13:59:04 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Building the kernel for a Broadcom SB1
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm having a few issues building the current
2.6.14-rc1 for a Broadcom SB1 MIPS64 processor. (No
huge surprise there, building anything for that
processor is a pain.)

Anyway, there are a few symbols undefined, which is
causing problems. First off the bat is TO_PHYS_MASK.
There is no set of definitions in
include/asm-mips/addrspace.h for the SB1 processor.
(For that matter, there's no set of definitions for
the MIPS64_R2, so I'm guessing those using _R2 chips
probably have the same problem.)

For the time-being, I've simply grouped the SB1 with
the MIPS64_R1 as the SiByte documentation is rather
limited on what the SB1 actually is.

Next off, if you enable processor threading, it looks
for IRQ_PER_CPU. A grep reveals that this needs
ARCH_HAS_IRQ_PER_CPU defined in the architecture's
irq.h file, but that no such definition exists for any
MIPS processor.

A Google shows that the processor threading was
recently added in (or back in, or something). Is the
change to irq.h not present for a reason (eg:
something is broken, so the code shouldn't be used
anyway), something that should have been checked out
but wasn't (ie: my computer has turned traitor) or got
forgotten somewhere else in the chain?

For the time-being, I've simply added a #define for it
in the include/asm-mips/irq.h file, but it would be
good to know what the "correct" solution was.

Any help would be much appreciated.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
