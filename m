Return-Path: <SRS0=kRNa=WK=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1BDC433FF
	for <linux-mips@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2267D2083B
	for <linux-mips@archiver.kernel.org>; Wed, 14 Aug 2019 12:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z6QBXPko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfHNMwy (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:52:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56223 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbfHNMwx (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 14 Aug 2019 08:52:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id f72so4507299wmf.5
        for <linux-mips@vger.kernel.org>; Wed, 14 Aug 2019 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XIHHUQTAaIkQq930LD3yLZeWwpYYGbLuLhq5EB1INAo=;
        b=Z6QBXPko9enURCdOuojsl2mrFx6CcB2vG7I4NrV7pWhMXnozW9rpsIycZp1r3kxBuO
         sLvwMTXlFBfA6bMxhsB7rit33gWgaQXIHBcDQ/AiHoG4MjAxYFJY733hCAndbkehnNsS
         w+yGA77hRsXFvS9BQZW19ND+wQ/PmgUWLf+2mGTHEhrHUdFZd3Z/fyUIr3jXzGYikL6H
         cnc3Z7n3dff+b1A3NSHkMXC5xrQkX0wQeewprGdLX2u1q6wfe3iPM6AQA3MNYn1dnzAi
         rM8YJiK2+cyWQP/2PwnoEe+kdxRLFxBSUte2ASTvoxdcQ2ZVK5fcrclqgjvcJ6rAIybX
         MxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XIHHUQTAaIkQq930LD3yLZeWwpYYGbLuLhq5EB1INAo=;
        b=DsFpEZFtdtlYAkYG5//w0VDGPyChfSphOmqVuXWvRBbXAKYUj+ZyUw0LwKT5dS+QFt
         bnPfoe6LzoMI3p7HlqRwpZe6C+ng9W4N6VbotcZUdr+Y7bXq1e81OzO/EuOiB4L8ZKTS
         bZJLKf2FfScfRlfXih1n8BIPNMgu9gJ8g5pHJN7Ie+xiqdVbv3ABbFszNL8r/lDiFoq7
         5Dut3Jc+I27df2pPthq/ah+AOfQJOJO6bX41Wv6mB+JS4VUSq48TGblE9KYivb25CR9O
         2L/vfwBIniuzSgKz0TxIGzF5zzMOOLZi0jRRX59VrwekqclCKotf+r0sf4xmDzh9tR8I
         QBfg==
X-Gm-Message-State: APjAAAXLrbA3PnXvFDcM6VwiX5abEcZ4ESPz793xv3dPrm/zmkcxCTiJ
        S9D5sMmf5xqliS8kBLzQOAbeoQ==
X-Google-Smtp-Source: APXvYqz5OnlzK877Zfa7M3b8ex6TlTS3w6rPOJiIdXueCVSQhbqCUfs6RFSomk9pcdM3HZlrq0+58Q==
X-Received: by 2002:a1c:1d4f:: with SMTP id d76mr8818760wmd.127.1565787171596;
        Wed, 14 Aug 2019 05:52:51 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id v3sm14272434wrq.34.2019.08.14.05.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 05:52:50 -0700 (PDT)
Subject: Re: [PATCH v4 3/9] nvmem: core: add nvmem_device_find
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Evgeniy Polyakov <zbr@ioremap.net>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20190809103235.16338-1-tbogendoerfer@suse.de>
 <20190809103235.16338-4-tbogendoerfer@suse.de>
 <8d18de64-9234-fcba-aa3d-b46789eb62a5@linaro.org>
 <20190814134616.b4dab3c0aa6ac913d78edb6a@suse.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <31d680ee-ddb3-8536-c915-576222d263e1@linaro.org>
Date:   Wed, 14 Aug 2019 13:52:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190814134616.b4dab3c0aa6ac913d78edb6a@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org



On 14/08/2019 12:46, Thomas Bogendoerfer wrote:
> On Tue, 13 Aug 2019 10:40:34 +0100
> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> wrote:
> 
>>
>>
>> On 09/08/2019 11:32, Thomas Bogendoerfer wrote:
>>> nvmem_device_find provides a way to search for nvmem devices with
>>> the help of a match function simlair to bus_find_device.
>>>
>>> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
>>> ---
>>>    drivers/nvmem/core.c           | 62 ++++++++++++++++++++++--------------------
>>>    include/linux/nvmem-consumer.h |  9 ++++++
>>>    2 files changed, 41 insertions(+), 30 deletions(-)
>>
>> Have you considered using nvmem_register_notifier() ?
> 
> yes, that was the first idea. But then I realized I need to build up
> a private database of information already present in nvmem bus. So I
> looked for a way to retrieve it from there. Unfortunately I couldn't
> use bus_find_device directly, because nvmem_bus_type and struct nvmem_device
> is hidden. So I refactured the lookup code and added a more universal
> lookup function, which fits my needs and should be usable for more.
I see your point.

overall the patch as it is look good, but recently we added more generic 
lookups for DT node, looks like part of your patch is un-doing generic 
device name lookup.

DT node match lookup is in 
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/log/?h=generic_lookup_helpers

of_nvmem_match and nvmem_match_name are duplicating the code here.
Looks like its possible to use generic lookups along with custom match 
by splitting __nvmem_device_get() to two functions, one for lookup and 
other for refcounting.

Other missing bit is adding this api to documentation in 
./Documentation/driver-api/nvmem.rst


thanks,
srini
> 
> Thomas.
> 
