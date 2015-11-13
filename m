Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Nov 2015 21:28:30 +0100 (CET)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35949 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012066AbbKMU22FUQPP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Nov 2015 21:28:28 +0100
Received: by pacdm15 with SMTP id dm15so109837940pac.3;
        Fri, 13 Nov 2015 12:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=f8v9+UglHyyabYYnTdnYlEn2R8GWb93xeOFU1lDUC7E=;
        b=yyoy+lGMqkpHGipGsTPTKXGvvbuyWAV+uaeBlMhmmgBGk37G+k5EShyRjzOR5YW4Gl
         KHRtvCx2mJF3BpnAWxnQn98lp81zr5E94qhE1WPDaAgsY2QscavlvTpFb3jYUbnwaBHU
         slp0H5ivTf2DjXLloEVqHA6vJYw+S4I2Fi1iknEv3uLavieX+vD05eYpWP1jgD5tunC2
         wCpd12z6O7dd8DwqOmwkbICd9rJcXTd3b49Rv9ETLFHgZv08qiyCRQH+a+ISeiwMzQUE
         OlVcakw7jRuQGyS9Ur9BwMXljz5tBCKXWT5yzuxKCFNEn33fzgN3YNc8PmhtmY6V/Scz
         v0zA==
X-Received: by 10.68.68.132 with SMTP id w4mr34227535pbt.137.1447446502033;
        Fri, 13 Nov 2015 12:28:22 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id bz1sm22091850pab.20.2015.11.13.12.28.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2015 12:28:21 -0800 (PST)
Message-ID: <564647AE.7070805@gmail.com>
Date:   Fri, 13 Nov 2015 12:27:26 -0800
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Jaedon Shin <jaedon.shin@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org
Subject: Re: [v4 00/10] add support SATA for BMIPS_GENERIC
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
In-Reply-To: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 30/10/15 07:01, Jaedon Shin wrote:
> Hi all,
> 
> This patch series add support SATA for BMIPS_GENERIC.

Sorry for the lag.

Tested on 7425b2, there is a small mistake in the interrupt number for
the AHCI controller in the 7425.dtsi file (40 -> 41, see below), after
fixing that, I get both drives (external and internal ports) to be
identified successfully:

# dmesg | grep scsi
<6>[    0.964097] scsi host0: brcm-ahci
<6>[    0.967982] scsi host1: brcm-ahci
<5>[    1.122386] scsi 0:0:0:0: Direct-Access     ATA      WDC
WD2500AAKX-7 1H19 PQ: 0 ANSI: 5
<5>[    1.124512] sd 0:0:0:0: Attached scsi generic sg0 type 0
<5>[    1.411546] scsi 1:0:0:0: Direct-Access     ATA      WDC
WD2500AAKX-7 1H19 PQ: 0 ANSI: 5
<5>[    1.428870] sd 1:0:0:0: Attached scsi generic sg1 type 0
#

And performance looks good:

# hdparm -tT /dev/sda

/dev/sda:
[   48.557068] random: nonblocking pool is initialized
Timing buffer-cache reads:   524 MB in 0.50 seconds = 1052111 kB/s
Timing buffered disk reads:  358 MB in 3.00 seconds = 122132 kB/s
# hdparm -tT /dev/sdb

/dev/sdb:
Timing buffer-cache reads:   528 MB in 0.50 seconds = 1060559 kB/s
Timing buffered disk reads:  374 MB in 3.00 seconds = 127496 kB/s


Tested-by: Florian Fainelli <f.fainelli@gmail.com>

For interrupt numbers, computing them from the HIF_CPU_INTR1 register
works like this this:

HW IRQ# = N * 32 + M

where N ranges from 0->2 and M is the bit within the 32-bits word.

Thanks!

> 
> Changes in v4:
> - remove unused properties from bcm{7425,7342,7362}.dtsi
> 
> Changes in v3:
> - fix typo quirk instead of quick
> - disable NCQ before initialzing SATA controller endianness
> - fix misnomer controlling phy interface
> - remove brcm,broken-ncq and brcm,broken-phy properties from devicetree
> - use compatible string for quirks
> - use list for compatible strings
> - add "Acked-by:" tags
> 
> Changes in v2:
> - adds quirk for ncq
> - adds quirk for phy interface control
> - remove unused definitions in ahci_brcmstb
> - combines compatible string
> 
> Jaedon Shin (10):
>   ata: ahci_brcmstb: add support MIPS-based platforms
>   ata: ahci_brcmstb: add quirk for broken ncq
>   ata: ahci_brcmstb: add quirk for different phy
>   ata: ahci_brcmstb: remove unused definitions
>   phy: phy_brcmstb_sata: remove duplicate definitions
>   phy: phy_brcmstb_sata: add data for phy version
>   phy: phy_brcmstb_sata: add support MIPS-based platforms
>   MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7425
>   MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7346
>   MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7362
> 
>  .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  4 +-
>  .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  1 +
>  arch/mips/boot/dts/brcm/bcm7346.dtsi               | 40 +++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7362.dtsi               | 40 +++++++++++++++
>  arch/mips/boot/dts/brcm/bcm7425.dtsi               | 40 +++++++++++++++
>  arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |  8 +++
>  arch/mips/boot/dts/brcm/bcm97362svmb.dts           |  8 +++
>  drivers/ata/Kconfig                                |  2 +-
>  drivers/ata/ahci_brcmstb.c                         | 58 +++++++++++++++++++++-
>  drivers/phy/Kconfig                                |  4 +-
>  drivers/phy/phy-brcmstb-sata.c                     | 47 ++++++++++++++----
>  11 files changed, 236 insertions(+), 16 deletions(-)
> 


-- 
Florian
