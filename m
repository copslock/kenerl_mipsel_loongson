Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 13:50:16 +0200 (CEST)
Received: from [134.100.9.70] ([134.100.9.70]:35262 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-FAIL-FAIL-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6865297Ab3HHLuMsNkfj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Aug 2013 13:50:12 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id F2C36D5E;
        Thu,  8 Aug 2013 13:49:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id DHEOTMI4mtq0; Thu,  8 Aug 2013 13:49:47 +0200 (CEST)
Received: from [192.168.178.21] (ppp-188-174-151-145.dynamic.mnet-online.de [188.174.151.145])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 6BA35D5D;
        Thu,  8 Aug 2013 13:49:46 +0200 (CEST)
Message-ID: <520385E9.9000906@metafoo.de>
Date:   Thu, 08 Aug 2013 13:50:01 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130704 Icedove/17.0.7
MIME-Version: 1.0
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/4] MIPS: lantiq: adds minimal dcdc driver
References: <1375952846-25812-1-git-send-email-blogic@openwrt.org> <1375952846-25812-2-git-send-email-blogic@openwrt.org> <520379D4.9040903@cogentembedded.com> <CAGVrzcY8NAu0BZBNXVC-sJk7_=40GmepG30ff4+wJQPr4A8J6w@mail.gmail.com>
In-Reply-To: <CAGVrzcY8NAu0BZBNXVC-sJk7_=40GmepG30ff4+wJQPr4A8J6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

On 08/08/2013 01:17 PM, Florian Fainelli wrote:
> 2013/8/8 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>:
>> Hello.
>>
>>
>> On 08-08-2013 13:07, John Crispin wrote:
>>
>>> This driver so far only reads the core voltage.
>>
>>
>>> Signed-off-by: John Crispin <blogic@openwrt.org>
>>
>> [...]
>>
>>
>>> diff --git a/arch/mips/lantiq/xway/dcdc.c b/arch/mips/lantiq/xway/dcdc.c
>>> new file mode 100644
>>> index 0000000..6361c30
>>> --- /dev/null
>>> +++ b/arch/mips/lantiq/xway/dcdc.c
>>> @@ -0,0 +1,75 @@
>>
>> [...]
>>
>>> +static int dcdc_probe(struct platform_device *pdev)
>>> +{
>>> +       struct resource *res;
>>> +
>>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +       if (!res) {
>>> +               dev_err(&pdev->dev, "Failed to get resource\n");
>>> +               return -ENOMEM;
>>> +       }
>>
>>
>>     You do not need to check this with devm_request_and_ioremap() or
>> devm_ioremap_resource().
>>
>>
>>> +
>>> +       /* remap dcdc register range */
>>> +       dcdc_membase = devm_request_and_ioremap(&pdev->dev, res);
>>
>>
>>     Use devm_ioremap_resource().
>>
>>
>>> +       if (!dcdc_membase) {
>>> +               dev_err(&pdev->dev, "Failed to remap resource\n");
>>
>>
>>     Error messages are already printed by devm_request_and_ioremap()
>> ordevm_ioremap_resource().
>>
>>> +               return -ENOMEM;
>>
>>
>>     -EADDRNOTAVAIL is the right code for devm_request_and_ioremap().
>
> This is the first time that I read this, lib/devres.c internal returns
> -ENOMEM when an ioremap() call fails (see devm_ioremap_resource),
> -EADDRNOTAVAIL really is for networking matter, this is not.
>

You shouldn't need worry about the return code in this case anyway. This is the 
correct pattern for situations like this:

res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
base = devm_ioremap_resource(&pdev->dev, res);
if (IS_ERR(base))
	return PTR_ERR(base);

- Lars
