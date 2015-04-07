Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 17:48:12 +0200 (CEST)
Received: from kiutl.biot.com ([31.172.244.210]:55212 "EHLO kiutl.biot.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27009668AbbDGPsKN6AVe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Apr 2015 17:48:10 +0200
Received: from spamd by kiutl.biot.com with sa-checked (Exim 4.83)
        (envelope-from <bert@biot.com>)
        id 1YfVjW-0003Mv-GT
        for linux-mips@linux-mips.org; Tue, 07 Apr 2015 17:48:10 +0200
Received: from [2a02:578:4a04:2a00::5]
        by kiutl.biot.com with esmtps (TLSv1.2:DHE-RSA-AES128-SHA:128)
        (Exim 4.83)
        (envelope-from <bert@biot.com>)
        id 1YfVjP-0003MN-65; Tue, 07 Apr 2015 17:48:03 +0200
Message-ID: <5523FC32.3080904@biot.com>
Date:   Tue, 07 Apr 2015 17:48:02 +0200
From:   Bert Vermeulen <bert@biot.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Lee Jones <lee.jones@linaro.org>
CC:     ralf@linux-mips.org, sameo@linux.intel.com,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: Add support for CPLD chip on Mikrotik RB4xx boards
References: <1428285076-14269-1-git-send-email-bert@biot.com> <20150407065217.GC3461@x1>
In-Reply-To: <20150407065217.GC3461@x1>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <bert@biot.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bert@biot.com
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

On 07/04/15 08:52, Lee Jones wrote:
> On Mon, 06 Apr 2015, Bert Vermeulen wrote:
>
>> The SPI-connected CPLD chip controls access to the main NAND flash
>> chip and five LEDs.
>>
>> Signed-off-by: Bert Vermeulen <bert@biot.com>
>> ---
>>   arch/mips/include/asm/mach-ath79/rb4xx_cpld.h |  49 +++++
>>   drivers/mfd/Kconfig                           |   7 +
>>   drivers/mfd/Makefile                          |   1 +
>>   drivers/mfd/rb4xx-cpld.c                      | 279 ++++++++++++++++++++++++++
>>   4 files changed, 336 insertions(+)
>>   create mode 100644 arch/mips/include/asm/mach-ath79/rb4xx_cpld.h
>>   create mode 100644 drivers/mfd/rb4xx-cpld.c
>
> This device doesn't look like an MFD, it rather looks like a CPLD
> driver.  We had a recent submission like this [1], perhaps this will
> provide another argument for drivers/programmables or something.
>
> [1] https://lkml.org/lkml/2015/2/17/42

Yup, got bounced into drivers/mfd after initially submitting it as an SPI
protocol driver (where it lives in openwrt). Indeed it's not a great fit
anywhere -- not even programmables: this thing has its firmware on board,
nothing ever feeds it on startup.

Drivers for CPLDs don't necessarily have anything in common -- these are
customized chips basically. In this case it's a NAND controller and GPIO/LED
expander rolled into one.


-- 
Bert Vermeulen
bert@biot.com
