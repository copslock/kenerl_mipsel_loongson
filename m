Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Nov 2015 06:32:02 +0100 (CET)
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33213 "EHLO
        mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009329AbbKQFcArRbvk convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Nov 2015 06:32:00 +0100
Received: by pabfh17 with SMTP id fh17so202833874pab.0;
        Mon, 16 Nov 2015 21:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lK/Ggun3Xid3hVwIAsMtPqtNfEE+wvIEBv2Gk1g96iM=;
        b=WXNwqIBpGh6ajeseUKK740xYIGvmkEHS2P5J0Wgt2RXTpU7rSt86Kr7eE8gf73DRW0
         3mDKHj6ck3YMeN6btD8PykC/nPrLc1fsX9sY5Ysps2KeW/I1XSfq7z0Sh5Ap20yK82Bj
         B+vmUmxrmiB1yXHly9m/6kxx2/iCj1D0NJxI++E0Xc5Md+tJL6FezkdervbXKiFeX4k3
         bcvKBWkdGrQZS95RvuOb1xWrAi0/4YyJqhZyut8sdvzEBCmX8nEB0K9Og2k+ujiOM5T+
         ltjC6LrK4xnUnzGn3fQX/AYjTxhDiWQCQx7QnToIrAw5iIuHT1DyEWWVT6Eykl3/p/nl
         Sd+Q==
X-Received: by 10.68.190.233 with SMTP id gt9mr6499095pbc.127.1447738314707;
        Mon, 16 Nov 2015 21:31:54 -0800 (PST)
Received: from [172.16.1.101] ([211.255.134.165])
        by smtp.gmail.com with ESMTPSA id bh4sm39899894pbb.17.2015.11.16.21.31.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Nov 2015 21:31:54 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3111\))
Subject: Re: [v4 02/10] ata: ahci_brcmstb: add quirk for broken ncq
From:   Jaedon Shin <jaedon.shin@gmail.com>
In-Reply-To: <20151117021603.GW8456@google.com>
Date:   Tue, 17 Nov 2015 14:31:48 +0900
Cc:     Florian Fainelli <f.fainelli@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dragan Stancevic <dragan.stancevic@gmail.com>,
        linux-ide@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>,
        devicetree@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9F5DD1EA-4BBE-445A-AF44-9F110E0B664B@gmail.com>
References: <1446213684-2625-1-git-send-email-jaedon.shin@gmail.com> <1446213684-2625-3-git-send-email-jaedon.shin@gmail.com> <20151117021603.GW8456@google.com>
To:     Brian Norris <computersforpeace@gmail.com>
X-Mailer: Apple Mail (2.3111)
Return-Path: <jaedon.shin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49960
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

Hi Brian,

> On Nov 17, 2015, at 11:16 AM, Brian Norris <computersforpeace@gmail.com> wrote:
> 
> Hi,
> 
> On Fri, Oct 30, 2015 at 11:01:16PM +0900, Jaedon Shin wrote:
>> Add quirk for broken ncq. Some chipsets (eg. BCM7349A0, BCM7445A0,
>> BCM7445B0, and all 40nm chipsets including BCM7425) need a workaround
>> disabling NCQ.
>> 
>> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
>> ---
>> drivers/ata/ahci_brcmstb.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 46 insertions(+)
>> 
>> diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcmstb.c
>> index 73e3b0b2a3c2..194aeda8f14d 100644
>> --- a/drivers/ata/ahci_brcmstb.c
>> +++ b/drivers/ata/ahci_brcmstb.c
>> @@ -69,10 +69,15 @@
>> 	(DATA_ENDIAN << DMADESC_ENDIAN_SHIFT) |		\
>> 	(MMIO_ENDIAN << MMIO_ENDIAN_SHIFT))
>> 
>> +enum brcm_ahci_quirks {
>> +	BRCM_AHCI_QUIRK_NONCQ		= BIT(0),
>> +};
>> +
>> struct brcm_ahci_priv {
>> 	struct device *dev;
>> 	void __iomem *top_ctrl;
>> 	u32 port_mask;
>> +	u32 quirks;
>> };
>> 
>> static const struct ata_port_info ahci_brcm_port_info = {
>> @@ -202,6 +207,42 @@ static u32 brcm_ahci_get_portmask(struct platform_device *pdev,
>> 	return impl;
>> }
>> 
>> +static void brcm_sata_quirks(struct platform_device *pdev,
>> +			     struct brcm_ahci_priv *priv)
>> +{
>> +	if (priv->quirks & BRCM_AHCI_QUIRK_NONCQ) {
>> +		void __iomem *ctrl = priv->top_ctrl + SATA_TOP_CTRL_BUS_CTRL;
>> +		void __iomem *ahci;
>> +		struct resource *res;
>> +		u32 reg;
>> +
>> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> +						   "ahci");
>> +		ahci = devm_ioremap_resource(&pdev->dev, res);
>> +		if (IS_ERR(ahci))
>> +			return;
>> +
>> +		reg = brcm_sata_readreg(ctrl);
>> +		reg |= OVERRIDE_HWINIT;
>> +		brcm_sata_writereg(reg, ctrl);
>> +
>> +		/* Clear out the NCQ bit so the AHCI driver will not issue
>> +		 * FPDMA/NCQ commands.
>> +		 */
>> +		reg = readl(ahci + HOST_CAP);
>> +		reg &= ~HOST_CAP_NCQ;
>> +		writel(reg, ahci + HOST_CAP);
> 
> You're using readl()/writel() to access the AHCI block, but...
> 
>> +
>> +		reg = brcm_sata_readreg(ctrl);
>> +		reg &= ~OVERRIDE_HWINIT;
>> +		brcm_sata_writereg(reg, ctrl);
>> +
>> +		devm_iounmap(&pdev->dev, ahci);
>> +		devm_release_mem_region(&pdev->dev, res->start,
>> +					resource_size(res));
>> +	}
>> +}
>> +
>> static void brcm_sata_init(struct brcm_ahci_priv *priv)
>> {
>> 	/* Configure endianness */
>> @@ -256,6 +297,11 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>> 	if (IS_ERR(priv->top_ctrl))
>> 		return PTR_ERR(priv->top_ctrl);
>> 
>> +	if (of_device_is_compatible(dev->of_node, "brcm,bcm7425-ahci"))
>> +		priv->quirks |= BRCM_AHCI_QUIRK_NONCQ;
>> +
>> +	brcm_sata_quirks(pdev, priv);
>> +
>> 	brcm_sata_init(priv);
> 
> ...the MMIO endianness is only configured in brcm_sata_init(). You won't
> see this problem on ARM LE, but you should on MIPS BE. Maybe
> brcm_sata_quirks() should be after brcm_sata_init()?
> 

Florian already pointed out, the NCQ disabling occurs prior to initializing 
the SATA controller endianness in the original BSP. Therefore I think it's better
to change to brcm_sata_{read,write}reg() instead of {read,write}l() for 
HOST_CAP overwriting.

>> 
>> 	priv->port_mask = brcm_ahci_get_portmask(pdev, priv);
> 
> Brian
