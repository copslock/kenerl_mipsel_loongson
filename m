Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2016 12:11:29 +0200 (CEST)
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36340 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992186AbcJDKLUZ5Xjq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Oct 2016 12:11:20 +0200
Received: by mail-wm0-f48.google.com with SMTP id k125so197555175wma.1
        for <linux-mips@linux-mips.org>; Tue, 04 Oct 2016 03:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=5k5ICmSBtDb9tyGfyNNZ3wd+U4uO6gEVo+ydW115qJ8=;
        b=m6yih3LKUdXKEhx5Lc4iUyToMEkxfdERjNj/1S1tRxQYkwP7jGN0PAagXWbBO4lE9M
         uHHMq+Gr9ZDX22BJLP37kyRo4udK8cCQbDedKX4n0KxVj6TGnKNdVAjKgZkAzqOLGIDD
         d5vz57FMEYXOTeOV3HQhOoJl4kmxDT6614xtnv2AXOmvpucILxsEdJvIg+FJ44VaFdSj
         6Hlhg+3LBUPPqCUQqU5uDsb4FoKK+y+zji2YWSljYgpvzmNflekV1Ho7lMF7oCaGLPPG
         AJW1i4LsjJkN/rsG0O9J2+4c6jzUzJnBvUduXYfZWpB2m8WnDnBP8TFFc5CyXtsksuvJ
         C7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=5k5ICmSBtDb9tyGfyNNZ3wd+U4uO6gEVo+ydW115qJ8=;
        b=ZIfmY9dqSzeA0to6/j5Yyvhi4cQSSqytLNj9nEWYxTYwcAM8IArtOy6Ulu6la3cX/b
         xUYyDmzyQ2jKCS8Gn+FwgrQiNo6kU7wz2Q3PBSo6iGovU9CNQlDhyQDfr3JU/2RR3Jqi
         h0lL1Cayq5NVfN3W63PAE3BsL14bVdqVO2tlNcssVtfsYXd8O616KVBJ5ziOAQoahn3/
         XHhr3q2KlMU2BQBOhI2q6dEa67i5TRF+u+XUtBvjBCGUiyo4qV+2+Qt+ws28/ftehQXd
         UPF+bYoaXEfzOaOSO9ZVC6RBt4reTzvFsSkpJOjXkhI4I0P5sA7k4n0vUWz5VYwmcQfD
         1YNw==
X-Gm-Message-State: AA6/9RkGHfiQMoyTBGvWaCCmI4+OcrI/d/Ti9ArNVnvJkHJeWzfPLW78s3+EmdZnqB5GllTy
X-Received: by 10.28.41.6 with SMTP id p6mr14301902wmp.18.1475575874520;
        Tue, 04 Oct 2016 03:11:14 -0700 (PDT)
Received: from [192.168.1.21] ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id us3sm2697592wjb.32.2016.10.04.03.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Oct 2016 03:11:14 -0700 (PDT)
Subject: Re: [PATCH] MIPS: ath79: Add initial support for the HAPROXY Aloha
 Pocket board
To:     Yegor Yefremov <yegorslists@googlemail.com>
References: <1475508931-16800-1-git-send-email-narmstrong@baylibre.com>
 <20161004110940.57d112df@tock>
 <3b41a114-7ec7-cd50-6967-9a1be96e2c2f@baylibre.com>
 <CAGm1_ktvXYY5r2nWk3GneERmcMV+YwNa=-4arSmJjC_kNjPpSQ@mail.gmail.com>
Cc:     Alban <albeu@free.fr>, ralf@linux-mips.org,
        linux-mips <linux-mips@linux-mips.org>,
        kernel list <linux-kernel@vger.kernel.org>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <154dc5c8-0d40-9cd7-5997-0ede70605510@baylibre.com>
Date:   Tue, 4 Oct 2016 12:11:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAGm1_ktvXYY5r2nWk3GneERmcMV+YwNa=-4arSmJjC_kNjPpSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <narmstrong@baylibre.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55318
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

On 10/04/2016 12:09 PM, Yegor Yefremov wrote:
> Hi Neil,
> 
> On Tue, Oct 4, 2016 at 11:40 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>> On 10/04/2016 11:09 AM, Alban wrote:
>>> On Mon,  3 Oct 2016 17:35:31 +0200
>>> Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>
>>>> The HAPROXY Aloha pocket board is a Load Balancer demo board based on the
>>>> Atheros AR9331 SoC with 64Mbytes DDR and 16Mbytes on-board SPI Flash.
>>>>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>
>>> Please use device tree instead of adding another board file.
>>>
>>> Alban
>>>
>>
>> Hi Alban,
>>
>> I'm quite surprised since it seems no device tree support is available for ath79,
>> I would really like to have device tree for this board, but this is only a copy/paste of
>> the mach-ap121 with button/leds gpio differences.
>>
>> Could it be possible to merge it ? I would be happy to support this board once device tree
>> support is landed on the mips tree !
> 
> Take a look at these DTS files from the current Linux tree:
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/qca/ar9331_dpt_module.dts
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
> 
> etc.
> 
> Regards,
> Yegor
> 

My bad, the qca naming is really disturbing.

I will push a dts instead.

Thanks,
Neil
