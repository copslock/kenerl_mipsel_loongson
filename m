Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 12:10:39 +0100 (CET)
Received: from mail-la0-f45.google.com ([209.85.215.45]:42054 "EHLO
        mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012286AbaJ3LKhunKmW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 12:10:37 +0100
Received: by mail-la0-f45.google.com with SMTP id gm9so4214488lab.18
        for <linux-mips@linux-mips.org>; Thu, 30 Oct 2014 04:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=cA60dN6NmlYa2+v/cxK/JlpwU0QsjWb9TSjbUeDHSiE=;
        b=cCQN7AIz98qraPcCB3l7w2iknuUTJFP73cszB2xA+XIT3WXE7mOjcOlHWUCeFsVejb
         /8FxSCukW8iaBA9AMTJALmyp3m4vIOjh4fR8DarcKAUMuqcdFel+adudFPDf+QRCrb3e
         5MAANdLfBYKFucHMEyJzM/3+vKEMy44tx6Q7KFOkY/rQHvAgL/wZPuUWG/5A+r13pggd
         Z+cQBUKzLBAyXv7JdNvZGKDEGHYRAGZ68p3tuQCe447O/dZZHfSgGk3DZ/V3xO5GCWl+
         SuZBcxGgu7AvBdU7v2cnEc0tPz6SXMlfp69WKL6ikDEOfltWJ2Gsrb80cveHf5sQT9gp
         WJ4g==
X-Gm-Message-State: ALoCoQlbS0AdzQSaHaLhuSwXrZ+URzxW2QhfIcO4RrHzJmSu66gvJ1sYdvvzjTB9bc95eZcjY1UJ
X-Received: by 10.152.216.167 with SMTP id or7mr9811463lac.93.1414667432303;
        Thu, 30 Oct 2014 04:10:32 -0700 (PDT)
Received: from [192.168.2.5] (ppp21-199.pppoe.mtu-net.ru. [81.195.21.199])
        by mx.google.com with ESMTPSA id ll3sm2227242lac.30.2014.10.30.04.10.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Oct 2014 04:10:31 -0700 (PDT)
Message-ID: <54521CA6.1000802@cogentembedded.com>
Date:   Thu, 30 Oct 2014 14:10:30 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>, arnd@arndb.de,
        f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org, lethal@linux-sh.org
CC:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 09/15] irqchip: Remove ARM dependency for bcm7120-l2
 and brcmstb-l2
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com> <1414635488-14137-10-git-send-email-cernekee@gmail.com>
In-Reply-To: <1414635488-14137-10-git-send-email-cernekee@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

On 10/30/2014 5:18 AM, Kevin Cernekee wrote:

> This can compile for MIPS (or anything else) now.

> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>   drivers/irqchip/Kconfig | 1 -
>   1 file changed, 1 deletion(-)

> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index b21f12f..09c79d1 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -50,7 +50,6 @@ config ATMEL_AIC5_IRQ
>
>   config BRCMSTB_L2_IRQ
>   	bool
> -	depends on ARM

    How about the following?

	depends on ARM || MIPS || COMPILE_TEST

[...]

WBR, Sergei
