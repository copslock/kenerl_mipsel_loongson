Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Jan 2015 10:39:06 +0100 (CET)
Received: from mga14.intel.com ([192.55.52.115]:61466 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009839AbbAGJjEe20pQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Jan 2015 10:39:04 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 07 Jan 2015 01:34:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,713,1413270000"; 
   d="scan'208";a="647477861"
Received: from tiejunch-mobl.ccr.corp.intel.com (HELO [10.238.128.188]) ([10.238.128.188])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jan 2015 01:38:54 -0800
Message-ID: <54ACFEAD.2040901@intel.com>
Date:   Wed, 07 Jan 2015 17:38:53 +0800
From:   "Chen, Tiejun" <tiejun.chen@intel.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: =?UTF-8?B?W8OeQVRDSF0ga3ZtdG9vbCwgbWlwczogU3VwcG9ydCBtb3JlIHQ=?=
 =?UTF-8?B?aGFuIDI1NiBNQiBndWVzdCBtZW1vcnk=?=
References: <20150106131512.GG4194@alberich>
In-Reply-To: <20150106131512.GG4194@alberich>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiejun.chen@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiejun.chen@intel.com
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

On 2015/1/6 21:15, Andreas Herrmann wrote:
> Two guest memory regions need to be defined and two "mem=" parameters
> need to be passed to guest kernel to support more than 256 MB.
>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
> ---
>   tools/kvm/mips/include/kvm/kvm-arch.h |   10 +++++++++
>   tools/kvm/mips/kvm.c                  |   36 +++++++++++++++++++++++++++------
>   2 files changed, 40 insertions(+), 6 deletions(-)
>
> diff --git a/tools/kvm/mips/include/kvm/kvm-arch.h b/tools/kvm/mips/include/kvm/kvm-arch.h
> index 7eadbf4..97bbf34 100644
> --- a/tools/kvm/mips/include/kvm/kvm-arch.h
> +++ b/tools/kvm/mips/include/kvm/kvm-arch.h
> @@ -1,10 +1,20 @@
>   #ifndef KVM__KVM_ARCH_H
>   #define KVM__KVM_ARCH_H
>
> +
> +/*
> + * Guest memory map is:
> + *   0x00000000-0x0fffffff : System RAM
> + *   0x10000000-0x1fffffff : I/O (defined by KVM_MMIO_START and KVM_MMIO_SIZE)
> + *   0x20000000-    ...    : System RAM
> + * See also kvm__init_ram().
> + */
> +
>   #define KVM_MMIO_START		0x10000000
>   #define KVM_PCI_CFG_AREA	KVM_MMIO_START
>   #define KVM_PCI_MMIO_AREA	(KVM_MMIO_START + 0x1000000)
>   #define KVM_VIRTIO_MMIO_AREA	(KVM_MMIO_START + 0x2000000)
> +#define KVM_MMIO_SIZE		0x10000000
>
>   /*
>    * Just for reference. This and the above corresponds to what's used
> diff --git a/tools/kvm/mips/kvm.c b/tools/kvm/mips/kvm.c
> index fc0428b..10b441b 100644
> --- a/tools/kvm/mips/kvm.c
> +++ b/tools/kvm/mips/kvm.c
> @@ -22,11 +22,28 @@ void kvm__init_ram(struct kvm *kvm)
>   	u64	phys_start, phys_size;
>   	void	*host_mem;
>
> -	phys_start = 0;
> -	phys_size  = kvm->ram_size;
> -	host_mem   = kvm->ram_start;
> +	if (kvm->ram_size <= KVM_MMIO_START) {
> +		/* one region for all memory */
> +		phys_start = 0;
> +		phys_size  = kvm->ram_size;
> +		host_mem   = kvm->ram_start;
>
> -	kvm__register_mem(kvm, phys_start, phys_size, host_mem);
> +		kvm__register_mem(kvm, phys_start, phys_size, host_mem);
> +	} else {
> +		/* one region for memory that fits below MMIO range */
> +		phys_start = 0;
> +		phys_size  = KVM_MMIO_SIZE;

Here phys_size = KVM_MMIO_START is better to make more sense.

> +		host_mem   = kvm->ram_start;
> +
> +		kvm__register_mem(kvm, phys_start, phys_size, host_mem);
> +
> +		/* one region for rest of memory */
> +		phys_start = KVM_MMIO_START + KVM_MMIO_SIZE;
> +		phys_size  = kvm->ram_size - 0x10000000;

and, phys_size = kvm->ram_size - KVM_MMIO_START.

Tiejun

> +		host_mem   = kvm->ram_start + KVM_MMIO_SIZE;
> +
> +		kvm__register_mem(kvm, phys_start, phys_size, host_mem);
> +	}
>   }
>
>   void kvm__arch_delete_ram(struct kvm *kvm)
> @@ -108,8 +125,15 @@ static void kvm__mips_install_cmdline(struct kvm *kvm)
>   	u64 argv_offset = argv_start;
>   	u64 argc = 0;
>
> -	sprintf(p + cmdline_offset, "mem=0x%llx@0 ",
> -		 (unsigned long long)kvm->ram_size);
> +
> +	if ((u64) kvm->ram_size <= KVM_MMIO_SIZE)
> +		sprintf(p + cmdline_offset, "mem=0x%llx@0 ",
> +			(unsigned long long)kvm->ram_size);
> +	else
> +		sprintf(p + cmdline_offset, "mem=0x%llx@0 mem=0x%llx@0x%llx ",
> +			(unsigned long long)KVM_MMIO_START,
> +			(unsigned long long)kvm->ram_size - KVM_MMIO_START,
> +			(unsigned long long)(KVM_MMIO_START + KVM_MMIO_SIZE));
>
>   	strcat(p + cmdline_offset, kvm->cfg.real_cmdline); /* maximum size is 2K */
>
>
