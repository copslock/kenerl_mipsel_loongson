Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 19:01:09 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19927 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491109Ab1BQSBG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 19:01:06 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d5d62930001>; Thu, 17 Feb 2011 10:01:55 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 10:01:03 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 17 Feb 2011 10:01:03 -0800
Message-ID: <4D5D625E.2000503@caviumnetworks.com>
Date:   Thu, 17 Feb 2011 10:01:02 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Antony Pavlov <antonynpavlov@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Kconfig: fix helper dependency
References: <1297952906-1099-1-git-send-email-antonynpavlov@gmail.com>
In-Reply-To: <1297952906-1099-1-git-send-email-antonynpavlov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2011 18:01:03.0095 (UTC) FILETIME=[A409D870:01CBCECC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 02/17/2011 06:28 AM, Antony Pavlov wrote:
> The option CAVIUM_OCTEON_HELPER does not depend
> on CPU_CAVIUM_OCTEON option.
> So my .config file for MIPS Malta board contains
>
>   CONFIG_MIPS_MALTA=y
>   ...
>   # CONFIG_CAVIUM_OCTEON_SIMULATOR is not set
>   # CONFIG_CAVIUM_OCTEON_REFERENCE_BOARD is not set
>   ...
>   CONFIG_CAVIUM_OCTEON_HELPER=y
>
> Signed-off-by: Antony Pavlov<antonynpavlov@gmail.com>

NAK.

I have a patch that takes a different approach.

David Daney


> ---
>   arch/mips/cavium-octeon/Kconfig |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
> index caae228..a6a2f3c 100644
> --- a/arch/mips/cavium-octeon/Kconfig
> +++ b/arch/mips/cavium-octeon/Kconfig
> @@ -97,7 +97,7 @@ config ARCH_SPARSEMEM_ENABLE
>
>   config CAVIUM_OCTEON_HELPER
>   	def_bool y
> -	depends on OCTEON_ETHERNET || PCI
> +	depends on CPU_CAVIUM_OCTEON&&  (OCTEON_ETHERNET || PCI)
>
>   config IOMMU_HELPER
>   	bool
