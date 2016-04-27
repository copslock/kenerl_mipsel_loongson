Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Apr 2016 16:40:24 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:49584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27027600AbcD0OkWjAEwi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Apr 2016 16:40:22 +0200
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5EABFD2ECF;
        Wed, 27 Apr 2016 14:40:19 +0000 (UTC)
Received: from potion (dhcp-1-215.brq.redhat.com [10.34.1.215])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u3REeEWH019655;
        Wed, 27 Apr 2016 10:40:14 -0400
Received: by potion (sSMTP sendmail emulation); Wed, 27 Apr 2016 16:40:14 +0200
Date:   Wed, 27 Apr 2016 16:40:14 +0200
From:   Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To:     Greg Kurz <gkurz@linux.vnet.ibm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, james.hogan@imgtec.com,
        mingo@redhat.com, linux-mips@linux-mips.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        qemu-ppc@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v4 1/2] KVM: remove NULL return path for vcpu ids >=
 KVM_MAX_VCPUS
Message-ID: <20160427144010.GA27247@potion>
References: <146124809455.32509.15232948272580716135.stgit@bahia.huguette.org>
 <146124810201.32509.2946887043729554992.stgit@bahia.huguette.org>
 <20160427054052.Horde.SSxGXKxS_wcijUfLJchjWw2@ltc.linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160427054052.Horde.SSxGXKxS_wcijUfLJchjWw2@ltc.linux.ibm.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 27 Apr 2016 14:40:19 +0000 (UTC)
Return-Path: <rkrcmar@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rkrcmar@redhat.com
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

2016-04-27 05:40-0400, Gerg Kurz:
> Quoting Greg Kurz <gkurz@linux.vnet.ibm.com>:
> 
>> Commit c896939f7cff ("KVM: use heuristic for fast VCPU lookup by id") added
>> a return path that prevents vcpu ids to exceed KVM_MAX_VCPUS. This is a
>> problem for powerpc where vcpu ids can grow up to 8*KVM_MAX_VCPUS.
>> 
>> This patch simply reverses the logic so that we only try fast path if the
>> vcpu id can be tried as an index in kvm->vcpus[]. The slow path is not
>> affected by the change.
>> 
>> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
>> ---
> 
> Radim,
> 
> I think this sanity check is only needed because kvm_get_vcpu() use the
> id as an index in kvm->vcpus[]. Checking against the new KVM_MAX_VCPU_ID
> would be clearly wrong here.

I agree, checking KVM_MAX_VCPU_ID would be pointless.

> And this patch got two R-b tags already. Do you agree we keep it ?

Yes, thanks.
