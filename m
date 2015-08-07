Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Aug 2015 12:52:51 +0200 (CEST)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:33091 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011331AbbHGKwtTX0MA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Aug 2015 12:52:49 +0200
Received: by lbbyj8 with SMTP id yj8so58646683lbb.0
        for <linux-mips@linux-mips.org>; Fri, 07 Aug 2015 03:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=x3lrnF5RsvttDvyRGTEniZZBNllxZPG2DRmtXyTYx84=;
        b=JakYReQJak43txD71fWVSL4+wJkd8Esnvlk6Aq7AAz8XcBUwZl4C9oZpLqZkIoPqAZ
         dmy3tI0svMNkxpitMGkhNSlIZDhUL2FNTmnq2AvYSdpYuvUln+RFPpLkBMGxKvKKBz54
         iTgrcTr5KHx2Xzo8cFcks3YZ8lfKA9U5DvPM+Lx54XO4dPtG3hcaetNcideSkj7ScuSU
         s2HbepYo8tzyxig+Kn+OIO3qsdcguttxKk6hBb2snCV4k+d3b7f5Zp4rt2cgkQlJzuKb
         unBa94EbA8A3rOSZotcsALzUUpwI5LvwpBSXQD/WIxUt9hEeicPy5g/N3et3yJmaYllI
         foaA==
X-Gm-Message-State: ALoCoQlxGYWp+Rb+06b0/mLua48JR1CoAoYH2SnCPCaO4IUhDMRRHyAIV8NBHH9YfxVNFallEnbx
X-Received: by 10.152.22.168 with SMTP id e8mr6896834laf.40.1438944763698;
        Fri, 07 Aug 2015 03:52:43 -0700 (PDT)
Received: from [10.0.0.11] ([80.82.22.190])
        by smtp.googlemail.com with ESMTPSA id z1sm2083471lbj.11.2015.08.07.03.52.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2015 03:52:43 -0700 (PDT)
Message-ID: <55C48DF9.70406@linaro.org>
Date:   Fri, 07 Aug 2015 12:52:41 +0200
From:   Tomasz Nowicki <tomasz.nowicki@linaro.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Firefox/31.0 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Robert Richter <robert.richter@caviumnetworks.com>
CC:     David Daney <ddaney.cavm@gmail.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        linux-mips@linux-mips.org, Sunil Goutham <sgoutham@cavium.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 2/2] net, thunder, bgx: Add support for ACPI binding.
References: <1438907590-29649-1-git-send-email-ddaney.cavm@gmail.com> <1438907590-29649-3-git-send-email-ddaney.cavm@gmail.com> <55C467A0.4020601@linaro.org> <20150807104320.GQ1820@rric.localhost>
In-Reply-To: <20150807104320.GQ1820@rric.localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tomasz.nowicki@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tomasz.nowicki@linaro.org
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

On 07.08.2015 12:43, Robert Richter wrote:
> On 07.08.15 10:09:04, Tomasz Nowicki wrote:
>> On 07.08.2015 02:33, David Daney wrote:
>
> ...
>
>>> +#else
>>> +
>>> +static int bgx_init_acpi_phy(struct bgx *bgx)
>>> +{
>>> +	return -ENODEV;
>>> +}
>>> +
>>> +#endif /* CONFIG_ACPI */
>>> +
>>>   #if IS_ENABLED(CONFIG_OF_MDIO)
>>>
>>>   static int bgx_init_of_phy(struct bgx *bgx)
>>> @@ -882,7 +1010,12 @@ static int bgx_init_of_phy(struct bgx *bgx)
>>>
>>>   static int bgx_init_phy(struct bgx *bgx)
>>>   {
>>> -	return bgx_init_of_phy(bgx);
>>> +	int err = bgx_init_of_phy(bgx);
>>> +
>>> +	if (err != -ENODEV)
>>> +		return err;
>>> +
>>> +	return bgx_init_acpi_phy(bgx);
>>>   }
>>>
>>
>> If kernel can work with DT and ACPI (both compiled in), it should take only
>> one path instead of probing DT and ACPI sequentially. How about:
>>
>> @@ -902,10 +925,9 @@ static int bgx_probe(struct pci_dev *pdev, const struct
>> pci_device_id *ent)
>>   	bgx_vnic[bgx->bgx_id] = bgx;
>>   	bgx_get_qlm_mode(bgx);
>>
>> -	snprintf(bgx_sel, 5, "bgx%d", bgx->bgx_id);
>> -	np = of_find_node_by_name(NULL, bgx_sel);
>> -	if (np)
>> -		bgx_init_of(bgx, np);
>> +	err = acpi_disabled ? bgx_init_of_phy(bgx) : bgx_init_acpi_phy(bgx);
>> +	if (err)
>> +		goto err_enable;
>>
>>   	bgx_init_hw(bgx);
>
> I would not pollute bgx_probe() with acpi and dt specifics, and instead
> keep bgx_init_phy(). The typical design pattern for this is:
>
> static int bgx_init_phy(struct bgx *bgx)
> {
> #ifdef CONFIG_ACPI
>          if (!acpi_disabled)
>                  return bgx_init_acpi_phy(bgx);
> #endif
>          return bgx_init_of_phy(bgx);
> }
>
> This adds acpi runtime detection (acpi=no), does not call dt code in
> case of acpi, and saves the #else for bgx_init_acpi_phy().
>

I am fine with keeping it in bgx_init_phy(), however we can drop there 
#ifdefs since both of bgx_init_{acpi,of}_phy calls have empty stub for 
!ACPI and !OF case. Like that:

static int bgx_init_phy(struct bgx *bgx)
{

         if (!acpi_disabled)
                 return bgx_init_acpi_phy(bgx);
	else
         	return bgx_init_of_phy(bgx);
}

Tomasz
