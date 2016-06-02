Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jun 2016 11:15:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59515 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27030556AbcFBJPUU4n4u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jun 2016 11:15:20 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 7037F76259F95;
        Thu,  2 Jun 2016 10:15:11 +0100 (IST)
Received: from [192.168.154.26] (192.168.154.26) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 2 Jun
 2016 10:15:13 +0100
Subject: Re: [PATCH] MIPS: pic32mzda: fix linker error for pic32_get_pbclk().
To:     Purna Chandra Mandal <purna.mandal@microchip.com>,
        <linux-kernel@vger.kernel.org>
References: <1464844821-1581-1-git-send-email-purna.mandal@microchip.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        Joshua Henderson <digitalpeer@digitalpeer.com>,
        Joshua Henderson <joshua.henderson@microchip.com>
From:   Harvey Hunt <harvey.hunt@imgtec.com>
Message-ID: <9f53c6f4-735a-1a76-9c62-a4f5f127b1e9@imgtec.com>
Date:   Thu, 2 Jun 2016 10:15:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1464844821-1581-1-git-send-email-purna.mandal@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.26]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: harvey.hunt@imgtec.com
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

Hi Purna,

On 02/06/16 06:20, Purna Chandra Mandal wrote:
> Early clock API pic32_get_pbclk() is defined in early_clk.c and
> used by time.c and early_console.c. When CONFIG_EARLY_PRINTK isn't
> set, early_clk.c isn't compiled and so a linker error is reported
> while referring the API from time.c.

Maybe "early_clk.c isn't compiled and so time.c fails to link"?

>
> Fix it by compiling early_clk.c always. Also sort files in
> alphabetical order.
>
> Cc: Harvey Hunt <harvey.hunt@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: Joshua Henderson <digitalpeer@digitalpeer.com>
>
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
>
> ---
>
>  arch/mips/pic32/pic32mzda/Makefile | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/pic32/pic32mzda/Makefile b/arch/mips/pic32/pic32mzda/Makefile
> index 4a4c272..c286496 100644
> --- a/arch/mips/pic32/pic32mzda/Makefile
> +++ b/arch/mips/pic32/pic32mzda/Makefile
> @@ -2,8 +2,7 @@
>  # Joshua Henderson, <joshua.henderson@microchip.com>
>  # Copyright (C) 2015 Microchip Technology, Inc.  All rights reserved.
>  #
> -obj-y			:= init.o time.o config.o
> +obj-y			:= config.o early_clk.o init.o time.o
>
>  obj-$(CONFIG_EARLY_PRINTK)	+= early_console.o      \
> -				   early_pin.o		\
> -				   early_clk.o
> +				   early_pin.o
>

Perhaps add:

Reported-by: Harvey Hunt <harvey.hunt@imgtec.com>

Thanks for fixing this,

Reviewed-by: Harvey Hunt <harvey.hunt@imgtec.com>

Thanks,

Harvey
