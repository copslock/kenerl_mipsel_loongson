Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 May 2010 00:17:44 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:56420 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492392Ab0E0WRk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 May 2010 00:17:40 +0200
Received: by fxm15 with SMTP id 15so493464fxm.36
        for <linux-mips@linux-mips.org>; Thu, 27 May 2010 15:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=eAWFstlp2EkJV3JG/DxeUBQj0dA3bhH9MxmaSvAMkYw=;
        b=M+xvG6pf9BFgyGXRZ7aVSM/3M7C98IZOfgkt+4GP6+aXKhUBUZuBg5dg7rvQlFbszK
         Ny+0FwEgFHWATIQplOcEjYpurxcZAe0eN4bzixNfMXaJ45uf9u+TXjDUB2jR8rAkDFch
         AEApysGzoC0YLJbmg7gpuwZPYFxz18ultGsp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GKwgv2nRUOL7iaSk5MMMoPCM24wzlrdP/3UUfsbmjXL8S6e7jl6fAtJ9AV1CwoHB+7
         M/w+2lJyIoiMbNY5UTJTqQ7To2/pfIsUMkdN5xNJ0uEHatDVxf9l6gq/T+lopH+3NNLw
         t8NI9ZE7jCYqB6NwKzWczSct4mpB7qxPXvvGo=
MIME-Version: 1.0
Received: by 10.223.58.83 with SMTP id f19mr106564fah.88.1274998654076; Thu, 
        27 May 2010 15:17:34 -0700 (PDT)
Received: by 10.223.104.209 with HTTP; Thu, 27 May 2010 15:17:33 -0700 (PDT)
In-Reply-To: <4BFEE551.8000306@gmail.com>
References: <1274711094.4bfa8c3675983@www.inmano.com>
        <AANLkTinOaPkOXm128trTQ39jNGWMcvPhVUGWSQz6hLjR@mail.gmail.com>
        <20100525131341.GA26500@linux-mips.org>
        <1274795905.4bfbd781a17fa@www.inmano.com>
        <20100525144400.GA30900@linux-mips.org>
        <1274879482.4bfd1dfa91e70@www.inmano.com>
        <AANLkTikbZmTWh8X4KOKLAUaJxKS5-PO39hmiTVICB5Zm@mail.gmail.com>
        <1274977788.4bfe9dfc7680f@www.inmano.com>
        <4BFEE551.8000306@gmail.com>
Date:   Fri, 28 May 2010 01:17:34 +0300
Message-ID: <AANLkTikmPlfI2uqQ4yUE2X40MduQGgZ1hPaQrQQ85DSD@mail.gmail.com>
Subject: Re: Cross compiling MIPS kernel under x86
From:   Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:     David Daney <david.s.daney@gmail.com>
Cc:     octane indice <octane@alinto.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, May 28, 2010 at 12:34 AM, David Daney <david.s.daney@gmail.com> wrote:
> On 05/27/2010 09:29 AM, octane indice wrote:
>>
> Otherwise remove the PT_NOTE from your kernel image (the technique
> for doing this is left as an excise for the reader, but I have found that
> emacs hexl mode works well).

I still believe using objcopy should be a bit more straightforward :)

Dmitri
