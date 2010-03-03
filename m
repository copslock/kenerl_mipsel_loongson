Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 19:25:56 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19299 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491194Ab0CCSZw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 19:25:52 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b8ea9b70002>; Wed, 03 Mar 2010 10:25:59 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 3 Mar 2010 10:25:50 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 3 Mar 2010 10:25:50 -0800
Message-ID: <4B8EA9AD.8070106@caviumnetworks.com>
Date:   Wed, 03 Mar 2010 10:25:49 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100225 Fedora/3.0.2-1.fc12 Thunderbird/3.0.2
MIME-Version: 1.0
To:     Yang Shi <yang.shi@windriver.com>, ralf@linux-mips.org
CC:     f.fainelli@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/3] MIPS: Octeon: Remove redundant declaration of octeon_reserve32_memory
References: <1267605801-5305-1-git-send-email-yang.shi@windriver.com> <fd8fb199609e60a5b6c10e2073976a3f6b599109.1267604875.git.yang.shi@windriver.com> <50e36e8549769a26986f99a23772d23fd039c230.1267604875.git.yang.shi@windriver.com>
In-Reply-To: <50e36e8549769a26986f99a23772d23fd039c230.1267604875.git.yang.shi@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2010 18:25:50.0029 (UTC) FILETIME=[F353B7D0:01CABAFE]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/03/2010 12:43 AM, Yang Shi wrote:
> In Octeon's setup.c, octeon_reserve32_memory is defined, so remove the
> redundant extern declaration of this variable.
>
> Signed-off-by: Yang Shi<yang.shi@windriver.com>

Acked-by: David Daney <ddaney@caviumnetworks.com>

This looks good to me.  Thanks,
David Daney

> ---
>   arch/mips/cavium-octeon/setup.c |    3 ---
>   1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index 4eaa35f..8309d68 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -45,9 +45,6 @@ extern struct plat_smp_ops octeon_smp_ops;
>   extern void pci_console_init(const char *arg);
>   #endif
>
> -#ifdef CONFIG_CAVIUM_RESERVE32
> -extern uint64_t octeon_reserve32_memory;
> -#endif
>   static unsigned long long MAX_MEMORY = 512ull<<  20;
>
>   struct octeon_boot_descriptor *octeon_boot_desc_ptr;
