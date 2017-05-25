Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 May 2017 10:54:04 +0200 (CEST)
Received: from fllnx209.ext.ti.com ([198.47.19.16]:42072 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992178AbdEYIx5j5j03 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 May 2017 10:53:57 +0200
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id v4P8qHjG022928;
        Thu, 25 May 2017 03:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ti.com;
        s=ti-com-17Q1; t=1495702337;
        bh=WoaTcMcZM3ty4nusoO4wafUoOO9fRfnTGr+ih/qm1+U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=k5uu9p+C0/M/hWr6gVcYHDFA1cETCVRC4Bf4qEYAkJkZvShCFehU88Inc4kGGEYcv
         Ap3p+9Q7TfN/Sk4yw1tt2HXa81kUuH5OnqQYwsYngbStx8PBlQ9/QG7epvaF0J3qwu
         CLQMZtFa6Z1sJ2qd64jPiQB+5CxTDNnPkN3DFnzE=
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id v4P8qBGU028974;
        Thu, 25 May 2017 03:52:11 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE72.ent.ti.com
 (128.247.5.109) with Microsoft SMTP Server id 14.3.294.0; Thu, 25 May 2017
 03:52:11 -0500
Received: from [172.24.190.171] (ileax41-snat.itg.ti.com [10.172.224.153])      by
 dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id v4P8q5wE030475;        Thu, 25 May
 2017 03:52:06 -0500
Subject: Re: [PATCH 2/3] gpio: pcf857x: move header file out of I2C realm
To:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jonathan Cameron <jic23@cam.ac.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <20170521215727.1243-1-wsa@the-dreams.de>
 <20170521215727.1243-3-wsa@the-dreams.de>
 <CACRpkdZzrtP0Jr5ZnOJrN9CZQDO1CXgW7Z9jTw1Mt_MkP0Saqw@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <41555985-34c3-da9c-e4a4-f61d4eb2ec38@ti.com>
Date:   Thu, 25 May 2017 14:22:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdZzrtP0Jr5ZnOJrN9CZQDO1CXgW7Z9jTw1Mt_MkP0Saqw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <nsekhar@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58001
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nsekhar@ti.com
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

Hi Linus,

On Tuesday 23 May 2017 03:05 PM, Linus Walleij wrote:
> On Sun, May 21, 2017 at 11:57 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> 
>> include/linux/i2c is not for client devices. Move the header file to a
>> more appropriate location.
>>
>> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
>> ---
>>  arch/arm/mach-davinci/board-da830-evm.c        | 2 +-
>>  arch/arm/mach-davinci/board-dm644x-evm.c       | 2 +-
>>  arch/arm/mach-davinci/board-dm646x-evm.c       | 2 +-
>>  arch/arm/mach-pxa/balloon3.c                   | 2 +-
>>  arch/arm/mach-pxa/stargate2.c                  | 2 +-
>>  arch/mips/ath79/mach-pb44.c                    | 2 +-
>>  drivers/gpio/gpio-pcf857x.c                    | 2 +-
>>  include/linux/{i2c => platform_data}/pcf857x.h | 0
>>  8 files changed, 7 insertions(+), 7 deletions(-)
>>  rename include/linux/{i2c => platform_data}/pcf857x.h (100%)
> 
> Patch applied.
> 
> BTW ARM SoC maintainers be warned, I optimistically assume this will
> not collide with any ARM SoC work...

Thanks for the heads-up. The mach-davinci part does not clash with
anything I have queued. I added this patch to a branch of my tree which
I merge together but don't sent upstream. So I will know if I end up
queuing anything which clashes.

Thanks,
Sekhar
