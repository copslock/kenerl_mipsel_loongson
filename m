Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Aug 2011 11:16:16 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:52936 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493625Ab1HXJQN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Aug 2011 11:16:13 +0200
Received: by wyh11 with SMTP id 11so865023wyh.36
        for <multiple recipients>; Wed, 24 Aug 2011 02:16:06 -0700 (PDT)
Received: by 10.227.13.130 with SMTP id c2mr19740wba.6.1314177366391;
        Wed, 24 Aug 2011 02:16:06 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.64.100])
        by mx.google.com with ESMTPS id fd4sm670754wbb.13.2011.08.24.02.16.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Aug 2011 02:16:05 -0700 (PDT)
Message-ID: <4E54C12F.1000408@mvista.com>
Date:   Wed, 24 Aug 2011 13:15:27 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:6.0) Gecko/20110812 Thunderbird/6.0
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Langer <thomas.langer@lantiq.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/8] MIPS: lantiq: fix early printk
References: <1314174704-15549-1-git-send-email-blogic@openwrt.org> <1314174704-15549-2-git-send-email-blogic@openwrt.org>
In-Reply-To: <1314174704-15549-2-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 30975
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17707

Hello.

On 24-08-2011 12:31, John Crispin wrote:

> The code was using a 32bit write operation in the early_printk code. This
> resulted in 3 zero bytes also being written to the serial port. Change the
> memory access to 8bit.

> Signed-off-by: Thomas Langer<thomas.langer@lantiq.com>
> Signed-off-by: John Crispin<blogic@openwrt.org>
> Cc: linux-mips@linux-mips.org
> ---
>   .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |    4 ++++
>   arch/mips/lantiq/early_printk.c                    |   14 ++++++++------
>   2 files changed, 12 insertions(+), 6 deletions(-)

> diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
> index 8a3c6be..e6d1ca0 100644
> --- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
> +++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
> @@ -34,6 +34,10 @@
>   #define LTQ_ASC1_BASE_ADDR	0x1E100C00
>   #define LTQ_ASC_SIZE		0x400
>
> +/* during early_printk no ioremap is possible
> +   lets use KSEG1 instead  */

    The preferred style of multi-line comments is:

/*
  * bla
  * bla
  */

WBR, Sergei
