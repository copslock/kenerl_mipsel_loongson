Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jan 2016 16:53:17 +0100 (CET)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35011 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010155AbcAGPxPK8O9V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jan 2016 16:53:15 +0100
Received: by mail-pa0-f43.google.com with SMTP id ho8so870436pac.2;
        Thu, 07 Jan 2016 07:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gzC+rO/zS2AXNuVzU1DeAQ3NFxCzgzLU8hUFbhuybIE=;
        b=Cn5IjVXKMmj3KVxKgaz7TQNSm0KnM1wVnt18Pj6q7OwZ3nSbg9PDZwHIktDrSujj6p
         +UISQ+kTtx1yNXBXKoDwcra6pOumoNLBymkPsa3YoF0BnHIpbzYaPbbFl8EOZ1N8g6ox
         eZCTBqNofIXy8iY6eQoDHgd5/uKc7mDw6cVU7OwRj3dUGDZQAJmKPDMHiom72AsyhmHu
         qfHAZjPXJMOhIsHJgkyg2TB7a4Zk8kHh/ktLyRZfzs6kO8VXWM9KPvyvbSTPR/DXPY/m
         bo8l71iwH0qKBw1j/bykS2JgQU++n+ST2d9Nw256fHZQ1YvcUQbjs48jYtwWWoJspBWA
         4GFg==
X-Received: by 10.66.182.202 with SMTP id eg10mr152036226pac.50.1452181988997;
        Thu, 07 Jan 2016 07:53:08 -0800 (PST)
Received: from [192.168.1.7] (ip174-67-203-144.oc.oc.cox.net. [174.67.203.144])
        by smtp.gmail.com with ESMTPSA id qj8sm17745223pac.40.2016.01.07.07.53.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jan 2016 07:53:07 -0800 (PST)
Message-ID: <568E89EC.4050902@gmail.com>
Date:   Thu, 07 Jan 2016 07:53:16 -0800
From:   Dragan Stancevic <dragan.stancevic@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Florian Fainelli <f.fainelli@gmail.com>, linux-mips@linux-mips.org
CC:     ralf@linux-mips.org, cernekee@gmail.com, jaedon.shin@gmail.com,
        gregory.0xf0@gmail.com
Subject: Re: [PATCH] MIPS: BMIPS: Enable ARCH_WANT_OPTIONAL_GPIOLIB
References: <1452106265-11384-1-git-send-email-f.fainelli@gmail.com>
In-Reply-To: <1452106265-11384-1-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <dragan.stancevic@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50961
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dragan.stancevic@gmail.com
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

Reviewed-by: Dragan Stancevic <dragan.stancevic@gmail.com>

On 01/06/2016 10:51 AM, Florian Fainelli wrote:
> Allow BMIPS_GENERIC supported platforms to build GPIO controller
> drivers.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 71683a853372..77dd3c0f10f8 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -170,6 +170,7 @@ config BMIPS_GENERIC
>  	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
>  	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
>  	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
> +	select ARCH_WANT_OPTIONAL_GPIOLIB
>  	help
>  	  Build a generic DT-based kernel image that boots on select
>  	  BCM33xx cable modem chips, BCM63xx DSL chips, and BCM7xxx set-top
