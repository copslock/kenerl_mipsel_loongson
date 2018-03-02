Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2018 18:56:39 +0100 (CET)
Received: from mail-ot0-x242.google.com ([IPv6:2607:f8b0:4003:c0f::242]:44866
        "EHLO mail-ot0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993004AbeCBR4bVmCai (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Mar 2018 18:56:31 +0100
Received: by mail-ot0-x242.google.com with SMTP id 79so9459758oth.11
        for <linux-mips@linux-mips.org>; Fri, 02 Mar 2018 09:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qGfGAM9LtqSx5H6CptQthgFk9g+HQRNZO8N4A3CAJGc=;
        b=T0ftpGAVHoJQ+wWaZZClzxaqZMGAbpW1E5Uh9umg6ORhTZ1mfrJpCkVQqDkP86GQgn
         csR/wk/SBcaa/VGfh+17GfWfzChj8VlEfQIamKIn8p3hj8AZCe8pHV+hg0hW+YGWBY6Q
         eAfUTBKqgip2iI1/4yVrbs1mIo0EAdjfbHD11o1BAUJJ2Q4PSb5XpMSA8UQVeWmHZ5Kp
         DHQiKBH6Pzm68Uixa2oC2/6zHgbAaIhh6W0qSmacXelOCXpfMV0UfqIFnsNbn64Fo/CM
         sSAKVcA6OyiCdywiGJvnjXxROBHlrWuP9QnpYX4BVKYDG6uWEOm0SeTGAcAPrbPTMX0c
         qSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qGfGAM9LtqSx5H6CptQthgFk9g+HQRNZO8N4A3CAJGc=;
        b=d5Xy4dX0JWHQv4bVBVthsMaFl+zqsvSPReOtfzKa7nQhHROXcaug9PCV0Xai4xSkls
         YYk89qrKdtpH9BXTftJMl2reZGnqiD3KnToUks5BcdOsXkUUSBaGgBceOqBlX/DCx8iW
         InFo4O3D+y+f7zsuwpshw2OI0CvOlSEfyTA+oS8xNEbmhxnWAxEe/0pwyRQdpz1Wzpva
         0O0H6F/4oZ4/H4rHK8LHeCjWDX28Aahsq2EMezs3J+LVVahc60umxckhn7e9IIE0c4AG
         abw6tl2QvbV52XdAYZqtdOO68h7+GM0mz74lP12IsV4kG0vOTRXk8JHU7UIYzEftG4Wc
         DhRw==
X-Gm-Message-State: APf1xPBm86sC0vRuztSf6n/A9dpi0rrTIGHtG8BaQPgFahSBt/NbcV5Q
        qviE6LQDePTFBCAJv4rzXlg=
X-Google-Smtp-Source: AG47ELtagPSKuhMSboz41FqAntAW9A/5swUF03R2T9u8YlmIlYrfYlmY6R5A9wJKA8X7rGFBLwDLww==
X-Received: by 10.157.85.67 with SMTP id h3mr4744166oti.329.1520013384807;
        Fri, 02 Mar 2018 09:56:24 -0800 (PST)
Received: from Larrylap.localdomain (cpe-24-31-251-255.kc.res.rr.com. [24.31.251.255])
        by smtp.gmail.com with ESMTPSA id q47sm3645970ota.39.2018.03.02.09.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 09:56:23 -0800 (PST)
Subject: Re: [PATCH v2] bcma: Prevent build of PCI host features in module
To:     Kalle Valo <kvalo@codeaurora.org>,
        Matt Redfearn <matt.redfearn@mips.com>
Cc:     zajec5@gmail.com, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org, jhogan@kernel.org
References: <1519898292-12155-1-git-send-email-matt.redfearn@mips.com>
 <87lgfcnkey.fsf@kamboji.qca.qualcomm.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <c5929bb5-c50f-e73e-3117-fb0a862bb0fc@lwfinger.net>
Date:   Fri, 2 Mar 2018 11:56:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87lgfcnkey.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <larry.finger@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Larry.Finger@lwfinger.net
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

On 03/01/2018 04:45 AM, Kalle Valo wrote:
> Matt Redfearn <matt.redfearn@mips.com> writes:
> 
>> Attempting to build bcma.ko with BCMA_DRIVER_PCI_HOSTMODE=y results in
>> a build error due to use of symbols not exported from vmlinux:
>>
>> ERROR: "pcibios_enable_device" [drivers/bcma/bcma.ko] undefined!
>> ERROR: "register_pci_controller" [drivers/bcma/bcma.ko] undefined!
>> make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1
>>
>> To prevent this, don't allow the host mode feature to be built if
>> CONFIG_BCMA=m
>>
>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>>
>> ---
>>
>> Changes in v2:
>> Rebase on v4.16-rc1
>>
>>   drivers/bcma/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bcma/Kconfig b/drivers/bcma/Kconfig
>> index ba8acca036df..cb0f1aad20b7 100644
>> --- a/drivers/bcma/Kconfig
>> +++ b/drivers/bcma/Kconfig
>> @@ -55,7 +55,7 @@ config BCMA_DRIVER_PCI
>>   
>>   config BCMA_DRIVER_PCI_HOSTMODE
>>   	bool "Driver for PCI core working in hostmode"
>> -	depends on MIPS && BCMA_DRIVER_PCI && PCI_DRIVERS_LEGACY
>> +	depends on MIPS && BCMA_DRIVER_PCI && PCI_DRIVERS_LEGACY && BCMA = y
> 
> Due to the recent regression in bcma I would prefer extra careful review
> before I apply this. So does this look ok to everyone?

I have a preference for wireless device drivers to be modules. For that reason, 
I would have submitted a patch exporting those two missing globals rather than 
forcing bcma to be built in. That said, it seems that the patch will do no 
further harm.

Larry
