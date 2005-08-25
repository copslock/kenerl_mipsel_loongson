Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2005 16:21:50 +0100 (BST)
Received: from rwcrmhc11.comcast.net ([IPv6:::ffff:204.127.198.35]:22430 "EHLO
	rwcrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225298AbVHYPVb>; Thu, 25 Aug 2005 16:21:31 +0100
Received: from ba3pi (pcp0010731669pcs.howard01.md.comcast.net[69.243.71.130])
          by comcast.net (rwcrmhc11) with SMTP
          id <200508251526590130063f7oe>; Thu, 25 Aug 2005 15:26:59 +0000
From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
To:	"'Ralf Baechle'" <ralf@linux-mips.org>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: custom ide driver causes "Badness in smp_call_function"
Date:	Thu, 25 Aug 2005 11:26:58 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWov/o2tje51yNZRMqC6qvo2vU/0gAyUQrg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20050824152444.GE2783@linux-mips.org>
Message-Id: <20050825152131Z8225298-3678+7482@linux-mips.org>
Return-Path: <bryan.althouse@3phoenix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bryan.althouse@3phoenix.com
Precedence: bulk
X-list: linux-mips

Ralf,

Thank you for your help.  
I'm doing MMIO, not PIO, but it looks like your assessment is still valid.
I've been searching for places where ide MMIO is performed with interrupts
disabled.  I got excited when I found these lines in probe_hwif() of
ide-probe.c:

   irqd = hwif->irq;
   if (irqd)
        disable_irq(hwif->irq);

I was not initializing hwif->irq in my driver, so probably the interrupts
were being disabled here, and subsequent lines were causing the SMP badness.
I added the line "hwif->irq = 0" to my driver.  Interrupts are no longer
disabled here, but still I get the SMP badness.  I'll keep looking for other
places where the interrupts might be disabled.  

Does anyone know if the mips/swarm.c driver has this problem with SMP?
Thanks!
  
Bryan
