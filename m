Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Sep 2011 21:50:58 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:16832 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492047Ab1IZTux (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Sep 2011 21:50:53 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e80d7e00000>; Mon, 26 Sep 2011 12:52:00 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 26 Sep 2011 12:50:45 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 26 Sep 2011 12:50:44 -0700
Message-ID: <4E80D794.3040701@cavium.com>
Date:   Mon, 26 Sep 2011 12:50:44 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     rongqing.li@windriver.com, netdev@vger.kernel.org,
        ralf@linux-mips.org, David Miller <davem@davemloft.net>
CC:     linux-mips@linux-mips.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH] staging/octeon: Software should check the checksum of
 no tcp/udp packets
References: <1316999280-11999-1-git-send-email-rongqing.li@windriver.com>
In-Reply-To: <1316999280-11999-1-git-send-email-rongqing.li@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Sep 2011 19:50:44.0968 (UTC) FILETIME=[946EB680:01CC7C85]
X-archive-position: 31168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 14909

On 09/25/2011 06:08 PM, rongqing.li@windriver.com wrote:
> From: Roy.Li<rongqing.li@windriver.com>
>
> Icmp packets with wrong checksum are never dropped since
> skb->ip_summed is set to CHECKSUM_UNNECESSARY.
>
> When icmp packets with wrong checksum pass through the octeon
> net driver, the not_IP, IP_exc, L4_error hardware indicators
> show no error. so the driver sets CHECKSUM_UNNECESSARY on
> skb->ip_summed.
>
> L4_error only works for TCP/UDP, not for ICMP.
>
> Signed-off-by: Roy.Li<rongqing.li@windriver.com>

We found the same problem, but have not yet sent the patch to fix it.

This looks fine to me,

Acked-by: David Daney <david.daney@cavium.com>

I would let davem, Ralf and Greg KH fight over who gets to merge it.

David Daney

> ---
>   drivers/staging/octeon/ethernet-rx.c |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
> index 1a7c19a..1747024 100644
> --- a/drivers/staging/octeon/ethernet-rx.c
> +++ b/drivers/staging/octeon/ethernet-rx.c
> @@ -411,7 +411,8 @@ static int cvm_oct_napi_poll(struct napi_struct *napi, int budget)
>   				skb->protocol = eth_type_trans(skb, dev);
>   				skb->dev = dev;
>
> -				if (unlikely(work->word2.s.not_IP || work->word2.s.IP_exc || work->word2.s.L4_error))
> +				if (unlikely(work->word2.s.not_IP || work->word2.s.IP_exc ||
> +					work->word2.s.L4_error || !work->word2.s.tcp_or_udp))
>   					skb->ip_summed = CHECKSUM_NONE;
>   				else
>   					skb->ip_summed = CHECKSUM_UNNECESSARY;
