Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 18:56:51 +0100 (CET)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:15568 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491194Ab0CCR4q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 18:56:46 +0100
Received: from maexch1.caveonetworks.com (Not Verified[192.168.14.20]) by smtp2.caviumnetworks.com with MailMarshal (v6,5,4,7535)
        id <B4b8ea15c0000>; Wed, 03 Mar 2010 12:50:21 -0500
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by maexch1.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 3 Mar 2010 12:56:43 -0500
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 3 Mar 2010 09:53:06 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 3 Mar 2010 09:53:06 -0800
Message-ID: <4B8EA1FD.5050007@caviumnetworks.com>
Date:   Wed, 03 Mar 2010 09:53:01 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100225 Fedora/3.0.2-1.fc12 Thunderbird/3.0.2
MIME-Version: 1.0
To:     Yang Shi <yang.shi@windriver.com>
CC:     ralf@linux-mips.org, f.fainelli@gmail.com,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] MIPS: Octeon: Remove superfluous on_each_cpu parameter
References: <1267605801-5305-1-git-send-email-yang.shi@windriver.com> <fd8fb199609e60a5b6c10e2073976a3f6b599109.1267604875.git.yang.shi@windriver.com>
In-Reply-To: <fd8fb199609e60a5b6c10e2073976a3f6b599109.1267604875.git.yang.shi@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2010 17:53:06.0861 (UTC) FILETIME=[61300DD0:01CABAFA]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26112
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/03/2010 12:43 AM, Yang Shi wrote:
> Now, on_each_cpu just need three parameters, but the on_each_cpu
> still uses four parameters in Octeon's setup.c. So, remove the
> superfluous parameter.
>
> Signed-off-by: Yang Shi<yang.shi@windriver.com>


NAK!  We are removing CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB completely.

I will send the removal patch soon.

David Daney

> ---
>   arch/mips/cavium-octeon/setup.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index b321d3b..4eaa35f 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -230,7 +230,7 @@ static void octeon_hal_setup_per_cpu_reserved32(void *unused)
>   void octeon_hal_setup_reserved32(void)
>   {
>   #ifdef CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB
> -	on_each_cpu(octeon_hal_setup_per_cpu_reserved32, NULL, 0, 1);
> +	on_each_cpu(octeon_hal_setup_per_cpu_reserved32, NULL, 1);
>   #endif
>   }
>
