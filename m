Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2014 14:02:09 +0200 (CEST)
Received: from smtpbgbr1.qq.com ([54.207.19.206]:46313 "EHLO smtpbgbr1.qq.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6855367AbaHTMCBaB7j2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Aug 2014 14:02:01 +0200
X-QQ-mid: bizesmtp8t1408536005t504t326
Received: from mail-ie0-f178.google.com (unknown [209.85.223.178])
        by esmtp4.qq.com (ESMTP) with 
        id ; Wed, 20 Aug 2014 20:00:03 +0800 (CST)
X-QQ-SSF: 01100000008000F0FF22B00A0000000
X-QQ-FEAT: HlPlO+HuJuzufYeN1dI2UgMRoqLOzybLks2Okr3w/I5bWDVZleHwtcv8uOWg9
        ZlYzIk/mDF25DP4byIClIrH1JjGXD7VrSvCjysQd+X57q2nEuJLEUyQ/uOkCSXBu3VEIr99
        +LbAGgx/2rxUKqGoRNLuYokCSoWIyuz3dty7emLV14xJysvTKNzQXHifJswT0I5eRqYDrjo
        =
X-QQ-GoodBg: 0
Received: by mail-ie0-f178.google.com with SMTP id rd18so2708632iec.9
        for <multiple recipients>; Wed, 20 Aug 2014 05:00:01 -0700 (PDT)
X-Received: by 10.43.164.130 with SMTP id ms2mr48070931icc.9.1408536001898;
 Wed, 20 Aug 2014 05:00:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.26.201 with HTTP; Wed, 20 Aug 2014 04:59:41 -0700 (PDT)
In-Reply-To: <20140820105356.GA21497@linux-mips.org>
References: <1408504488-12319-1-git-send-email-chenj@lemote.com>
 <1408504488-12319-2-git-send-email-chenj@lemote.com> <20140820105356.GA21497@linux-mips.org>
From:   Chen Jie <chenj@lemote.com>
Date:   Wed, 20 Aug 2014 19:59:41 +0800
Message-ID: <CAGXxSxVqEs5jyckaOG=iX24UeV2P_WgmqV=EBQYycRJ1P9vPgg@mail.gmail.com>
Subject: Re: [PATCH] mips: define _MIPS_ARCH_LOONGSON3A for Loongson3
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        =?UTF-8?B?546L6ZSQ?= <wangr@lemote.com>
Content-Type: text/plain; charset=UTF-8
X-QQ-SENDSIZE: 520
X-QQ-Bgrelay: 1
Return-Path: <chenj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42162
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
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

2014-08-20 18:53 GMT+08:00 Ralf Baechle <ralf@linux-mips.org>:
> On Wed, Aug 20, 2014 at 11:14:48AM +0800, chenj wrote:
>
>> +cflags-$(CONFIG_CPU_LOONGSON3)  += -D_MIPS_ARCH_LOONGSON3A
>
> The _MIPS_ARCH_* namespace belongs to GCC.  While it seems current GCC
> does not define this symbol _MIPS_ARCH_LOONGSON3A runs into the danger
> of causing a conflict when GCC eventually will define the symbol.
When this symbol will be defined? With option '-march=loongson3a'?
