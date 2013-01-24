Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Jan 2013 08:00:17 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:44728 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6832072Ab3AXHAQQwsmI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 Jan 2013 08:00:16 +0100
Message-ID: <5100DB68.20903@phrozen.org>
Date:   Thu, 24 Jan 2013 07:57:44 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [RFC 08/11] MIPS: ralink: adds early_printk support
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org> <1358942755-25371-9-git-send-email-blogic@openwrt.org> <5100610A.80609@mvista.com>
In-Reply-To: <5100610A.80609@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35525
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 23/01/13 23:15, Sergei Shtylyov wrote:
> Hello.
>
> On 23-01-2013 16:05, John Crispin wrote:
>
>> Add the code needed to make early printk work.
>
>> Signed-off-by: John Crispin <blogic@openwrt.org>
>> ---
>> arch/mips/ralink/early_printk.c | 43
>> +++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 43 insertions(+)
>> create mode 100644 arch/mips/ralink/early_printk.c
>
>> diff --git a/arch/mips/ralink/early_printk.c
>> b/arch/mips/ralink/early_printk.c
>> new file mode 100644
>> index 0000000..c610084
>> --- /dev/null
>> +++ b/arch/mips/ralink/early_printk.c
>> @@ -0,0 +1,43 @@
>> +/*
>> + * This program is free software; you can redistribute it and/or
>> modify it
>> + * under the terms of the GNU General Public License version 2 as
>> published
>> + * by the Free Software Foundation.
>> + *
>> + * Copyright (C) 2011-2012 Gabor Juhos <juhosg@openwrt.org>
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/serial_reg.h>
>
> BTW, I don't see that file in the current Linus' tree... and in
> linux-next too.
>
> WBR, Sergei
>
>
>
Hi,

./include/uapi/linux/serial_reg.h

if i recall correctly they differ to the defaults. all the defines were 
added as reference even if only a few are used. i will have a closer 
look at this today

	John
