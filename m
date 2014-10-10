Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Oct 2014 14:37:49 +0200 (CEST)
Received: from mail-la0-f41.google.com ([209.85.215.41]:39104 "EHLO
        mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011068AbaJJMhsHnsA1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Oct 2014 14:37:48 +0200
Received: by mail-la0-f41.google.com with SMTP id pn19so3197194lab.14
        for <linux-mips@linux-mips.org>; Fri, 10 Oct 2014 05:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=iy35wAKFHTJWcsre0wuV1oUNaUZx4MTGsrYl17aifpM=;
        b=Xz8pgw4SV7cFudGCmcAnR8TtNo8MnXWnEn3hWSEjF8llulEchtpwIkw4cRP07dE2Xr
         OYbH5fBF3YkRdqhsjx1nyazivgLL+XgK9h5tMPglysc0R5oehxpnbbeSHYupjCCliYsM
         hlpVwHfvyG2J0szrs6GgE8AZfb57w7P1lzcGuQWGB8W5oj6C4+ae0e1J6AK3PhrTz4Ls
         4ASGYwAhDY/abUZXfCk1/yJ4Fl59mnmHrMscYZlhlAyOvt7CyZ7+DIYiEg3z8afc5JVH
         Wq7PO79hKJ9FHoGS7PyVkfdCDxef7ge1ywLsNX+HxVF4ff+/twXDp5zN75NMQ6v1K6gJ
         cEFQ==
X-Gm-Message-State: ALoCoQlf+iWnb1Ht/dYY8PABG0v1s5S6MyXgRkyxkXiAWZBMHpMy2/thVz2mbUDdaIegJkcmvuY0
X-Received: by 10.152.43.99 with SMTP id v3mr4576820lal.13.1412944655396;
        Fri, 10 Oct 2014 05:37:35 -0700 (PDT)
Received: from [192.168.2.5] (ppp18-197.pppoe.mtu-net.ru. [81.195.18.197])
        by mx.google.com with ESMTPSA id dw2sm1791382lbc.38.2014.10.10.05.37.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Oct 2014 05:37:34 -0700 (PDT)
Message-ID: <5437D30E.6030602@cogentembedded.com>
Date:   Fri, 10 Oct 2014 16:37:34 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] DT: Add documentation for gpio-rt2880
References: <1412885241-12476-1-git-send-email-blogic@openwrt.org> <5436F058.6010406@cogentembedded.com> <54376E45.8020904@openwrt.org>
In-Reply-To: <54376E45.8020904@openwrt.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

On 10/10/2014 9:27 AM, John Crispin wrote:

    Hm, why didn't you reply to me but only to linux-mips?

>>> +- interrupts : Specify the INTC interrupt number +-
>>> ralink,num-gpios : Specify the number of GPIOs +-
>>> ralink,register-map : The register layout depends on the GPIO
>>> bank and actual +        SoC type. Register offsets need to be in
>>> this order. +        [ INT, EDGE, RENA, FENA, DATA, DIR, POL,
>>> SET, RESET, TOGGLE ]

>> This should be determined by the "compatible" property alone, I
>> think.

> we specifically put this into dts as almost each of the SoC versions
> has a different register layout. i really want to avoid having to
> patch the gpio driver whenever ralink/mtk decides to "change the
> registers yet again".

    Yes, that's what we have to do in e.g. driver/net/ethernet/sh_eth.c.
There are 5 register layouts known by now, 2 of them were added recently. :-)

> I can change it if must be.

    Yes, I think it must be this way.

> but i really would
> prefer to keep it this way as it will safe me lots of time in future

> 	John

WBR, Sergei
