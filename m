Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Apr 2017 18:58:34 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:34058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993927AbdDYQ6Yi0l7d (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Apr 2017 18:58:24 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 4C5D9201B4;
        Tue, 25 Apr 2017 16:58:22 +0000 (UTC)
Received: from mail-yw0-f171.google.com (mail-yw0-f171.google.com [209.85.161.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8B6E201C8;
        Tue, 25 Apr 2017 16:58:19 +0000 (UTC)
Received: by mail-yw0-f171.google.com with SMTP id u70so98793527ywe.2;
        Tue, 25 Apr 2017 09:58:19 -0700 (PDT)
X-Gm-Message-State: AN3rC/4DdbJ8f3+Pi26wEocGdc6d4Sl0VjqaKoBNBpjW2qqdhkGLxrw+
        h7WrFV+phOuj8BXx3VNN+bf5C5f8CQ==
X-Received: by 10.129.104.67 with SMTP id d64mr10841872ywc.97.1493139499052;
 Tue, 25 Apr 2017 09:58:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.52.82 with HTTP; Tue, 25 Apr 2017 09:57:58 -0700 (PDT)
In-Reply-To: <8742e3b3-4dc2-bc74-f607-00d96f74512c@hauke-m.de>
References: <20170417192942.32219-1-hauke@hauke-m.de> <20170417192942.32219-7-hauke@hauke-m.de>
 <20170420144848.hwvtrhnwxcsxyv7x@rob-hp-laptop> <8742e3b3-4dc2-bc74-f607-00d96f74512c@hauke-m.de>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 25 Apr 2017 11:57:58 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLdtyc_w5CWW9YTN6+xnYVQemSbVEmjJbhH8kP_8a-wkA@mail.gmail.com>
Message-ID: <CAL_JsqLdtyc_w5CWW9YTN6+xnYVQemSbVEmjJbhH8kP_8a-wkA@mail.gmail.com>
Subject: Re: [PATCH 06/13] MIPS: lantiq: Convert the xbar driver to a platform_driver
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        John Crispin <john@phrozen.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        hauke.mehrtens@intel.com
Content-Type: text/plain; charset=UTF-8
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Tue, Apr 25, 2017 at 1:56 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>
>
> On 04/20/2017 04:48 PM, Rob Herring wrote:
>> On Mon, Apr 17, 2017 at 09:29:35PM +0200, Hauke Mehrtens wrote:
>>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>>
>>> This allows using the xbar driver on ARX300 based SoCs which require the
>>> same xbar setup as the xRX200 chipsets because the xbar driver
>>> initialization is not guarded by an xRX200 specific
>>> of_machine_is_compatible condition anymore. Additionally the new driver
>>> takes a syscon phandle to configure the XBAR endianness bits in RCU
>>> (before this was done in arch/mips/lantiq/xway/reset.c and also
>>> guarded by an xRX200 specific if-statement).
>>>
>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>> ---
>>>  .../devicetree/bindings/mips/lantiq/xbar.txt       |  22 +++++
>>>  MAINTAINERS                                        |   1 +
>>>  arch/mips/lantiq/xway/reset.c                      |   4 -
>>>  arch/mips/lantiq/xway/sysctrl.c                    |  41 ---------
>>>  drivers/soc/Makefile                               |   1 +
>>>  drivers/soc/lantiq/Makefile                        |   1 +
>>>  drivers/soc/lantiq/xbar.c                          | 100 +++++++++++++++++++++
>>>  7 files changed, 125 insertions(+), 45 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>>>  create mode 100644 drivers/soc/lantiq/Makefile
>>>  create mode 100644 drivers/soc/lantiq/xbar.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/mips/lantiq/xbar.txt b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>>> new file mode 100644
>>> index 000000000000..86e53ff3b0d5
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mips/lantiq/xbar.txt
>>> @@ -0,0 +1,22 @@
>>> +Lantiq XWAY SoC XBAR binding
>>> +============================
>>> +
>>> +
>>> +-------------------------------------------------------------------------------
>>> +Required properties:
>>> +- compatible        : Should be "lantiq,xbar-xway"
>>
>> This compatible is already in use so it is fine, but you should also
>> have per SoC compatible strings.
>
> I will add a new SoC specific one.
> What does per SoC device tree mean? Does it mean for the same silicon,
> for the same silicon revision, for the same fusing of a silicon or for
> the same marketing name?

Depends how specific you need to some extent. For fusing, packaging,
metal fixes, speed grading, etc. probably use the same compatible.
Different design and dies from the start, then they should have
different compatibles.

> I would like to make it per silicon or per silicon revision for the IP
> cores which I know are different.

Being "the same IP" doesn't really matter. The errata can be different
and often there is no visibility into what h/w designers may have
changed. On some IP you can rely on revision/feature registers though
forgetting to rev revision registers is not uncommon. You need to have
sufficient information that you can work-around a problem in the
future without requiring a new dtb.

Rob
