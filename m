Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 16:45:17 +0200 (CEST)
Received: from bear.ext.ti.com ([192.94.94.41]:59113 "EHLO bear.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27026939AbbEKOpPNI9Oe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 May 2015 16:45:15 +0200
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id t4BEj5mD017204;
        Mon, 11 May 2015 09:45:05 -0500
Received: from DLEE71.ent.ti.com (dlee71.ent.ti.com [157.170.170.114])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id t4BEj4wE031494;
        Mon, 11 May 2015 09:45:05 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE71.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server id 14.3.224.2; Mon, 11 May 2015
 09:45:04 -0500
Received: from [172.24.190.82] (ileax41-snat.itg.ti.com [10.172.224.153])       by
 dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id t4BEj1MA011876;        Mon, 11 May
 2015 09:45:02 -0500
Message-ID: <5550C06D.2010409@ti.com>
Date:   Mon, 11 May 2015 20:15:01 +0530
From:   Kishon Vijay Abraham I <kishon@ti.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     <1428444258-25852-1-git-send-email-abrestic@chromium.org>,
        <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     <devicetree@vger.kernel.org>,
        James Hartley <james.hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Bresticker <abrestic@chromium.org>
Subject: Re: [PATCH V2 0/3] Pistachio USB2.0 PHY
References: <1428444258-25852-1-git-send-email-abrestic@chromium.org> <CAL1qeaE0+aMLBgk8SKgJ3fXm==M2-Z_yEPYNVZ0yxSee-p7YOw@mail.gmail.com> <5549083F.8080505@imgtec.com>
In-Reply-To: <5549083F.8080505@imgtec.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kishon@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kishon@ti.com
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



On Tuesday 05 May 2015 11:43 PM, Ezequiel Garcia wrote:
> Hi Kishon,
>
>>
>> This series adds support for the USB2.0 PHY present on the IMG Pistachio SoC.
>>
>> Based on mips-for-linux-next and tested on the IMG Pistachio BuB.  If possible,
>> I'd like this to go through the MIPS tree with Kishon's ACK.
>>
>
> Tested-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>
> Can we have your Ack for this series so Ralf can pick it?

sure..

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
>
> Thanks!
> Ezequiel
>
>> Cc: James Hartley <james.hartley@imgtec.com>
>> Cc: Damien Horsley <Damien.Horsley@imgtec.com>
>>
>> Changes from v1:
>>   - Added patch to enable PHY driver in pistachio_defconfig
>>   - Fixed a couple of spelling errors
>>
>> Andrew Bresticker (3):
>>    phy: Add binding document for Pistachio USB2.0 PHY
>>    phy: Add driver for Pistachio USB2.0 PHY
>>    MIPS: pistachio: Enable USB PHY driver in defconfig
>>
>>   .../devicetree/bindings/phy/pistachio-usb-phy.txt  |  29 +++
>>   arch/mips/configs/pistachio_defconfig              |   1 +
>>   drivers/phy/Kconfig                                |   7 +
>>   drivers/phy/Makefile                               |   1 +
>>   drivers/phy/phy-pistachio-usb.c                    | 206 +++++++++++++++++++++
>>   include/dt-bindings/phy/phy-pistachio-usb.h        |  16 ++
>>   6 files changed, 260 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
>>   create mode 100644 drivers/phy/phy-pistachio-usb.c
>>   create mode 100644 include/dt-bindings/phy/phy-pistachio-usb.h
>>
>> --
>> 2.2.0.rc0.207.ga3a616c
>>
>
