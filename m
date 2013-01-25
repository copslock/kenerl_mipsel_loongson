Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jan 2013 12:41:24 +0100 (CET)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:55694 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6833458Ab3AYLlTnPw7c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Jan 2013 12:41:19 +0100
Received: by mail-lb0-f177.google.com with SMTP id go11so534362lbb.22
        for <linux-mips@linux-mips.org>; Fri, 25 Jan 2013 03:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=uQ/L6CutdGkOKNANqpMMLNURXuH77YSqUL0Jrdsc2Bw=;
        b=F6+VT1wlrTuL+uvqrmkVeyFv1eKmT18NVJrvMvzmu3Mixy3FG/nNOp7dUtWgMLC/2o
         uZjv3f0Sy2t24165Fmd+FbNIyzgX/K31pNwhXvTL936hCoRAm7Cw6vfP9AyS9BrZ6Wht
         nt7iLlJpzAxe2jm9mac28fUADZTSsC75cHNmP+3CXl8pG1zMTimNsWGFeE92FokDCtlB
         NqKmaxBIE6igfHr1PLceQIRi92bA9EJ+pqPMZcldzgyoSabY0rQSrTabyl3yRDIN8eSm
         hsj05Pbl+5f33QulsK2DEczlaKr/6EezUiSS9ycAdu5UROxPny15hvb2CPFwm8NvRMlI
         ensA==
X-Received: by 10.112.13.162 with SMTP id i2mr2024594lbc.76.1359114073945;
        Fri, 25 Jan 2013 03:41:13 -0800 (PST)
Received: from [192.168.2.2] (ppp91-79-73-40.pppoe.mtu-net.ru. [91.79.73.40])
        by mx.google.com with ESMTPS id gt13sm375746lab.14.2013.01.25.03.41.09
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 03:41:11 -0800 (PST)
Message-ID: <51026F48.1060106@mvista.com>
Date:   Fri, 25 Jan 2013 15:40:56 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] serial: ralink: adds support for the serial core
 found on ralink wisoc
References: <1359111008-9998-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1359111008-9998-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmOtd262Lq8Tmxis0kUEFmSZj2YDIgZgqTbJAQsmtfWuY7z+5f4y2SAn3mjFswdfqaeUSAG
X-archive-position: 35555
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

On 25-01-2013 14:50, John Crispin wrote:

> The MIPS based Ralink WiSoC platform has 1 or more 8250 compatible serial cores.
> To make them work we require the same quirks that are used by AU1x00.

> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   drivers/tty/serial/8250/8250.c  |    6 +++---
>   drivers/tty/serial/8250/Kconfig |    8 ++++++++
>   include/linux/serial_core.h     |    2 +-
>   3 files changed, 12 insertions(+), 4 deletions(-)

> diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
> index f932043..b727779 100644
> --- a/drivers/tty/serial/8250/8250.c
> +++ b/drivers/tty/serial/8250/8250.c
> @@ -324,9 +324,9 @@ static void default_serial_dl_write(struct uart_8250_port *up, int value)
>   	serial_out(up, UART_DLM, value >> 8 & 0xff);
>   }
>
> -#ifdef CONFIG_MIPS_ALCHEMY
> +#if defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_SERIAL_8250_RT288X)
>
> -/* Au1x00 UART hardware has a weird register layout */
> +/* Au1x00 RT288x UART hardware has a weird register layout */
             ^
    You need either comma or slash or "and" between those...

WBR, Sergei
