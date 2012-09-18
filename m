Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2012 13:53:20 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:48191 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903421Ab2IRLxI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Sep 2012 13:53:08 +0200
Received: by lagu2 with SMTP id u2so4782094lag.36
        for <linux-mips@linux-mips.org>; Tue, 18 Sep 2012 04:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=BwIBRmozRA46Z/CJu0PALTbW0qRyHmO4otM3q4cmvyQ=;
        b=c36cjZ5/BRICMZYJm9wnYJKMM4feUz8lf3dEFFp/FBevBMveITj+3DHG6m+uGs0Ktc
         S9TSvLQqezPmnaUc+w/G0Ci1MpGadozPIdt30Yy0u+iHFrKtJY77TEXcaj8rLVTU1YCZ
         Y91skgvawIzmGIxuUp2R7bbWcyjilPs2fddIPnv7eJ+k6PYK2DTR8ZDAKsfLQJjSAUbV
         ye0DZCHs2NbNF5TeST1sZxRWzYEKr6H0P22IoJwI2AG+DnxgQVaIc+nLYGTmph4U4O9I
         dBeh/5AE5/jNF3BnCl12XjoUXMGIUo4hma5tBpecDbX2fDxzsImGuoSYHCBg3kfFdsp9
         mM+w==
Received: by 10.152.104.77 with SMTP id gc13mr12471677lab.31.1347969182141;
        Tue, 18 Sep 2012 04:53:02 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-85-75.pppoe.mtu-net.ru. [91.79.85.75])
        by mx.google.com with ESMTPS id o7sm3321938lbg.4.2012.09.18.04.52.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Sep 2012 04:53:00 -0700 (PDT)
Message-ID: <50586059.4090407@mvista.com>
Date:   Tue, 18 Sep 2012 15:51:53 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
MIME-Version: 1.0
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH] MIPS: BCM63XX: properly handle mac address octet overflow
References: <1347960728-5884-1-git-send-email-jonas.gorski@gmail.com>
In-Reply-To: <1347960728-5884-1-git-send-email-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlYZCdXJiZEKRYkHTUU8drpONkaq1UZXW71a3x2feINBp/7Em4NlrXrfgy5WNnC9scQm75W
X-archive-position: 34526
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

On 18-09-2012 13:32, Jonas Gorski wrote:

> While calculating the mac address the pointer for the current octet was
> never reset back to the least significant one after being decremented
> because of an octet overflow. This resulted in the code continuing to
> increment at the current octet, potentially generating duplicate or
> invalid mac addresses.

> As a second issue the pointer was allowed to advance up to the most
> significant octet, modifying the OUI, and potentially changing the type
> of mac address.

> Rewrite the code so it resets the pointer to the least significant
> in each outer loop step, and bails out when the least significant octet
> of the OUI is reached.

> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>   arch/mips/bcm63xx/boards/board_bcm963xx.c |   16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)

> diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
> index ea4ea77..f0fcec6 100644
> --- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
> +++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
> @@ -720,7 +720,7 @@ const char *board_get_name(void)
>    */
>   static int board_get_mac_address(u8 *mac)
>   {
> -	u8 *p;
> +	u8 *oui;
>   	int count;
>
>   	if (mac_addr_used >= nvram.mac_addr_count) {
> @@ -729,21 +729,23 @@ static int board_get_mac_address(u8 *mac)
>   	}
>
>   	memcpy(mac, nvram.mac_addr_base, ETH_ALEN);
> -	p = mac + ETH_ALEN - 1;
> +	oui = mac + ETH_ALEN/2 - 1;
>   	count = mac_addr_used;
>
>   	while (count--) {
> +		p = mac + ETH_ALEN - 1;

    But didn't you remove 'p' above? Did you compile this?

WBR, Sergei
