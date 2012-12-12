Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 15:46:51 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:39229 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825730Ab2LLOqrJbd6P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 15:46:47 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 9EB468F65;
        Wed, 12 Dec 2012 15:46:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R7pWmUGRIu8K; Wed, 12 Dec 2012 15:46:33 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:8dd6:f11a:ffd3:5c8c] (unknown [IPv6:2001:470:1f0b:447:8dd6:f11a:ffd3:5c8c])
        by hauke-m.de (Postfix) with ESMTPSA id 0DFB78F64;
        Wed, 12 Dec 2012 15:46:32 +0100 (CET)
Message-ID: <50C898C4.4040609@hauke-m.de>
Date:   Wed, 12 Dec 2012 15:46:28 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     john@phrozen.org, ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: BCM47XX: fix compile error in wgt634u.c
References: <1355274612-19167-1-git-send-email-hauke@hauke-m.de> <50C84AC3.9020809@openwrt.org>
In-Reply-To: <50C84AC3.9020809@openwrt.org>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 35262
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 12/12/2012 10:13 AM, Florian Fainelli wrote:
> Hello Hauke,
> 
> Le 12/12/12 02:10, Hauke Mehrtens a écrit :
>> After the new GPIO handling for the bcm47xx target was introduced
>> wgt634u.c was not changed.
>> This patch fixes the following compile error:
>>
>> arch/mips/bcm47xx/wgt634u.c: In function ‘gpio_interrupt’:
>> arch/mips/bcm47xx/wgt634u.c:119:2: error: implicit declaration of
>> function ‘gpio_polarity’ [-Werror=implicit-function-declaration]
>> arch/mips/bcm47xx/wgt634u.c: In function ‘wgt634u_init’:
>> arch/mips/bcm47xx/wgt634u.c:153:4: error: implicit declaration of
>> function ‘gpio_intmask’ [-Werror=implicit-function-declaration]
> 
> Thanks for fixing this. We should probably remove this wgt634u file some
> day or the other as it was an ad-hoc hack for this single device while
> we actually need a general solution for all BCM47xx boards out there.
> 

Yes I also want to get rid of this file.

Currently OpenWrt uses its own detection and gpio/led/button configure
code [0], but this doe not look nice to me. I saw Jonas RFC patch for
device tree integration into bcm63xx [1] and thought about doing
something similar for bcm47xx. Initially device tree would be used for
mapping gpios to leds and buttons.

I haven't read much about DT, but it looks nice. Is it possible to
detect devices by some arbitrary nvram settings like it is done in diag.c?

Hauke

[0]: https://dev.openwrt.org/browser/trunk/package/broadcom-diag/src/diag.c
[1]: http://www.linux-mips.org/archives/linux-mips/2012-11/msg00092.html
