Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jun 2014 00:44:57 +0200 (CEST)
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36516 "EHLO
        mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822081AbaFQWoyHhYbb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Jun 2014 00:44:54 +0200
Received: by mail-ie0-f169.google.com with SMTP id at1so23408iec.14
        for <multiple recipients>; Tue, 17 Jun 2014 15:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=TeJ52l4Zs2cXk1VUAEBg3pchR2oIIF6o6fEkOPbo2ik=;
        b=f2BYa6Dj7L0Cf0/j19E1NLEhnNy638oWlvxI34MgE4u/iqVYUYy8b4+XJDQKPQo5+0
         gDEbjjMLMNM1StrKBifUc01WG7Lh0b9pMmyqPKBVgDv5Pbl29oCIYLj01sh1iH75iejj
         E0sPMpzND1CBOHSF4f3SrXm8WQYJlOPzyk4l7jP/GWlZw9j8CaOsLxjNpGpLY3bjEoZX
         BhHF6YFZ+evCkSIT3m4bup3CnPp5fvLwtoNPaiJrHH5OdErlAmFmH2GHlg+vTfcnDGoi
         lcl/qZRn4reZ+ddT1337QA5yFH1Dm3geSMkG4wX8L99ru0ImYj4oiNKNOiyTr7ifae/H
         7h/A==
X-Received: by 10.43.66.202 with SMTP id xr10mr5567551icb.77.1403045087785;
        Tue, 17 Jun 2014 15:44:47 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id uu8sm1183211igb.13.2014.06.17.15.44.46
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 17 Jun 2014 15:44:47 -0700 (PDT)
Message-ID: <53A0C4DE.6000408@gmail.com>
Date:   Tue, 17 Jun 2014 15:44:46 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/3] MIPS: OCTEON: disable SMP if the bootloader version
 is incorrect
References: <1402949190-28182-1-git-send-email-aaro.koskinen@iki.fi> <1402949190-28182-3-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1402949190-28182-3-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 06/16/2014 01:06 PM, Aaro Koskinen wrote:
> Disable SMP if the bootloader version is incorrect for HOTPLUG_CPU.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

NAK to this one.


> ---
>   arch/mips/cavium-octeon/smp.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/smp.c b/arch/mips/cavium-octeon/smp.c
> index ea96930..71f5505 100644
> --- a/arch/mips/cavium-octeon/smp.c
> +++ b/arch/mips/cavium-octeon/smp.c
> @@ -88,8 +88,10 @@ static void octeon_smp_hotplug_setup(void)
>   		return;
>
>   	labi = (struct linux_app_boot_info *)PHYS_TO_XKSEG_CACHED(LABI_ADDR_IN_BOOTLOADER);
> -	if (labi->labi_signature != LABI_SIGNATURE)
> -		panic("The bootloader version on this board is incorrect.");
> +	if (labi->labi_signature != LABI_SIGNATURE) {
> +		setup_max_cpus = 0;
> +		WARN(1, "Disabling SMP - the bootloader version on this board does not support HOTPLUG_CPU.");
> +	}

We really want to allow SMP, but just disable hot-plugging in the case 
that the bootloader magic is missing.  This is not what setup_max_cpus 
is for.

I would prefer to see a separate variable that indicated ability to 
hot-plug, and have that be used to gate both the watchdog things as well 
as octeon_cpu_disable().


>
>   	octeon_bootloader_entry_addr = labi->InitTLBStart_addr;
>   #endif
>
