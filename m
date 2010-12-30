Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Dec 2010 17:52:08 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:38314 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491110Ab0L3QwF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Dec 2010 17:52:05 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id C90263FC03A;
        Thu, 30 Dec 2010 17:51:57 +0100 (CET)
Received: from [192.168.254.10] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 427C8570001;
        Thu, 30 Dec 2010 17:51:57 +0100 (CET)
Message-ID: <4D1CB8A7.6010409@openwrt.org>
Date:   Thu, 30 Dec 2010 17:51:51 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; hu-HU; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Wim Van Sebroeck <wim@iguana.be>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Kathy Giori <Kathy.Giori@Atheros.com>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v3 06/16] watchdog: add driver for the Atheros      AR71XX/AR724X/AR913X
 SoCs
References: <1293560437-7967-1-git-send-email-juhosg@openwrt.org> <1293560437-7967-7-git-send-email-juhosg@openwrt.org> <20101230102506.GA6521@infomag.iguana.be>
In-Reply-To: <20101230102506.GA6521@infomag.iguana.be>
X-Enigmail-Version: 1.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-VBMS: A104B49DCF2 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Wim,

>> This patch adds a driver for the built-in hardware watchdog device
>> of the Atheros AR71XX/AR724X/AR913X SoCs.
>>
>> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
>> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
>> Cc: Wim Van Sebroeck <wim@iguana.be>
>> Cc: linux-watchdog@vger.kernel.org
>> ---
>>
>> Changes since RFC: ---
>>
>> Changes since v1:
>>     - rebased against 2.6.37-rc7
>>
>> Changes since v2: ---
> 
> I adapted the code a little bit:
> Changes since v3:
> * remove #ifdef CONFIG_WATCHDOG_NOWAYOUT for nowayout module-parameter.
> * add ath79_wdt_keepalive when doing un unexpected close of /dev/watchdog (the close is considered as communication with /dev/watchdog)
> * replace reboot_notifier with a platform shutdown.

Thanks!

> Attached the new patch. Can you test it?

I have tested that, it works fine. I would have to resend the patch with your
changes?

> PS: is there a reason why you don't add a module-parameter for wdt_timeout?

I have no specific reason, simply i did not need that so far. However I can add
that in a separate patch, or I can integrate that into the current one if you
prefer.

Regards,
Gabor
