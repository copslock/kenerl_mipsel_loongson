Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Apr 2018 15:56:27 +0200 (CEST)
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992521AbeDSN4UPiOGb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 19 Apr 2018 15:56:20 +0200
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03CD44182D5A;
        Thu, 19 Apr 2018 13:56:14 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2982010EE95B;
        Thu, 19 Apr 2018 13:56:08 +0000 (UTC)
Date:   Thu, 19 Apr 2018 15:56:06 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     jhogan@kernel.org, ralf@linux-mips.org, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au,
        borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com, pbonzini@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, christoffer.dall@linaro.org,
        marc.zyngier@arm.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, willy@infradead.org
Subject: Re: [PATCH] kvm: Change return type to vm_fault_t
Message-ID: <20180419155606.45a85009.cohuck@redhat.com>
In-Reply-To: <20180418191958.GA25806@jordon-HP-15-Notebook-PC>
References: <20180418191958.GA25806@jordon-HP-15-Notebook-PC>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 19 Apr 2018 13:56:14 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 19 Apr 2018 13:56:14 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Return-Path: <cohuck@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63603
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cohuck@redhat.com
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

On Thu, 19 Apr 2018 00:49:58 +0530
Souptick Joarder <jrdr.linux@gmail.com> wrote:

> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  arch/mips/kvm/mips.c       | 2 +-
>  arch/powerpc/kvm/powerpc.c | 2 +-
>  arch/s390/kvm/kvm-s390.c   | 2 +-
>  arch/x86/kvm/x86.c         | 2 +-
>  include/linux/kvm_host.h   | 2 +-
>  virt/kvm/arm/arm.c         | 2 +-
>  virt/kvm/kvm_main.c        | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
