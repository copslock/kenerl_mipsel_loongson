Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2012 13:11:51 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:43914 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823117Ab2KAMLup6Hmi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2012 13:11:50 +0100
Received: by mail-lb0-f177.google.com with SMTP id gi11so1693098lbb.36
        for <linux-mips@linux-mips.org>; Thu, 01 Nov 2012 05:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=qID7ZSdadDLVE23o88UyOwOG8xrA/TAZZeLeckT/RjE=;
        b=l5XEqSAjiTMgGvd76SNYWAZ2iwnaLQcJWBRPGkHIwYzgeFRSa8PJEWXDvulnXCVEGG
         duuZEBHC1Lr5Zeu8WsU9zwBvi391CwmtbZtixcWQAw6HyLz/aq31Abijy0YQ0/RSW1wR
         WK9ejAyo6596AzoC5Pk4c/B7gIpFxo8ToSdNTIzjVDBkbtgV9OpCZqwcmxeiwV0671r6
         spInb99BuIIcRWoQORVjivWky9PMHoser52mUGWkV6X60j8lEW4tyKCCofRK2Umu/m2I
         /MPbnxC+l92Drd0juA6QKlQHtCvyNYHjDL20C8Jw5Su8biRB8S4MZGVPQK6yyKAbCcfd
         sZUw==
Received: by 10.152.106.171 with SMTP id gv11mr37045390lab.26.1351771905158;
        Thu, 01 Nov 2012 05:11:45 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-82-15.pppoe.mtu-net.ru. [91.79.82.15])
        by mx.google.com with ESMTPS id ts2sm2154695lab.10.2012.11.01.05.11.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 05:11:44 -0700 (PDT)
Message-ID: <509266B7.3060107@mvista.com>
Date:   Thu, 01 Nov 2012 16:10:31 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
MIME-Version: 1.0
To:     Sanjay Lal <sanjayl@kymasys.com>
CC:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 14/20] MIPS: Use the UM bit instead of the CU0 enable
 bit in the status register to figure out the stack for  saving regs.
References: <6BC12683-224F-4867-818C-FE4CF722B272@kymasys.com>
In-Reply-To: <6BC12683-224F-4867-818C-FE4CF722B272@kymasys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlpofnPNyulLL4ZoR4PTuLaFDpbi+HzzKaIdCNgDvN9g5DqrrmDEubgQNma3o0l738uSUtH
X-archive-position: 34840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
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

Hello.

On 31-10-2012 19:20, Sanjay Lal wrote:

> Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
> ---
>   arch/mips/include/asm/stackframe.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

> diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
> index cb41af5..59c9245 100644
> --- a/arch/mips/include/asm/stackframe.h
> +++ b/arch/mips/include/asm/stackframe.h
[...]
> @@ -162,9 +162,9 @@
>   		.set	noat
>   		.set	reorder
>   		mfc0	k0, CP0_STATUS
> -		sll	k0, 3		/* extract cu0 bit */
> +		andi    k0,k0,0x10 		/* check user mode bit*/
>   		.set	noreorder
> -		bltz	k0, 8f
> +         beq     k0, $0, 8f

    Use tabs, not spaces to indent the code, same as above.

WBR, Sergei
