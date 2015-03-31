Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Mar 2015 13:54:06 +0200 (CEST)
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:40209 "EHLO
        ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006154AbbCaLyEd08NK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 Mar 2015 13:54:04 +0200
Received: from localhost (localhost [127.0.0.1])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id AEB0846074E
        for <linux-mips@linux-mips.org>; Tue, 31 Mar 2015 12:53:59 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
        by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oRFBcigjSQse; Tue, 31 Mar 2015 12:53:57 +0100 (BST)
Received: from [10.24.2.193] (rainbowdash.dyn.ducie.codethink.co.uk [10.24.2.193])
        by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id B58234605F5;
        Tue, 31 Mar 2015 12:53:57 +0100 (BST)
Message-ID: <551A8AD5.8000509@codethink.co.uk>
Date:   Tue, 31 Mar 2015 12:53:57 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
MIME-Version: 1.0
To:     Paul Martin <paul.martin@codethink.co.uk>,
        linux-mips@linux-mips.org
Subject: Re: [Linux-kernel] [PATCH 10/10] MIPS: OCTEON: Fix Kconfig file typo
References: <1427731263-29950-1-git-send-email-paul.martin@codethink.co.uk> <1427731263-29950-11-git-send-email-paul.martin@codethink.co.uk>
In-Reply-To: <1427731263-29950-11-git-send-email-paul.martin@codethink.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <ben.dooks@codethink.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben.dooks@codethink.co.uk
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

On 30/03/15 17:01, Paul Martin wrote:
> Signed-off-by: Paul Martin <paul.martin@codethink.co.uk>
> ---
>  arch/mips/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 68e64cb..c4d0229 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -780,7 +780,7 @@ config CAVIUM_OCTEON_SOC
>  	select SYS_SUPPORTS_BIG_ENDIAN
>  	select EDAC_SUPPORT
>  	select SYS_SUPPORTS_LITTLE_ENDIAN
> -	select SYS_SUPPORTS_HOTPLUG_CPU if CONFIG_CPU_BIG_ENDIAN
> +	select SYS_SUPPORTS_HOTPLUG_CPU if CPU_BIG_ENDIAN
>  	select SYS_HAS_EARLY_PRINTK
>  	select SYS_HAS_CPU_CAVIUM_OCTEON
>  	select SWAP_IO_SPACE
> 

merge back into previous commit?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
