Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Nov 2010 22:04:11 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:44657 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491923Ab0KNVEI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Nov 2010 22:04:08 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id AE1D745C002;
        Sun, 14 Nov 2010 22:04:01 +0100 (CET)
Received: from [192.168.254.10] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 0E04A1F0003;
        Sun, 14 Nov 2010 22:03:58 +0100 (CET)
Message-ID: <4CE04EBC.4080701@openwrt.org>
Date:   Sun, 14 Nov 2010 22:03:56 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; hu-HU; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        David Brownell <dbrownell@users.sourceforge.net>,
        spi-devel-general@lists.sourceforge.net,
        Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [RFC 11/18] spi: add SPI controller driver for the Atheros AR71XX/AR724X/AR913X
 SoCs
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org> <1289598684-30624-12-git-send-email-juhosg@openwrt.org> <20101114082242.GA3137@angua.secretlab.ca>
In-Reply-To: <20101114082242.GA3137@angua.secretlab.ca>
X-Enigmail-Version: 1.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-VBMS: A112754AD59 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Grant,

>> <...>
>> +#include <asm/mach-ath79/ath79_spi_platform.h>
>> +
>> +#define DRV_DESC	"SPI controller driver for Atheros AR71XX/AR724X/AR91X"
> 
> Used exactly once.  Don't bother with a #define

Ok.

>> +#define DRV_NAME	"ath79-spi"
>> +
>> +struct ath79_spi {
>> +	struct	spi_bitbang	bitbang;
>> +	u32			ioc_base;
>> +	u32			reg_ctrl;
>> +
>> +	void __iomem		*base;
>> +
>> +	struct platform_device	*pdev;
>> +};
>> +
>> +static inline u32 ath79_spi_rr(struct ath79_spi *sp, unsigned reg)
>> +{
>> +	return __raw_readl(sp->base + reg);
>> +}
>> +
>> +static inline void ath79_spi_wr(struct ath79_spi *sp, unsigned reg, u32 val)
>> +{
>> +	__raw_writel(val, sp->base + reg);
>> +}
> 
> This is suspect.  Why is __raw_{readl,writel} being used instead of
> ioread32/iowrite32?  The __raw versions don't provide any kind of
> ordering barriers.

Mainly because the resulting code is smaller, and the performance is a bit
better with the use of the __raw versions. The controller is embedded into the
SoC and the registers are memory mapped, so i think it is safe to access them
with __raw_{readl,writel}. However I can change it if that is the preferred method.

>> <...>
>> +static int ath79_spi_probe(struct platform_device *pdev)
> 
> __devinit

I will add this.

> 
>> +{
>> +	struct spi_master *master;
>> +	struct ath79_spi *sp;
>> +	struct ath79_spi_platform_data *pdata;
>> +	struct resource	*r;
>> +	int ret;
>> +
>> +	master = spi_alloc_master(&pdev->dev, sizeof(*sp));
>> +	if (master == NULL) {
>> +		dev_err(&pdev->dev, "failed to allocate spi master\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	sp = spi_master_get_devdata(master);
>> +	platform_set_drvdata(pdev, sp);
>> +
>> +	pdata = pdev->dev.platform_data;
>> +
>> +	master->setup = ath79_spi_setup;
>> +	master->cleanup = ath79_spi_cleanup;
>> +	if (pdata) {
>> +		master->bus_num = pdata->bus_num;
>> +		master->num_chipselect = pdata->num_chipselect;
>> +	} else {
>> +		master->bus_num = 0;
> 
> Use -1 so that a bus number can be dynamically assigned

All right.

>> <...>
>> +static int ath79_spi_remove(struct platform_device *pdev)
> 
> __devexit
> 
>> +{
>> +	struct ath79_spi *sp = platform_get_drvdata(pdev);
>> +
>> +	spi_bitbang_stop(&sp->bitbang);
>> +	iounmap(sp->base);
>> +	platform_set_drvdata(pdev, NULL);
>> +	spi_master_put(sp->bitbang.master);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver ath79_spi_drv = {
>> +	.probe		= ath79_spi_probe,
>> +	.remove		= ath79_spi_remove,
> 
> __devexit_p(ath79_spi_remove),
> 

I will add these annotations as well.

Thank you,
Gabor
