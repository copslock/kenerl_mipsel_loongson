Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 12 Aug 2012 08:21:16 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:53718 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1901166Ab2HLGVN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 12 Aug 2012 08:21:13 +0200
Message-ID: <50274B1D.7070309@phrozen.org>
Date:   Sun, 12 Aug 2012 08:20:13 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH V5 10/18] MIPS: Loongson: Add Loongson-3 Kconfig options.
References: <1344677543-22591-1-git-send-email-chenhc@lemote.com> <1344677543-22591-11-git-send-email-chenhc@lemote.com>
In-Reply-To: <1344677543-22591-11-git-send-email-chenhc@lemote.com>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34116
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 11/08/12 11:32, Huacai Chen wrote:
> Added Kconfig options include: Loongson-3 CPU and machine definition,
> UEFI-like firmware interface, HT-linked PCI, big memory support, etc.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Hongliang Tao <taohl@lemote.com>
> Signed-off-by: Hua Yan <yanh@lemote.com>
> ---
>  arch/mips/Kconfig          |   22 ++++++++++++++++++
>  arch/mips/loongson/Kconfig |   52 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 331d574..9e8e86c 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1571,6 +1571,16 @@ config CPU_LOONGSON2
>  	select CPU_SUPPORTS_64BIT_KERNEL
>  	select CPU_SUPPORTS_HIGHMEM
>  
> +config CPU_LOONGSON3
> +	bool "Loongson 3 CPU"
> +	depends on SYS_HAS_CPU_LOONGSON3
> +	select CPU_SUPPORTS_32BIT_KERNEL
> +	select CPU_SUPPORTS_64BIT_KERNEL
> +	select CPU_SUPPORTS_HIGHMEM
> +	help
> +		The Loongson 3 processor implements the MIPS III instruction set
> +		with many extensions.
> +
>  config CPU_LOONGSON1
>  	bool
>  	select CPU_MIPS32
> @@ -1597,6 +1607,9 @@ config SYS_HAS_CPU_LOONGSON2F
>  	select CPU_SUPPORTS_ADDRWINCFG if 64BIT
>  	select CPU_SUPPORTS_UNCACHED_ACCELERATED
>  
> +config SYS_HAS_CPU_LOONGSON3
> +	bool
> +

It look slike this series uses the SYS_HAS_CPU_LOONGSON3 symbol only as
a proxy to select CPU_LOONGSON3. I can so no other references.
LEMOTE_MACH3A can select CPU_LOONGSON3 direclty ?
