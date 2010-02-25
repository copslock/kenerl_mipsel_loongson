Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2010 22:13:05 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:42700 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492128Ab0BYVNC convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 25 Feb 2010 22:13:02 +0100
Received: by pwj2 with SMTP id 2so4556208pwj.36
        for <linux-mips@linux-mips.org>; Thu, 25 Feb 2010 13:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZC04EUPyp0GfL9rGTNRHvFCf1c5tBkzO09pSGK0SA2k=;
        b=DKapL/kKKBSL8NH7Sk43WFF0vO2Z4/VHsIuCuZi4Skxo2bXDu/0Z02Tz1Fe0IeXt/T
         9YNLZxDeDFng1sM4Wi38OzCy5ra0qhs5VL6Hl3n5wPOb6lRinYLFhLfyBobgdpNVGIPs
         cIh7bG5Na+8/usv5cwKJRzUrM/R8VIsBqVHEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sV9Kb1b1xMG4xNbmcy+7qjxKshazW8ZgcvDC6D16Lbv+3kQ9XvDaiHstleJxYz52nW
         D6cq57ybw7uJt0SVlDcMr8+pLdOy1erG+Q0kgH2K63vcFonVC2BptcOWCIrc17YibjJV
         ntvRI4TX0s+y5vflHW2Kwqviy/tkm8OEGkfVQ=
MIME-Version: 1.0
Received: by 10.143.21.40 with SMTP id y40mr903759wfi.348.1267132372434; Thu, 
        25 Feb 2010 13:12:52 -0800 (PST)
In-Reply-To: <201002250852.09638.florian@openwrt.org>
References: <4B861890.6090002@gmail.com>
         <201002250852.09638.florian@openwrt.org>
Date:   Fri, 26 Feb 2010 07:42:52 +1030
Message-ID: <6ec4247d1002251312h37f409bdp2384d7fcbddbb321@mail.gmail.com>
Subject: Re: [PATCH 0/3] XBurst JZ4730 support
From:   Graham Gower <graham.gower@gmail.com>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Mirko Vogt <lists@nanl.de>, Lars-Peter Clausen <lars@metafoo.de>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <graham.gower@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26053
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: graham.gower@gmail.com
Precedence: bulk
X-list: linux-mips

On 25 February 2010 18:22, Florian Fainelli <florian@openwrt.org> wrote:
> Hi Graham,
>
> On Thursday 25 February 2010 07:28:32 Graham Gower wrote:
>> This patch set contains support for Ingenic's XBurst cpu, plus basic
>> support for their JZ4730 reference boards.
>>
>>
>> Graham Gower (3):
>>   Add XBurst JZ4730 support.
>>   8250: serial driver changes for XBurst SoCs.
>>   net: add driver for JZ4730 ethernet controller.
>
> Seems like patches 1 and 3 were too big and got retained by the mailing-list
> program.

They seem to have made it to the list archives now. Thread here:
http://www.linux-mips.org/archives/linux-mips/2010-02/msg00243.html

>
> Maybe you should work with the OpenWrt and qi-hardware guys to get the jz4740
> also merged in the same time?
>

I've not seen any active attempt to get xburst code merged before and
assumed there was no interest from others. I'm happy to be wrong on
this.

My patch does not preclude adding jz4740 support. I don't have any of
these devices however, so have only included code for the jz4730.

-Graham
