Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2003 03:40:42 +0000 (GMT)
Received: from p508B68E7.dip.t-dialin.net ([IPv6:::ffff:80.139.104.231]:743
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225379AbTKKDka>; Tue, 11 Nov 2003 03:40:30 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAB3eJsY023467;
	Tue, 11 Nov 2003 04:40:19 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAB3eCT0023466;
	Tue, 11 Nov 2003 04:40:12 +0100
Date: Tue, 11 Nov 2003 04:40:12 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: "Liu Hongming (Alan)" <alanliu@trident.com.cn>
Cc: Adeel Malik <AdeelM@quartics.com>, linux-mips@linux-mips.org
Subject: Re: How to request an IRQ for NMI on MIPS Processor
Message-ID: <20031111034012.GA23100@linux-mips.org>
References: <15F9E1AE3207D6119CEA00D0B7DD5F6801C99461@TMTMS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15F9E1AE3207D6119CEA00D0B7DD5F6801C99461@TMTMS>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Liu,

On Tue, Nov 11, 2003 at 10:51:50AM +0800, Liu Hongming (Alan) wrote:

> when using request_irq(...),the parameter irq is a value specified by you,
> of course,when porting linux for your board,you should have specified value
> for every IRQ. 0--5 only means CPU pin for interrupt,unless that only one
> interrupt
> may occur on this pin,you will use other value in request_irq,instead of
> 0-5.
>  
> all in all, when we touch request_irq,it is board specific.When your board
> has
> been made out,all interrupts have specific route to cpu(unless you have IRQ
> router,since embedded,need this??).If you have more external interrupts than
> cpu pins,maybe you have cascaded many interrupt using one cpu pin.So,
> the parameter irq in request_irq is determined by your board and your
> porting
> for interrupt handling.Just ask that guy that ported linux.He will tell
> you.If you
> are using linux ported by others,have a look at BSP codes.

your answer is correct for normal interrupts, not the NMI.  The NMI goes
through the firmware and none of the board support code so far bothered
to make it available via request_irq as it has several severe limitations.
To repeat one of my prior postings about the NMI:

NMI on MIPS is pretty much miss-designed for use in application code; it's
use should be limited to debugging and recovery from catastrophical
failure.  The reason for this is the way this exception is handled:
                                                                                
  - the BEV, TS, SR, NMI and ERL bits in c0_status are overwritten - that is
    their old state is lost.
  - c0_errorepc is overwritten - again that means the old value is lost so
    in case the NMI interrupts an exception handler that uses this register
    such as the cache error handler you can not resume execution.
  - the program counter is set to 0xbfc00000.  Most likely a slow flash
    memory is mapped at this address but in any case it's an uncached
    segment of the address space so execution will be even slower.
  - execution will pass through the firmware.  That means you can only
    use the NMI at all if firmware provides some kind of hook.
                                                                                
It seems pretty clear to me that the MIPS designers never intended the
NMI for anything else than catastrophic events.

  Ralf
