Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jul 2015 06:12:35 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:49855 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007865AbbGPEMeWt5QB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Jul 2015 06:12:34 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id E2AEC140281;
        Thu, 16 Jul 2015 14:12:29 +1000 (AEST)
Message-ID: <1437019949.28475.6.camel@ellerman.id.au>
Subject: Re: [3/3] IRQ: Print "unexpected IRQ" messages consistently across
 architectures
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        linux-am33-list@redhat.com,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org,
        "x86@kernel.org" <x86@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Thu, 16 Jul 2015 14:12:29 +1000
In-Reply-To: <CAErSpo52Kk0c=1UHQzxntJc3ph_CX8vcY+QdULBKv-HGUHBK9Q@mail.gmail.com>
References: <20150712220211.7166.42035.stgit@bhelgaas-glaptop2.roam.corp.google.com>
         <20150713032303.D49801402B1@ozlabs.org>
         <CAErSpo52Kk0c=1UHQzxntJc3ph_CX8vcY+QdULBKv-HGUHBK9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48321
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

On Mon, 2015-07-13 at 13:35 -0500, Bjorn Helgaas wrote:
> On Sun, Jul 12, 2015 at 10:23 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > On Sun, 2015-12-07 at 22:02:11 UTC, Bjorn Helgaas wrote:
> >> Many architectures use a variant of "unexpected IRQ trap at vector %x" to
> >> log unexpected IRQs.  This is confusing because (a) it prints the Linux IRQ
> >> number, but "vector" more often refers to a CPU vector number, and (b) it
> >> prints the IRQ number in hex with no base indication, while Linux IRQ
> >> numbers are usually printed in decimal.
> >>
> >> Print the same text ("unexpected IRQ %d") across all architectures.
> >>
> >> No functional change other than the output text.
> >
> > There's already a fallback version in asm-generic, so shouldn't you instead
> > just delete all the versions that are identical to that?
> >
> > eg. on powerpc we have:
> >
> >>  static inline void ack_bad_irq(unsigned int irq)
> >>  {
> >> -     printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
> >> +     printk(KERN_CRIT "unexpected IRQ %d\n", irq);
> >>  }
> >
> > And the generic version is:
> >
> >>  #ifndef ack_bad_irq
> >>  static inline void ack_bad_irq(unsigned int irq)
> >>  {
> >> -     printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
> >> +     printk(KERN_CRIT "unexpected IRQ %d\n", irq);
> >>  }
> >>  #endif
> >
> > So we can just delete the powerpc version?
> 
> Wow, I really didn't do my homework here.  Not only is there a generic
> version already, but there's also print_irq_desc(), which prints way
> more information than any of the ack_bad_irq() implementations.

Even better :)

> I'll try again :)

Thanks.

cheers
