Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 19:34:06 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:54132 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835071Ab3DLReGBZd0z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 12 Apr 2013 19:34:06 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id p3wMPhCCjcS8; Fri, 12 Apr 2013 19:33:18 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id D33332848BB;
        Fri, 12 Apr 2013 19:33:18 +0200 (CEST)
Message-ID: <516845AB.8080109@openwrt.org>
Date:   Fri, 12 Apr 2013 19:34:35 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: move mips_{set,get}_machine_name() to a more generic
 place
References: <1365662099-3981-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1365662099-3981-1-git-send-email-blogic@openwrt.org>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2013.04.11. 8:34 keltezéssel, John Crispin írta:
> Previously this functionality was only available to users of the mips_machine
> api. Moving the code to prom.c allows us to also add a OF wrapper.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>  arch/mips/include/asm/mips_machine.h |    4 ----
>  arch/mips/include/asm/prom.h         |    3 +++
>  arch/mips/kernel/mips_machine.c      |   20 --------------------
>  arch/mips/kernel/proc.c              |    1 +
>  arch/mips/kernel/prom.c              |   33 +++++++++++++++++++++++++++++++++
>  5 files changed, 37 insertions(+), 24 deletions(-)
> 

<...>

> diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
> index 028f6f8..9d653e1 100644
> --- a/arch/mips/kernel/prom.c
> +++ b/arch/mips/kernel/prom.c
> @@ -23,6 +23,21 @@
>  #include <asm/page.h>
>  #include <asm/prom.h>
>  
> +static char mips_machine_name[64] = "Unknown";
> +
> +__init void mips_set_machine_name(const char *name)
> +{
> +	if (name == NULL)
> +		return;
> +
> +	snprintf(mips_machine_name, sizeof(mips_machine_name), name);

Any specific reason why you are using snprintf? If someone would call this with
format characters in the 'name' that would cause weird things.

-Gabor
