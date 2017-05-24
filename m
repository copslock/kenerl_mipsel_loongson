Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 20:15:34 +0200 (CEST)
Received: from mout.web.de ([212.227.15.4]:60943 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994780AbdEXSP0LTypg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 May 2017 20:15:26 +0200
Received: from [192.168.1.2] ([92.228.187.15]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LwHmQ-1e1TQr1rwc-0182OT; Wed, 24
 May 2017 20:15:15 +0200
Subject: Re: [PATCH] MIPS: Alchemy: Delete an error message for a failed
 memory allocation in alchemy_pci_probe()
To:     Manuel Lauss <manuel.lauss@gmail.com>, linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <6ebb5193-239f-5c34-c5f6-2be8a2fa79a5@users.sourceforge.net>
 <CAOLZvyHq-7q0XxiBsyX3q0g0J3kjfFv4SU7amX1hpjRDyK+feQ@mail.gmail.com>
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <796029e7-60a3-a94b-8b5c-4686a0656560@users.sourceforge.net>
Date:   Wed, 24 May 2017 20:15:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAOLZvyHq-7q0XxiBsyX3q0g0J3kjfFv4SU7amX1hpjRDyK+feQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:7vUIFUogHlKlcL3HavEsYY84s0F/yusWsTzkC8TbXw+2V9RUSDI
 IdXb5ostoS7bgzTXOR9UllT1PvRX5KPwVjVzDoNctFJ5N93InubQoo4+hhscmjtCofGEeIW
 UQU2q/46uu2PC32jE7+g9tRPSm9JvY/SDQZoGnd2rh/YXuNBszAWqcnOdZb/nZfU4ZZVFxV
 C10nQTerwOo+lwsyaJ2dw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ipMlkQtXuzE=:ZVZPUYX2PwsyVWv6kZqhCw
 KW/LfmKsOJnQjM7Yhq3UEDn2LKT7leuik5PwyyOTbQeNuO5FQEX8iHgJ4YCk6OAg+BIQfmSZN
 Swo/c/qWPFopMutEMIe1VP3Wrb7CFEhosNajVzyccz7qYL31G8a8rVgoe7RNe9F5jqg0B96E6
 KtYPp2ruXBLdwrMz4b3E/d689M4sJFyznKf6ZrBtdmizfLrPATbk7yT+NgzhER3qVKQbdi2Me
 V9/AukC35BSTkTRXBlIWg4VFm6tlchLRyY9p6M8wpIrh3kzLIy399KOo3Cm44KJ10jhyDKnfU
 gpIyDEdATZvL0W16AJjpEsWLTl34GYu4bhDS2ieKT1DUD+DbFyA7hu3xEFySuSYpLDnuGvWgF
 sh7gHPFBGDWQ57dVnveTisoEpj5Vj0kPrCo+zrV2CiESPa7tUXUQB5OGddop18uwJA41/5cs1
 iTO5yR/Tx5fqWBse+fW+W1pTp8r0aa1TGtDjSHlcZxZAyw+MpF3y+QwyJjmfV1z+AVX2kkFB/
 RVY//5zpI93WZcZuHP/oH60LPO9JBjYbXRZmCrISwAm/P9GaIDDViQcBpK5U/UVmC+/Obkni1
 s+9hgJxYwn6bsV5ywViUzhjCdFH/NerzVJ4PUIubZuLzc6Jp35Lr4SAluGtI8CP9KMzZ4WsUx
 /3i8kpqzWAuueEMGcTYqYOm26rGqI7UXuDLZM9nSp95X98spquS0PvKcvzsa+ghyBuzMyWPYl
 7IvmTZEP8x4jHMzCl6tdafq5BaE6fqI0VXI6QVFEu/Egx4DUcwr/ThKma5fyLMq5sXWMELeoR
 uuF51KW
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

>> +++ b/arch/mips/pci/pci-alchemy.c
>> @@ -377,7 +377,6 @@ static int alchemy_pci_probe(struct platform_device *pdev)
>>
>>         ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>>         if (!ctx) {
>> -               dev_err(&pdev->dev, "no memory for pcictl context\n");
>>                 ret = -ENOMEM;
>>                 goto out;
>>         }
>> --
>> 2.13.0
> 
> Why are you removing just this one dev_err()?

How do you think about to achieve a small code reduction also for this software module?


> What issue are you trying to address?

Do you find information from a Linux allocation failure report sufficient
for such a function implementation?

Regards,
Markus
