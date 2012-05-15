Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2012 18:40:12 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:50411 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903678Ab2EOQkE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 May 2012 18:40:04 +0200
Received: by lbbgg6 with SMTP id gg6so5382240lbb.36
        for <linux-mips@linux-mips.org>; Tue, 15 May 2012 09:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=zsMrg5QSM8YydG3/0wsE/EtRKR00gqVocxYBgJszFHo=;
        b=LubVEfxqjzsRuulwCFPIE6Ev/6eyWd0DHajZdXQewfy2Aj/XqhtYMNWEjLv6fuL2EO
         48MBCA2HRKOYwbdaezhk85x1jrbteQtHpf1607ky7Sb2W9q+B5bULtOY37Ey+GhokchV
         Ssa5QUm/RAYyNJJBLXBl5H4w27g2FBVKs3ghAreWA4iiQPXD3gPv+BXrP0gz6uyHiQVD
         AKYvICT4Miu8KFzIMrJBarbKEbInIGvGqF9sLioXwQtSGJH51vfiIrQTJb0hXXxo4XOG
         szsnnuOe6rCEUAfpfmzJYy9pNbBUxXMVerJHebBvlEPxFB1QkX4xJKWEKrRGAMeRKP7k
         8ViA==
Received: by 10.112.44.233 with SMTP id h9mr6017540lbm.26.1337099998642;
        Tue, 15 May 2012 09:39:58 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id k4sm29197635lbb.12.2012.05.15.09.39.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 May 2012 09:39:57 -0700 (PDT)
Message-ID: <4FB28694.6030300@mvista.com>
Date:   Tue, 15 May 2012 20:38:44 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [RESEND PATCH V2 06/17] MIPS: lantiq: convert dma to platform
 driver
References: <1337017363-14424-1-git-send-email-blogic@openwrt.org> <1337017363-14424-6-git-send-email-blogic@openwrt.org> <4FB237EE.5010502@mvista.com>
In-Reply-To: <4FB237EE.5010502@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQn4bfWT3a6xq6Bqz30u6IKkNLvGnMAHTkg8KIqYNZoEXhsRgFRoGH0yiloEfrtAVQMIuMje
X-archive-position: 33328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 05/15/2012 03:03 PM, Sergei Shtylyov wrote:

>> Add code to make the dma driver load as a platform device from the devicetree.

>> Signed-off-by: John Crispin<blogic@openwrt.org>
>> ---
>> arch/mips/lantiq/xway/dma.c | 65 ++++++++++++++++++++++++++++--------------
>> 1 files changed, 43 insertions(+), 22 deletions(-)

>> diff --git a/arch/mips/lantiq/xway/dma.c b/arch/mips/lantiq/xway/dma.c
>> index b210e93..0dffb94 100644
>> --- a/arch/mips/lantiq/xway/dma.c
>> +++ b/arch/mips/lantiq/xway/dma.c
> [...]
>> +int __init
>> +dma_init(void)
>> +{
>> + int ret = platform_driver_register(&dma_driver);
>> +
>> + if (ret)
>> + pr_info("ltq_dma : Error registering platfom driver!");

> You forgot '\n'.

    And I didn't notice "platfom" at first. Sorry. :-)
    Maybe you'll just get rid of the message? ;-)

WBR, Sergei
