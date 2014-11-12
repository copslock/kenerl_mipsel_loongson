Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 22:09:40 +0100 (CET)
Received: from hauke-m.de ([5.39.93.123]:50328 "EHLO hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013413AbaKLVJgTyPg6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Nov 2014 22:09:36 +0100
Received: from [IPv6:2001:470:7259:0:855b:83cf:788:3e2] (unknown [IPv6:2001:470:7259:0:855b:83cf:788:3e2])
        by hauke-m.de (Postfix) with ESMTPSA id DE82920025;
        Wed, 12 Nov 2014 22:09:35 +0100 (CET)
Message-ID: <5463CC8F.5000309@hauke-m.de>
Date:   Wed, 12 Nov 2014 22:09:35 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MIPS: BCM47XX: Move NVRAM driver to the drivers/misc/
References: <1415735146-31552-1-git-send-email-zajec5@gmail.com> <15071020.3LPpWWN4p1@wuerfel>
In-Reply-To: <15071020.3LPpWWN4p1@wuerfel>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44086
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

On 11/12/2014 10:43 AM, Arnd Bergmann wrote:
> On Tuesday 11 November 2014 20:45:46 Rafał Miłecki wrote:
>> After Broadcom switched from MIPS to ARM for their home routers we need
>> to have NVRAM driver in some common place (not arch/mips/).
>> We were thinking about putting it in bus directory, however there are
>> two possible buses for MIPS: drivers/ssb/ and drivers/bcma/. So this
>> won't fit there neither.
>> This is why I would like to move this driver to the drivers/misc/
>>
>> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
>>
> 
> I think drivers/soc would be more appropriate, as this is a purely
> in-kernel interface, and it interacts with other drivers, while
> drivers/misc is generally for oddball devices that don't fit in
> elsewhere and have their own user interface.
> 
> I don't remember if what we had concluded on the previous discussion.
> I think I suggested converting the nvram variables into DT properties
> on ARM. The API certainly feels obscure, so it would be nice to
> keep it out of the modern port if we can come up with a better alternative
> to pass the same information.

When there would be devices shipping with device tree in the boot loader
with this SoC I would go for using device tree for this purpose, but I
do not think there are any and I do not know what Broadcom plans are.

The nvram partition contains all configuration information about the
device like the MAC addresses, the calibration data for the Wifi chips
(either in the SoC or attached via PCIe/USB), default configuration for
the switch and so on. I think expect for the MAC addresses these values
do not vary on one series of boards, but I am to completely sure about
the calibration data. For the mac address we have to parse this as long
as the boot loader does not provide these information in some other way.

My plan would be that we integrate this nvram support into Linux also
for the ARM SoCs at first and then make the old drivers also take device
tree attributes. For new drivers we can make them use device tree
attributes only.

Hauke
