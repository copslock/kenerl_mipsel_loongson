Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jul 2015 16:07:08 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:48578 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009616AbbGQOHGmmx0m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Jul 2015 16:07:06 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZG6I4-00046s-2I; Fri, 17 Jul 2015 16:07:04 +0200
Date:   Fri, 17 Jul 2015 16:06:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
        linux-am33-list@redhat.com, linux-ia64@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-alpha@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] x86, irq: Rename VECTOR_UNDEFINED and VECTOR_RETRIGGERED
 to IRQ_*
In-Reply-To: <20150712220154.7166.48327.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <alpine.DEB.2.11.1507171558010.18576@nanos>
References: <20150712215559.7166.33068.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20150712220154.7166.48327.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Sun, 12 Jul 2015, Bjorn Helgaas wrote:

> The per-cpu vector_irq[] table is indexed by CPU vector numbers, and each
> entry contains an IRQ number.
> 
> Rename the special values VECTOR_UNDEFINED and VECTOR_RETRIGGERED to
> IRQ_UNDEFINED and IRQ_RETRIGGERED to indicate that they are in the IRQ
> number space, not the CPU vector number space.

Makes some sense, but OTOH vector_irq actually reflects the vector
state not the irq number state. The fact that we store the Linux irq
number in vector_irq is just an implementation detail.

VECTOR_UNDEFINED is certainly a misnomer; that should be VECTOR_UNUSED

VECTOR_RETRIGGERED is pretty accurate. In the case we retrigger an
interrupt, we merily use the Linux irq number to figure out which
vector to kick. And after we retriggered it, we lose the association
to the Linux irq number completely.

That said, I'm working on storing the irq descriptor pointer in
vector_irq instead of the irq number, which has the advantage that we
avoid the lookup of the irq descriptor in the interrupt hotpath.

Thanks,

	tglx
