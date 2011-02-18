Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Feb 2011 02:52:31 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14818 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491120Ab1BRBw2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Feb 2011 02:52:28 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d5dd10d0000>; Thu, 17 Feb 2011 17:53:17 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 17:52:24 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 17:52:24 -0800
Message-ID: <4D5DD0D8.4030104@caviumnetworks.com>
Date:   Thu, 17 Feb 2011 17:52:24 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     ralf@linux-mips.org
CC:     linux-mips@linux-mips.org, Antony Pavlov <antonynpavlov@gmail.com>
Subject: Re: [PATCH] MIPS: Only include arch/mips/cavium-octeon/Kconfig if
 CPU_CAVIUM_OCTEON
References: <1297965723-26059-1-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1297965723-26059-1-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Feb 2011 01:52:24.0535 (UTC) FILETIME=[7D171E70:01CBCF0E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 02/17/2011 10:02 AM, David Daney wrote:
> Instead of making each Octeon specific option depend on
> CPU_CAVIUM_OCTEON, just quit including cavium-octeon/Kconfig if it is
> not applicable.
>
> Signed-off-by: David Daney<ddaney@caviumnetworks.com>
> Cc: Antony Pavlov<antonynpavlov@gmail.com>
> ---
>   arch/mips/Kconfig               |    4 ++++
>   arch/mips/cavium-octeon/Kconfig |    3 ---
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index bd7b64d..b0a1cb3 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -748,7 +748,11 @@ source "arch/mips/sgi-ip27/Kconfig"
>   source "arch/mips/sibyte/Kconfig"
>   source "arch/mips/txx9/Kconfig"
>   source "arch/mips/vr41xx/Kconfig"
> +
> +if CPU_CAVIUM_OCTEON
>   source "arch/mips/cavium-octeon/Kconfig"
> +endif
> +

Ralf pointed out that nobody else has the IFs here.  I will create a new 
patch that moves them into arch/mips/cavium-octeon/Kconfig

David Daney


>   source "arch/mips/loongson/Kconfig"
>
>   endmenu
> diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
> index caae228..3dab0ec 100644
> --- a/arch/mips/cavium-octeon/Kconfig
> +++ b/arch/mips/cavium-octeon/Kconfig
> @@ -1,6 +1,5 @@
>   config CAVIUM_OCTEON_SPECIFIC_OPTIONS
>   	bool "Enable Octeon specific options"
> -	depends on CPU_CAVIUM_OCTEON
>   	default "y"
>
>   config CAVIUM_CN63XXP1
> @@ -93,7 +92,6 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
>   config ARCH_SPARSEMEM_ENABLE
>   	def_bool y
>   	select SPARSEMEM_STATIC
> -	depends on CPU_CAVIUM_OCTEON
>
>   config CAVIUM_OCTEON_HELPER
>   	def_bool y
> @@ -107,6 +105,5 @@ config NEED_SG_DMA_LENGTH
>
>   config SWIOTLB
>   	def_bool y
> -	depends on CPU_CAVIUM_OCTEON
>   	select IOMMU_HELPER
>   	select NEED_SG_DMA_LENGTH
