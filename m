Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Oct 2013 14:29:51 +0200 (CEST)
Received: from mail-la0-f52.google.com ([209.85.215.52]:37954 "EHLO
        mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824926Ab3JOM3pVJj08 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Oct 2013 14:29:45 +0200
Received: by mail-la0-f52.google.com with SMTP id ev20so6574446lab.25
        for <linux-mips@linux-mips.org>; Tue, 15 Oct 2013 05:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=olKljBBSPnHO8QuJqahZ0tDZHnCoHmqXXVwHhMa19js=;
        b=hCR6vlppiS8R6Se3/KGH55V0Lr8Bv89vOdEsuL64c6bTLFgyWF0Cqs1thUoSh7rxIZ
         /bOP85EwMVbhR8Efmb/NtGryKBkTdzp/YMgzGOVvavrIAyTNLcWtV/nwLrUbeU1QY8PG
         x8gGyDTq1YzbLQ0xK2R42yS8IgSMi0/FCRPydQOcG3ZscgXPLzg/sM966+mn7Qvtx+7R
         wxOCYpPEXPeQHAPdSpE3pYGCuHsP3aN2ldBcc9PvuSmjaZuIUehlIwNcaVxYSRWnSGIw
         jqNqbsVqVUMb1zeCbEvUmvexinrD7bQI99w5Lq6LEKIIFQEubLqQCCHLeRlCByMia9w9
         ePxQ==
X-Gm-Message-State: ALoCoQnVX9qAe98I6aSeRXUFVcAbuCRxJh+X2aRxoUPxkdc1A1X7n7ebqlgUkNqM2ZN+WeYy9mNW
X-Received: by 10.112.168.170 with SMTP id zx10mr34844845lbb.0.1381840179680;
        Tue, 15 Oct 2013 05:29:39 -0700 (PDT)
Received: from [192.168.2.4] (ppp83-237-56-125.pppoe.mtu-net.ru. [83.237.56.125])
        by mx.google.com with ESMTPSA id b1sm64527181lah.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 05:29:39 -0700 (PDT)
Message-ID: <525D34F4.80807@cogentembedded.com>
Date:   Tue, 15 Oct 2013 16:28:36 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
MIME-Version: 1.0
To:     Jayachandran C <jchandra@broadcom.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 17/18] MIPS: Netlogic: XLP9XX PIC OF support
References: <1381756874-22616-1-git-send-email-jchandra@broadcom.com> <1381756874-22616-18-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1381756874-22616-18-git-send-email-jchandra@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38344
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

On 14-10-2013 17:21, Jayachandran C wrote:

> Support for adding legacy IRQ domain for XLP9XX. The node id of the
> PIC has to be calulated differently for XLP9XX.

> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
>   arch/mips/netlogic/common/irq.c |   28 ++++++++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)

> diff --git a/arch/mips/netlogic/common/irq.c b/arch/mips/netlogic/common/irq.c
> index 8092bb3..34be9bb 100644
> --- a/arch/mips/netlogic/common/irq.c
> +++ b/arch/mips/netlogic/common/irq.c
[...]
> @@ -293,7 +292,28 @@ static int __init xlp_of_pic_init(struct device_node *node,
>   		pr_err("PIC %s: reg property not found!\n", node->name);
>   		return -EINVAL;
>   	}
> -	socid = (res.start >> 18) & 0x3;
> +
> +	if (cpu_is_xlp9xx()) {
> +		bus = (res.start >> 20) & 0xf;
> +		for (socid = 0; socid < NLM_NR_NODES; socid++) {
> +			if (!nlm_node_present(socid))
> +				continue;
> +			if (nlm_get_node(socid)->socbus == bus)
> +				break;
> +		}
> +		if (socid == NLM_NR_NODES) {
> +			pr_err("PIC %s: Node mapping for bus %d not found!n",
> +					node->name, bus);
> +			return -EINVAL;
> +		}
> +	} else
> +		socid = (res.start >> 18) & 0x3;

    Both arms of the *if* statement should have {} if one arm has it, 
according to Documentation/CodingStyle.

WBR, Sergei
