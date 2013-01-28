Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2013 13:17:05 +0100 (CET)
Received: from mail-la0-f47.google.com ([209.85.215.47]:51795 "EHLO
        mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833251Ab3A1MRDkPgTN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Jan 2013 13:17:03 +0100
Received: by mail-la0-f47.google.com with SMTP id fj20so740017lab.34
        for <linux-mips@linux-mips.org>; Mon, 28 Jan 2013 04:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=RaiN88RtiFQQVbQM6CfSI7Xr3dxCvIYzL5ig/eauGCs=;
        b=jpwqLMneBT7bAoMH20RjdGS+ZjtzztVHpSMIXFfqGt7wvIh7crYNg+mnWXlbjA/dub
         fWdp7+/I5Kz9IC+6RyFLGv9sMOyxriBDVBVp4aDvJMryDGWcEvlZJzzD9aaNHuvIQJlE
         vWjZYZwfn78OAvK6m03LPpS7vFM2h7oDQjn7CcTcPlFAPWDCgK+67vE+mg5aGEqitjKC
         MY+3qd172S2VjxB+nYZzLPmT2Jia2+ld+fhWwXJJzIqwPeXrPW0b5tOs4GTwqqnPf1rg
         0Vedd1qmm3KSAY6e1+Y+rqFatqp/vZ7eq3WhAcPu4RWhiAoIP9ADXlwsoNQWBSAcRjB6
         DWsw==
X-Received: by 10.112.49.66 with SMTP id s2mr5507497lbn.16.1359375417095;
        Mon, 28 Jan 2013 04:16:57 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-64-122.pppoe.mtu-net.ru. [91.79.64.122])
        by mx.google.com with ESMTPS id fj2sm3545283lbb.6.2013.01.28.04.16.55
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 04:16:55 -0800 (PST)
Message-ID: <51066C27.4070403@mvista.com>
Date:   Mon, 28 Jan 2013 16:16:39 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V3 7/10] MIPS: ralink: adds early_printk support
References: <1359358817-3867-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1359358817-3867-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkOwJyez4sbS0wWKnVqambd68dFSo9EGVaAlUCXlToK1EmCGydbuzEdrMor7t3ybv53ej5h
X-archive-position: 35582
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

On 28-01-2013 11:40, John Crispin wrote:

> Add the code needed to make early printk work.

> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   arch/mips/ralink/early_printk.c |   45 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
>   create mode 100644 arch/mips/ralink/early_printk.c

> diff --git a/arch/mips/ralink/early_printk.c b/arch/mips/ralink/early_printk.c
> new file mode 100644
> index 0000000..68aabb9
> --- /dev/null
> +++ b/arch/mips/ralink/early_printk.c
> @@ -0,0 +1,45 @@
> +/*
> + *  This program is free software; you can redistribute it and/or modify it
> + *  under the terms of the GNU General Public License version 2 as published
> + *  by the Free Software Foundation.
> + *
> + *  Copyright (C) 2011-2012 Gabor Juhos <juhosg@openwrt.org>
> + */
> +
> +#include <linux/io.h>
> +#include <linux/serial_reg.h>
> +
> +#include <asm/addrspace.h>
> +
> +/* UART registers */

    this comment refers to the register #defines below, why it is here?

> +#define EARLY_UART_BASE         0x10000c00
> +
> +#define UART_REG_RX             0x00
> +#define UART_REG_TX             0x04
> +#define UART_REG_IER            0x08
> +#define UART_REG_IIR            0x0c
> +#define UART_REG_FCR            0x10
> +#define UART_REG_LCR            0x14
> +#define UART_REG_MCR            0x18
> +#define UART_REG_LSR            0x1c

WBR, Sergei
