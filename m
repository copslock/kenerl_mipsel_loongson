Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jul 2012 18:05:52 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:55498 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903474Ab2GVQFo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Jul 2012 18:05:44 +0200
Received: by lbbgg6 with SMTP id gg6so7299661lbb.36
        for <linux-mips@linux-mips.org>; Sun, 22 Jul 2012 09:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=KB/4yX0raSZ+EgCIhPLBcvEiLSv/mY5gsQNiZNeLuqM=;
        b=mg6789Rt51jpoFyhb314o9aUxIMIeJnYSoUoBJQA3bgoG5+Kho4bRc3Vh2JwUklzGZ
         RjqjDOcQPzRLj1s/b7Yp7n8Plr61nEplAQpHnRfOYSSpz7EOD+KT2rPbyGD5+NxRNufG
         VbyX1yTzTPi+ZOhrmY2+oWcJqJ9gORcdvgTnwQHpSmkXt1CiiR9bZNfudkid3MryPolf
         sD6+UooDE+wtA43b52xRCtTbih8HcnqVnSsaDA5smP9lblNXIF609ZiXWfE2FeLMNkw/
         n0j8leAGlDFGjFQRDeiBpeznntPkkpWwqqgmWcpsHQfyCL3P39VcniObsrpOK5VRWt46
         D2Og==
Received: by 10.152.112.138 with SMTP id iq10mr13579173lab.13.1342973139044;
        Sun, 22 Jul 2012 09:05:39 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-65-231.pppoe.mtu-net.ru. [91.79.65.231])
        by mx.google.com with ESMTPS id n7sm2290759lbk.10.2012.07.22.09.05.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 09:05:37 -0700 (PDT)
Message-ID: <500C2498.1010609@mvista.com>
Date:   Sun, 22 Jul 2012 20:04:40 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] MIPS: lantiq: add helper to set PCI clock delay
References: <1342940161-1421-1-git-send-email-blogic@openwrt.org> <1342940161-1421-2-git-send-email-blogic@openwrt.org>
In-Reply-To: <1342940161-1421-2-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQl3/JdrpNDmueqMZ2FtT4j3eIE+wV8h3pKKtwSZbc4xrNnhJ4/Kcy7r9UA69Qx5GFcTzHKy
X-archive-position: 33954
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

On 22-07-2012 10:55, John Crispin wrote:

> The PCI core has a register that allows us to set the nanosecond delay of the
> PCI clock lane. This patch adds a helper function to allow setting this value.

> Signed-off-by: John Crispin <blogic@openwrt.org>
[...]

> diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
> index befbb76..91bb435 100644
> --- a/arch/mips/lantiq/xway/sysctrl.c
> +++ b/arch/mips/lantiq/xway/sysctrl.c
[...]
> @@ -258,6 +262,16 @@ static void clkdev_add_pci(void)
>   	clkdev_add(&clk_ext->cl);
>   }
>
> +/* allow PCI driver to specify the clock delay. This is a 6 bit value */

    WHy make it 'u32' then?

> +void ltq_pci_set_delay(u32 delay)
> +{
> +	u32 val = ltq_cgu_r32(pcicr);
> +
> +	val &= ~(PCI_DLY_MASK << PCI_DLY_SHIFT);
> +	val |= (delay & PCI_DLY_MASK) << PCI_DLY_SHIFT;
> +	ltq_cgu_w32(val, pcicr);
> +}
> +

WBR, Sergei
