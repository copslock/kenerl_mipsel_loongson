Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Apr 2012 13:55:41 +0200 (CEST)
Received: from mail-lpp01m010-f49.google.com ([209.85.215.49]:36981 "EHLO
        mail-lpp01m010-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903640Ab2DKLzg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Apr 2012 13:55:36 +0200
Received: by lagy4 with SMTP id y4so702749lag.36
        for <linux-mips@linux-mips.org>; Wed, 11 Apr 2012 04:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=PqFaNYmQg6rZvoCSsCRVg8H5/Jkx3RsM0o6zncoCCKY=;
        b=e39trGmyBtvZqG5b7dms+hWlwaNrFzndmB5VklvBQfsh2xiw5KFJQtiHrDa4NxcIhY
         miPE3DyY7wWgZT+A0HoDIanJkjjR2U3nq5b+mENS7lm1Al3TIfKZMOF5/BfktZcVsx1F
         n8FvROdPBTkiCNrEiX9wohRA5yNtt/otrpCUzYJZiMhRu62UfIIAj7DpJuOa95/AcV2c
         3v58umDVKzYeAIEZ0HVl1X2BVCasm3bThOo8CIVIIJoeFa8raHlEhbI+LdZtMz25jzc/
         GxNEYU1wEEO7Co6Mgy/YbJQbBLlBC0jUsFGRxfBYHTafqCVOe7BunTKAPLbhZJ2b2/gq
         lIGA==
Received: by 10.152.135.104 with SMTP id pr8mr17786601lab.27.1334145329740;
        Wed, 11 Apr 2012 04:55:29 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-77-157.pppoe.mtu-net.ru. [91.79.77.157])
        by mx.google.com with ESMTPS id pb13sm2546249lab.16.2012.04.11.04.55.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 04:55:26 -0700 (PDT)
Message-ID: <4F8570D0.3050303@mvista.com>
Date:   Wed, 11 Apr 2012 15:53:52 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To:     Leonid Yegoshin <yegoshin@mips.com>
CC:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH] Add MIPS64R2 core support.
References: <1333987461-822-1-git-send-email-sjhill@mips.com> <4F841E48.7000104@mvista.com> <4F848576.6040204@mips.com> <4F848957.6000400@mvista.com> <4F849017.1020706@mips.com>
In-Reply-To: <4F849017.1020706@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnGmwrUcO/qsy68z71WOVJGtn4GcnjEof20Ix3Tq8VMlXKqRlomp1REzGVMpAxMv2WGvIlm
X-archive-position: 32931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 10-04-2012 23:55, Leonid Yegoshin wrote:

>>>>> +config 64BIT_PHYS_ADDR
>>>>> + bool "Kernel supports 64 bit physical addresses" if EXPERIMENTAL
>>>>> + depends on 64BIT

>>>> This option is selected on 32-bit CPUs like Alchemy, which has 36-bit
>>>> physical address. It will cause a warning about unmet

>>> Just verified - selected Alchemy and DB1000 board and got

>>> # CONFIG_64BIT is not set
>>> CONFIG_64BIT_PHYS_ADDR=y
>>> CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
>>> CONFIG_PHYS_ADDR_T_64BIT=y

>>> ???

>> And you didn't get a warning on "select 64BIT_PHYS_ADDR"? Strange, modern
>> Kconfig should spit out one...

> OK, you right, I missed it in bunch of another. It has sense to add a missed
> dependency.

    You mean to remove it? There's nothing you can add.

> - Leonid.

WBR, Sergei
