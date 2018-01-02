Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 13:02:37 +0100 (CET)
Received: from mail-wm0-x241.google.com ([IPv6:2a00:1450:400c:c09::241]:42123
        "EHLO mail-wm0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992821AbeABMCRti4oa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 13:02:17 +0100
Received: by mail-wm0-x241.google.com with SMTP id b141so14224671wme.1
        for <linux-mips@linux-mips.org>; Tue, 02 Jan 2018 04:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xfm4uNmV3HoBAPLdtsqHN+e54pBK6QYyagHaVhf/MKI=;
        b=CHSdO9gHFBXDq2qJFIVIu5t1jYBz8LYicqepA2HGppy7FgvpEilS2UQwdj++tz+s3x
         ETX1pjh4wsxaD7k2buDr+Sn2iNzgAm4BqBMMfFVUgAROfaoncS2PB60pK1auyz+l9Me6
         GEWPdNgW5LSe+4rZ4SJgu/oWSDGzJeaGZxaMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xfm4uNmV3HoBAPLdtsqHN+e54pBK6QYyagHaVhf/MKI=;
        b=qGwltkopl+UL7t4FPG5xEwZZatymhSmH2kyh9N0J8BU+WvGA/R5N+7RJBITppSjoLB
         KqQUqRCgBVS6jPFyDVvrIAEHkIwXJ2pJwg1fnVcwDgqWInrHEktBZcJfp5gPv7i2J0mL
         feA5ZzSZjf1rzMx0EPeFr82vfoozscdq45y3b+mHrDPEwHjeroLaAnpjEDsafak+ATIX
         ihQ44YMyt6Zd4Fxwp7mA76LFa5acgryWJZWaYssTGrx4J6VKMVHQoNBbAOWbKv96r4Iz
         pnl/0iYUcv8vOMR+AueNMlGyb7n9y8mkRYyHn9m3CtFyCOl/HKFznN9kwBnyYMZ9zvLe
         QvNA==
X-Gm-Message-State: AKGB3mJpu8ci020n9g+QIkBKqmcIjHkOelJDuTZbvd567W+ZT9urZL4A
        tQRdRp4jLD2lp1hu7YVzvNhrui4VrUk=
X-Google-Smtp-Source: ACJfBou/zT8gPCRIYqeRy7a4vCNXWuKIxLgYsCd8Atc7XJFpfnWVKeOy0BopdJxAPc4yXH1N4LXnmg==
X-Received: by 10.80.175.161 with SMTP id h30mr62503464edd.292.1514894532322;
        Tue, 02 Jan 2018 04:02:12 -0800 (PST)
Received: from [192.168.0.20] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id y28sm35523527edi.95.2018.01.02.04.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jan 2018 04:02:11 -0800 (PST)
Subject: Re: [PATCH v2 1/2] nvmem: add driver for JZ4780 efuse
To:     Mathieu Malaterre <malat@debian.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zubair.Kakakhel@mips.com,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
References: <20171228212954.2922-1-malat@debian.org>
 <20171228212954.2922-2-malat@debian.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3ec9ddab-f855-8c39-4d75-d35be7bd6731@linaro.org>
Date:   Tue, 2 Jan 2018 12:02:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20171228212954.2922-2-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <srinivas.kandagatla@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: srinivas.kandagatla@linaro.org
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



On 28/12/17 21:29, Mathieu Malaterre wrote:
> From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> 
> This patch brings support for the JZ4780 efuse. Currently it only expose
> a read only access to the entire 8K bits efuse memory.
> 
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
Please split this patch, as you are mixing code, documentation, dts and 
MAINTAINER changes here.

Without which patch can not be reviewed!!


Thanks,
Srini

>   .../ABI/testing/sysfs-driver-jz4780-efuse          |  16 ++

>   .../bindings/nvmem/ingenic,jz4780-efuse.txt        |  17 ++
>   MAINTAINERS                                        |   5 +
>   arch/mips/boot/dts/ingenic/jz4780.dtsi             |  40 ++-
>   drivers/nvmem/Kconfig                              |  10 +
>   drivers/nvmem/Makefile                             |   2 +
>   drivers/nvmem/jz4780-efuse.c                       | 305 +++++++++++++++++++++
>   7 files changed, 383 insertions(+), 12 deletions(-)
...
