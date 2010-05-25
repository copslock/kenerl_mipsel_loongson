Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 May 2010 05:30:52 +0200 (CEST)
Received: from mail-qy0-f185.google.com ([209.85.221.185]:56723 "EHLO
        mail-qy0-f185.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491119Ab0EYDas convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 May 2010 05:30:48 +0200
Received: by qyk15 with SMTP id 15so6572484qyk.6
        for <linux-mips@linux-mips.org>; Mon, 24 May 2010 20:30:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.227.133 with SMTP id ja5mr1317938qcb.174.1274758241345; 
        Mon, 24 May 2010 20:30:41 -0700 (PDT)
Received: by 10.229.33.19 with HTTP; Mon, 24 May 2010 20:30:41 -0700 (PDT)
In-Reply-To: <4BFB0547.4070607@simtec.co.uk>
References: <q2u180e2c241005040255n628614a0p828116a04f65a894@mail.gmail.com>
         <4BFB0547.4070607@simtec.co.uk>
Date:   Tue, 25 May 2010 11:30:41 +0800
Message-ID: <AANLkTilfHtKwWrDoEcV8T1GQ_mOekJSOkeR1hDLxIiUA@mail.gmail.com>
Subject: Re: [PATCH 8/12] gdium uses different freq of mclk&m1xclk of sm501
From:   yajin <yajinzhou@vm-kernel.org>
To:     Ben Dooks <ben@simtec.co.uk>
Cc:     linux-mips@linux-mips.org,
        loongson-dev <loongson-dev@googlegroups.com>,
        wuzhangjin@gmail.com, apatard@mandriva.com, vince@simtec.co.uk
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <yajinzhou@vm-kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yajinzhou@vm-kernel.org
Precedence: bulk
X-list: linux-mips

Hi,


2010/5/25 Ben Dooks <ben@simtec.co.uk>:
> On 04/05/10 18:55, yajin wrote:
>> Gdium uses different freq of mclk&m1xclk of sm501. This seems a dirty
>> hack. Maybe we need a configuration option for changing the freq of
>> these clocks.
>>
>> Signed-off-by: yajin <yajin@vm-kernel.org>
>> ---
>>  drivers/mfd/sm501.c |    9 +++++++--
>>  1 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
>> index ce5dfce..5e55cbd 100644
>> --- a/drivers/mfd/sm501.c
>> +++ b/drivers/mfd/sm501.c
>> @@ -1606,10 +1606,15 @@ static struct sm501_initdata sm501_pci_initdata = {
>>       .devices        = SM501_USE_ALL,
>>
>>       /* Errata AB-3 says that 72MHz is the fastest available
>> -      * for 33MHZ PCI with proper bus-mastering operation */
>> -
>> +      * for 33MHZ PCI with proper bus-mastering operation
>> +      * For gdium, it works under 84&112M clock freq.*/
>> +#ifdef CONFIG_DEXXON_GDIUM
>> +     .mclk           = 84 * MHZ,
>> +     .m1xclk         = 112 * MHZ,
>> +#else
>
> I think these frequencies are out of spec for the SM501,
> Plus, it is a hack.
> Does it not work at 72/144?
>

I have asked the similar question on loongson-dev mail list[1]. If the
mclk clock freq is set to 72M, the LCD output has some problem. But it
works well on 84M freq. Maybe Arnaud knows the reason.


[1] http://groups.google.com/group/loongson-dev/browse_thread/thread/6233a6cb67dc02d2?hl=en_US
