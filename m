Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Sep 2017 02:14:58 +0200 (CEST)
Received: from mail-pf0-x244.google.com ([IPv6:2607:f8b0:400e:c00::244]:33982
        "EHLO mail-pf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991131AbdIQAOvo4Rcx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Sep 2017 02:14:51 +0200
Received: by mail-pf0-x244.google.com with SMTP id g65so2960454pfe.1;
        Sat, 16 Sep 2017 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IaG7BT5sDma7BcQen1l3asVYGUeYoxUkzGqSFwaKGF0=;
        b=BNyybLN1anRPtNhjpopTr3kgeL1Xu1swxHytn5OYtVjikOEIt5zxN1RzRWYRL2YHOJ
         ozNX036VCQPNT9TWDKmm2bFOS8syp5c3pQgRh44Lmv0O/MWUX5WM5kF1+eXpIJVmntGJ
         Ke6aHmwVcogN20g1YoftpDsXxcavQWavAzke1+P/JJFADAiLs3mj2AlbfqCZYY31fm3U
         HKf7l3TDXIEJUGCUocHE1DSAQ6qIOmhmOAVxCQaX2Mhx2qgUV2XvO+nFZ6xv51qsEvSJ
         n30zZLdBWkL1M0bydrc33Yq5qJlzMaPscQiR+eTGWWueUGmdS92YeRPLP6ZoUOXI+7iS
         0t5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IaG7BT5sDma7BcQen1l3asVYGUeYoxUkzGqSFwaKGF0=;
        b=SSAc68ylTzS+mdePdsA0Vq0BEU6dNpKJJntr4o1nmUv3+ODKH4PPSXTFDX+DHDMel9
         b/J1sCX+rWOMSZg/20aZAJzwQ9JpCTUAM0HCPcZ+3AsccTEJ9tFE+BeZQbzphvcuZq49
         /HUEpfVsGmPwfGTtHzR/2ux2uJHnaVjXVc82LKorbmyOW/9Hq57Jg1FginvlUQnLpvkN
         dEU3nMLmJcoaxGmfwOttj3gXP1y4b+OMVk/1Z2RyUlSquT0WInqrrpQB/J3EqJr4BElj
         CyWIC12OycI36S93NyHkrLIyD8lI9rgTZpzhW2+GUov4uuZvepL9nomWNmFPMUbNvbWL
         JWfQ==
X-Gm-Message-State: AHPjjUi3sf78C3T7EyyiL8pvn3zRlJTv6xOgbQ64wMnYjd4ASVEBPDF4
        rwSWpcc/ovxIb2ji
X-Google-Smtp-Source: ADKCNb4CxOvGcoh3LUxDi0QhWo8K/+dit5IMJ/9PiUYp/LKbQLWFgLwOJ5JkqZSdpNGFsyXMNRlWhg==
X-Received: by 10.99.121.141 with SMTP id u135mr28649426pgc.262.1505607284992;
        Sat, 16 Sep 2017 17:14:44 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id i63sm8950704pfk.34.2017.09.16.17.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Sep 2017 17:14:43 -0700 (PDT)
Subject: Re: [PATCH 1/5] i2c: gpio: Convert to use descriptors
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Ben Dooks <ben@fluff.org.uk>,
        Ville Syrjala <syrjala@sci.fi>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Schocher <hs@denx.de>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        "arm@kernel.org" <arm@kernel.org>, Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org>
 <20170914093509.uwk47vt3wnm3rtqb@dell>
 <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7f67dfa0-31da-0967-0929-28ae105bb2b5@roeck-us.net>
Date:   Sat, 16 Sep 2017 17:14:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdZYDALXSoEE9jdo7A5P4XZczVbh_uiLkE54=sRtA3rNDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60035
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

On 09/16/2017 03:25 PM, Linus Walleij wrote:
> On Thu, Sep 14, 2017 at 11:35 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
>>>   drivers/mfd/sm501.c                          |  49 +++++-----
>>
>> I'd prefer for this to be applied with a Tested-by.  I appreciate that
>> this is an old driver, but can you attempt to contact one of the
>> authors or someone else who might have hardware please?
> 
> For SM501 specifically I guess.
> 
> OK makes sense as it is the most invasive one, paging around...
> 
> Ben, Ville, Magnus, Heiko, Guenther: is one of you still using this
> hardware so you can test the patch set?
> 

qemu supports it. I _think_ my commit for this driver was to fix a warning
I saw when running some qemu test. Unfortunately, I have no idea how that
message was triggered in my tests, or in other words which qemu machine
actually uses it. I'll try to find out, but no promises.

Guenter
