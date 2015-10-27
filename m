Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2015 10:55:41 +0100 (CET)
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36433 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010106AbbJ0JzjcOn4e convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 27 Oct 2015 10:55:39 +0100
Received: by pacfv9 with SMTP id fv9so227801379pac.3;
        Tue, 27 Oct 2015 02:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1NTf3myyAWRaOYYWWpOyZH0rBHsTmwCL2xe2Xb+dvLs=;
        b=QZG3ixTHB9ZOmrtsEsm4iH4Sfm71ITNvvNnNC7kml/XIj8lPUYnUWPyc08TsX2VL00
         4+0+SKLoeJXa+WhlW2vGr80IHznRqOeyUncnpVG+qeaZmkU63l+2jQ0Jj9oJVsbaPFUX
         T8yFrrJ0MiS2DAbE5Eib8e9JmVwmCFZcZ7leNI69X/g7lAP9lGwBq1UHM/nLeUXzc/PO
         S54DZuhSquEzzP7HiBDF9MEez7qCYKY0GC1oiHHcaa2+95lj/yb26WZm5XoWnVuNRcmR
         W2rEMPXh8EfSqxCydR8Bt1FUCYz32kQg/GD8fBtT2t3QKKsNqCdC+RixlX7w59GmJ6YT
         IPvA==
X-Received: by 10.68.134.73 with SMTP id pi9mr27618011pbb.169.1445939733497;
        Tue, 27 Oct 2015 02:55:33 -0700 (PDT)
Received: from [172.16.1.101] ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id dk2sm38641461pbd.57.2015.10.27.02.55.30
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 02:55:33 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [v2 03/10] ata: ahci_brcmstb: add quick for broken phy
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <CAL_Jsq+GngRS80_T2joPZwOB3gGnHZuuaTzXn6Tc07exAq_Fag@mail.gmail.com>
Date:   Tue, 27 Oct 2015 18:55:27 +0900
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <62DC2CD1-1992-4A64-A5DA-8CF13921BEED@gmail.com>
References: <1445928491-7320-1-git-send-email-jaedon.shin@gmail.com> <1445928491-7320-4-git-send-email-jaedon.shin@gmail.com> <CAL_Jsq+GngRS80_T2joPZwOB3gGnHZuuaTzXn6Tc07exAq_Fag@mail.gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
X-Mailer: Apple Mail (2.3096.5)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49716
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

On Oct 27, 2015, at 5:17 PM, Rob Herring <robh+dt@kernel.org> wrote:
> 
> On Tue, Oct 27, 2015 at 1:48 AM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
>> Add quick for broken phy. The ARM-based 28nm chipsets have four phy
> 
> I believe you mean "quirk".
> 

Oops! All the "quick" of patches should be changed to a "quirk".

Thanks.

>> interface control registers and each port has two registers. But, The
> 
> registers, but the...
> 
>> MIPS-based 40nm chipsets have three. and there are no information and
> 
> s/and there/There/
> 
>> documentation. The legacy version of broadcom's strict-ahci based
>> initial code did not control these registers.
>> 
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> ---
>> Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt |  1 +
> 
> Other than the commit message:
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
>> drivers/ata/ahci_brcmstb.c                                  | 10 ++++++++++
>> 2 files changed, 11 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
>> index 488a383ce202..0f0925d58188 100644
>> --- a/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
>> +++ b/Documentation/devicetree/bindings/ata/brcm,sata-brcmstb.txt
>> @@ -12,6 +12,7 @@ Required properties:
>> 
>> Optional properties:
>> - brcm,broken-ncq    : if present, NCQ is unusable
>> +- brcm,broken-phy    : if present, to control phy interface is unusable
>> 
>> Also see ahci-platform.txt.
>> 
>> diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
>> index e53962cb48ee..c61303f7c7dc 100644
>> --- a/drivers/ata/ahci_brcmstb.c
>> +++ b/drivers/ata/ahci_brcmstb.c
>> @@ -71,6 +71,7 @@
>> 
>> enum brcm_ahci_quicks {
>>        BRCM_AHCI_QUICK_NONCQ           = BIT(0),
>> +       BRCM_AHCI_QUICK_NOPHY           = BIT(1),
>> };
>> 
>> struct brcm_ahci_priv {
>> @@ -119,6 +120,9 @@ static void brcm_sata_phy_enable(struct brcm_ahci_priv *priv, int port)
>>        void __iomem *p;
>>        u32 reg;
>> 
>> +       if (priv->quicks & BRCM_AHCI_QUICK_NOPHY)
>> +               return;
>> +
>>        /* clear PHY_DEFAULT_POWER_STATE */
>>        p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_1;
>>        reg = brcm_sata_readreg(p);
>> @@ -148,6 +152,9 @@ static void brcm_sata_phy_disable(struct brcm_ahci_priv *priv, int port)
>>        void __iomem *p;
>>        u32 reg;
>> 
>> +       if (priv->quicks & BRCM_AHCI_QUICK_NOPHY)
>> +               return;
>> +
>>        /* power-off the PHY digital logic */
>>        p = phyctrl + SATA_TOP_CTRL_PHY_CTRL_2;
>>        reg = brcm_sata_readreg(p);
>> @@ -297,6 +304,9 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>>        if (of_property_read_bool(dev->of_node, "brcm,broken-ncq"))
>>                priv->quicks |= BRCM_AHCI_QUICK_NONCQ;
>> 
>> +       if (of_property_read_bool(dev->of_node, "brcm,broken-phy"))
>> +               priv->quicks |= BRCM_AHCI_QUICK_NOPHY;
>> +
>>        brcm_sata_init(priv);
>>        brcm_sata_quick(pdev, priv);
>> 
>> --
>> 2.6.2
>> 
