Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2005 16:37:49 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:31517 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8225298AbVHYPh2>; Thu, 25 Aug 2005 16:37:28 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j7PFgnBe009413;
	Thu, 25 Aug 2005 16:42:49 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j7PFgnco009412;
	Thu, 25 Aug 2005 16:42:49 +0100
Date:	Thu, 25 Aug 2005 16:42:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: custom ide driver causes "Badness in smp_call_function"
Message-ID: <20050825154249.GC2731@linux-mips.org>
References: <20050824152444.GE2783@linux-mips.org> <20050825152131Z8225298-3678+7482@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825152131Z8225298-3678+7482@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 25, 2005 at 11:26:58AM -0400, Bryan Althouse wrote:
> From:	"Bryan Althouse" <bryan.althouse@3phoenix.com>
> To:	"'Ralf Baechle'" <ralf@linux-mips.org>
> Cc:	<linux-mips@linux-mips.org>
> Subject: RE: custom ide driver causes "Badness in smp_call_function"
> Date:	Thu, 25 Aug 2005 11:26:58 -0400
> Content-Type: text/plain;
> 	charset="us-ascii"
> 
> Ralf,
> 
> Thank you for your help.  
> I'm doing MMIO, not PIO, but it looks like your assessment is still valid.

... which still is programmed io ...

> I've been searching for places where ide MMIO is performed with interrupts
> disabled.  I got excited when I found these lines in probe_hwif() of
> ide-probe.c:
> 
>    irqd = hwif->irq;
>    if (irqd)
>         disable_irq(hwif->irq);
> 
> I was not initializing hwif->irq in my driver, so probably the interrupts
> were being disabled here, and subsequent lines were causing the SMP badness.
> I added the line "hwif->irq = 0" to my driver.  Interrupts are no longer
> disabled here, but still I get the SMP badness.  I'll keep looking for other
> places where the interrupts might be disabled.  
> 
> Does anyone know if the mips/swarm.c driver has this problem with SMP?
> Thanks!

No, SB1 has sane caches.

  Ralf
