Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 11:49:15 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:39531 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903711Ab1KUKtK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2011 11:49:10 +0100
Received: by bkat2 with SMTP id t2so8428521bka.36
        for <multiple recipients>; Mon, 21 Nov 2011 02:49:03 -0800 (PST)
Received: by 10.204.148.4 with SMTP id n4mr13966846bkv.42.1321872543565;
        Mon, 21 Nov 2011 02:49:03 -0800 (PST)
Received: from [192.168.2.2] (ppp85-141-190-27.pppoe.mtu-net.ru. [85.141.190.27])
        by mx.google.com with ESMTPS id j9sm6950544bkd.2.2011.11.21.02.49.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 02:49:02 -0800 (PST)
Message-ID: <4ECA2C67.9040406@mvista.com>
Date:   Mon, 21 Nov 2011 14:48:07 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     Hillf Danton <dhillf@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        "Jayachandran C." <jayachandranc@netlogicmicro.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Flush huge TLB
References: <CAJd=RBBTx8zWrFfVQGMK=aj=iPO_+i6nvqkhGDfYp_9=d1hyEw@mail.gmail.com>
In-Reply-To: <CAJd=RBBTx8zWrFfVQGMK=aj=iPO_+i6nvqkhGDfYp_9=d1hyEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17123

Hello.

On 18-11-2011 17:15, Hillf Danton wrote:

> When flushing TLB, if @vma is backed by huge page, we could flush huge TLB,
> due to that huge page is defined to be far from normal page.

> Signed-off-by: Hillf Danton<dhillf@gmail.com>
> ---

> --- a/arch/mips/mm/tlb-r4k.c	Mon May 30 21:17:04 2011
> +++ b/arch/mips/mm/tlb-r4k.c	Fri Nov 18 21:13:13 2011
> @@ -120,22 +120,30 @@ void local_flush_tlb_range(struct vm_are
[...]
>   				write_c0_entryhi(start | newpid);
> -				start += (PAGE_SIZE<<  1);
> +				if (huge)
> +					start += HPAGE_SIZE;
> +				else
> +					start += (PAGE_SIZE << 1);

    Parens not needed.

WBR, Sergei
