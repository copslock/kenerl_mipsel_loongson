Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 18:23:58 +0200 (CEST)
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:41360 "EHLO
        e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028427AbcEIQXy1FTql (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 May 2016 18:23:54 +0200
Received: from localhost
        by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <cornelia.huck@de.ibm.com>;
        Mon, 9 May 2016 17:23:48 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp17.uk.ibm.com (192.168.101.147) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Mon, 9 May 2016 17:23:45 +0100
X-IBM-Helo: d06dlp03.portsmouth.uk.ibm.com
X-IBM-MailFrom: cornelia.huck@de.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 096BC1B08069
        for <linux-mips@linux-mips.org>; Mon,  9 May 2016 17:24:38 +0100 (BST)
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com [9.149.37.212])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u49GNj5R6685158
        for <linux-mips@linux-mips.org>; Mon, 9 May 2016 16:23:45 GMT
Received: from d06av01.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u49GNill011264
        for <linux-mips@linux-mips.org>; Mon, 9 May 2016 10:23:45 -0600
Received: from gondolin (dyn-9-152-224-125.boeblingen.de.ibm.com [9.152.224.125])
        by d06av01.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u49GNik6011253;
        Mon, 9 May 2016 10:23:44 -0600
Date:   Mon, 9 May 2016 18:23:39 +0200
From:   Cornelia Huck <cornelia.huck@de.ibm.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v6 2/2] kvm: introduce KVM_MAX_VCPU_ID
Message-ID: <20160509182339.04fe7ef2.cornelia.huck@de.ibm.com>
In-Reply-To: <146281032358.17210.17266631315196879115.stgit@bahia.huguette.org>
References: <146281031018.17210.8148336192033754193.stgit@bahia.huguette.org>
        <146281032358.17210.17266631315196879115.stgit@bahia.huguette.org>
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
x-cbid: 16050916-0005-0000-0000-000018D80F14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
Return-Path: <cornelia.huck@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53318
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

On Mon, 09 May 2016 18:13:37 +0200
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
> This patch only implements KVM_MAX_VCPU_ID with a specific value for PowerPC.
> Other archs continue to return KVM_MAX_VCPUS instead.
> 
> Suggested-by: Radim Krcmar <rkrcmar@redhat.com>
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
> v6: - provide cap in generic code (Cornelia)
>     - change PowerPC limit to threads_per_subcore * KVM_MAX_VCORES (Radim)
> ---
>  Documentation/virtual/kvm/api.txt   |   10 ++++++++--
>  arch/powerpc/include/asm/kvm_host.h |    3 +++
>  include/linux/kvm_host.h            |    4 ++++
>  include/uapi/linux/kvm.h            |    1 +
>  virt/kvm/kvm_main.c                 |    4 +++-
>  5 files changed, 19 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
