Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jul 2010 09:47:27 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:56302 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492022Ab0GUHrU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jul 2010 09:47:20 +0200
Received: by iwn40 with SMTP id 40so8111553iwn.36
        for <linux-mips@linux-mips.org>; Wed, 21 Jul 2010 00:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=3+wysBMNGZxEsuh81yVGz+SbXspbHNPR1W3399USaCw=;
        b=wQDcCcKJxaF6mrAPI0MAx4ZvS3sxkJUOv/7dFYJW5SxWNz58wwVHooZm7wOIPOdaXZ
         PJSKLTNXQGxiyKi7C6LjBI27Witaao/H/KC9m7nLWpH7dVzME8imUd0I5QKdkFR01P2R
         zNboIFU3d4dAR3CbTwr+QZ5ix7znrPs44TMR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=f2AIpZg+pPiPZksFI38U2Gy9vXZZzUrpuGZz2yPKWeoHtT9HV8YCTKHungNhQM4uX6
         gvZsGdFv7oB/eR7sCcH81FphITazXQTtX8la5CpMrYjWNcyI/XWnl0F7AGrFxnPMhBJd
         vXlBEa8fwjVVYcXEhi3f02aQ0x6fL98osdAYI=
MIME-Version: 1.0
Received: by 10.231.149.198 with SMTP id u6mr6703451ibv.7.1279698438706; Wed, 
        21 Jul 2010 00:47:18 -0700 (PDT)
Received: by 10.231.59.10 with HTTP; Wed, 21 Jul 2010 00:47:18 -0700 (PDT)
In-Reply-To: <4C45762E.70909@grandegger.com>
References: <1279544125-28104-1-git-send-email-manuel.lauss@googlemail.com>
        <4C45762E.70909@grandegger.com>
Date:   Wed, 21 Jul 2010 09:47:18 +0200
Message-ID: <AANLkTim3A0zcXbKFWdh=bVHzbzkBRHK3W2nyt3pz721g@mail.gmail.com>
Subject: Re: [RFC PATCH v2] au1000_eth: get ethernet address from 
        platform_data
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Wolfgang Grandegger <wg@grandegger.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Wolfgang Grandegger <wg@denx.de>,
        Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Tue, Jul 20, 2010 at 12:10 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> On 07/19/2010 02:55 PM, Manuel Lauss wrote:
>> Modify au1000_eth to receive an ethernet address from platform data,
>> or choose a random one.
>>
>> The default address is usually provided by the firmware; modify
>> platform device registration to use it if the board code has not
>> already overridden it.

> I gave the patch a try. The kernel builds and runs fine. The eth's are
> realized in the correct order and do work properly. Feel free to add my
> "Tested-by: Wolfgang Grandegger <wg@denx.de>".

Thank you, much appreciated.

Manuel
