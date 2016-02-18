Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Feb 2016 18:41:10 +0100 (CET)
Received: from mail-lf0-f42.google.com ([209.85.215.42]:34289 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012967AbcBRRlJNxi6y convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 18 Feb 2016 18:41:09 +0100
Received: by mail-lf0-f42.google.com with SMTP id j78so37688169lfb.1
        for <linux-mips@linux-mips.org>; Thu, 18 Feb 2016 09:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2i0C7I/npKOtS2H1A2Osy5oyHor9I+P3L/dw7HXPcFI=;
        b=a3QvQdDA5OpQnGhjr3xaNrThlwlCNbmxj4JIA0Nv/BUCqu1vRH9IuRoaBEKxt5w8oK
         qCxkIdz7rs/KPL+cELC76LXrutjMHEyxnWd+wEWhyFd27keHhxwtIR9YR2AuurxYe+qb
         HP1OxpzSDI0N1NGHGvPGMyVsMLCXhbGOLMTEuuwx4aSfTk71/3SCk86okIDDSaNGT+xY
         1OekqW5f3wG4wiJ3MPgYhGdLaY1EGqiCNmpi4fnG02O0XJKmJWZiLJLmA/prnZao46Sg
         30GCq82kyfU65xuUVHaEIHfzXQSW2IeR3CA3OsuMS4A7q6klyZ5HVzCyvwfNugXb0O0F
         4l7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=2i0C7I/npKOtS2H1A2Osy5oyHor9I+P3L/dw7HXPcFI=;
        b=bCJ898FoYANiT/VEA2Nn8xJum2HfYvtGJV674QZbdv4Pr8oZTpgBaFponIi9qIfImZ
         phy7bIh9NKv5vgcx+Inp8Yo6pvHF2pAfrzWCXlldcHBWZWM2oDmUqIH8soFlXzVqf00K
         mstBLv6UGDMlNsY92BHdw0QDnbMTlsMa/o1Zcl0CdIz5bLB2ESuSfSdtJAz8s/tk8n8c
         jKPC8co0yDqlUqnvFNkle3cFYDAV/wxG1jQNHE1FAAHm1fRlEwEY3Ad9ZmcTh3KLr2mB
         aW7tt+OJVIF/LmoydoB+3ff6AdP46tXNUpBpQCc6FMyswGA6lO7+rDHv1uCB+mLN9KuM
         7KwQ==
X-Gm-Message-State: AG10YORjItXphWGJ2gkX1pALLBcrJsUC2q8F+3DbzUNUD8TzMR1Kh5btnFuiPG4L56S0eg==
X-Received: by 10.25.127.208 with SMTP id a199mr3062833lfd.149.1455817263823;
        Thu, 18 Feb 2016 09:41:03 -0800 (PST)
Received: from flare (t35.niisi.ras.ru. [193.232.173.35])
        by smtp.gmail.com with ESMTPSA id 88sm1056369lfr.44.2016.02.18.09.41.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Feb 2016 09:41:03 -0800 (PST)
Date:   Thu, 18 Feb 2016 21:06:52 +0300
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>, Marek Vasut <marex@denx.de>
Cc:     linux-mips@linux-mips.org, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v5 07/15] usb: ehci: add vbus-gpio parameter
Message-Id: <20160218210652.68ae464eed8ddbffd33e7a02@gmail.com>
In-Reply-To: <Pine.LNX.4.44L0.1602181111350.1280-100000@iolanthe.rowland.org>
References: <1455005641-7079-8-git-send-email-antonynpavlov@gmail.com>
        <Pine.LNX.4.44L0.1602181111350.1280-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed 3.5.0beta3 (GTK+ 2.24.25; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

On Thu, 18 Feb 2016 11:12:43 -0500 (EST)
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Tue, 9 Feb 2016, Antony Pavlov wrote:
> 
> > This patch retrieves and configures the vbus control gpio via
> > the device tree.
> > 
> > This patch is based on a ehci-s5p.c commit fd81d59c90d38661
> > ("USB: ehci-s5p: Add vbus setup function to the s5p ehci glue layer").
> > 
> > Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-usb@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/usb/host/ehci-platform.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
> > index bd7082f2..0d95ced 100644
> > --- a/drivers/usb/host/ehci-platform.c
> > +++ b/drivers/usb/host/ehci-platform.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_gpio.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/reset.h>
> > @@ -142,6 +143,25 @@ static struct usb_ehci_pdata ehci_platform_defaults = {
> >  	.power_off =		ehci_platform_power_off,
> >  };
> >  
> > +static void setup_vbus_gpio(struct device *dev)
> > +{
> > +	int err;
> > +	int gpio;
> > +
> > +	if (!dev->of_node)
> > +		return;
> > +
> > +	gpio = of_get_named_gpio(dev->of_node, "vbus-gpio", 0);
> > +	if (!gpio_is_valid(gpio))
> > +		return;
> > +
> > +	err = devm_gpio_request_one(dev, gpio,
> > +				GPIOF_OUT_INIT_HIGH | GPIOF_EXPORT_DIR_FIXED,
> > +				"ehci_vbus_gpio");
> > +	if (err)
> > +		dev_err(dev, "can't request ehci vbus gpio %d", gpio);
>
>
> I don't understand this.  If you get an error here, what's the point of 
> allowing the probe to continue?  Shouldn't you return an error code so 
> the probe will fail?

Please ignore the 'usb: ehci: add vbus-gpio parameter' patch!

In the new AR9331 patchseries I use chipidea USB driver (thanks to Marek for the suggestion)
in the AR9331 dtsi-file:

        usb: usb@1b000100 {
                compatible = "chipidea,usb2";
                reg = <0x1b000000 0x200>;

                interrupt-parent = <&cpuintc>;
                interrupts = <3>;
                resets = <&rst 5>;

                phy-names = "usb-phy";
                phys = <&usb_phy>;

                status = "disabled";
        };


so I use regulator in the TL-MR3020 board dts file:

        reg_usb_vbus: reg_usb_vbus {
                compatible = "regulator-fixed";
                regulator-name = "usb_vbus";
                regulator-min-microvolt = <5000000>;
                regulator-max-microvolt = <5000000>;
                gpio = <&gpio 8 GPIO_ACTIVE_HIGH>;
                enable-active-high;
        };

&usb {
        dr_mode = "host";
        vbus-supply = <&reg_usb_vbus>;
        status = "okay";
};

As a result there is no need in adding vbus-gpio parameter to ehci anymore!

> > +}
> > +
> >  static int ehci_platform_probe(struct platform_device *dev)
> >  {
> >  	struct usb_hcd *hcd;
> > @@ -174,6 +194,8 @@ static int ehci_platform_probe(struct platform_device *dev)
> >  		return irq;
> >  	}
> >  
> > +	setup_vbus_gpio(&dev->dev);
> > +
> >  	hcd = usb_create_hcd(&ehci_platform_hc_driver, &dev->dev,
> >  			     dev_name(&dev->dev));
> >  	if (!hcd)
> > 
> 


-- 
-- 
Best regards,
  Antony Pavlov
