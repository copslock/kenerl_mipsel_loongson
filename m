Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jan 2011 13:57:00 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:60518 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492064Ab1ADM4x convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Jan 2011 13:56:53 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 48BB445C013;
        Tue,  4 Jan 2011 13:56:44 +0100 (CET)
Received: from [192.168.254.10] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id 0B9461F0001;
        Tue,  4 Jan 2011 13:56:42 +0100 (CET)
Message-ID: <4D231907.8070302@openwrt.org>
Date:   Tue, 04 Jan 2011 13:56:39 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; hu-HU; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Grant Likely <grant.likely@secretlab.ca>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        David Brownell <dbrownell@users.sourceforge.net>,
        "Luis R. Rodriguez" <lrodriguez@atheros.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Kathy Giori <Kathy.Giori@Atheros.com>,
        spi-devel-general@lists.sourceforge.net,
        Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [PATCH v4 09/16] spi: add SPI controller driver for the Atheros
 AR71XX/AR724X/AR913X SoCs
References: <1293994589-6794-1-git-send-email-juhosg@openwrt.org> <1293994589-6794-10-git-send-email-juhosg@openwrt.org> <20110103170211.GA2522@angua.secretlab.ca>
In-Reply-To: <20110103170211.GA2522@angua.secretlab.ca>
X-Enigmail-Version: 1.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-VBMS: A1668018B32 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28818
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

2011.01.03. 18:02 keltezéssel, Grant Likely írta:
> On Sun, Jan 02, 2011 at 07:56:22PM +0100, Gabor Juhos wrote:
>> The Atheros AR71XX/AR724X/AR913X SoCs have a built-in SPI controller. This
>> patch implements a driver for that.
>>
> 
> Mostly looks okay to me.  A few comments below.  Do you want this one
> merged via my spi tree, or does it depend on other patches in this
> series?  I'm also okay with it going in with the rest of this series.

The driver won't be usable without the preceding patches in the series.
Additionally, further patches depends on this one so it should go via the MIPS tree.

> After addressing comments, feel free to add:
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Thank you!

>> <...>
>> +struct ath79_spi {
>> +	struct	spi_bitbang	bitbang;
>> +	u32			ioc_base;
>> +	u32			reg_ctrl;
>> +
>> +	void __iomem		*base;
>> +
>> +	struct platform_device	*pdev;
> 
> This field doesn't seem to actually be used anywhere.

True, i will remove that.

> 
>> +};
>> +
>> +static inline u32 ath79_spi_rr(struct ath79_spi *sp, unsigned reg)
>> +{
>> +	return ioread32(sp->base + reg);
>> +}
>> +
>> +static inline void ath79_spi_wr(struct ath79_spi *sp, unsigned reg, u32 val)
>> +{
>> +	iowrite32(val, sp->base + reg);
>> +}
>> +
>> +static inline struct ath79_spi *spidev_to_sp(struct spi_device *spi)
> 
> should be ath79_spidev_to_sp()

Ok.

> 
>> +{
>> +	return spi_master_get_devdata(spi->master);
>> +}
>> +
>> +static void ath79_spi_chipselect(struct spi_device *spi, int is_active)
>> +{
>> +	struct ath79_spi *sp = spidev_to_sp(spi);
>> +	int cs_high = (spi->mode & SPI_CS_HIGH) ? is_active : !is_active;
>> +
>> +	if (is_active) {
>> +		/* set initial clock polarity */
>> +		if (spi->mode & SPI_CPOL)
>> +			sp->ioc_base |= AR71XX_SPI_IOC_CLK;
>> +		else
>> +			sp->ioc_base &= ~AR71XX_SPI_IOC_CLK;
>> +
>> +		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
>> +	}
>> +
>> +	if (spi->chip_select) {
>> +		unsigned long gpio = (unsigned long) spi->controller_data;
>> +
>> +		/* SPI is normally active-low */
>> +		gpio_set_value(gpio, cs_high);
>> +	} else {
>> +		if (cs_high)
>> +			sp->ioc_base |= AR71XX_SPI_IOC_CS0;
>> +		else
>> +			sp->ioc_base &= ~AR71XX_SPI_IOC_CS0;
>> +
>> +		ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
>> +	}
>> +
>> +}
>> +
>> +static int ath79_spi_setup_cs(struct spi_device *spi)
>> +{
>> +	struct ath79_spi *sp = spidev_to_sp(spi);
>> +
>> +	/* enable GPIO mode */
>> +	ath79_spi_wr(sp, AR71XX_SPI_REG_FS, AR71XX_SPI_FS_GPIO);
>> +
>> +	/* save CTRL register */
>> +	sp->reg_ctrl = ath79_spi_rr(sp, AR71XX_SPI_REG_CTRL);
>> +	sp->ioc_base = ath79_spi_rr(sp, AR71XX_SPI_REG_IOC);
>> +
>> +	/* TODO: setup speed? */
>> +	ath79_spi_wr(sp, AR71XX_SPI_REG_CTRL, 0x43);
>> +
>> +	if (spi->chip_select) {
>> +		unsigned long gpio = (unsigned long) spi->controller_data;
> 
> Casting here is bad practice.  

It seems that the spi-gpio driver was a bad example. :)

> It would be better to have an explicit ath97_spi_controller_data structure.

I will add the explicit structure. Expect an updated version soon.

Thanks,
Gabor
