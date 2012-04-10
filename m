Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Apr 2012 21:27:30 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:53737 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903712Ab2DJT1Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Apr 2012 21:27:24 +0200
Received: by lboj14 with SMTP id j14so153586lbo.36
        for <linux-mips@linux-mips.org>; Tue, 10 Apr 2012 12:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=Kd2gJNwePdIb8cNbKZ1XmcQUdIcW8/Oq5t+NJw38p08=;
        b=HDlwxAlW7yYNmFiWYcmnvlMRFPaJ1xUQSf8M+G2F5fO0Uhc8fHK8zOtuMg/nOjCytQ
         6sAvnP0YyN2sHLHnzM61WHTLdC79H+fwJktDuGE7XHYLeyeyu+XJtfbts1L6fMZ1y55U
         SdjTKYEyx9t75Di7mdgCfTAYrKN58zTMmpjGSZZpvPqEtia+zQs7NEurameZ7smPbtTb
         GYF5hwY5DGUult7OpwspKFQR68hyr8hfwbAcLAKynK/SiDndaygsnAU5F6mDVo8BNEy0
         7j39Te/4v8kgNK9qDxAUlr/C8VzQOAAww+QGC1lmTNHGquRERT7qBNzWig7xmOtQD+fb
         06yg==
Received: by 10.112.85.228 with SMTP id k4mr1686939lbz.76.1334086038151;
        Tue, 10 Apr 2012 12:27:18 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id a8sm269611lba.15.2012.04.10.12.27.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 12:27:17 -0700 (PDT)
Message-ID: <4F848957.6000400@mvista.com>
Date:   Tue, 10 Apr 2012 23:26:15 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     Leonid Yegoshin <yegoshin@mips.com>
CC:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: [PATCH] Add MIPS64R2 core support.
References: <1333987461-822-1-git-send-email-sjhill@mips.com> <4F841E48.7000104@mvista.com> <4F848576.6040204@mips.com>
In-Reply-To: <4F848576.6040204@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnm3A3xKOlCAT+kQajEF8+PkX5VGiHyi1rvVCPbpUj8H8TjtQOcmaTqiQuK8oHSRv9uRhOM
X-archive-position: 32927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

Leonid Yegoshin wrote:

>>> +config 64BIT_PHYS_ADDR
>>> +    bool "Kernel supports 64 bit physical addresses" if EXPERIMENTAL
>>> +    depends on 64BIT

>>    This option is selected on 32-bit CPUs like Alchemy, which has 
>> 36-bit physical address. It will cause a warning about unmet

> Just verified - selected Alchemy and DB1000 board and got

> # CONFIG_64BIT is not set
> CONFIG_64BIT_PHYS_ADDR=y
> CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
> CONFIG_PHYS_ADDR_T_64BIT=y

> ???

    And you didn't get a warning on "select 64BIT_PHYS_ADDR"? Strange, modern 
Kconfig should spit out one...

> I also want to say that NetLogic Microsystems web site indicates that 
> some of Alchemy CPU has only 14 bit DDR/SDRAM address, for exam - Au1550 
> (http://www.netlogicmicro.com/Products/Alchemy/Au1550.asp) but 
> arch/mips/configs/db1550_defconfig (and pb1550) choses 64BIT_PHYS_ADDR 
> too.  Seems like something wrong here.

    High address bits on Alchemies are used to address PCI/PCMCIA space, not RAM.

> - Leonid.

WBR, Sergei
