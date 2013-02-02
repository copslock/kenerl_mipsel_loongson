Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Feb 2013 15:27:41 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:57438 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823088Ab3BBO1kiKgy4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 2 Feb 2013 15:27:40 +0100
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9OgJzdZ_xO9b; Sat,  2 Feb 2013 15:27:38 +0100 (CET)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 0E67A284B53;
        Sat,  2 Feb 2013 15:27:36 +0100 (CET)
Message-ID: <510D2256.4000703@openwrt.org>
Date:   Sat, 02 Feb 2013 15:27:34 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     John Crispin <john@phrozen.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/5] MIPS: pci-ar724x: convert into a platform driver
References: <1359808846-23083-1-git-send-email-juhosg@openwrt.org> <510D2012.8070408@phrozen.org>
In-Reply-To: <510D2012.8070408@phrozen.org>
X-Enigmail-Version: 1.5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 35687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

2013.02.02. 15:17 keltezéssel, John Crispin írta:
> On 02/02/13 13:40, Gabor Juhos wrote:
>> +static int ar724x_pci_probe(struct platform_device *pdev)
>> +{
>> +    struct resource *res;
>> +    int irq;
>> +
>> +    res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl_base");
>> +    if (!res)
>> +        return -EINVAL;
>> +
>> +    ar724x_pci_ctrl_base = devm_request_and_ioremap(&pdev->dev, res);
>> +    if (ar724x_pci_ctrl_base == NULL)
>> +        return -EBUSY;
>> +
>> +    res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg_base");
>> +    if (!res)
>> +        return -EINVAL;
> 
> 
> Hi,
> 
> maybe better use platform_get_resource(pdev, IORESOURCE_MEM, 0/1) ... you will
> otherwise have to patch this again when you convert to OF

I will not have to convert that. The node can have a reg-names property like this:

> 	pci0: pcie@180f0000 {
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 		#interrupt-cells = <1>;
> 		device_type = "pci";
> 		interrupt-controller;
> 		compatible = "qca,qca9558-pcie", "qca,ar7240-pcie";
> 		bus-range = <0 255>;
> 		ranges = <0x02000000 0 0x00000000 0x10000000 0 0x02000000   /* pci memory */
> 				0x01000000 0 0x00000000 0x00000000 0 0x00000001>; /* io space */
> 		reg = <0x180f0000 0x0100	/* controller base */
> 			0x14000000 0x1000	/* config space */
> 			0x180c0000 0x1000>;	/* CRP base */
> 		reg-names = "ctrl_base", "cfg_base", "crp_base";
> 
> 		interrupt-map-mask = <0xf800 0 0 7>;
> 		interrupt-map = <0 0 0 1 &pci0 0
> 					0 0 0 2 &pci0 0
> 					0 0 0 3 &pci0 0
> 					0 0 0 4 &pci0 0>;
> 
> 		interrupt-parent = <&EINTC>;
> 		interrupts = <0>;
> 	};



-Gabor
