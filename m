Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 13:07:36 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:52246 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990487AbdLKMHZ3xBC7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Dec 2017 13:07:25 +0100
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3AD827E425;
        Mon, 11 Dec 2017 12:07:19 +0000 (UTC)
Received: from gondolin (ovpn-117-94.ams2.redhat.com [10.36.117.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE305600D1;
        Mon, 11 Dec 2017 12:07:13 +0000 (UTC)
Date:   Mon, 11 Dec 2017 13:07:11 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christoffer Dall <cdall@kernel.org>
Cc:     kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 04/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_get_regs
Message-ID: <20171211130711.62270b1f.cohuck@redhat.com>
In-Reply-To: <20171204203538.8370-5-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
        <20171204203538.8370-5-cdall@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 11 Dec 2017 12:07:19 +0000 (UTC)
Return-Path: <cohuck@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61403
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

On Mon,  4 Dec 2017 21:35:26 +0100
Christoffer Dall <cdall@kernel.org> wrote:

> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Move vcpu_load() and vcpu_put() into the architecture specific
> implementations of kvm_arch_vcpu_ioctl_get_regs().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/mips/kvm/mips.c      | 3 +++
>  arch/powerpc/kvm/book3s.c | 3 +++
>  arch/powerpc/kvm/booke.c  | 3 +++
>  arch/s390/kvm/kvm-s390.c  | 2 ++
>  arch/x86/kvm/x86.c        | 3 +++
>  virt/kvm/kvm_main.c       | 2 --
>  6 files changed, 14 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
