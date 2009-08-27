Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2009 16:14:27 +0200 (CEST)
Received: from h155.mvista.com ([63.81.120.155]:24132 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492487AbZH0OOT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Aug 2009 16:14:19 +0200
Received: from [192.168.11.189] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 706DA3EC9; Thu, 27 Aug 2009 07:14:11 -0700 (PDT)
Message-ID: <4A969519.7010604@ru.mvista.com>
Date:	Thu, 27 Aug 2009 18:15:53 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Florian Fainelli <florian@openwrt.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] alchemy: add au1000-eth platform device
References: <200908170105.38154.florian@openwrt.org> <200908181801.41602.florian@openwrt.org> <4A92D5D1.60009@ru.mvista.com> <200908271442.36306.florian@openwrt.org>
In-Reply-To: <200908271442.36306.florian@openwrt.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Florian Fainelli wrote:

>>>>>This patch adds the board code to register a per-board au1000-eth
>>>>>platform device to be used wit the au1000-eth platform driver in a
>>>>>subsequent patch. Note that the au1000-eth driver knows about the
>>>>>default driver settings such that we do not need to pass any
>>>>>platform_data informations in most cases except db1x00.

>>>>   Sigh, NAK...
>>>>   Please don't register the SoC device per board, do it in
>>>>alchemy/common/platfrom.c and find a way to pass the board specific
>>>>platform data from the board file there instead -- something like
>>>>arch/arm/mach-davinci/usb.c does.

>>>Ok, like I promised, this was the per-board device registration. Do you
>>>prefer something like this:

>>    I certainly do, but still not in this incarnation... :-)

>>>+static struct au1000_eth_platform_data au1xxx_eth0_platform_data = {
>>>+	.phy1_search_mac0 = 1,
>>>+};

>>    I'm not sure that the default platfrom data is really a great idea...

> Can you elaborate a bit more ? We actually need to make the Ethernet MAC driver aware of some PHY settings.

    But why do you have the platform data in *this* file, no the board files?

>>>+#ifndef CONFIG_SOC_AU1100
>>>+static struct platform_device au1xxx_eth1_device = {
>>>+	.name		= "au1000-eth",
>>>+	.id		= 1,
>>>+	.num_resources	= ARRAY_SIZE(au1xxx_eth1_resources),
>>>+	.resource	= au1xxx_eth1_resources,

>>    And where's the platfrom data for the second Ethernet?

> There is no need to, as the driver originally did not override any specific settings on the second MAC (afair).

    Specific settings where, in the driver? Shouldn't all such settings be 
bound to the platform data instead?

>>>+};
>>>+#endif
>>>+
>>>+void __init au1xxx_override_eth0_cfg(struct au1000_eth_platform_data
>>>*eth_data) +{
>>>+	if (!eth_data)
>>>+		return;
>>>+
>>>+	memcpy(&au1xxx_eth0_platform_data, eth_data,
>>>+		sizeof(struct au1000_eth_platform_data));

>>    Why not just set the pointer in au1xxx_eth0_device. And really, why not
>>make the function more generic, with a prototype like:

> For the same reasons as explained below, MAC1 did not need any specific change.

    So, the driver can get away without platform data? What does it do in 
this case -- I haven't looked at that patch?

>>void __init au1xxx_override_eth_cfg(unsigned port, struct
>>				    au1000_eth_platform_data *eth_data);

>>>+}
>>>+
>>> static struct platform_device *au1xxx_platform_devices[] __initdata = {
>>> 	&au1xx0_uart_device,
>>> 	&au1xxx_usb_ohci_device,
>>>@@ -351,17 +422,25 @@ static struct platform_device
>>>*au1xxx_platform_devices[] __initdata = { #ifdef SMBUS_PSC_BASE
>>> 	&pbdb_smbus_device,
>>> #endif
>>>+	&au1xxx_eth0_device,
>>> };
>>>
>>> static int __init au1xxx_platform_init(void)
>>> {
>>> 	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
>>>-	int i;
>>>+	int i, ni;
>>>
>>> 	/* Fill up uartclk. */
>>> 	for (i = 0; au1x00_uart_data[i].flags; i++)
>>> 		au1x00_uart_data[i].uartclk = uartclk;
>>>
>>>+	/* Register second MAC if enabled in pinfunc */
>>>+#ifndef CONFIG_SOC_AU1100
>>>+	ni = (int)((au_readl(SYS_PINFUNC) & (u32)(SYS_PF_NI2)) >> 4);
>>>+	if (!(ni + 1))

>>    Why so complex, and how can (ni + 1) ever be 0?! :-/

> This is left-over debugging stub, I will rework it. About complexity, this line is taken directly from the au1000_eth driver.

    I don't see !(ni + 1) there, only:

	num_ifs = NUM_ETH_INTERFACES - ni;

which is correct, unlike what you've written.

WBR, Sergei
