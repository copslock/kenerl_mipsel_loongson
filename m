Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2012 14:08:42 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:42919 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903693Ab2D1MIf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Apr 2012 14:08:35 +0200
Received: by lboj14 with SMTP id j14so1292735lbo.36
        for <linux-mips@linux-mips.org>; Sat, 28 Apr 2012 05:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=R7hm/pGCFcFFmi6WHBqyKy/aXm5xDGDONK6VKBedA7U=;
        b=dRJvzZtOEJ6zka28InJETsTvIRE/hzlJCRIqOPe+P/JGtcUi9yrDtoFYM15aFwMO2p
         y2mr5CjzAAA6c1LKdfzzm1Byztkag5ln+qC44Ccc0gVKRR2/a4k8svDRbDAZzssRL7H7
         kmiqABGb1UOttrxNCMFCiDE2kfwBl5N0VDajDmqtkCLASL6w7HogiYGWNj/AWIa7rCrm
         PRjeIa4OioCV1ojRTjqd9shlIsyPPRZEUdQDXwPZeSdnCL7L0oMZtFpWaHl372Eg2qVe
         a1yGQ7n9F4CqP6h+fXHEZi/5wc6zY+S0BMiqmpmvk8/kLok0mkzBuJa5NN02BRPvqC4A
         2tpg==
Received: by 10.112.99.198 with SMTP id es6mr6693624lbb.66.1335614908864;
        Sat, 28 Apr 2012 05:08:28 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-65-218.pppoe.mtu-net.ru. [91.79.65.218])
        by mx.google.com with ESMTPS id nv7sm9726603lab.9.2012.04.28.05.08.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Apr 2012 05:08:26 -0700 (PDT)
Message-ID: <4F9BDD54.9080309@mvista.com>
Date:   Sat, 28 Apr 2012 16:06:44 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120420 Thunderbird/12.0
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: ath79: fix number of GPIO lines for AR724[12]
References: <1335546613-32078-1-git-send-email-juhosg@openwrt.org> <1335546613-32078-2-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1335546613-32078-2-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnV1XHWS6FovShzfTBp65Xvebvu2muAfYdT8ySOHxrONwj8XStv0M9eU3fyiGCqpjYpGxX7
X-archive-position: 33045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 27-04-2012 21:10, Gabor Juhos wrote:

> The AR724[12] SoCs have more GPIO lines than the AR7240.

> Signed-off-by: Gabor Juhos<juhosg@openwrt.org>

    Interdiff should be separated by --- tear line.

>   arch/mips/ath79/gpio.c                         |    6 ++++--
>   arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    3 ++-
>   2 files changed, 6 insertions(+), 3 deletions(-)

>   arch/mips/ath79/gpio.c                         |    6 ++++--
>   arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    3 ++-
>   2 files changed, 6 insertions(+), 3 deletions(-)

    ... and one was enough. :-)

WBR, Sergei
