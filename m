Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Dec 2004 00:58:31 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:21495 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8226189AbULBA60>; Thu, 2 Dec 2004 00:58:26 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 55FB61871B; Wed,  1 Dec 2004 16:58:19 -0800 (PST)
Message-ID: <41AE68AB.8010801@mvista.com>
Date: Wed, 01 Dec 2004 16:58:19 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] 2.4: Preemption fixes for Broadcom DMA Page operations
References: <20041202003308.GA13085@prometheus.mvista.com> <Pine.LNX.4.58L.0412020041420.20966@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0412020041420.20966@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hi Maciej,

Maciej W. Rozycki wrote:
> On Wed, 1 Dec 2004, Manish Lachwani wrote:
> 
> 
>>The attached patch implements preempt_disable/preempt_enable around the
>>SB1 DMA page operations. Please review ...
> 
> 
>  Why is it needed?
> 
>  Also I think these:
> 
> -   if [ "$CONFIG_SIBYTE_SB1250" = "y" ]; then
> +   if [ "$CONFIG_SIBYTE_BOARD" = "y" ]; then
> 
> are unrelated and inaccurate.  The devices are internal to the SoCs and 
> not strictly board-dependent.  How about:
> 
> +   if [ "$CONFIG_SIBYTE_SB1250" = "y" || "$CONFIG_SIBYTE_BCM112X" = "y"]; then

Actually, this makes more sense. I will send a new patch

Thanks
Manish Lachwani

> 
> at the very least, or perhaps using reverse dependencies?
> 
>  Maciej
