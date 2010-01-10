Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Jan 2010 18:17:46 +0100 (CET)
Received: from mail-ew0-f209.google.com ([209.85.219.209]:35007 "EHLO
        mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492959Ab0AJRRm convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 10 Jan 2010 18:17:42 +0100
Received: by ewy1 with SMTP id 1so2303623ewy.28
        for <multiple recipients>; Sun, 10 Jan 2010 09:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=7sVBBMv9Pg2LoNYLESgn8SRgmPIog48xF1CjS7e3lrg=;
        b=TXNMp4nJCMvWzKR0KpNDMjy3tO2uriOuhZT0HrlRg2P8OzCvTotvCOKFf8gP07C8gC
         muDmk5lqxDmLYNElkW5lzROLYtPuKNB5JaFFgnj0GIZSfYtDvwpBHmTF1aB4K59jEBbA
         jMrx5hWjMbZHKP7zf1ukyqZsjEf0fA2L3fN6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=cz7EOMMdo2XVBvgc6WL1uAQa9ABroo0Ar76vWERtMZp6BLH4lvwByhYJmp7Ah/UJsr
         Zlw04vg1G6fOaXSuRmW6aW/PTKfLqQKpKZ2lWfKqZzmwyLLZ2tP7K7HS8a8Qpf/0AI0g
         6EPNEL9lXmHUoEPxnBntUGAYN6kghgzvVfU9w=
MIME-Version: 1.0
Received: by 10.216.86.148 with SMTP id w20mr5926744wee.138.1263143855293; 
        Sun, 10 Jan 2010 09:17:35 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001101708360.13474@eddie.linux-mips.org>
References: <3a665c761001052313v36bfeb89v37ada6b76e91c271@mail.gmail.com>
         <alpine.LFD.2.00.1001061244330.13474@eddie.linux-mips.org>
         <3a665c761001100809g1400db9er5cc3a6228467934a@mail.gmail.com>
         <alpine.LFD.2.00.1001101708360.13474@eddie.linux-mips.org>
Date:   Sun, 10 Jan 2010 18:17:35 +0100
X-Google-Sender-Auth: 15b7842c961b72bd
Message-ID: <10f740e81001100917j825b672xcf1a786f21f88c26@mail.gmail.com>
Subject: Re: some question about Extended Asm
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     loody <miloody@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 25557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 6586

On Sun, Jan 10, 2010 at 18:14, Maciej W. Rozycki <macro@linux-mips.org> wrote:
> On Mon, 11 Jan 2010, loody wrote:
>
>> I have some question about extended assembly in mips
>> 1. is mips assembly in AT&T syntax?
>>     from the document I google from the web, they emphasize that the
>> GNU C compiler use AT&T syntax, and they list some example about intel
>> instructions.
>
>  I'm not sure if the "AT&T syntax" term has any meaning except for Intel
> architecture processors.

It also affects m68k, IIRC.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
