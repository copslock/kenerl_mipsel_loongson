Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2014 23:34:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:54290 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6854791AbaEIVehvSYhu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 May 2014 23:34:37 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 674E75519C3C3;
        Fri,  9 May 2014 22:34:27 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Fri, 9 May
 2014 22:34:30 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Fri, 9 May 2014 22:34:30 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 9 May
 2014 22:34:30 +0100
Message-ID: <536D49E6.5050201@imgtec.com>
Date:   Fri, 9 May 2014 22:34:30 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>, <kvm@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 07/11] kvm tools: Provide per arch macro to specify type
 for KVM_CREATE_VM
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1399391491-5021-8-git-send-email-andreas.herrmann@caviumnetworks.com>
In-Reply-To: <1399391491-5021-8-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Hi Andreas,

On 06/05/14 16:51, Andreas Herrmann wrote:
> This is is usually 0 for most archs. On mips we have two types.
> TE (type 0) and MIPS-VZ (type 1). Default to 1 on mips.
> 
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> ---
>  tools/kvm/arm/include/arm-common/kvm-arch.h |    2 ++
>  tools/kvm/kvm.c                             |    2 +-
>  tools/kvm/mips/include/kvm/kvm-arch.h       |    2 ++
>  tools/kvm/powerpc/include/kvm/kvm-arch.h    |    2 ++
>  tools/kvm/x86/include/kvm/kvm-arch.h        |    2 ++
>  5 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/kvm/arm/include/arm-common/kvm-arch.h b/tools/kvm/arm/include/arm-common/kvm-arch.h
> index b6c4bf8..a552163 100644
> --- a/tools/kvm/arm/include/arm-common/kvm-arch.h
> +++ b/tools/kvm/arm/include/arm-common/kvm-arch.h
> @@ -32,6 +32,8 @@
>  
>  #define KVM_IRQ_OFFSET		GIC_SPI_IRQ_BASE
>  
> +#define KVM_VM_TYPE		0
> +
>  #define VIRTIO_DEFAULT_TRANS(kvm)	\
>  	((kvm)->cfg.arch.virtio_trans_pci ? VIRTIO_PCI : VIRTIO_MMIO)
>  
> diff --git a/tools/kvm/kvm.c b/tools/kvm/kvm.c
> index cfc0693..278b915 100644
> --- a/tools/kvm/kvm.c
> +++ b/tools/kvm/kvm.c
> @@ -284,7 +284,7 @@ int kvm__init(struct kvm *kvm)
>  		goto err_sys_fd;
>  	}
>  
> -	kvm->vm_fd = ioctl(kvm->sys_fd, KVM_CREATE_VM, 0);
> +	kvm->vm_fd = ioctl(kvm->sys_fd, KVM_CREATE_VM, KVM_VM_TYPE);
>  	if (kvm->vm_fd < 0) {
>  		pr_err("KVM_CREATE_VM ioctl");
>  		ret = kvm->vm_fd;
> diff --git a/tools/kvm/mips/include/kvm/kvm-arch.h b/tools/kvm/mips/include/kvm/kvm-arch.h
> index 4a8407b..0210f0b 100644
> --- a/tools/kvm/mips/include/kvm/kvm-arch.h
> +++ b/tools/kvm/mips/include/kvm/kvm-arch.h
> @@ -17,6 +17,8 @@
>  
>  #define KVM_IRQ_OFFSET		1
>  
> +#define KVM_VM_TYPE		1

A comment or define to clarify this wouldn't hurt.

Cheers
James
