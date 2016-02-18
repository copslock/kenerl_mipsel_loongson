Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Feb 2016 17:39:48 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.10]:33805 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011800AbcBRQjqjYI9m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Feb 2016 17:39:46 +0100
Received: from mail.nefkom.net (unknown [192.168.8.184])
        by mail-out.m-online.net (Postfix) with ESMTP id 3q5hb50jDfz3hjkP;
        Thu, 18 Feb 2016 17:39:45 +0100 (CET)
X-Auth-Info: XWbrS6dDp6jGqrFa9FAHTlAjn983gwqHEgwSfIDD3o8=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mnet-online.de (Postfix) with ESMTPSA id 3q5hb43PkVzvdWS;
        Thu, 18 Feb 2016 17:39:44 +0100 (CET)
Message-ID: <56C5F3D4.3080809@denx.de>
Date:   Thu, 18 Feb 2016 17:39:48 +0100
From:   Marek Vasut <marex@denx.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
MIME-Version: 1.0
To:     Alan Stern <stern@rowland.harvard.edu>,
        Antony Pavlov <antonynpavlov@gmail.com>
CC:     linux-mips@linux-mips.org, Wills Wang <wills.wang@live.com>,
        Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
        Alban Bedel <albeu@free.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v5 07/15] usb: ehci: add vbus-gpio parameter
References: <Pine.LNX.4.44L0.1602181111350.1280-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1602181111350.1280-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <marex@denx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52117
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marex@denx.de
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

On 02/18/2016 05:12 PM, Alan Stern wrote:
> On Tue, 9 Feb 2016, Antony Pavlov wrote:
> 
>> This patch retrieves and configures the vbus control gpio via
>> the device tree.
>>
>> This patch is based on a ehci-s5p.c commit fd81d59c90d38661
>> ("USB: ehci-s5p: Add vbus setup function to the s5p ehci glue layer").
>>
>> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-usb@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  drivers/usb/host/ehci-platform.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
>> index bd7082f2..0d95ced 100644
>> --- a/drivers/usb/host/ehci-platform.c
>> +++ b/drivers/usb/host/ehci-platform.c
>> @@ -28,6 +28,7 @@
>>  #include <linux/io.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>> +#include <linux/of_gpio.h>
>>  #include <linux/phy/phy.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/reset.h>
>> @@ -142,6 +143,25 @@ static struct usb_ehci_pdata ehci_platform_defaults = {
>>  	.power_off =		ehci_platform_power_off,
>>  };
>>  
>> +static void setup_vbus_gpio(struct device *dev)
>> +{
>> +	int err;
>> +	int gpio;
>> +
>> +	if (!dev->of_node)
>> +		return;
>> +
>> +	gpio = of_get_named_gpio(dev->of_node, "vbus-gpio", 0);
>> +	if (!gpio_is_valid(gpio))
>> +		return;
>> +
>> +	err = devm_gpio_request_one(dev, gpio,
>> +				GPIOF_OUT_INIT_HIGH | GPIOF_EXPORT_DIR_FIXED,
>> +				"ehci_vbus_gpio");
>> +	if (err)
>> +		dev_err(dev, "can't request ehci vbus gpio %d", gpio);
> 
> I don't understand this.  If you get an error here, what's the point of 
> allowing the probe to continue?  Shouldn't you return an error code so 
> the probe will fail?

The idea is I believe that if there is no vbus gpio specified, the port
might just not have vbus control, so the probe can continue. But this
patch is irrelevant anyway, since Alexey will switch to CI HDRC driver
and use standard regulator, as it should be done.
