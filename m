Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Nov 2012 14:29:37 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45244 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816553Ab2K3N3c4g5-M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Nov 2012 14:29:32 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id D7A078F65;
        Fri, 30 Nov 2012 14:29:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 35jmJ7HhGjnS; Fri, 30 Nov 2012 14:29:19 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:c1a9:1867:9184:6e2a] (unknown [IPv6:2001:470:1f0b:447:c1a9:1867:9184:6e2a])
        by hauke-m.de (Postfix) with ESMTPSA id 0A1B48F64;
        Fri, 30 Nov 2012 14:29:18 +0100 (CET)
Message-ID: <50B8B4AB.4060102@hauke-m.de>
Date:   Fri, 30 Nov 2012 14:29:15 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     john@phrozen.org, ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, florian@openwrt.org, m@bues.ch
Subject: Re: [PATCH v3 0/8] bcma/ssb/BCM47XX: add GPIO driver to ssb/bcma
References: <1353453874-523-1-git-send-email-hauke@hauke-m.de> <CACna6rzGE=CaD_9yAaTDkR6CuUy1HqRq1-v+fAd-Zg-uMmH2bQ@mail.gmail.com>
In-Reply-To: <CACna6rzGE=CaD_9yAaTDkR6CuUy1HqRq1-v+fAd-Zg-uMmH2bQ@mail.gmail.com>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 35159
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

On 11/30/2012 02:11 PM, Rafał Miłecki wrote:
> 2012/11/21 Hauke Mehrtens <hauke@hauke-m.de>:
>> This is a complete rewrote of the original patch "MIPS: BCM47xx: use
>> gpiolib"
>> Instead of providing the GPIO driver in the arch code it is now moved
>> into ssb and bcma and could also be used by other systems. The GPIO
>> functions in drivers/ssb/embedded.c are still used by arch/mips/bcm47xx
>> /wgt634u.c, but I am planing to write some code for baord detection and
>> a driver for LED and the buttons, after that wgt634u.c could be removed.
>>
>> This is based on mips/master tree.
> 
> Is this patches supposed to appear in
> http://git.kernel.org/?p=linux/kernel/git/ralf/linux.git;a=summary
> ? Just so I can know where to look for it.
> 
Hi Rafał,

It is in a mips tree at [0] and it is also in linux-next.

Hauke

[0]: http://git.linux-mips.org/?p=ralf/upstream-sfr.git;a=summary
