Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 May 2016 08:49:24 +0200 (CEST)
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:47030 "EHLO
        e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027933AbcECGtW37lEw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 May 2016 08:49:22 +0200
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <cornelia.huck@de.ibm.com>;
        Tue, 3 May 2016 07:49:17 +0100
Received: from d06dlp01.portsmouth.uk.ibm.com (9.149.20.13)
        by e06smtp14.uk.ibm.com (192.168.101.144) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 3 May 2016 07:49:15 +0100
X-IBM-Helo: d06dlp01.portsmouth.uk.ibm.com
X-IBM-MailFrom: cornelia.huck@de.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6ECE617D805F
        for <linux-mips@linux-mips.org>; Tue,  3 May 2016 07:50:08 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com [9.149.37.252])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u436nEO63801560
        for <linux-mips@linux-mips.org>; Tue, 3 May 2016 06:49:14 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u436nEoc010777
        for <linux-mips@linux-mips.org>; Tue, 3 May 2016 00:49:14 -0600
Received: from gondolin (dyn-9-152-224-154.boeblingen.de.ibm.com [9.152.224.154])
        by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u436nD2T010735;
        Tue, 3 May 2016 00:49:13 -0600
Date:   Tue, 3 May 2016 08:49:12 +0200
From:   Cornelia Huck <cornelia.huck@de.ibm.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v5 2/2] kvm: introduce KVM_MAX_VCPU_ID
Message-ID: <20160503084912.2cdc42f8.cornelia.huck@de.ibm.com>
In-Reply-To: <146221113787.32310.7342723782230547207.stgit@bahia.huguette.org>
References: <146221092579.32310.10051562885606992534.stgit@bahia.huguette.org>
        <146221113787.32310.7342723782230547207.stgit@bahia.huguette.org>
Organization: IBM Deutschland Research & Development GmbH Vorsitzende des
 Aufsichtsrats: Martina Koederitz =?UTF-8?B?R2VzY2jDpGZ0c2bDvGhydW5nOg==?=
 Dirk Wittkopp Sitz der Gesellschaft: =?UTF-8?B?QsO2Ymxpbmdlbg==?=
 Registergericht: Amtsgericht Stuttgart, HRB 243294
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16050306-0017-0000-0000-00001D2D3031
Return-Path: <cornelia.huck@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cornelia.huck@de.ibm.com
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

On Tue, 03 May 2016 06:52:02 +0200
Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:

> The KVM_MAX_VCPUS define provides the maximum number of vCPUs per guest, and
> also the upper limit for vCPU ids. This is okay for all archs except PowerPC
> which can have higher ids, depending on the cpu/core/thread topology. In the
> worst case (single threaded guest, host with 8 threads per core), it limits
> the maximum number of vCPUS to KVM_MAX_VCPUS / 8.
> 
> This patch separates the vCPU numbering from the total number of vCPUs, with
> the introduction of KVM_MAX_VCPU_ID, as the maximal valid value for vCPU ids
> plus one.
> 
> The corresponding KVM_CAP_MAX_VCPU_ID allows userspace to validate vCPU ids
> before passing them to KVM_CREATE_VCPU.
> 
> Only PowerPC gets unlimited vCPU ids for the moment. This patch doesn't
> change anything for other archs.
> 
> Suggested-by: Radim Krcmar <rkrcmar@redhat.com>
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
>  Documentation/virtual/kvm/api.txt   |   10 ++++++++--
>  arch/powerpc/include/asm/kvm_host.h |    2 ++
>  arch/powerpc/kvm/powerpc.c          |    3 +++
>  include/linux/kvm_host.h            |    4 ++++
>  include/uapi/linux/kvm.h            |    1 +
>  virt/kvm/kvm_main.c                 |    2 +-
>  6 files changed, 19 insertions(+), 3 deletions(-)
> 

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 23bfe1bd159c..3b4efa1c088c 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -35,6 +35,10 @@
> 
>  #include <asm/kvm_host.h>
> 
> +#ifndef KVM_MAX_VCPU_ID
> +#define KVM_MAX_VCPU_ID KVM_MAX_VCPUS

As you are defining KVM_MAX_VCPU_ID in any case, would it make sense to
provide the cap in generic code? power will simply override the value.

> +#endif
> +
>  /*
>   * The bit 16 ~ bit 31 of kvm_memory_region::flags are internally used
>   * in kvm, other bits are visible for userspace which are defined in
