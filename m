Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Nov 2011 10:12:26 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:36862 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903545Ab1KRJMT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Nov 2011 10:12:19 +0100
Received: by faar25 with SMTP id r25so5048127faa.36
        for <multiple recipients>; Fri, 18 Nov 2011 01:12:14 -0800 (PST)
Received: by 10.204.133.197 with SMTP id g5mr2430939bkt.43.1321607534562;
        Fri, 18 Nov 2011 01:12:14 -0800 (PST)
Received: from [192.168.2.2] (ppp85-141-239-170.pppoe.mtu-net.ru. [85.141.239.170])
        by mx.google.com with ESMTPS id cc2sm129913bkb.8.2011.11.18.01.12.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Nov 2011 01:12:13 -0800 (PST)
Message-ID: <4EC62138.7010703@mvista.com>
Date:   Fri, 18 Nov 2011 13:11:20 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
MIME-Version: 1.0
To:     Gabor Juhos <juhosg@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, Imre Kaloz <kaloz@openwrt.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 2/6] MIPS: ath79: remove 'ar913x' from common variable
 and function names
References: <1321568027-32066-1-git-send-email-juhosg@openwrt.org> <1321568027-32066-3-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1321568027-32066-3-git-send-email-juhosg@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15196

Hello.

On 18-11-2011 2:13, Gabor Juhos wrote:

> The wireless MAC specific variables and the registration
> code can be shared between multiple SoCs. Remove the 'ar913x'
> part from the function and variable names to avoid confusions.

> Signed-off-by: Gabor Juhos<juhosg@openwrt.org>
> ---
>   arch/mips/ath79/dev-ar913x-wmac.c |   20 ++++++++++----------
>   arch/mips/ath79/dev-ar913x-wmac.h |    8 ++++----

    Don't you need to rename these files if they're no longer AR913x specific?

>   arch/mips/ath79/mach-ap81.c       |    2 +-
>   3 files changed, 15 insertions(+), 15 deletions(-)

WBR, Sergei
