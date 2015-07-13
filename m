Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 05:23:10 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:34647 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007238AbbGMDXIOPfom (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Jul 2015 05:23:08 +0200
Received: by ozlabs.org (Postfix, from userid 1034)
        id D49801402B1; Mon, 13 Jul 2015 13:23:03 +1000 (AEST)
In-Reply-To: <20150712220211.7166.42035.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-am33-list@redhat.com, linux-ia64@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-alpha@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [3/3] IRQ: Print "unexpected IRQ" messages consistently across architectures
Message-Id: <20150713032303.D49801402B1@ozlabs.org>
Date:   Mon, 13 Jul 2015 13:23:03 +1000 (AEST)
Return-Path: <michael@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sun, 2015-12-07 at 22:02:11 UTC, Bjorn Helgaas wrote:
> Many architectures use a variant of "unexpected IRQ trap at vector %x" to
> log unexpected IRQs.  This is confusing because (a) it prints the Linux IRQ
> number, but "vector" more often refers to a CPU vector number, and (b) it
> prints the IRQ number in hex with no base indication, while Linux IRQ
> numbers are usually printed in decimal.
> 
> Print the same text ("unexpected IRQ %d") across all architectures.
> 
> No functional change other than the output text.

There's already a fallback version in asm-generic, so shouldn't you instead
just delete all the versions that are identical to that?

eg. on powerpc we have:

>  static inline void ack_bad_irq(unsigned int irq)
>  {
> -	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
> +	printk(KERN_CRIT "unexpected IRQ %d\n", irq);
>  }

And the generic version is:

>  #ifndef ack_bad_irq
>  static inline void ack_bad_irq(unsigned int irq)
>  {
> -	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
> +	printk(KERN_CRIT "unexpected IRQ %d\n", irq);
>  }
>  #endif

So we can just delete the powerpc version?

cheers
