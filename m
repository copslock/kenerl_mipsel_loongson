Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jun 2014 21:11:30 +0200 (CEST)
Received: from mail.savoirfairelinux.com ([209.172.62.77]:62362 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859948AbaFTTL1kj59m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jun 2014 21:11:27 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 0E53710D7299;
        Fri, 20 Jun 2014 15:11:21 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Feh10IfxxdTi; Fri, 20 Jun 2014 15:11:20 -0400 (EDT)
Received: from [192.168.50.114] (mtl.savoirfairelinux.net [208.88.110.46])
        by mail.savoirfairelinux.com (Postfix) with ESMTPSA id AAC3D10D7293;
        Fri, 20 Jun 2014 15:11:20 -0400 (EDT)
Message-ID: <53A48855.2010102@savoirfairelinux.com>
Date:   Fri, 20 Jun 2014 15:15:33 -0400
From:   Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        John Crispin <blogic@openwrt.org>,
        Qais Yousef <Qais.Yousef@imgtec.com>
CC:     linux-kernel@vger.kernel.org,
        Jerome Oufella <jerome.oufella@savoirfairelinux.com>
Subject: Re: [PATCH 1/1] MIPS: APRP: Fix an issue when device_create() fails.
References: <1403209823-6376-1-git-send-email-sebastien.bourdelin@savoirfairelinux.com> <53A4702D.3090503@imgtec.com>
In-Reply-To: <53A4702D.3090503@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <sebastien.bourdelin@savoirfairelinux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastien.bourdelin@savoirfairelinux.com
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

Hi,

correct me if i'm wrong, but if we pre-decrement, it will decrement
before evaluate and the channel 0 will never be destroy.
So the while condition must change too accordingly.
In any case inside the while loop, "i" will be "i - 1" so we destroy the
previously device.
I think it's correct like this.

On 06/20/2014 01:32 PM, Deng-Cheng Zhu wrote:
> On 06/19/2014 01:30 PM, Sebastien Bourdelin wrote:
>> If a call to device_create() fails for a channel during the initialize
>> loop, we need to clean the devices entries already created before
>> leaving.
>>
>> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
>> ---
>>   arch/mips/kernel/rtlx-cmp.c | 3 +++
>>   arch/mips/kernel/rtlx-mt.c  | 3 +++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/mips/kernel/rtlx-cmp.c b/arch/mips/kernel/rtlx-cmp.c
>> index 758fb3c..d26dcc4 100644
>> --- a/arch/mips/kernel/rtlx-cmp.c
>> +++ b/arch/mips/kernel/rtlx-cmp.c
>> @@ -77,6 +77,9 @@ int __init rtlx_module_init(void)
>>   		dev = device_create(mt_class, NULL, MKDEV(major, i), NULL,
>>   				    "%s%d", RTLX_MODULE_NAME, i);
>>   		if (IS_ERR(dev)) {
>> +			while (i--)
> --i?
>
>> +				device_destroy(mt_class, MKDEV(major, i));
>> +
>>   			err = PTR_ERR(dev);
>>   			goto out_chrdev;
>>   		}
>> diff --git a/arch/mips/kernel/rtlx-mt.c b/arch/mips/kernel/rtlx-mt.c
>> index 5a66b97..cb95470 100644
>> --- a/arch/mips/kernel/rtlx-mt.c
>> +++ b/arch/mips/kernel/rtlx-mt.c
>> @@ -103,6 +103,9 @@ int __init rtlx_module_init(void)
>>   		dev = device_create(mt_class, NULL, MKDEV(major, i), NULL,
>>   				    "%s%d", RTLX_MODULE_NAME, i);
>>   		if (IS_ERR(dev)) {
>> +			while (i--)
> Same here.
>
>> +				device_destroy(mt_class, MKDEV(major, i));
>> +
>>   			err = PTR_ERR(dev);
>>   			goto out_chrdev;
>>   		}
>
>
> Deng-Cheng
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
