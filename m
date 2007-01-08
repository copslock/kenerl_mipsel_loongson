Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jan 2007 15:10:35 +0000 (GMT)
Received: from wf1.mips-uk.com ([194.74.144.154]:18659 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28573979AbXAHPKV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Jan 2007 15:10:21 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l08FBBdC028705;
	Mon, 8 Jan 2007 15:11:11 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l08FBBLe028704;
	Mon, 8 Jan 2007 15:11:11 GMT
Date:	Mon, 8 Jan 2007 15:11:11 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Define MIPS_CPU_IRQ_BASE in generic header
Message-ID: <20070108151111.GB28691@linux-mips.org>
References: <20070108.021429.78706014.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108.021429.78706014.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 08, 2007 at 02:14:29AM +0900, Atsushi Nemoto wrote:

> The irq_base for {mips,rm7k,rm9k}_cpu_irq_init() are constant on all
> platforms and are same value on most platforms (0 or 16, depends on
> CONFIG_I8259).  Define them in asm-mips/mach-generic/irq.h and make
> them customizable.  This will save a few cycle on each CPU interrupt.
> 
> A good side effect is removing some dependencies to MALTA in generic
> SMTC code.
> 
> Although MIPS_CPU_IRQ_BASE is customizable, this patch changes irq
> mappings on DDB5477, EMMA2RH and MIPS_SIM, since really customizing
> them might cause some header dependency problem and there seems no
> good reason to customize it.  So currently only VR41XX is using custom
> MIPS_CPU_IRQ_BASE value, which is 0 regardless of CONFIG_I8259.
> 
> Testing this patch on those platforms is greatly appreciated.  Thank
> you.

Queued for 2.6.21,

  Ralf
