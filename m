Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 20:50:11 +0200 (CEST)
Received: from test.hauke-m.de ([5.39.93.123]:39721 "EHLO test.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860038AbaG3SuGSb0K0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Jul 2014 20:50:06 +0200
Received: from [IPv6:2001:470:7259:0:b12f:49a3:124:6e3c] (unknown [IPv6:2001:470:7259:0:b12f:49a3:124:6e3c])
        by test.hauke-m.de (Postfix) with ESMTPSA id A7685200D8;
        Wed, 30 Jul 2014 20:50:05 +0200 (CEST)
Message-ID: <53D93E5C.2000706@hauke-m.de>
Date:   Wed, 30 Jul 2014 20:50:04 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: BCM47XX: make reboot more relaiable
References: <1406584437-31108-1-git-send-email-hauke@hauke-m.de> <CACna6rw_OswnvN7YD7AVnCNKtKJAk8UGXEjUdVJEvaBF3ErAmQ@mail.gmail.com>
In-Reply-To: <CACna6rw_OswnvN7YD7AVnCNKtKJAk8UGXEjUdVJEvaBF3ErAmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41823
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

On 07/30/2014 08:06 PM, Rafał Miłecki wrote:
> On 28 July 2014 23:53, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> The reboot on the BCM47XX SoCs is done, by setting the watchdog counter
>> to 1 and let it trigger a reboot, when it reaches 0. Some devices with
>> a BCM4705/BCM4785 SoC do not reboot when the counter is set to 1 and
>> decreased to 0 by the hardware. It looks like it works more reliable
>> when we set it to 3. As far as I understand the hardware, this should
>> not make any difference, but I do not have access to any documentation
>> for this SoC.
>> It is still not 100% reliable.
> 
> Did you see code in hndmips.c of Broadcom SDK? Maybe we need this
> magic ASM code they have it there?
> 
> if (CHIPID(sih->chip) == BCM4785_CHIP_ID)
>     MTC0(C0_BROADCOM, 4, (1 << 22));
> si_watchdog(sih, 1);
> if (CHIPID(sih->chip) == BCM4785_CHIP_ID) {
>     __asm__ __volatile__(
>         ".set\tmips3\n\t"
>         "sync\n\t"
>         "wait\n\t"
>         ".set\tmips0");
> }
> while (1);
> 
> Maybe it'll work better and more reliable?
> 
This looks interesting, I haven't seen this.

Please drop this patch for now, I will create a new one

Hauke
