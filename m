Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Feb 2017 02:27:16 +0100 (CET)
Received: from mail-ot0-x242.google.com ([IPv6:2607:f8b0:4003:c0f::242]:33577
        "EHLO mail-ot0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992209AbdBRB1HitFBY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 18 Feb 2017 02:27:07 +0100
Received: by mail-ot0-x242.google.com with SMTP id g13so345653otd.0;
        Fri, 17 Feb 2017 17:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=dE0K9h5ik2FgMuEqMUa6jPL5yUoqSXzwwnn19JD+qjU=;
        b=N5EINQgPlyhyCUAl/fE7ibVq66kjM+6lGCAHqlkdTgCmMGhu0UHdivza2bomuknf63
         wgaG5a4B5bwZnredF6wNTogqjtA3iQiMU76vW0QMbGnUXztkKsYgMIU8WV3oaaVJE5T/
         EreD5FO86ZkZFRgYOL/9gBuc//UILrE5fkXFiamJXZMnIrqsb//DKWGwLsxU+JPDMtky
         Rdu1cKI9Po6v6DAI/vsyi/DUTcDVMsVWe6ksWPejsI+o0ryWJB6jjP02lEjUNhHZIfQb
         Io88RBZURs7/fkoeOlkXHbMmap/t6lGM05P53Z217tux2rDXZOa7H92wII8kB0F3Y1QI
         4BWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=dE0K9h5ik2FgMuEqMUa6jPL5yUoqSXzwwnn19JD+qjU=;
        b=lgBLM53Fej1mJ5GtY61XBXMKybGCdBVCP/gRU1HJuGJy7x8f7tnItpkLqqCDKWvnX0
         j+2cggxxfqKFcDxNjFQTicmeTxEzX5BovOfcMONTTJCxlCb/hOm1W6gkyj4RAIvwWpeL
         53bDm80BInn1j0mSQu2h2rFRYBkol/JBUjXC1ULqKK//KfXIqkcKtL6uU8mhTyVyJmt9
         kdpCosKO/UtlJepYg18O0Scobi44/b4lYPcgmyt0yGLuvkxXXZ2Mxy7zdk68U7jo6Xmz
         PfXB+jWHKyvX7ZnSLM0NrPayphYeV8l1mo+v2MVgiobSmjmNLrt5Uhf4jVnCI/4Tlxf+
         4tbw==
X-Gm-Message-State: AMke39nO9kJKgx7FlUQRZwhYg8j32JwGJ43Lk09prv37ioGfrCl76pBI92oGv2s3hWBdKA==
X-Received: by 10.157.58.101 with SMTP id j92mr6435245otc.100.1487381220793;
        Fri, 17 Feb 2017 17:27:00 -0800 (PST)
Received: from ?IPv6:2001:470:d:73f:f1d2:aee0:203:f72a? ([2001:470:d:73f:f1d2:aee0:203:f72a])
        by smtp.gmail.com with ESMTPSA id k51sm705925otc.12.2017.02.17.17.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2017 17:27:00 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: cpufreq: add bmips-cpufreq.c
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Markus Mayer <code@mmayer.net>
References: <20170217183050.31889-1-code@mmayer.net>
 <c7a1f607-6619-445a-db35-902f11569dad@gmail.com>
 <2370147.zGx6MqB346@aspire.rjw.lan>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Markus Mayer <mmayer@broadcom.com>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3d7ecb19-f181-fe32-908e-b69906bea941@gmail.com>
Date:   Fri, 17 Feb 2017 17:26:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <2370147.zGx6MqB346@aspire.rjw.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56867
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



On 02/17/2017 05:20 PM, Rafael J. Wysocki wrote:
> On Friday, February 17, 2017 11:24:56 AM Florian Fainelli wrote:
>> On 02/17/2017 10:30 AM, Markus Mayer wrote:
>>> From: Markus Mayer <mmayer@broadcom.com>
>>>
>>> Add maintainer information for bmips-cpufreq.c.
>>>
>>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>>
>> Looks great, thanks for adding this, one nit below:
>>
>>> ---
>>>
>>> This is based on PM's linux-next from today (February 17).
>>>
>>> This patch could be squashed into patch 3/4 of the original series if that
>>> is acceptable (see [1]) or it can remain separate.
>>>
>>> [1] https://lkml.org/lkml/2017/2/7/775
>>>
>>>  MAINTAINERS | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 107c10e..db251c0 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2692,6 +2692,12 @@ F:	drivers/irqchip/irq-brcmstb*
>>>  F:	include/linux/bcm963xx_nvram.h
>>>  F:	include/linux/bcm963xx_tag.h
>>>  
>>> +BROADCOM BMIPS CPUFREQ DRIVER
>>> +M:	Markus Mayer <mmayer@broadcom.com>
>>> +L:	linux-pm@vger.kernel.org
>>
>> Please also include bcm-kernel-feedback-list@broadcom.com here
>>
>> With that:
>>
>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
>>
> 
> Patch applied.

There was a v2 submitted shortly after.
-- 
Florian
