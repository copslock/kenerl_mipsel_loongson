Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Apr 2010 07:54:47 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:47757 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491165Ab0DWFyn convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Apr 2010 07:54:43 +0200
Received: by gyb11 with SMTP id 11so5075456gyb.36
        for <linux-mips@linux-mips.org>; Thu, 22 Apr 2010 22:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rInIZiTCB/eKMDQm4ZIdQvB59DDSdsZ/yNTRnnitrNQ=;
        b=OgFHVlARrRO0Sc57l4GQutacU9OO4q6Wa26NMZmVOtCKzd7vaUdUCth9JI2dUJFQLF
         WFfgyI4/BP9JGnusCr6YpViHoBPtdhXjr/ZPxAEOVeb3/YDBkWa7J0RnUhbXmE7wnwLT
         IWInSGUouOJBBUculoR/mSTFxl0Vr7RlPTgTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QEmTpAQA23fq+w3KSszjfzcR2CrRNUq7YXLa498OtTNxbH0x9KYrbuS/9jG8eNXCyC
         o10cEyBb/VwRkg5HVGtyGVJHI7jRb/p0HloCIiFrxJHfHUdKNvE+7ZyBXdWRufUI4U10
         6hkuUzkK/FMuqSEk2DCqGv0EVGvcLAMhgOtnw=
MIME-Version: 1.0
Received: by 10.231.154.8 with HTTP; Thu, 22 Apr 2010 22:54:36 -0700 (PDT)
In-Reply-To: <5858DE952C53A441BDA3408A0524130104CCE08F@mkegmal01>
References: <5858DE952C53A441BDA3408A0524130104CCE08F@mkegmal01>
Date:   Fri, 23 Apr 2010 15:24:36 +0930
Received: by 10.101.149.17 with SMTP id b17mr27004430ano.80.1272002076539; 
        Thu, 22 Apr 2010 22:54:36 -0700 (PDT)
Message-ID: <j2w6ec4247d1004222254j6452d09dvab747378596c66c8@mail.gmail.com>
Subject: Re: Porting U-boot on MIPS (Au1350)
From:   Graham Gower <graham.gower@gmail.com>
To:     Gurumurthy G M <Gurumurthy.Gowdar@gmobis.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <graham.gower@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26457
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: graham.gower@gmail.com
Precedence: bulk
X-list: linux-mips

On 23 April 2010 15:08, Gurumurthy G M <Gurumurthy.Gowdar@gmobis.com> wrote:
>
>
> Hi All,
>       we are porting U-boot 1.2.0 to MIPS32 Au1350 Processor. i am using ELDK 4.1 for MIPS32.
>
> Thanks wolfgang now am able to compile toolchain for mips after using ELDK for MIPS.
>
> Now while porting U-boot to Au1350 MIPS32 we are facing following problems mentioned below.
>
> We have a MIPS CPU which has reset address 0xBFC00000 , this is mapped to NOR flash with XIP in place. The boot block  ( ie 0xBFC00000) is in the top block of the NOR flash and its of 16KB. U-Boot shall be put from address 0xBFC00000 in the NOR flash for CPU boot up , since it is the last block (16KB only) we cannot put complete U-Boot , some part of the U-Boot should go to lower blocks . To do this u-boot need to be divided into blocks and we shall provide a jump from the top block to other blocks of NOR flash. We have BDI3000 debugger for flashing the NOR flash and bdiGDB for MIPS.

So, your NOR is mapped at: 0xbfc00000 + 16*1024 - 0x00200000 = 0xbfa04000 ?
Wouldn't it be simpler to get your hardware engineer(s) to map the NOR
flash to a saner address? e.g. 0xbfc00000.


>
> Is there any NOR flash drivers available which can support the below chip?
>
> NOR Flash chip : M29W160ET --> AM29BX16
> NOR Flash chip size is 0x00200000 --> 2MB

You'll probably have to add an entry for the chip in
linux/drivers/mtd/chips/jedec_probe.c and create a mapping driver
(plenty of really simple examples in linux/drivers/mtd/maps/).

>
> MIPS CPU Clock is 660MHz
> System Bus is 330MHz
> SDRAM bus clock is 165MHz
>
>
> please let me know if am going wrong anywhere or missing out something.
>
> With Regards,
> Gurumurthy Gowdar
> KPIT Cummins Infosystems Ltd
>
>

-Graham
