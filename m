Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jan 2013 22:55:09 +0100 (CET)
Received: from mail-la0-f49.google.com ([209.85.215.49]:50370 "EHLO
        mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833416Ab3AWVzHqsqNs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Jan 2013 22:55:07 +0100
Received: by mail-la0-f49.google.com with SMTP id fs13so3092719lab.36
        for <linux-mips@linux-mips.org>; Wed, 23 Jan 2013 13:55:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=6TKmiFgS7ghLLobDtIaN60j5fzw5pC76bzdN8Wr5YvQ=;
        b=i6aGnF3hmzoD2/YEeQi8j4mx3Qg7c3xK/sOOG5c30zD7xXwB67KyQrA4jbzt68oa7E
         lfO45CtFmTHcvMBDMlONb4O5Q18YdqpQmh2T/4ca1rLzrdq7JD9vTp0y457H/MCSI6sr
         MROUTiCv3TwX/3xrF7TD7/h/6lsLYVpyPNPmXa/pw9vppoDP0Kggy5UQHVdS9zYEKZvc
         TW1bk89yaa2dGBoqd6qHt5LTWm/uoSo+sYuIQMfFyTVyZx8Ey412UkZD2Q87hIoFgDx7
         xs7rwULrbbAnMhgUJ3xHe8qjyDz8e14w11uwtEbEtyQXmbr/XWid74EHLIZ/UXNNwHgR
         r2gA==
X-Received: by 10.112.8.231 with SMTP id u7mr1234336lba.45.1358978102095;
        Wed, 23 Jan 2013 13:55:02 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-77-250.pppoe.mtu-net.ru. [91.79.77.250])
        by mx.google.com with ESMTPS id n2sm8891835lbc.5.2013.01.23.13.55.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 13:55:00 -0800 (PST)
Message-ID: <51005C28.4050002@mvista.com>
Date:   Thu, 24 Jan 2013 01:54:48 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RFC 08/11] MIPS: ralink: adds early_printk support
References: <1358942755-25371-1-git-send-email-blogic@openwrt.org> <1358942755-25371-9-git-send-email-blogic@openwrt.org> <510038A8.6020606@openwrt.org>
In-Reply-To: <510038A8.6020606@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQkf2FiPs8sLq1zgpG98TO+5avzpO0YOP72hrpLa15GvxIfC1uMYTdyZpIZsZ+UfVldtT52q
X-archive-position: 35523
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

On 23-01-2013 23:23, Florian Fainelli wrote:

>> Add the code needed to make early printk work.

>> Signed-off-by: John Crispin <blogic@openwrt.org>
>> ---
>>   arch/mips/ralink/early_printk.c |   43
>> +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 43 insertions(+)
>>   create mode 100644 arch/mips/ralink/early_printk.c

>> diff --git a/arch/mips/ralink/early_printk.c b/arch/mips/ralink/early_printk.c
>> new file mode 100644
>> index 0000000..c610084
>> --- /dev/null
>> +++ b/arch/mips/ralink/early_printk.c
>> @@ -0,0 +1,43 @@
>> +/*
>> + *  This program is free software; you can redistribute it and/or modify it
>> + *  under the terms of the GNU General Public License version 2 as published
>> + *  by the Free Software Foundation.
>> + *
>> + *  Copyright (C) 2011-2012 Gabor Juhos <juhosg@openwrt.org>
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/serial_reg.h>
>> +
>> +#include <asm/addrspace.h>
>> +
>> +/* UART registers */
>> +#define EARLY_UART_BASE         0x10000c00
>> +
>> +#define UART_REG_RX             0
>> +#define UART_REG_TX             1
>> +#define UART_REG_IER            2
>> +#define UART_REG_IIR            3
>> +#define UART_REG_FCR            4
>> +#define UART_REG_LCR            5
>> +#define UART_REG_MCR            6
>> +#define UART_REG_LSR            7

> Is that really required considering that you already include serial_reg.h and
> could use defines from there?

    Off the top of my head, these #define's are not quite compatible with 
standard 8250 registers.

WBR, Sergei
