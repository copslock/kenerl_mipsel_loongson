Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jan 2015 02:25:05 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:45766 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010460AbbAKBZDP2Ylo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Jan 2015 02:25:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=8DYq9yZBERvDM8vYwUxcYBopg/F1kxv0+lpNcRpJUB8=;
        b=NIngx7ewy05EHrSw+xFtUonF5aMafWqBRwaP6vHPyyUvxNdUBG47oA63HKu5IqR0ZPqTXqOiB2+6vN9DkxweTl4hx5t4tZGa1i3Pbo4ineC5Md9ejPau4o8ittgVWHxUMxmrHGNIKk8hc4iYY25Z/jrUzUsSF+/HvmP1UM6eOuA=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YA7Gz-0009DA-Qd
        for linux-mips@linux-mips.org; Sun, 11 Jan 2015 01:24:57 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:52254 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YA7Gy-00098A-8M; Sun, 11 Jan 2015 01:24:56 +0000
Message-ID: <54B1D0E5.3010904@roeck-us.net>
Date:   Sat, 10 Jan 2015 17:24:53 -0800
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Wim Van Sebroeck <wim@iguana.be>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/3] MIPS: qi_lb60: Register watchdog device
References: <1420914550-18335-1-git-send-email-lars@metafoo.de> <1420914550-18335-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1420914550-18335-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020203.54B1D0E9.007A,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.001
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: C_4847,
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 2
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45058
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 01/10/2015 10:29 AM, Lars-Peter Clausen wrote:
> The next commit will move the restart code to the watchdog driver. So for
> restart to continue to work we need to register the watchdog device.
>
> Also enable the watchdog driver in the default config.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>   arch/mips/configs/qi_lb60_defconfig |    2 ++
>   arch/mips/jz4740/board-qi_lb60.c    |    1 +
>   2 files changed, 3 insertions(+)
>
> diff --git a/arch/mips/configs/qi_lb60_defconfig b/arch/mips/configs/qi_lb60_defconfig
> index 2b96547..ce06a92 100644
> --- a/arch/mips/configs/qi_lb60_defconfig
> +++ b/arch/mips/configs/qi_lb60_defconfig
> @@ -73,6 +73,8 @@ CONFIG_POWER_SUPPLY=y
>   CONFIG_BATTERY_JZ4740=y
>   CONFIG_CHARGER_GPIO=y
>   # CONFIG_HWMON is not set
> +CONFIG_WATCHDOG=y
> +CONFIG_JZ4740_WDT=y

Shouldn't JZ4740_WDT be selected from MACH_JZ4740 ?

Guess it doesn't really matter if there is just one board, but if there
is ever another board the reset handler would not automatically be enabled.

Thanks,
Guenter

>   CONFIG_MFD_JZ4740_ADC=y
>   CONFIG_REGULATOR=y
>   CONFIG_REGULATOR_FIXED_VOLTAGE=y
> diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
> index c454525..a00f134 100644
> --- a/arch/mips/jz4740/board-qi_lb60.c
> +++ b/arch/mips/jz4740/board-qi_lb60.c
> @@ -436,6 +436,7 @@ static struct gpiod_lookup_table qi_lb60_audio_gpio_table = {
>   };
>
>   static struct platform_device *jz_platform_devices[] __initdata = {
> +	&jz4740_wdt_device,
>   	&jz4740_udc_device,
>   	&jz4740_udc_xceiv_device,
>   	&jz4740_mmc_device,
>
