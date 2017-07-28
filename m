Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jul 2017 02:00:12 +0200 (CEST)
Received: from mail-wm0-x242.google.com ([IPv6:2a00:1450:400c:c09::242]:35733
        "EHLO mail-wm0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993974AbdG2AAFjiEMl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 Jul 2017 02:00:05 +0200
Received: by mail-wm0-x242.google.com with SMTP id r77so15951599wmd.2;
        Fri, 28 Jul 2017 17:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D+3ZdGUtG2uH/NtSvEIbe5NiinAJoNLsFZd8JJkw/Z4=;
        b=mPrdjsZhS8F9pR2KYOGmmWYR2V1c3maDFY0Lt6/+8/mo8upPcRBdPswaSZIqGca6Q2
         D1mybyab1R7eBJK55E5aWkUSkKouDyfTOmS4AK4OnKRa7fq8tmctqgetw83o5aXEx0V/
         3uHW78RLuKiIC2CeyMJ6rRUCgj4C6Gjgs/NTFSqV+mtQQxuRYAC3SI5JYipxDkWYBiOF
         FQ8uIvzdfQvBjiOb3FyvfSNHRmJ+zH1krkh4NYLiBz5E1PJR89GROa3Xup0OvedNhx7c
         H+/aehVltS8uqNiO+6NfxytNkGuCBcgHJsBXzicWjWq7APB+/6LoNxeIGaJC6BuX5IZP
         pWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D+3ZdGUtG2uH/NtSvEIbe5NiinAJoNLsFZd8JJkw/Z4=;
        b=LTr5o5+0ylDP7EqUjseXg/qVHUJY/9DDNBJ3bsuFogaTr+6aKHOOC6Mln1IuKpqcNJ
         f7YAChM+baFjc3HXd31mQcreka4eHuOZNtRz4+jhKNDjH77/ApeJjsDprlaDU5gz2VpD
         gdJlGak+XYKW1/ouk3C4Vqnml7uyyE6bYCtl+hogBJgXra6ECY29jiW4f0vuIX+dgQvW
         NZGisfQqwDjkfuZOM/gUZ4hCmTdWIzTFN74ZjKmhUJ4J+3oPmtS0uLhd26ptRgKrAsK2
         HQCMVPdmG5NCEusYrGLhxMMFbPZJNLKTNP1exWryG4gbXrg0WqJ9eEZGG9GmAdtmqRPP
         +UFA==
X-Gm-Message-State: AIVw111V99OB4PH1lsOzkSB6UdPSt5xjICspYM0cf6Ksb3P7qExIcsdu
        Cx6sggGPQrKjGg==
X-Received: by 10.28.97.133 with SMTP id v127mr7107434wmb.150.1501286400299;
        Fri, 28 Jul 2017 17:00:00 -0700 (PDT)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id q185sm6189403wmd.19.2017.07.28.16.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2017 16:59:59 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Broadcom STB S2/S3/S5 support for ARM and MIPS
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>, Eric Anholt <eric@anholt.net>,
        Justin Chen <justinpopo6@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:BROADCOM BCM47XX MIPS ARCHITECTURE" 
        <linux-mips@linux-mips.org>, linux-pm@vger.kernerl.org
References: <20170706222225.9758-1-f.fainelli@gmail.com>
 <72d54e9c-6a50-2eac-52db-b1e8c234c552@broadcom.com>
Message-ID: <4bebae92-5ae3-8b89-a85a-c06f9d70d658@gmail.com>
Date:   Fri, 28 Jul 2017 16:59:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <72d54e9c-6a50-2eac-52db-b1e8c234c552@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59303
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 07/18/2017 12:52 PM, Florian Fainelli wrote:
> On 07/06/2017 03:22 PM, Florian Fainelli wrote:
>> Hi,
>>
>> This patch series adds support for S2/S3/S5 suspend/resume states on
>> ARM and MIPS based Broadcom STB SoCs.
>>
>> This was submitted a long time ago by Brian, and I am now picking this
>> up and trying to get this included with support for our latest chips.
>>
>> Provided that I can collect the necessary Acks from Rob (DT) and other
>> people (Rafael?) I would probably take this via the Broadcom ARM SoC
>> pull requests.
> 
> Rafael, any feedback on this?

Applied these 4 patches to drivers/next now.
-- 
Florian
