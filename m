Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2012 18:03:22 +0100 (CET)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:47317 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903698Ab2A3RDN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Jan 2012 18:03:13 +0100
Received: by yhjj72 with SMTP id j72so1892323yhj.36
        for <multiple recipients>; Mon, 30 Jan 2012 09:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=0Fz3HIz3jZEZlUuClcwvxGbnLR+n2pq8L4fFjgLwGf0=;
        b=qGmZ7W58SFl0re+FZAMdtk1rfcJfXtOh199LNO/Ozbin2Z4PFNh24tgmRaCHzCihTb
         9FYmngUqdL38fgE6EFBkNyQnSfyX8CPw01MF0zkXo0QA1yyPdaBVZtdcW3QlyzQCqj/k
         KN5ImrwUVZSa1o97nfXmlgL30QXneiEIANJdE=
Received: by 10.236.80.39 with SMTP id j27mr27527409yhe.92.1327942987444;
        Mon, 30 Jan 2012 09:03:07 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id i12sm47770903anm.6.2012.01.30.09.03.05
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 09:03:06 -0800 (PST)
Message-ID: <4F26CD48.3040809@gmail.com>
Date:   Mon, 30 Jan 2012 09:03:04 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix duplicate instances of ARCH_SPARSEMEM_ENABLE
References: <0736d2becb10905c35eec74f04c63970@localhost>
In-Reply-To: <0736d2becb10905c35eec74f04c63970@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 32333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 01/28/2012 03:07 PM, Kevin Cernekee wrote:
> "config ARCH_SPARSEMEM_ENABLE" exists in both arch/mips/Kconfig and
> arch/mips/cavium-octeon/Kconfig, but the dependencies are not the same.
> This results in warnings when a non-Cavium platform tries to select
> ARCH_SPARSEMEM_ENABLE:
>
>      $ make lemote2f_defconfig ARCH=mips
>      warning: (LEMOTE_FULOONG2E&&  LEMOTE_MACH2F) selects ARCH_SPARSEMEM_ENABLE which has unmet direct dependencies (CPU_CAVIUM_OCTEON)
>      warning: (LEMOTE_FULOONG2E&&  LEMOTE_MACH2F) selects ARCH_SPARSEMEM_ENABLE which has unmet direct dependencies (CPU_CAVIUM_OCTEON)
>      #
>      # configuration written to .config
>      #
>
> Proposed workaround is to use a Cavium-specific config option which
> "select"s the desired options.
>
> Signed-off-by: Kevin Cernekee<cernekee@gmail.com>
> ---
>   arch/mips/cavium-octeon/Kconfig |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
> index f9e275a..eda8266 100644
> --- a/arch/mips/cavium-octeon/Kconfig
> +++ b/arch/mips/cavium-octeon/Kconfig
> @@ -82,8 +82,9 @@ config CAVIUM_OCTEON_LOCK_L2_MEMCPY
>   	help
>   	  Lock the kernel's implementation of memcpy() into L2.
>
> -config ARCH_SPARSEMEM_ENABLE
> +config CAVIUM_OCTEON_SPARSEMEM_ENABLE
>   	def_bool y
> +	select ARCH_SPARSEMEM_ENABLE
>   	select SPARSEMEM_STATIC
>
>   config IOMMU_HELPER

NAK!

A cleaner patch for this was already done here:

http://patchwork.linux-mips.org/patch/3285/
