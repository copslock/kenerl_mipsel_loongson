Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Apr 2013 09:15:41 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:48947 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819780Ab3DKHOT35uH0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Apr 2013 09:14:19 +0200
Message-ID: <516661DA.4020205@openwrt.org>
Date:   Thu, 11 Apr 2013 09:10:18 +0200
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: move mips_{set,get}_machine_name() to a more generic
 place
References: <1365662099-3981-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1365662099-3981-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

On 11/04/13 08:34, John Crispin wrote:
> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> index 7a54f74..fcdedfb 100644
> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c
> @@ -12,6 +12,7 @@
>   #include<asm/cpu-features.h>
>   #include<asm/mipsregs.h>
>   #include<asm/processor.h>
> +#include<asm/prom.h>
>   #include<asm/mips_machine.h>
>   
we should really remove <asm/mips_machine.h>  ...

     John
