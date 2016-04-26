Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Apr 2016 09:45:16 +0200 (CEST)
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:55233 "EHLO
        e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027260AbcDZHpLQ4DhV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Apr 2016 09:45:11 +0200
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mips@linux-mips.org> from <cornelia.huck@de.ibm.com>;
        Tue, 26 Apr 2016 08:45:04 +0100
Received: from d06dlp03.portsmouth.uk.ibm.com (9.149.20.15)
        by e06smtp13.uk.ibm.com (192.168.101.143) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        Tue, 26 Apr 2016 08:45:02 +0100
X-IBM-Helo: d06dlp03.portsmouth.uk.ibm.com
X-IBM-MailFrom: cornelia.huck@de.ibm.com
X-IBM-RcptTo: linux-mips@linux-mips.org
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id AEA751B08070
        for <linux-mips@linux-mips.org>; Tue, 26 Apr 2016 08:45:48 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com [9.149.37.251])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u3Q7j17o5964230
        for <linux-mips@linux-mips.org>; Tue, 26 Apr 2016 07:45:01 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
        by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u3Q6j3FJ022661
        for <linux-mips@linux-mips.org>; Tue, 26 Apr 2016 00:45:03 -0600
Received: from gondolin (dyn-9-152-224-197.boeblingen.de.ibm.com [9.152.224.197])
        by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id u3Q6j2Z9022589;
        Tue, 26 Apr 2016 00:45:02 -0600
Date:   Tue, 26 Apr 2016 09:44:58 +0200
From:   Cornelia Huck <cornelia.huck@de.ibm.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 1/2] KVM: remove NULL return path for vcpu ids >=
 KVM_MAX_VCPUS
Message-ID: <20160426094458.03685ae5.cornelia.huck@de.ibm.com>
In-Reply-To: <146124810201.32509.2946887043729554992.stgit@bahia.huguette.org>
References: <146124809455.32509.15232948272580716135.stgit@bahia.huguette.org>
        <146124810201.32509.2946887043729554992.stgit@bahia.huguette.org>
Organization: IBM Deutschland Research & Development GmbH Vorsitzende des
 Aufsichtsrats: Martina Koederitz =?UTF-8?B?R2VzY2jDpGZ0c2bDvGhydW5nOg==?=
 Dirk Wittkopp Sitz der Gesellschaft: =?UTF-8?B?QsO2Ymxpbmdlbg==?=
 Registergericht: Amtsgericht Stuttgart, HRB 243294
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 16042607-0013-0000-0000-00000EEB30A1
Return-Path: <cornelia.huck@de.ibm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53231
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

On Thu, 21 Apr 2016 16:15:05 +0200
Greg Kurz <gkurz@linux.vnet.ibm.com> wrote:

> Commit c896939f7cff ("KVM: use heuristic for fast VCPU lookup by id") added
> a return path that prevents vcpu ids to exceed KVM_MAX_VCPUS. This is a
> problem for powerpc where vcpu ids can grow up to 8*KVM_MAX_VCPUS.
> 
> This patch simply reverses the logic so that we only try fast path if the
> vcpu id can be tried as an index in kvm->vcpus[]. The slow path is not
> affected by the change.
> 
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> ---
>  include/linux/kvm_host.h |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
