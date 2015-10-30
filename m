Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Oct 2015 14:56:49 +0100 (CET)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36730 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010999AbbJ3N4rfwO10 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Oct 2015 14:56:47 +0100
Received: by pacfv9 with SMTP id fv9so78592077pac.3;
        Fri, 30 Oct 2015 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=luWrn0SPBdJ52kzHp8ukLnisvqOYbFS88XJvz0sMzkw=;
        b=H89IyBi/EPaVngArOK6Tt9GwcozzQOeovPCv1mwyFpM6v/heUxTyAXZnLfffH4nueU
         06sj2DwqgZDUs/3otgmaIYmAbPZDU8QRlmoySeLQWySNNkJsB/bFdFLXhP4B2X1FY0ZT
         ixpYQvHpmNmQqBEI8fH99JbGntcI9s+FnsG0KUDGsEs+rKLNbJ1Q3A5uUj9w7Z8Y3jgI
         cD0UAjlvxVhI8fcGZOYFfpxbzCtFSJGUkHKmZUHr+6FEs+jJ4+iH9Kh2hnazCK4JZS0W
         dIjOCY2oaBBl6wNeGYOMzlSr6Uw5ptG+dICwha3OtNeHVF43jzaKnnk+3oM67GmMP7Wv
         JF5w==
X-Received: by 10.66.122.69 with SMTP id lq5mr8944106pab.125.1446213401778;
        Fri, 30 Oct 2015 06:56:41 -0700 (PDT)
Received: from [192.168.0.105] ([59.12.167.210])
        by smtp.gmail.com with ESMTPSA id or3sm8428009pbb.56.2015.10.30.06.56.38
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 30 Oct 2015 06:56:41 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [v3 00/10] add support SATA for BMIPS_GENERIC
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
Date:   Fri, 30 Oct 2015 22:56:36 +0900
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <673D3A37-DE97-4136-BDCE-3DF803405F59@gmail.com>
References: <1446212339-1210-1-git-send-email-jaedon.shin@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>
X-Mailer: Apple Mail (2.3096.5)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49787
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

Hi all,

Please discard this patch series. These have fault properties.

Sorry, for the noise.

I will soon send v4 version again.

--
Jaedon

> On Oct 30, 2015, at 10:38 PM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> 
> Hi all,
> 
> This patch series add support SATA for BMIPS_GENERIC.
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
>  ata: ahci_brcmstb: add support MIPS-based platforms
>  ata: ahci_brcmstb: add quirk for broken ncq
>  ata: ahci_brcmstb: add quirk for different phy
>  ata: ahci_brcmstb: remove unused definitions
>  phy: phy_brcmstb_sata: remove duplicate definitions
>  phy: phy_brcmstb_sata: add data for phy version
>  phy: phy_brcmstb_sata: add support MIPS-based platforms
>  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7425
>  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7346
>  MIPS: BMIPS: brcmstb: add SATA/PHY nodes for bcm7362
> 
> .../devicetree/bindings/ata/brcm,sata-brcmstb.txt  |  4 +-
> .../bindings/phy/brcm,brcmstb-sata-phy.txt         |  1 +
> arch/mips/boot/dts/brcm/bcm7346.dtsi               | 42 ++++++++++++++++
> arch/mips/boot/dts/brcm/bcm7362.dtsi               | 42 ++++++++++++++++
> arch/mips/boot/dts/brcm/bcm7425.dtsi               | 42 ++++++++++++++++
> arch/mips/boot/dts/brcm/bcm97346dbsmb.dts          |  8 +++
> arch/mips/boot/dts/brcm/bcm97362svmb.dts           |  8 +++
> drivers/ata/Kconfig                                |  2 +-
> drivers/ata/ahci_brcmstb.c                         | 58 +++++++++++++++++++++-
> drivers/phy/Kconfig                                |  4 +-
> drivers/phy/phy-brcmstb-sata.c                     | 47 ++++++++++++++----
> 11 files changed, 242 insertions(+), 16 deletions(-)
> 
> -- 
> 2.6.2
> 
