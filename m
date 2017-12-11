Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 12:58:09 +0100 (CET)
Received: from mx1.redhat.com ([209.132.183.28]:33768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990436AbdLKL6CoA6c7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Dec 2017 12:58:02 +0100
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 482B18046E;
        Mon, 11 Dec 2017 11:57:56 +0000 (UTC)
Received: from gondolin (ovpn-117-94.ams2.redhat.com [10.36.117.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B0564D75F;
        Mon, 11 Dec 2017 11:57:53 +0000 (UTC)
Date:   Mon, 11 Dec 2017 12:57:49 +0100
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
Subject: Re: [PATCH v3 02/16] KVM: Prepare for moving vcpu_load/vcpu_put
 into arch specific code
Message-ID: <20171211125749.445a8260.cohuck@redhat.com>
In-Reply-To: <20171204203538.8370-3-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
        <20171204203538.8370-3-cdall@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 11 Dec 2017 11:57:56 +0000 (UTC)
Return-Path: <cohuck@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61401
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

On Mon,  4 Dec 2017 21:35:24 +0100
Christoffer Dall <cdall@kernel.org> wrote:

> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> In preparation for moving calls to vcpu_load() and vcpu_put() into the
> architecture specific implementations of the KVM vcpu ioctls, move the
> calls in the main kvm_vcpu_ioctl() dispatcher function to each case
> of the ioctl select statement.  This allows us to move the vcpu_load()
> and vcpu_put() calls into architecture specific implementations of vcpu
> ioctls, one by one.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  virt/kvm/kvm_main.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
