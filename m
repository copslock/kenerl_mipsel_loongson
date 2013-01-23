Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jan 2013 23:16:03 +0100 (CET)
Received: from mail-la0-f45.google.com ([209.85.215.45]:61349 "EHLO
        mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833417Ab3AWWP7y4KLp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jan 2013 23:15:59 +0100
Received: by mail-la0-f45.google.com with SMTP id er20so3902194lab.18
        for <linux-mips@linux-mips.org>; Wed, 23 Jan 2013 14:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=SiHjIkCKqNv5pYtnPgNoQokMiie+lB+ESx28Q5B0v7o=;
        b=LHSslhHzLGhQfMQIeOBShgMhMkc1YiHyA0fIC5vQsD2izWtfIgaKbTEyol30minHO7
         KE/Ix5CuhUdXJiA6AmZ1k/MQ7li1Bh2mZV3gTbobUyfg4rsj6nZCAHHZelnOJ+xTW+Ga
         ZwTei0r82/SgIQzXQfVznG9Em2J0AD5BAkRneyVdpNGJ986ZPGXsjHYz1Av0a2ff0HY4
         sIdRG0rjTnJNnzvYYeDtQhK2+bhpq61VVUsb6erCIboLmMWTCJYyjBXAszeiah7GM3dm
         8ux7qjbdOPUnvukhcDajWh9XDMUcz3I+ry7SV+j6YExtlbHEq2WxuvJZDyCLsx2XDT52
         LIkA==
X-Received: by 10.112.48.130 with SMTP id l2mr1359064lbn.44.1358979352630;
        Wed, 23 Jan 2013 14:15:52 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-77-250.pppoe.mtu-net.ru. [91.79.77.250])
        by mx.google.com with ESMTPS id f8sm8905876lbg.2.2013.01.23.14.15.50
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 14:15:51 -0800 (PST)
Message-ID: <5100610A.80609@mvista.com>
Date:   Thu, 24 Jan 2013 02:15:38 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC 08/11] MIPS: ralink: adds early_printk support
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org> <1358942755-25371-9-git-send-email-blogic@openwrt.org>
In-Reply-To: <1358942755-25371-9-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnZNF0CsE43zbuKblWJuwuQ7Tj8wvVu+jnWY1F4fh//ppBO4TMeNgPG450ASiSaCPdmXpWL
X-archive-position: 35524
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

On 23-01-2013 16:05, John Crispin wrote:

> Add the code needed to make early printk work.

> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   arch/mips/ralink/early_printk.c |   43 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
>   create mode 100644 arch/mips/ralink/early_printk.c

> diff --git a/arch/mips/ralink/early_printk.c b/arch/mips/ralink/early_printk.c
> new file mode 100644
> index 0000000..c610084
> --- /dev/null
> +++ b/arch/mips/ralink/early_printk.c
> @@ -0,0 +1,43 @@
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

    BTW, I don't see that file in the current Linus' tree... and in linux-next 
too.

WBR, Sergei
