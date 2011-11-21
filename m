Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 15:37:15 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:61601 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903761Ab1KUOhE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2011 15:37:04 +0100
Received: by bkat2 with SMTP id t2so8721291bka.36
        for <multiple recipients>; Mon, 21 Nov 2011 06:36:58 -0800 (PST)
Received: by 10.205.121.1 with SMTP id ga1mr12228818bkc.60.1321886218081;
        Mon, 21 Nov 2011 06:36:58 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id hy13sm7480790bkc.0.2011.11.21.06.36.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 06:36:57 -0800 (PST)
Message-ID: <4ECA6FE7.6070602@mvista.com>
Date:   Mon, 21 Nov 2011 18:36:07 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:6.0) Gecko/20110812 Thunderbird/6.0
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2] NET: MIPS: lantiq: return value of request_irq was
 not handled gracefully
References: <1321882291-13062-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1321882291-13062-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17350

Hello.

On 11/21/2011 04:31 PM, John Crispin wrote:

> The return values of request_irq() were not checked leading to the following
> error message.

> drivers/net/ethernet/lantiq_etop.c: In function 'ltq_etop_hw_init':
> drivers/net/ethernet/lantiq_etop.c:368:15: warning: ignoring return value of 'request_irq', declared with attribute warn_unused_result
> drivers/net/ethernet/lantiq_etop.c:377:15: warning: ignoring return value of 'request_irq', declared with attribute warn_unused_result

> Signed-off-by: John Crispin<blogic@openwrt.org>
> Acked-by: David S. Miller<davem@davemloft.net>
> ---
> Changes in V2:
> * drop IRQF_DISABLED

   This should have been noted in the patch description...

WBR, Sergei
