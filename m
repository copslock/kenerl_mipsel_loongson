Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Apr 2012 15:00:51 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:34881 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903693Ab2D1NAr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 28 Apr 2012 15:00:47 +0200
X-Virus-Scanned: at arrakis.dune.hu
Received: from [192.168.254.129] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id E6DC823C0084;
        Sat, 28 Apr 2012 15:00:44 +0200 (CEST)
Message-ID: <4F9BE9F9.6050309@openwrt.org>
Date:   Sat, 28 Apr 2012 15:00:41 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: ath79: fix number of GPIO lines for AR724[12]
References: <1335546613-32078-1-git-send-email-juhosg@openwrt.org> <1335546613-32078-2-git-send-email-juhosg@openwrt.org> <4F9BDD54.9080309@mvista.com>
In-Reply-To: <4F9BDD54.9080309@mvista.com>
X-Enigmail-Version: 1.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33046
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Sergei,

> On 27-04-2012 21:10, Gabor Juhos wrote:
> 
>> The AR724[12] SoCs have more GPIO lines than the AR7240.
> 
>> Signed-off-by: Gabor Juhos<juhosg@openwrt.org>
> 
>    Interdiff should be separated by --- tear line.
> 
>>   arch/mips/ath79/gpio.c                         |    6 ++++--
>>   arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    3 ++-
>>   2 files changed, 6 insertions(+), 3 deletions(-)
> 
>>   arch/mips/ath79/gpio.c                         |    6 ++++--
>>   arch/mips/include/asm/mach-ath79/ar71xx_regs.h |    3 ++-
>>   2 files changed, 6 insertions(+), 3 deletions(-)
> 
>    ... and one was enough. :-)

You are absolutely right. It seems that I have messed up one of my patch
handling scripts. I will repost this and the 'MIPS: ath79: allow to use USB on
AR934x' series as well.

Thanks,
Gabor
