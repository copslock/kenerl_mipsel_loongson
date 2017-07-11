Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jul 2017 08:40:49 +0200 (CEST)
Received: from lelnx194.ext.ti.com ([198.47.27.80]:11136 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991978AbdGKGkmzvXHe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Jul 2017 08:40:42 +0200
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id v6B6c6I4010098;
        Tue, 11 Jul 2017 01:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ti.com;
        s=ti-com-17Q1; t=1499755086;
        bh=h4xHMmrtNPldBAbKG58wsjflyqS/BWWZAXd/xGW4UzA=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=ZB60FzOSnyBGiaseTZTMu9sq0cAHdQMrv3RUKqmRDb9Hrnz80DlkyFCwBaafrTxcR
         UGekR9QXBSEnvLHxux4Pw87mrZgdBYaTPUzduaR9Z8WOnK7U+c6ro/941U4S2gHtu4
         rrHZeFx4RriSV+P4oLoT+0o3QrYGTTAHrujifvWA=
Received: from DLEE70.ent.ti.com (dlemailx.itg.ti.com [157.170.170.113])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id v6B6c6ug001121;
        Tue, 11 Jul 2017 01:38:06 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE70.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server id 14.3.294.0; Tue, 11 Jul 2017
 01:38:05 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])      by
 dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id v6B6c1j6005262;        Tue, 11 Jul
 2017 01:38:02 -0500
Subject: Re: [PATCH v7 14/16] phy: Add an USB PHY driver for the Lantiq SoCs
 using the RCU module
To:     Rob Herring <robh@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>
References: <20170702224051.15109-1-hauke@hauke-m.de>
 <20170702224051.15109-15-hauke@hauke-m.de>
 <20170707142312.5pwily3gbntvesbm@rob-hp-laptop>
CC:     <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <linux-mtd@lists.infradead.org>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <martin.blumenstingl@googlemail.com>,
        <john@phrozen.org>, <linux-spi@vger.kernel.org>,
        <hauke.mehrtens@intel.com>, <andy.shevchenko@gmail.com>,
        <p.zabel@pengutronix.de>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <30adb3f5-50b5-35e3-685f-9fe0fa8c31f8@ti.com>
Date:   Tue, 11 Jul 2017 12:08:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170707142312.5pwily3gbntvesbm@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-Path: <kishon@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59088
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

Hi,

On Friday 07 July 2017 07:53 PM, Rob Herring wrote:
> On Mon, Jul 03, 2017 at 12:40:49AM +0200, Hauke Mehrtens wrote:
>> This driver starts the DWC2 core(s) built into the XWAY SoCs and provides
>> the PHY interfaces for each core. The phy instances can be passed to the
>> dwc2 driver, which already supports the generic phy interface.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>

I see you have added my name in cc but for some reason I don't have the patch
in my mailbox. Can you resend it please?

>> ---
>>  .../bindings/phy/phy-lantiq-rcu-usb2.txt           |  42 ++++
>>  arch/mips/lantiq/xway/sysctrl.c                    |  24 +-
>>  drivers/phy/Kconfig                                |   8 +
>>  drivers/phy/Makefile                               |   1 +
>>  drivers/phy/phy-lantiq-rcu-usb2.c                  | 275 +++++++++++++++++++++

Please create a new directory withing phy for adding a phy driver.

Thanks
Kishon
