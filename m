Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Jan 2015 17:18:06 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:36722 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011138AbbAKQSD56IEu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Jan 2015 17:18:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=gcI2oTgPOKEvSuXz4boaHfJHN4v5lFI/lb5SS+vMSlg=;
        b=6Yl+sLQU7NkD8mdtc0Z7Vf692j+9ff7ujwbrtj3g8DQVPI0rUZ3Pstn8ZwiWN4syb8ZQ7zQuU8eIfILJ2YfmGwf+Z3xjowE/ljjfW4iLAdcudqq6tORERchbH67yU7pvbo69q1KSkxuinajDSsk0XafBGaLbdXNZF1LSoJVecGw=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YALDC-004Cl7-JY
        for linux-mips@linux-mips.org; Sun, 11 Jan 2015 16:17:58 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57145 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1YALDB-004CfQ-EF; Sun, 11 Jan 2015 16:17:57 +0000
Message-ID: <54B2A233.4070105@roeck-us.net>
Date:   Sun, 11 Jan 2015 08:17:55 -0800
From:   Guenter Roeck <linux@roeck-us.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Maarten ter Huurne <maarten@treewalker.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/3] MIPS: qi_lb60: Register watchdog device
References: <1420914550-18335-1-git-send-email-lars@metafoo.de> <1420914550-18335-2-git-send-email-lars@metafoo.de> <54B1D0E5.3010904@roeck-us.net> <2955853.HTsalEGzQa@hyperion>
In-Reply-To: <2955853.HTsalEGzQa@hyperion>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020206.54B2A236.0029,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.001
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: C_4847,
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 15
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
X-archive-position: 45072
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

On 01/10/2015 05:37 PM, Maarten ter Huurne wrote:
> On Saturday 10 January 2015 17:24:53 Guenter Roeck wrote:
>> On 01/10/2015 10:29 AM, Lars-Peter Clausen wrote:
>>> The next commit will move the restart code to the watchdog driver. So
>>> for
>>> restart to continue to work we need to register the watchdog device.
>>>
>>> Also enable the watchdog driver in the default config.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>> ---
>>>
>>>    arch/mips/configs/qi_lb60_defconfig |    2 ++
>>>    arch/mips/jz4740/board-qi_lb60.c    |    1 +
>>>    2 files changed, 3 insertions(+)
>>>
>>> diff --git a/arch/mips/configs/qi_lb60_defconfig
>>> b/arch/mips/configs/qi_lb60_defconfig index 2b96547..ce06a92 100644
>>> --- a/arch/mips/configs/qi_lb60_defconfig
>>> +++ b/arch/mips/configs/qi_lb60_defconfig
>>> @@ -73,6 +73,8 @@ CONFIG_POWER_SUPPLY=y
>>>
>>>    CONFIG_BATTERY_JZ4740=y
>>>    CONFIG_CHARGER_GPIO=y
>>>    # CONFIG_HWMON is not set
>>>
>>> +CONFIG_WATCHDOG=y
>>> +CONFIG_JZ4740_WDT=y
>>
>> Shouldn't JZ4740_WDT be selected from MACH_JZ4740 ?
>>
>> Guess it doesn't really matter if there is just one board, but if there
>> is ever another board the reset handler would not automatically be
>> enabled.
>
> There is only one board in the mainline kernel, but Paul Cercueil and me did
> maintain a kernel for the Dingoo A320 for a while which is also JZ4740-
> based. Also, a lot of the JZ4740 drivers can be used as-is or with small
> adaptations on later SoC generations. For example, we're using a slightly
> modified version of this watchdog driver on the JZ4770-based GCW Zero.
>

Where does that leave us ? Should CONFIG_JZ4740_WDT be auto-selected ?

Thanks,
Guenter
