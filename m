Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Aug 2010 14:42:53 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:49757 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491985Ab0HQMmt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Aug 2010 14:42:49 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o7HCgkf5016980;
        Tue, 17 Aug 2010 13:42:47 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o7HCgkFa016978;
        Tue, 17 Aug 2010 13:42:46 +0100
Date:   Tue, 17 Aug 2010 13:42:46 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     arrow zhang <arrow.ebd@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [Help] R3000 CPU porting, Oops while run app
Message-ID: <20100817124246.GA14155@linux-mips.org>
References: <AANLkTi=bs4wJqG-3MeFJfr8sGC-s9PG_KksCY5TLo7ra@mail.gmail.com>
 <AANLkTikW2_NNj52goVm-h9yvHZb3e-TktmOY5jDHPpRe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTikW2_NNj52goVm-h9yvHZb3e-TktmOY5jDHPpRe@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 17, 2010 at 11:49:27AM +0800, arrow zhang wrote:

> yeah, I have known some reason on it:
> * not call "mips_cpu_irq_init" in function "arch_init_irq"
> * and did not use "set_irq_chip_and_handler"
> * before I only setup the "chip" with code "irq_desc[i].chip =
> &irq_type;", but it is for old kernel(2.6.19)
> 
> so new code is:
> void __init arch_init_irq(void)
> {
> 	int i;
> 
> 	mips_cpu_irq_init();
> 	for (i = 0; i < 32; ++i) {
> 		set_irq_chip_and_handler(i, &irq_type, handle_level_irq);
> 	}
> }

Most systems define MIPS_CPU_IRQ_BASE as 0 so be careful that your
set_irq_chip_and_handler loop doesn't overwrite any previous setup by
mips_cpu_irq_init.  If your interrupt controller has 32 interrupts you
probably want to assign interrupts 0..7 to the CPU interrupts and 8..39
to the other controller.

  Ralf
