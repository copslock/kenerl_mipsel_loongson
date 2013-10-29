Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Oct 2013 09:45:47 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:51326 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817258Ab3J2Ipl3Z-5g (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 29 Oct 2013 09:45:41 +0100
Message-ID: <526F7569.7040903@openwrt.org>
Date:   Tue, 29 Oct 2013 09:44:25 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Wim Van Sebroeck <wim@iguana.be>
CC:     linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] watchdog: MIPS: add ralink watchdog driver
References: <1375954303-28830-1-git-send-email-blogic@openwrt.org> <20131029073935.GD19569@spo001.leaseweb.com>
In-Reply-To: <20131029073935.GD19569@spo001.leaseweb.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
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

On 29/10/13 08:39, Wim Van Sebroeck wrote:
> Hi John,
>
>> Add a driver for the watchdog timer found on Ralink SoC
>>
>> Signed-off-by: John Crispin<blogic@openwrt.org>
>> Cc: linux-watchdog@vger.kernel.org
>> Cc: linux-mips@linux-mips.org
>> ---
>>   drivers/watchdog/Kconfig      |    7 ++
>>   drivers/watchdog/Makefile     |    1 +
>>   drivers/watchdog/rt2880_wdt.c |  208 +++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 216 insertions(+)
>>   create mode 100644 drivers/watchdog/rt2880_wdt.c
> This patch (together with the DT binding part) has been added as 1 patch to linux-watchdog-next.
>
> Kind regards,
> Wim.
>
>
>

Hi Wim,

Thanks a lot for the review/merge

     John
