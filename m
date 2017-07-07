Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jul 2017 22:19:02 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:54258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993949AbdGGUSyu1fpc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 7 Jul 2017 22:18:54 +0200
Received: from mail-yb0-f172.google.com (mail-yb0-f172.google.com [209.85.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39C8522C7C;
        Fri,  7 Jul 2017 20:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C8522C7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
Received: by mail-yb0-f172.google.com with SMTP id p207so14087465yba.2;
        Fri, 07 Jul 2017 13:18:53 -0700 (PDT)
X-Gm-Message-State: AIVw1138FBOxCCPfWCZIDkxHIm0LlZnGvBob0CqMigFQq4yTm4ROP5Y9
        w90l6OlHFxyjaOSh+lnCVFUaVvbIkg==
X-Received: by 10.37.98.141 with SMTP id w135mr1124576ybb.192.1499458732384;
 Fri, 07 Jul 2017 13:18:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.82.66 with HTTP; Fri, 7 Jul 2017 13:18:31 -0700 (PDT)
In-Reply-To: <704b3b8b-3f33-3d51-82d7-a9515fc39742@hauke-m.de>
References: <20170702224051.15109-1-hauke@hauke-m.de> <20170702224051.15109-6-hauke@hauke-m.de>
 <20170707140834.nugjw5jxkyzwrmzq@rob-hp-laptop> <704b3b8b-3f33-3d51-82d7-a9515fc39742@hauke-m.de>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 7 Jul 2017 15:18:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKM329HsQHCe4i6UK6SQZqRvJ-BPxOsv-1z0h=EDe2C-Q@mail.gmail.com>
Message-ID: <CAL_JsqKM329HsQHCe4i6UK6SQZqRvJ-BPxOsv-1z0h=EDe2C-Q@mail.gmail.com>
Subject: Re: [PATCH v7 05/16] watchdog: lantiq: add device tree binding documentation
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        John Crispin <john@phrozen.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59066
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

On Fri, Jul 7, 2017 at 2:01 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>
>
> On 07/07/2017 04:08 PM, Rob Herring wrote:
>> On Mon, Jul 03, 2017 at 12:40:40AM +0200, Hauke Mehrtens wrote:
>>> The binding was not documented before, add the documentation now.
>>>
>>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>>> ---
>>>  .../devicetree/bindings/watchdog/lantiq-wdt.txt    | 24 ++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
>>> new file mode 100644
>>> index 000000000000..c3967feebb6c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
>>> @@ -0,0 +1,24 @@
>>> +Lantiq WTD watchdog binding
>>> +============================
>>> +
>>> +This describes the binding of the Lantiq watchdog driver.
>>> +
>>> +-------------------------------------------------------------------------------
>>> +Required properties:
>>> +- compatible                : Should be one of
>>> +                            "lantiq,wdt"
>>> +                            "lantiq,xrx100-wdt"
>>> +                            "lantiq,xrx200-wdt"
>>> +                            "lantiq,falcon-wdt"
>>> +- lantiq,rcu                : A phandle to the RCU syscon (required for
>>> +                      "lantiq,falcon-wdt", "lantiq,xrx200-wdt" and
>>> +                      "lantiq,xrx100-wdt")
>>> +
>>> +-------------------------------------------------------------------------------
>>> +Example for the watchdog on the xRX200 SoCs:
>>> +            watchdog@803f0 {
>>> +                    compatible = "lantiq,xrx200-wdt", "lantiq,xrx100-wdt";
>>
>> This is still mismatched. If the example is correct, then the compatible
>> list should be:
>>
>> "lantiq,wdt"
>> "lantiq,xrx100-wdt"
>> "lantiq,xrx200-wdt", "lantiq,xrx100-wdt"
>> "lantiq,falcon-wdt"
>>
>> You can also remove "lantiq,xrx200-wdt" from the driver if you want as
>> "lantiq,xrx100-wdt" is good enough to match on.
>>
>> Rob
>>
> Ok thank you.
>
> All the features that are supported by the wtd drivers use the same
> register offsets on the xrx100 and xrx200 SoCs. I added the xrx200 only
> if in the future we find some mismatch and I want to be able to use some
> other code for this SoC.

Yes, the dts should have the xrx200 compatible. The driver can use the
xrx100 one until you need it.

> In this case I would then list complete compatible line which should be
> used for this SoC in the description of the compatible line, is that
> correct?

Yes.

Rob
