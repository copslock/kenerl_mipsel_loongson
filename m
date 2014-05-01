Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 May 2014 18:06:27 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:16994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831271AbaEAQGYI8s3T (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 May 2014 18:06:24 +0200
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s41G6G87020286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 May 2014 12:06:16 -0400
Received: from dhcp-26-207.brq.redhat.com (vpn-53-36.rdu2.redhat.com [10.10.53.36])
        by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s41G6APX023006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 1 May 2014 12:06:13 -0400
Date:   Thu, 1 May 2014 18:07:39 +0200
From:   Alexander Gordeev <agordeev@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        x86@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/MSI: Phase out pci_enable_msi_block()
Message-ID: <20140501160738.GA10407@dhcp-26-207.brq.redhat.com>
References: <cover.1397458024.git.agordeev@redhat.com>
 <0b08613dc17cd608c1babc1f42b8919f60e1093f.1397458024.git.agordeev@redhat.com>
 <20140414120921.GA32132@dhcp-26-207.brq.redhat.com>
 <20140414132834.GA9164@dhcp-26-207.brq.redhat.com>
 <20140430234933.GB31315@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140430234933.GB31315@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Return-Path: <agordeev@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agordeev@redhat.com
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

On Wed, Apr 30, 2014 at 05:49:33PM -0600, Bjorn Helgaas wrote:
> I mistakenly assumed this would have to wait because I thought there were
> other pci_enable_msi_block() users that wouldn't be removed until the v3.16
> merge window.  But I think I was wrong: I put your GenWQE patch in my tree,
> and I think that was the last use, so I can just add this patch on top.

That is right, GenWQE is the last one.

> But I need a little help understanding the changelog:
> 
> > Up until now, when enabling MSI mode for a device a single
> > successful call to arch_msi_check_device() was followed by
> > a single call to arch_setup_msi_irqs() function.
> 
> I understand this part; the following two paths call
> arch_msi_check_device() once and then arch_setup_msi_irqs() once:
> 
>   pci_enable_msi_block
>     pci_msi_check_device
>       arch_msi_check_device
>     msi_capability_init
>       arch_setup_msi_irqs
> 
>   pci_enable_msix
>     pci_msi_check_device
>       arch_msi_check_device
>     msix_capability_init
>       arch_setup_msi_irqs
> 
> > Yet, if arch_msi_check_device() returned success we should be
> > able to call arch_setup_msi_irqs() multiple times - while it
> > returns a number of MSI vectors that could have been allocated
> > (a third state).
> 
> I don't know what you mean by "a third state."

That is "a number of MSI vectors that could have been allocated", which
is neither success nor failure. In previous conversations someone branded
it this as "third state".

> Previously we only called arch_msi_check_device() once.  After your patch,
> pci_enable_msi_range() can call it several times.  The only non-trivial
> implementation of arch_msi_check_device() is in powerpc, and all the
> ppc_md.msi_check_device() possibilities look safe to call multiple times.

Yep, I see it the same way.

> After your patch, the pci_enable_msi_range() path can also call
> arch_setup_msi_irqs() several times.  I don't see a problem with that --
> even if the first call succeeds and allocates something, then a subsequent
> call fails, I assume the allocations will be cleaned up when
> msi_capability_init() calls free_msi_irqs().

Well, the potential problem related to the fact arch_msi_check_device()
could be called with 'nvec1' while arch_setup_msi_irqs() could be called
with 'nvec2', where 'nvec1' > 'nvec2'.

While it is not a problem with current implementations, in therory it is
possible free_msi_irqs() could be called with 'nvec2' and fail to clean
up 'nvec1' - 'nvec2' number of resources.

The only assumption that makes the above scenario impossible is if
arch_msi_check_device() is stateless.

Again, that is purely theoretical with no particular architecture in mind.

> > This update makes use of the assumption described above. It
> > could have broke things had the architectures done any pre-
> > allocations or switch to some state in a call to function
> > arch_msi_check_device(). But because arch_msi_check_device()
> > is expected stateless and MSI resources are allocated in a
> > follow-up call to arch_setup_msi_irqs() we should be fine.
> 
> I guess you mean that your patch assumes arch_msi_check_device() is
> stateless.  That looks like a safe assumption to me.

Moreover, if arch_msi_check_device() was not stateless then it would
be superfluous, since all state switches and allocations are done in
arch_setup_msi_irqs() anyway.

In fact, I think arch_msi_check_device() could be eliminated, but I
do not want to engage with PPC folks at this stage ;)

> arch_setup_msi_irqs() is clearly not stateless, but I assume
> free_msi_irqs() is enough to clean up any state if we fail.
> 
> Bjorn

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
