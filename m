Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jul 2009 15:40:43 +0200 (CEST)
Received: from h155.mvista.com ([63.81.120.155]:31713 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492845AbZG2Nkg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 29 Jul 2009 15:40:36 +0200
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 7BFDD3ECA; Wed, 29 Jul 2009 06:40:26 -0700 (PDT)
Message-ID: <4A70517A.6060006@ru.mvista.com>
Date:	Wed, 29 Jul 2009 17:41:14 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Manuel Lauss <manuel.lauss@googlemail.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/4] alchemy: register au1000_eth as a platform driver
  part one
References: <200907282300.14118.florian@openwrt.org> <f861ec6f0907290015v34d277beh18efed6aac10aa79@mail.gmail.com> <200907291010.09526.florian@openwrt.org>
In-Reply-To: <200907291010.09526.florian@openwrt.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Florian Fainelli wrote:

>>> static int __init au1xxx_platform_init(void)
>>> {
>>>       unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
>>>-       int i;
>>>+       int i, ni;
>>>
>>>       /* Fill up uartclk. */
>>>       for (i = 0; au1x00_uart_data[i].flags; i++)
>>>               au1x00_uart_data[i].uartclk = uartclk;
>>>
>>>+       /* Register second MAC if enabled in pinfunc */
>>>+#ifndef CONFIG_SOC_AU1100
>>>+        ni = (int)((au_readl(SYS_PINFUNC) & (u32)(SYS_PF_NI2)) >> 4);
>>>+        if (!(ni + 1))
>>>+               platform_device_register(&au1xxx_eth1_device);
>>>+#endif
>>>+

>>This won't work on Au1200/Au1300 since their SYS_PINFUNC register
>>has a different bit layout.

>>And you already know that I'm not very fond of alchemy/common/platform.c
>>;-) I still think you should add appropriate MAC platform information to
>>the boards which actually use it.

> Yes I know ;) I was just wanting to get this out quickly before you kill platform.c

    I'd NAK such patch (and have already done so, AFAIR).

> I will make the au1000-eth devices be registered on a per-board basis.

    Please don't. You can register them in platform.c, and yet leave 
actually board specific platform data in the board files. There's no reason 
to duplicate the platfrom device itself.

WBR, Sergei
