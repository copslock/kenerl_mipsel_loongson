Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Aug 2010 19:41:23 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6841 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492360Ab0HKRlT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Aug 2010 19:41:19 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c62d6340001>; Wed, 11 Aug 2010 09:56:21 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 11 Aug 2010 09:55:50 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 11 Aug 2010 09:55:50 -0700
Message-ID: <4C62D616.9050000@caviumnetworks.com>
Date:   Wed, 11 Aug 2010 09:55:50 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100720 Fedora/3.0.6-1.fc12 Thunderbird/3.0.6
MIME-Version: 1.0
To:     =?UTF-8?B?QW5kcmVhcyBCaWXDn21hbm4=?= <biessmann@corscience.de>
CC:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] cavium-octeon: determine if helper should build
References: <1281545393-23690-1-git-send-email-biessmann@corscience.de>
In-Reply-To: <1281545393-23690-1-git-send-email-biessmann@corscience.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Aug 2010 16:55:50.0573 (UTC) FILETIME=[0D81DDD0:01CB3976]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 08/11/2010 09:49 AM, Andreas Bießmann wrote:
>   This patch adds an config switch to determine if we need to build some
>   workaround helper files.
>
>   The staging driver octeon-ethernet references some symbols which are only
>   built when PCI is enabled. The new config switch enables these symbols in
>   bothe cases.
>
> Signed-off-by: Andreas Bießmann<biessmann@corscience.de>

Acked-by: David Daney <ddaney@caviumnetworks.com>


> ---
>   arch/mips/cavium-octeon/Kconfig            |    4 ++++
>   arch/mips/cavium-octeon/executive/Makefile |    2 +-
>   2 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
> index 094c17e..47323ca 100644
> --- a/arch/mips/cavium-octeon/Kconfig
> +++ b/arch/mips/cavium-octeon/Kconfig
> @@ -83,3 +83,7 @@ config ARCH_SPARSEMEM_ENABLE
>   	def_bool y
>   	select SPARSEMEM_STATIC
>   	depends on CPU_CAVIUM_OCTEON
> +
> +config CAVIUM_OCTEON_HELPER
> +	def_bool y
> +	depends on OCTEON_ETHERNET || PCI
> diff --git a/arch/mips/cavium-octeon/executive/Makefile b/arch/mips/cavium-octeon/executive/Makefile
> index 2fd66db..7f41c5b 100644
> --- a/arch/mips/cavium-octeon/executive/Makefile
> +++ b/arch/mips/cavium-octeon/executive/Makefile
> @@ -11,4 +11,4 @@
>
>   obj-y += cvmx-bootmem.o cvmx-l2c.o cvmx-sysinfo.o octeon-model.o
>
> -obj-$(CONFIG_PCI) += cvmx-helper-errata.o cvmx-helper-jtag.o
> +obj-$(CONFIG_CAVIUM_OCTEON_HELPER) += cvmx-helper-errata.o cvmx-helper-jtag.o
