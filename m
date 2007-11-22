Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2007 16:19:58 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:21708 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025862AbXKVQT4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Nov 2007 16:19:56 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAMGJaVA006647;
	Thu, 22 Nov 2007 16:19:36 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAMGJZki006646;
	Thu, 22 Nov 2007 16:19:35 GMT
Date:	Thu, 22 Nov 2007 16:19:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] irq_cpu: use handle_percpu_irq handler to avoid
	dropping interrupts.
Message-ID: <20071122161935.GA6605@linux-mips.org>
References: <S20032632AbXKOURg/20071115201736Z+24020@ftp.linux-mips.org> <20071123.004132.61510296.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071123.004132.61510296.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 23, 2007 at 12:41:32AM +0900, Atsushi Nemoto wrote:

> This might broke probe_irq_on()/probe_irq_off(), since
> handle_percpu_irq() does not check IRQ_WAITING bit.

Ok - but does that matter at all?  IRQ probing is only used with ISA
drivers and for those there will be another interrupt controller such as
a i8259 PIC daisy chained to one of the CPU interrupt pins.

  Ralf
