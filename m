Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2018 14:41:12 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:62807 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990401AbeARNlE7gn5A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Jan 2018 14:41:04 +0100
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2018 05:41:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,377,1511856000"; 
   d="scan'208";a="27504072"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga002.jf.intel.com with ESMTP; 18 Jan 2018 05:40:58 -0800
Message-ID: <1516282857.7000.1057.camel@linux.intel.com>
Subject: Re: [PATCH v2] FIRMWARE: bcm47xx_nvram: Replace mac address parsing
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Date:   Thu, 18 Jan 2018 15:40:57 +0200
In-Reply-To: <4671dc40-8c6e-2525-bed0-89e7844026a4@hauke-m.de>
References: <20171221144055.3840-1-andriy.shevchenko@linux.intel.com>
         <4671dc40-8c6e-2525-bed0-89e7844026a4@hauke-m.de>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <andriy.shevchenko@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andriy.shevchenko@linux.intel.com
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

On Thu, 2017-12-21 at 17:42 +0100, Hauke Mehrtens wrote:
> 
> On 12/21/2017 03:40 PM, Andy Shevchenko wrote:
> > Replace sscanf() with mac_pton().
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> 
> The patch looks good, but I haven't tested them on my devices.

Any news on this, anyone?

> > ---
> > - use negative condition to be consistent with the rest code
> >  drivers/firmware/broadcom/Kconfig         |  1 +
> >  drivers/firmware/broadcom/bcm47xx_sprom.c | 18 +++---------------
> >  2 files changed, 4 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/firmware/broadcom/Kconfig
> > b/drivers/firmware/broadcom/Kconfig
> > index 5e29f83e7b39..c041dcb7ea52 100644
> > --- a/drivers/firmware/broadcom/Kconfig
> > +++ b/drivers/firmware/broadcom/Kconfig
> > @@ -13,6 +13,7 @@ config BCM47XX_NVRAM
> >  config BCM47XX_SPROM
> >  	bool "Broadcom SPROM driver"
> >  	depends on BCM47XX_NVRAM
> > +	select GENERIC_NET_UTILS
> >  	help
> >  	  Broadcom devices store configuration data in SPROM.
> > Accessing it is
> >  	  specific to the bus host type, e.g. PCI(e) devices have
> > it mapped in
> > diff --git a/drivers/firmware/broadcom/bcm47xx_sprom.c
> > b/drivers/firmware/broadcom/bcm47xx_sprom.c
> > index 62aa3cf09b4d..4787f86c8ac1 100644
> > --- a/drivers/firmware/broadcom/bcm47xx_sprom.c
> > +++ b/drivers/firmware/broadcom/bcm47xx_sprom.c
> > @@ -137,20 +137,6 @@ static void nvram_read_leddc(const char
> > *prefix, const char *name,
> >  	*leddc_off_time = (val >> 16) & 0xff;
> >  }
> >  
> > -static void bcm47xx_nvram_parse_macaddr(char *buf, u8 macaddr[6])
> > -{
> > -	if (strchr(buf, ':'))
> > -		sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
> > &macaddr[0],
> > -			&macaddr[1], &macaddr[2], &macaddr[3],
> > &macaddr[4],
> > -			&macaddr[5]);
> > -	else if (strchr(buf, '-'))
> > -		sscanf(buf, "%hhx-%hhx-%hhx-%hhx-%hhx-%hhx",
> > &macaddr[0],
> > -			&macaddr[1], &macaddr[2], &macaddr[3],
> > &macaddr[4],
> > -			&macaddr[5]);
> > -	else
> > -		pr_warn("Can not parse mac address: %s\n", buf);
> > -}
> > -
> >  static void nvram_read_macaddr(const char *prefix, const char
> > *name,
> >  			       u8 val[6], bool fallback)
> >  {
> > @@ -161,7 +147,9 @@ static void nvram_read_macaddr(const char
> > *prefix, const char *name,
> >  	if (err < 0)
> >  		return;
> >  
> > -	bcm47xx_nvram_parse_macaddr(buf, val);
> > +	strreplace(buf, '-', ':');
> > +	if (!mac_pton(buf, val))
> > +		pr_warn("Can not parse mac address: %s\n", buf);
> >  }
> >  
> >  static void nvram_read_alpha2(const char *prefix, const char *name,
> > 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
