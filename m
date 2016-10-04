Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2016 12:21:29 +0200 (CEST)
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36041 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992178AbcJDKVVQTM0q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Oct 2016 12:21:21 +0200
Received: by mail-wm0-f47.google.com with SMTP id k125so198033735wma.1
        for <linux-mips@linux-mips.org>; Tue, 04 Oct 2016 03:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=XkfEz6WFZxr7zqPa/ho7aweV7GAmEAmn6GboxDrGOyc=;
        b=Jrkmf71Iaitk9ov6xNZT+wmOuDuO5/TY/YfNkDW6x2puFiWmpMCgTx3ejbeMcqiaUO
         keHN88Vv4SL2xqkln0+RgWpiD8Pm71x+x7DS9Qrbm2ZxBaDUOXm+J9pxd5I4NfUoRGqw
         JH6HY2yAewFh4XfLwqBAM5GR/fN/diPVt4sH40ZSSPI+M1VYcUyNVNbvLYSYlrhwuYOv
         Bai34Wi+/1Dar2MQAtuSo5doCuDbAa4mcgdUiG0A55xNo9AL4/ePffSVXtDrWdt8LooN
         Pv/l/ymK20gXe789b1ju6bYBYdr/61reFPaiVa5vheqgmoNgTrngIaJHInTuXgfUTcOd
         eRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=XkfEz6WFZxr7zqPa/ho7aweV7GAmEAmn6GboxDrGOyc=;
        b=eYzoc3DEsstuA53wadkidBqoy9SoISiX3pw/aCGXXhttbCdSf4ypl6dp/Do5J3FjPN
         9EsgyDBJtGjF2BUgi5CMOc4BSauhvqLEsKGM8GJd5sJyIe6aV7G+YqgHAmZ0+c4Pgnez
         Rp+huQpPthDw9s00W8CdOlU/UZe2xBPBwFQdJi8G9AGepySM5Mb3Tdhlb6gwX2mLcgTx
         iVDoyRPg+H6qe64foCSIaqX26XArioK5iDs9gyGC4dEKqC0UZBmBA3UYeU6FTfoK5SOm
         qs2gpS5heJecaufYZzjQIlGizb+/Cy3IzLtFYAsmLZya8o0BmCU76N/+vKI5DGJasdpw
         c22g==
X-Gm-Message-State: AA6/9Rk4AxDyVgSz2dOw5lFPRwVfkEby2E2eWUID1Dzg4GRacD3Th6IgULLKdTYq0LOLcJT0
X-Received: by 10.194.191.162 with SMTP id gz2mr2313859wjc.182.1475576475832;
        Tue, 04 Oct 2016 03:21:15 -0700 (PDT)
Received: from [192.168.1.21] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id xy4sm2777326wjc.2.2016.10.04.03.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2016 03:21:15 -0700 (PDT)
Subject: Re: [PATCH] MIPS: ath79: Add initial support for the HAPROXY Aloha
 Pocket board
To:     Yegor Yefremov <yegorslists@googlemail.com>
References: <1475508931-16800-1-git-send-email-narmstrong@baylibre.com>
 <20161004110940.57d112df@tock>
 <3b41a114-7ec7-cd50-6967-9a1be96e2c2f@baylibre.com>
 <CAGm1_ktvXYY5r2nWk3GneERmcMV+YwNa=-4arSmJjC_kNjPpSQ@mail.gmail.com>
 <154dc5c8-0d40-9cd7-5997-0ede70605510@baylibre.com>
 <CAGm1_kvAtXf1GPF93U3VMBoHO_Fmc2rANxoNHwcF2-VuerA7pQ@mail.gmail.com>
Cc:     Alban <albeu@free.fr>, ralf@linux-mips.org,
        linux-mips <linux-mips@linux-mips.org>,
        kernel list <linux-kernel@vger.kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <332f9438-ef25-b972-77f0-d46be3ec349d@baylibre.com>
Date:   Tue, 4 Oct 2016 12:21:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAGm1_kvAtXf1GPF93U3VMBoHO_Fmc2rANxoNHwcF2-VuerA7pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <narmstrong@baylibre.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: narmstrong@baylibre.com
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

On 10/04/2016 12:14 PM, Yegor Yefremov wrote:
> On Tue, Oct 4, 2016 at 12:11 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>> On 10/04/2016 12:09 PM, Yegor Yefremov wrote:
>>> Hi Neil,
>>>
>>> On Tue, Oct 4, 2016 at 11:40 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>> On 10/04/2016 11:09 AM, Alban wrote:
>>>>> On Mon,  3 Oct 2016 17:35:31 +0200
>>>>> Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>>
>>>>>> The HAPROXY Aloha pocket board is a Load Balancer demo board based on the
>>>>>> Atheros AR9331 SoC with 64Mbytes DDR and 16Mbytes on-board SPI Flash.
>>>>>>
>>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>>
>>>>> Please use device tree instead of adding another board file.
>>>>>
>>>>> Alban
>>>>>
>>>>
>>>> Hi Alban,
>>>>
>>>> I'm quite surprised since it seems no device tree support is available for ath79,
>>>> I would really like to have device tree for this board, but this is only a copy/paste of
>>>> the mach-ap121 with button/leds gpio differences.
>>>>
>>>> Could it be possible to merge it ? I would be happy to support this board once device tree
>>>> support is landed on the mips tree !
>>>
>>> Take a look at these DTS files from the current Linux tree:
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
>>>
>>> etc.
>>>
>>> Regards,
>>> Yegor
>>>
>>
>> My bad, the qca naming is really disturbing.
>>
>> I will push a dts instead.
> 
> Are you also going to submit driver for the network controller? This
> is almost the last missing component for this SoC.
> 
> Yegor
> 

Hi Yegor,

I'm not sure I have the right knowledge to push this, but what is the status of the OpenWrt driver ?

Neil
