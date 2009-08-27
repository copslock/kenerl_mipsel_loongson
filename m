Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2009 16:55:28 +0200 (CEST)
Received: from mail-ew0-f225.google.com ([209.85.219.225]:45885 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492941AbZH0OzW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Aug 2009 16:55:22 +0200
Received: by ewy25 with SMTP id 25so1254639ewy.33
        for <multiple recipients>; Thu, 27 Aug 2009 07:55:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=yiPtsnI0gIMEGRrAI20G324VONu/IyiVViSvO0rQO9M=;
        b=htybKM/+5G3c1NvsDG/EnnqcHtLEo4K9QWUhqNNCNhsDnIuz0sDvYHasT87JM4PUYQ
         P4u8OJ42ZD5ngaUMrSA0MbKO5wF3DCPsRO8VVLqKtaaUw1Q0xsNBVgDDAOn9IFf7/caA
         LlTw1d/v+XWLQvMPYY9rIo9mZIredHpzyQsOY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Va1jaS2trcI2KGTb6PRhvfYb5kf99VAMWcN7+dYSF1zuhh8eXCPYdZkd4CmgnQqN7x
         CsAFz4ej3ibY0FtH8ThuJRvPqboDHkchYFg9YLwKMiEAOk1UCq/W5NR9v61l9+qUn+Tc
         t/u8ZKaCt9x/IAp0KYzbnNBdzebKVuQb+zloE=
Received: by 10.210.2.19 with SMTP id 19mr394910ebb.94.1251384916615;
        Thu, 27 Aug 2009 07:55:16 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 28sm14276eye.20.2009.08.27.07.55.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Aug 2009 07:55:14 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] alchemy: add au1000-eth platform device
Date:	Thu, 27 Aug 2009 16:55:09 +0200
User-Agent: KMail/1.9.9
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org
References: <200908170105.38154.florian@openwrt.org> <200908271442.36306.florian@openwrt.org> <4A969519.7010604@ru.mvista.com>
In-Reply-To: <4A969519.7010604@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200908271655.11086.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hello,

Le Thursday 27 August 2009 16:15:53 Sergei Shtylyov, vous avez écrit :
> Hello.
>
> Florian Fainelli wrote:
> >>>>>This patch adds the board code to register a per-board au1000-eth
> >>>>>platform device to be used wit the au1000-eth platform driver in a
> >>>>>subsequent patch. Note that the au1000-eth driver knows about the
> >>>>>default driver settings such that we do not need to pass any
> >>>>>platform_data informations in most cases except db1x00.
> >>>>
> >>>>   Sigh, NAK...
> >>>>   Please don't register the SoC device per board, do it in
> >>>>alchemy/common/platfrom.c and find a way to pass the board specific
> >>>>platform data from the board file there instead -- something like
> >>>>arch/arm/mach-davinci/usb.c does.
> >>>
> >>>Ok, like I promised, this was the per-board device registration. Do you
> >>>prefer something like this:
> >>
> >>    I certainly do, but still not in this incarnation... :-)
> >>
> >>>+static struct au1000_eth_platform_data au1xxx_eth0_platform_data = {
> >>>+	.phy1_search_mac0 = 1,
> >>>+};
> >>
> >>    I'm not sure that the default platfrom data is really a great idea...
> >
> > Can you elaborate a bit more ? We actually need to make the Ethernet MAC
> > driver aware of some PHY settings.
>
>     But why do you have the platform data in *this* file, no the board
> files?

The default setting is to search for a PHY on the corresponding MAC, which is 
the case for all boards but bosporus, thus it is in this file. No platform 
data at all would be fine too.

>
> >>>+#ifndef CONFIG_SOC_AU1100
> >>>+static struct platform_device au1xxx_eth1_device = {
> >>>+	.name		= "au1000-eth",
> >>>+	.id		= 1,
> >>>+	.num_resources	= ARRAY_SIZE(au1xxx_eth1_resources),
> >>>+	.resource	= au1xxx_eth1_resources,
> >>
> >>    And where's the platfrom data for the second Ethernet?
> >
> > There is no need to, as the driver originally did not override any
> > specific settings on the second MAC (afair).
>
>     Specific settings where, in the driver? Shouldn't all such settings be
> bound to the platform data instead?

Yes, platform data should handle that for us, what I was trying to explain is 
that the driver did not configure anything specific for MAC1 already, thus 
there is no platfo

>
> >>>+};
> >>>+#endif
> >>>+
> >>>+void __init au1xxx_override_eth0_cfg(struct au1000_eth_platform_data
> >>>*eth_data) +{
> >>>+	if (!eth_data)
> >>>+		return;
> >>>+
> >>>+	memcpy(&au1xxx_eth0_platform_data, eth_data,
> >>>+		sizeof(struct au1000_eth_platform_data));
> >>
> >>    Why not just set the pointer in au1xxx_eth0_device. And really, why
> >> not make the function more generic, with a prototype like:
> >
> > For the same reasons as explained below, MAC1 did not need any specific
> > change.
>
>     So, the driver can get away without platform data? What does it do in
> this case -- I haven't looked at that patch?

In that case it searchs for a PHY attached to the MAC, this is what the driver 
did already. Please have a look at the patch, specifically the part which 
handles a NULL platform_data.

>
> >>void __init au1xxx_override_eth_cfg(unsigned port, struct
> >>				    au1000_eth_platform_data *eth_data);
> >>
> >>>+}
> >>>+
> >>> static struct platform_device *au1xxx_platform_devices[] __initdata = {
> >>> 	&au1xx0_uart_device,
> >>> 	&au1xxx_usb_ohci_device,
> >>>@@ -351,17 +422,25 @@ static struct platform_device
> >>>*au1xxx_platform_devices[] __initdata = { #ifdef SMBUS_PSC_BASE
> >>> 	&pbdb_smbus_device,
> >>> #endif
> >>>+	&au1xxx_eth0_device,
> >>> };
> >>>
> >>> static int __init au1xxx_platform_init(void)
> >>> {
> >>> 	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
> >>>-	int i;
> >>>+	int i, ni;
> >>>
> >>> 	/* Fill up uartclk. */
> >>> 	for (i = 0; au1x00_uart_data[i].flags; i++)
> >>> 		au1x00_uart_data[i].uartclk = uartclk;
> >>>
> >>>+	/* Register second MAC if enabled in pinfunc */
> >>>+#ifndef CONFIG_SOC_AU1100
> >>>+	ni = (int)((au_readl(SYS_PINFUNC) & (u32)(SYS_PF_NI2)) >> 4);
> >>>+	if (!(ni + 1))
> >>
> >>    Why so complex, and how can (ni + 1) ever be 0?! :-/
> >
> > This is left-over debugging stub, I will rework it. About complexity,
> > this line is taken directly from the au1000_eth driver.
>
>     I don't see !(ni + 1) there, only:
>
> 	num_ifs = NUM_ETH_INTERFACES - ni;
>
> which is correct, unlike what you've written.
-- 
Best regards, Florian Fainelli
Email: florian@openwrt.org
Web: http://openwrt.org
IRC: [florian] on irc.freenode.net
-------------------------------
