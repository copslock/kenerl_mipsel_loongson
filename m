Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Aug 2013 14:04:17 +0200 (CEST)
Received: from mail-la0-f54.google.com ([209.85.215.54]:33269 "EHLO
        mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817904Ab3HHMEPPkPsp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Aug 2013 14:04:15 +0200
Received: by mail-la0-f54.google.com with SMTP id ea20so1988064lab.41
        for <linux-mips@linux-mips.org>; Thu, 08 Aug 2013 05:04:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Po/M7Q1rcuAFGGK/ONkyZc/aiNy9s8BZl+0nWLGNrns=;
        b=B+mueIHA3C9+jXdZLaR1t51PifGWOYU7jBDUR7EIW3r36NhQWQWzSoQYGoEc2XS7wQ
         cd0i4HqU9RQUYsj5YdyuNr3TGRW11wcTUBnTmKbqGchFFhbVI7tIjrZR2kvRIISe82B2
         fZMTxy89SeUHe/tuw8SrMyAePNmc4MJ4VlqgIbHcK8v4BKnTneg+Jyzm3KLJWXeFv21Z
         lhdgapkN86BMG0RVaKsHGU5FO+XdytOeNYCk2NB/mnNdyqqzYekj9h+xcJz6hNv/DYy5
         gio6NWF9bpgfYsfTEZbslHU+McPq1Ptvu7N6A3cVoqR9IUmsZMu0i2Xt1oLdgnllCx25
         WFxQ==
X-Gm-Message-State: ALoCoQmkPQsboXhUbqkyXVdQSKgN8wsL+zWDteiDnN93+all7a/lk0SUvO8YsUhgGPILvRANmoI8
X-Received: by 10.152.19.70 with SMTP id c6mr3632372lae.25.1375963449603;
        Thu, 08 Aug 2013 05:04:09 -0700 (PDT)
Received: from [192.168.2.4] (ppp91-76-149-206.pppoe.mtu-net.ru. [91.76.149.206])
        by mx.google.com with ESMTPSA id eb20sm4940459lbb.15.2013.08.08.05.04.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 05:04:08 -0700 (PDT)
Message-ID: <5203893E.4040401@cogentembedded.com>
Date:   Thu, 08 Aug 2013 16:04:14 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/4] MIPS: lantiq: adds minimal dcdc driver
References: <1375952846-25812-1-git-send-email-blogic@openwrt.org> <1375952846-25812-2-git-send-email-blogic@openwrt.org> <520379D4.9040903@cogentembedded.com> <CAGVrzcY8NAu0BZBNXVC-sJk7_=40GmepG30ff4+wJQPr4A8J6w@mail.gmail.com>
In-Reply-To: <CAGVrzcY8NAu0BZBNXVC-sJk7_=40GmepG30ff4+wJQPr4A8J6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37470
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

Hello.

On 08-08-2013 15:17, Florian Fainelli wrote:

>>> This driver so far only reads the core voltage.

>>> Signed-off-by: John Crispin <blogic@openwrt.org>

>> [...]

>>> diff --git a/arch/mips/lantiq/xway/dcdc.c b/arch/mips/lantiq/xway/dcdc.c
>>> new file mode 100644
>>> index 0000000..6361c30
>>> --- /dev/null
>>> +++ b/arch/mips/lantiq/xway/dcdc.c
>>> @@ -0,0 +1,75 @@

>> [...]

>>> +
>>> +       /* remap dcdc register range */
>>> +       dcdc_membase = devm_request_and_ioremap(&pdev->dev, res);

>>     Use devm_ioremap_resource().

>>> +       if (!dcdc_membase) {
>>> +               dev_err(&pdev->dev, "Failed to remap resource\n");

>>     Error messages are already printed by devm_request_and_ioremap()
>> ordevm_ioremap_resource().

>>> +               return -ENOMEM;

>>     -EADDRNOTAVAIL is the right code for devm_request_and_ioremap().

> This is the first time that I read this, lib/devres.c internal returns
> -ENOMEM when an ioremap() call fails

    What if the other call fails?

> (see devm_ioremap_resource),
> -EADDRNOTAVAIL really is for networking matter, this is not.

    Just see the comment accompanying devm_request_and_ioremap().

WBR, Sergei
