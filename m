Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2010 19:46:35 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7189 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492794Ab0LUSqa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Dec 2010 19:46:30 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4d10f2950000>; Tue, 21 Dec 2010 10:31:49 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 21 Dec 2010 10:32:27 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 21 Dec 2010 10:32:26 -0800
Message-ID: <4D10F268.8080706@caviumnetworks.com>
Date:   Tue, 21 Dec 2010 10:31:04 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 3/3] MIPS: Use C0_KScratch (if present) to hold PGD pointer.
References: <1292879828-20493-1-git-send-email-ddaney@caviumnetworks.com> <1292879828-20493-4-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1292879828-20493-4-git-send-email-ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Dec 2010 18:32:26.0975 (UTC) FILETIME=[6AF59EF0:01CBA13D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28666
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 12/20/2010 01:17 PM, David Daney wrote:
> Decide at runtime to use either Context or KScratch to hold the PGD
> pointer.
>
> Signed-off-by: David Daney<ddaney@caviumnetworks.com>
> ---
>   arch/mips/include/asm/mmu_context.h |    8 +--
>   arch/mips/kernel/traps.c            |    2 +-
>   arch/mips/mm/tlbex.c                |  110 +++++++++++++++++++++++++++++++---
>   3 files changed, 102 insertions(+), 18 deletions(-)
>
[...]
>   /* Install CPU exception handler */
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index 6184f0a..2e15aa6 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -26,8 +26,10 @@
>   #include<linux/smp.h>
>   #include<linux/string.h>
>   #include<linux/init.h>
> +#include<linux/cache.h>
>
> -#include<asm/mmu_context.h>

Whoops, that include should stay, it is needed for ip32.

> +#include<asm/cacheflush.h>
> +#include<asm/pgtable.h>
>   #include<asm/war.h>
>   #include<asm/uasm.h>
>[...]

I will send a revised patch.
