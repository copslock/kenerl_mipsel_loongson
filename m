Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Aug 2017 13:29:53 +0200 (CEST)
Received: from mx2.mailbox.org ([80.241.60.215]:42008 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991955AbdH1L3pE06G1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Aug 2017 13:29:45 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id D91C64908C;
        Mon, 28 Aug 2017 13:29:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 97tgqcsUuLhn; Mon, 28 Aug 2017 13:29:37 +0200 (CEST)
Subject: Re: [PATCH v10 03/16] spi: spi-falcon: drop check of boot select
To:     Ralf Baechle <ralf@linux-mips.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        kishon@ti.com, mark.rutland@arm.com
References: <20170819221823.13850-1-hauke@hauke-m.de>
 <20170819221823.13850-4-hauke@hauke-m.de>
 <20170828112327.GA15640@linux-mips.org>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <40428f8d-f781-7952-30c6-41f65ec1096b@hauke-m.de>
Date:   Mon, 28 Aug 2017 13:29:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170828112327.GA15640@linux-mips.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59833
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

On 08/28/2017 01:23 PM, Ralf Baechle wrote:
> On Sun, Aug 20, 2017 at 12:18:10AM +0200, Hauke Mehrtens wrote:
> 
>> Do not check which flash type the SoC was booted from before
>> using this driver. Assume that the device tree is correct and use this
>> driver when it was added to device tree. This also removes a build
>> dependency to the SoC code.
>>
>> All device trees I am aware of only have one correct flash device entry
>> in it. The device tree is anyway bundled with the kernel in all systems
>> using device tree I know of.
>>
>> The boot mode can be specified with some pin straps and will select the
>> flash type the rom code will boot from. One SPI, NOR or NAND flash chip
>> can be connect to the EBU and used to load the first stage boot loader
>> from.
> 
> I think other than this patch we finally have all the acks necessary so
> I merged the series except this patch which shouldn't be strictly necessary.
> 
>   Ralf
> 

Hi Ralf and Mark,

this driver will not build any more without this patch, because
ltq_boot_select() gets removed in "[PATCH v10 09/16] MIPS: lantiq:
remove ltq_reset_cause() and ltq_boot_select()"

Mark could you please have a look at the commit message if it is better now.

Hauke
