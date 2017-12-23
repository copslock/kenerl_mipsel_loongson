Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Dec 2017 16:57:58 +0100 (CET)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:33337
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990502AbdLWP5wArgi3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Dec 2017 16:57:52 +0100
Received: by mail-pl0-x242.google.com with SMTP id 1so13084126plv.0;
        Sat, 23 Dec 2017 07:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1IfxSqrDmvb98HC/fFZYWsuw74blD3gNCqQyCuae3gI=;
        b=HxjkM2zporuAueqFs6JWY42sga4fNS2uEwwzCJdEFpxVWbulMULIJOeKOI1Ib+Mgct
         2rmU+R9S2gO3utEE3rUALG1HA7y96rHFatXgalUBKIF4Z63cYYg97EPfiaCoaW4TdvH9
         wzxqC2rUCnDs1efedLSIlT1iad3kvwuNRZ4bvS87AZPIiVp56lq7SrjaI0gUeYNEGdbC
         y1ncj8EmcOEEdgQ4XrLQZYqcTKAZEdS0NLU9TvLzrGq/B0lip7WPp0GiKDeGYJaekoF7
         CoypLbYfoPwxMN8CWI9jhKoUtDIPBH36Bj85i5dt9Yho34mEpVIX6tZRp00g88Mo1Vaj
         7Apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1IfxSqrDmvb98HC/fFZYWsuw74blD3gNCqQyCuae3gI=;
        b=GhK3Kk2o8b1roMgvunf8LTGQrctlglqmENdldEm7a7g/yCyxhjbeXb6DIevbiiMv4O
         bthE+biOCj9sBM4/8aABg+h9FYOSybZVe6hainsJbjkxFNjveUhxFhAuHdDOiZQSHPvO
         w2uudyRHlbRySfPd9lK3PJKFpUVgoRfgqy/OgxZd6hyvGIkeajUJ9Y3MfRRYlERHnfiL
         v9gjX3bPNAt0u2xt4BdBbSUvHMxOOfB6mO3WgD8mLOtH96VuPFRaumPrVLbzVx9FNzIL
         1bPsaWfKdp6h20MbxcJVrxLsiOl/SYTBBaDizShviVOVn7kLV7exKsE7DbtGtZ0fNd63
         GsPA==
X-Gm-Message-State: AKGB3mIGur/44ONF1E9Wfl7jL28EU0ufs+Ih9RNz1E46FB84Bwf6pQD1
        jSV2HDPbH5zJwI5U2FZi5qc=
X-Google-Smtp-Source: ACJfBot4tk+t3T8+1ArGVSfTQ5z/Ag47FAQL0ZQZ2Q52thAgeVbBIpWJAU8hfYAH4eF6zL0s8HHsXQ==
X-Received: by 10.84.252.137 with SMTP id y9mr17402953pll.153.1514044665398;
        Sat, 23 Dec 2017 07:57:45 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id f67sm48344493pff.173.2017.12.23.07.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Dec 2017 07:57:44 -0800 (PST)
Subject: Re: [PATCH v3 00/27] kill devm_ioremap_nocache
To:     Greg KH <gregkh@linuxfoundation.org>,
        Yisheng Xie <xieyisheng1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, ysxie@foxmail.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        boris.brezillon@free-electrons.com, richard@nod.at,
        marek.vasut@gmail.com, cyrille.pitchen@wedev4u.fr,
        linux-mtd@lists.infradead.org, alsa-devel@alsa-project.org,
        wim@iguana.be, linux-watchdog@vger.kernel.org,
        b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        lgirdwood@gmail.com, broonie@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, arnd@arndb.de,
        andriy.shevchenko@linux.intel.com,
        industrypack-devel@lists.sourceforge.net, wg@grandegger.com,
        mkl@pengutronix.de, linux-can@vger.kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com, linux-rtc@vger.kernel.org,
        daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        seanpaul@chromium.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org,
        tj@kernel.org, linux-ide@vger.kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, devel@driverdev.osuosl.org,
        dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, jakub.kicinski@netronome.com,
        davem@davemloft.net, nios2-dev@lists.rocketboards.org,
        netdev@vger.kernel.org, vinod.koul@intel.com,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        jslaby@suse.com
References: <1514026525-32538-1-git-send-email-xieyisheng1@huawei.com>
 <20171223134831.GB10103@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f7632cf5-2bcc-4d74-b912-3999937a1269@roeck-us.net>
Date:   Sat, 23 Dec 2017 07:57:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171223134831.GB10103@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 12/23/2017 05:48 AM, Greg KH wrote:
> On Sat, Dec 23, 2017 at 06:55:25PM +0800, Yisheng Xie wrote:
>> Hi all,
>>
>> When I tried to use devm_ioremap function and review related code, I found
>> devm_ioremap and devm_ioremap_nocache is almost the same with each other,
>> except one use ioremap while the other use ioremap_nocache.
> 
> For all arches?  Really?  Look at MIPS, and x86, they have different
> functions.
> 

Both mips and x86 end up mapping the same function, but other arches don't.
mn10300 is one where ioremap and ioremap_nocache are definitely different.

Guenter

>> While ioremap's
>> default function is ioremap_nocache, so devm_ioremap_nocache also have the
>> same function with devm_ioremap, which can just be killed to reduce the size
>> of devres.o(from 20304 bytes to 18992 bytes in my compile environment).
>>
>> I have posted two versions, which use macro instead of function for
>> devm_ioremap_nocache[1] or devm_ioremap[2]. And Greg suggest me to kill
>> devm_ioremap_nocache for no need to keep a macro around for the duplicate
>> thing. So here comes v3 and please help to review.
> 
> I don't think this can be done, what am I missing?  These functions are
> not identical, sorry for missing that before.
> 
> thanks,
> 
> greg k-h
> 
