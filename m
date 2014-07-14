Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2014 13:33:15 +0200 (CEST)
Received: from mail-lb0-f175.google.com ([209.85.217.175]:61216 "EHLO
        mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860083AbaGNLdLjWFU1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2014 13:33:11 +0200
Received: by mail-lb0-f175.google.com with SMTP id n15so2663159lbi.20
        for <linux-mips@linux-mips.org>; Mon, 14 Jul 2014 04:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:organization:user-agent
         :mime-version:to:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Ds+ut0vChX/VBGohC8pKeFzgoM5J4H98o23zyJqBOnU=;
        b=hVQtO0XcAeMei2OarftE1sJNGe/EDWFGKkXfVThXpL6MQiIyW7Xwe3rj7UGdWyC+P4
         atvSmyHgb3AgkQvwuWBXC8XlYMOEB9n24Db1VqZMGfGqpaJeGkUk1O9aLWy5qiUr9NOV
         6qeWD1a7N0gY6wSjTvs6B1hrQcRIYWxh37CInoSr3q1AD4bE10gW/aVzL+B7PMIA1Y2I
         ma7yYeHzUmPDWXkdmklpcgbCyu4O4X9TEaUG4F1QkvnBrOFILzFcutkTtzvUQJvAtpVc
         TNdRv91H7RTF9c/DHCb5xiwkOmroltcj4C07MlXsUE0cLXWU9JOfMNFysgGo17Ifna/s
         iwdw==
X-Gm-Message-State: ALoCoQk7XTxAsyMhVI03TJg18F6Tspq1l7ul2BtCfO0Y52UleWopnpqhBqorOOhAeOVn+hes4o0N
X-Received: by 10.112.88.202 with SMTP id bi10mr13181955lbb.4.1405337585567;
        Mon, 14 Jul 2014 04:33:05 -0700 (PDT)
Received: from wasted.cogentembedded.com (ppp83-237-249-70.pppoe.mtu-net.ru. [83.237.249.70])
        by mx.google.com with ESMTPSA id v4sm5226687lav.44.2014.07.14.04.33.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 14 Jul 2014 04:33:04 -0700 (PDT)
Message-ID: <53C3BFF3.8050004@cogentembedded.com>
Date:   Mon, 14 Jul 2014 15:33:07 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 4/4] MIPS: Malta: initialise MAARs
References: <1405330336-18167-1-git-send-email-paul.burton@imgtec.com> <1405330336-18167-5-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1405330336-18167-5-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 07/14/2014 01:32 PM, Paul Burton wrote:

> Initialise the MAARs such that speculation is enabled for all physical
> addresses outside of the I/O region.

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
>   arch/mips/mti-malta/malta-memory.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)

> diff --git a/arch/mips/mti-malta/malta-memory.c b/arch/mips/mti-malta/malta-memory.c
> index 6d97730..e96803d 100644
> --- a/arch/mips/mti-malta/malta-memory.c
> +++ b/arch/mips/mti-malta/malta-memory.c
[...]
> @@ -164,3 +165,28 @@ void __init prom_free_prom_memory(void)
>   				addr, addr + boot_mem_map.map[i].size);
>   	}
>   }
> +
> +unsigned platform_maar_init(unsigned num_pairs)
> +{
> +	phys_addr_t mem_end = (physical_memsize & ~0xffffull) - 1;
> +	struct maar_config cfg[] = {
> +		/* DRAM preceeding I/O */

    Perhaps "preceding"?

WBR, Sergei
