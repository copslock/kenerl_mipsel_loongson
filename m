Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 Nov 2015 03:16:51 +0100 (CET)
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33952 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012227AbbKNCQsPTzVt convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 14 Nov 2015 03:16:48 +0100
Received: by padhx2 with SMTP id hx2so116936893pad.1;
        Fri, 13 Nov 2015 18:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gKfeWIP+/Hu6hD6f6xJF+LxDn4dUJQAr4mn3yfzdd/4=;
        b=uu6LtDdBlGKfORcFWmNb8lZc93sp8GDgiDzxwzufCFJA5s/qbUS8GuQijXH6K01q4o
         HaQVt6WQ0XVA9zPHsXSR69GBcmjDwvPK0uM8k3ebR7vsJPVFT+BGOhVZcssG4ztbdHiq
         kIkASsnc472n43ML5WfwvqK54nUoMIRQZA2pfcG94vxJPXLCE2oTTHcTwBO2VHaWEPzP
         7i7vGVcDGsbmQrMsOvGQXzntw6PJ/8YsBd5qoTy+YbnBCYFCtMtpRSCwB6ooVmcakX9y
         U+ae0r/NlSYALkaXztpYZ3nNnpfapQYu3jRfbgxdg8tGbMC3u8kxA/OYb4VlbHuJlScr
         H4/A==
X-Received: by 10.68.245.138 with SMTP id xo10mr36079171pbc.50.1447467401941;
        Fri, 13 Nov 2015 18:16:41 -0800 (PST)
Received: from [192.168.0.105] ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id bn1sm22884235pad.17.2015.11.13.18.16.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Nov 2015 18:16:41 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3111\))
Subject: Re: [v4 00/10] add support SATA for BMIPS_GENERIC
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <564647AE.7070805@gmail.com>
Date:   Sat, 14 Nov 2015 11:16:36 +0900
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <AD47C548-229B-455C-8BF1-E95752FB6C87@gmail.com>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com> <564647AE.7070805@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: Apple Mail (2.3111)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jaedon.shin@gmail.com
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

Hi Florian,

> On Nov 14, 2015, at 5:27 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 
> On 30/10/15 07:01, Jaedon Shin wrote:
>> Hi all,
>> 
>> This patch series add support SATA for BMIPS_GENERIC.
> 
> Sorry for the lag.
> 
> Tested on 7425b2, there is a small mistake in the interrupt number for
> the AHCI controller in the 7425.dtsi file (40 -> 41, see below), after
> fixing that, I get both drives (external and internal ports) to be
> identified successfully:
> 

It's a mistake, and your explanation is correct.

The patches of device node are already applied by Ralf. So I'll add a patch
to fix the details for applied patches.

Thanks.

Jaedon

> # dmesg | grep scsi
> <6>[    0.964097] scsi host0: brcm-ahci
> <6>[    0.967982] scsi host1: brcm-ahci
> <5>[    1.122386] scsi 0:0:0:0: Direct-Access     ATA      WDC
> WD2500AAKX-7 1H19 PQ: 0 ANSI: 5
> <5>[    1.124512] sd 0:0:0:0: Attached scsi generic sg0 type 0
> <5>[    1.411546] scsi 1:0:0:0: Direct-Access     ATA      WDC
> WD2500AAKX-7 1H19 PQ: 0 ANSI: 5
> <5>[    1.428870] sd 1:0:0:0: Attached scsi generic sg1 type 0
> #
> 
> And performance looks good:
> 
> # hdparm -tT /dev/sda
> 
> /dev/sda:
> [   48.557068] random: nonblocking pool is initialized
> Timing buffer-cache reads:   524 MB in 0.50 seconds = 1052111 kB/s
> Timing buffered disk reads:  358 MB in 3.00 seconds = 122132 kB/s
> # hdparm -tT /dev/sdb
> 
> /dev/sdb:
> Timing buffer-cache reads:   528 MB in 0.50 seconds = 1060559 kB/s
> Timing buffered disk reads:  374 MB in 3.00 seconds = 127496 kB/s
> 
> 
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> For interrupt numbers, computing them from the HIF_CPU_INTR1 register
> works like this this:
> 
> HW IRQ# = N * 32 + M
> 
> where N ranges from 0->2 and M is the bit within the 32-bits word.
> 
> Thanks!
> 
>> 
>> Changes in v4:
>> - remove unused properties from bcm{7425,7342,7362}.dtsi
>> 
>> Changes in v3:
>> - fix typo quirk instead of quick
>> - disable NCQ before initialzing SATA controller endianness
>> - fix misnomer controlling phy interface
>> - remove brcm,broken-ncq and brcm,broken-phy properties from devicetree
>> - use compatible string for quirks
>> - use list for compatible strings
>> - add "Acked-by:" tags
>> 
>> Changes in v2:
>> - adds quirk for ncq
>> - adds quirk for phy interface control
>> - remove unused definitions in ahci_brcmstb
>> - combines compatible string
>> 
>> Jaedon Shin (10):
>>  ata: ahci_brcmstb: add support MIPS-based platforms
>>  ata: ahci_brcmstb: add quirk for broken ncq
>>  ata: ahci_brcmstb: add quirk for different phy
>>  ata: ahci_brcmstb: remove unused definitions
>>  phy: phy_brcmstb_sata: remove duplicate definitions
>>  phy: phy_brcmstb_sata: add data for phy version
>>  phy: phy_brcmstb_sata: add support MIPS-based platforms
>>  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7425
>>  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7346
>>  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7362
>> 
>> .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  4 +-
>> .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  1 +
>> arch/mips/boot/dts/brcm/bcm7346.dtsi               | 40 +++++++++++++++
>> arch/mips/boot/dts/brcm/bcm7362.dtsi               | 40 +++++++++++++++
>> arch/mips/boot/dts/brcm/bcm7425.dtsi               | 40 +++++++++++++++
>> arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |  8 +++
>> arch/mips/boot/dts/brcm/bcm97362svmb.dts           |  8 +++
>> drivers/ata/Kconfig                                |  2 +-
>> drivers/ata/ahci_brcmstb.c                         | 58 +++++++++++++++++++++-
>> drivers/phy/Kconfig                                |  4 +-
>> drivers/phy/phy-brcmstb-sata.c                     | 47 ++++++++++++++----
>> 11 files changed, 236 insertions(+), 16 deletions(-)
>> 
> 
> 
> -- 
> Florian
