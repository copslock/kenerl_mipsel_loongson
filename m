Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jun 2017 00:17:15 +0200 (CEST)
Received: from hauke-m.de ([5.39.93.123]:45361 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992170AbdFTWRHvouFe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Jun 2017 00:17:07 +0200
Received: from [IPv6:2003:86:281e:2600:3d84:650:c911:2ee8] (p20030086281E26003D840650C9112EE8.dip0.t-ipconnect.de [IPv6:2003:86:281e:2600:3d84:650:c911:2ee8])
        by mail.hauke-m.de (Postfix) with ESMTPSA id 567CF1001DD;
        Wed, 21 Jun 2017 00:17:05 +0200 (CEST)
Subject: Re: [PATCH v4 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20170619222608.13344-1-hauke@hauke-m.de>
 <20170619222608.13344-11-hauke@hauke-m.de>
 <CAHp75Vc+UGCat0QcVeDuxEugc9r=yB5HNPnHuzAdmQnkK2=hGg@mail.gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        "martin.blumenstingl" <martin.blumenstingl@googlemail.com>,
        john <john@phrozen.org>, linux-spi <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <9a0479f2-e40d-fabb-38ce-8ea366f3da40@hauke-m.de>
Date:   Wed, 21 Jun 2017 00:17:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc+UGCat0QcVeDuxEugc9r=yB5HNPnHuzAdmQnkK2=hGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58711
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

On 06/20/2017 01:29 AM, Andy Shevchenko wrote:
> On Tue, Jun 20, 2017 at 1:26 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
>> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>
>> The reset controllers (on xRX200 and newer SoCs have two of them) are
>> provided by the RCU module. This was initially implemented as a simple
>> reset controller. However, the RCU module provides more functionality
>> (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
>> The old reset controller driver implementation from
>> arch/mips/lantiq/xway/reset.c did not honor this fact.
>>
>> For some devices the request and the status bits are different.
>>
> 
> FWIW,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> One nit below.
> 
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> ---
>>  .../devicetree/bindings/reset/lantiq,reset.txt     |  29 +++
>>  drivers/reset/Kconfig                              |   6 +
>>  drivers/reset/Makefile                             |   1 +
>>  drivers/reset/reset-lantiq.c                       | 215 +++++++++++++++++++++
>>  4 files changed, 251 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reset/lantiq,reset.txt
>>  create mode 100644 drivers/reset/reset-lantiq.c

......

>> +static int lantiq_rcu_reset_status_timeout(struct reset_controller_dev *rcdev,
>> +                                          unsigned long id, bool assert)
>> +{
>> +       int ret;
>> +       int retry = LANTIQ_RCU_RESET_TIMEOUT;
>> +
>> +       do {
>> +               ret = lantiq_rcu_reset_status(rcdev, id);
>> +               if (ret < 0)
>> +                       return ret;
> 
>> +               if (ret == assert)
>> +                       break;
> 
> return 0;
> 
>> +               usleep_range(20, 40);
>> +       } while (--retry);
>> +
> 
>> +       return retry ? 0 : -ETIMEDOUT;
> 
> return -ETIMEDOUT;
> 
Changed

...

Hauke
