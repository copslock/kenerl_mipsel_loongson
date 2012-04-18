Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2012 18:20:39 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:3916 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903631Ab2DRQUc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Apr 2012 18:20:32 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4f8eea3a0000>; Wed, 18 Apr 2012 09:22:18 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 18 Apr 2012 09:20:29 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 18 Apr 2012 09:20:29 -0700
Message-ID: <4F8EE9CC.20000@cavium.com>
Date:   Wed, 18 Apr 2012 09:20:28 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Wolfram Sang <w.sang@pengutronix.de>
CC:     Rob Herring <robherring2@gmail.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "devicetree-discuss@lists.ozlabs.org" 
        <devicetree-discuss@lists.ozlabs.org>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>,
        "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>
Subject: Re: [PATCH 1/5] i2c: Convert i2c-octeon.c to use device tree.
References: <1332808075-8333-1-git-send-email-ddaney.cavm@gmail.com> <1332808075-8333-2-git-send-email-ddaney.cavm@gmail.com> <4F7115FA.6080507@gmail.com> <4F7117FD.7000700@cavium.com> <20120418151621.GF19802@pengutronix.de>
In-Reply-To: <20120418151621.GF19802@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Apr 2012 16:20:29.0551 (UTC) FILETIME=[2BBD97F0:01CD1D7F]
X-archive-position: 32962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/18/2012 08:16 AM, Wolfram Sang wrote:
>>>> -	if (i2c_data == NULL) {
>>>> -		dev_err(i2c->dev, "no I2C frequency data\n");
>>>> +	/*
>>>> +	 * "clock-rate" is a legacy binding, the official binding is
>>>> +	 * "clock-frequency".  Try the official one first and then
>>>> +	 * fall back if it doesn't exist.
>>>> +	 */
>>>> +	data = of_get_property(pdev->dev.of_node, "clock-frequency",&len);
>>>> +	if (!data || len != sizeof(*data))
>>>> +		data = of_get_property(pdev->dev.of_node, "clock-rate",&len);
>>>> +	if (data&&   len == sizeof(*data)) {
>>>> +		i2c->twsi_freq = be32_to_cpup(data);
>>>
>>> Can't you use of_property_read_u32?
>>
>> I will investigate, and use it if possible.
>
> Any outcome?

Yes, I have implemented Rob's suggestions.  A new patch set reflecting 
this is coming soon.

>
> And shouldn't the bindings be documented? Or are they only standard and
> we hide the legacy one?
>

Yes, they are documented here:

http://patchwork.linux-mips.org/patch/3536/

look in the cavium-i2c.txt file.

Thanks,
David Daney
