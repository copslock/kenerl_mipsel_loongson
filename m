Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Nov 2010 00:58:32 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:45057 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491000Ab0KRX63 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Nov 2010 00:58:29 +0100
Received: by wwj40 with SMTP id 40so1282020wwj.24
        for <linux-mips@linux-mips.org>; Thu, 18 Nov 2010 15:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=z1V6lp1d5dM0VVUS7Oeyj9wBx+/KnEReAZYoroV1WgU=;
        b=iAl4vfDXQXLWk1KV+lw5f05iLjZ2iIDt2mW7EOp16GqozQs8w/sEfOwhOMjXr8s/6s
         XnGoOaztF9cEDTSkUdumze5vg64IXN25J2f6tZZOF+y3O+M8v3gKvD89ud0hoyxVpovx
         6DJkRDfRmRAnMFcgJ/iMqPfLC6SNYA+zsEnfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=VrvRfPA/TVNgZgv/FMhnD6C9qzMNpEb2r9CBWSlIg+sYh2rgUHNnJnDZQLjYjd8RRP
         Ep2a/V/DPh0C1VhhO1KGjAYhS741VvzFu/y+Ui/79oV2HjlQvWda0yb89kzdGcFcPqC6
         2BpZpYoQARhNgIb8Ji3ULRXd0wkgrIgEjquz4=
MIME-Version: 1.0
Received: by 10.216.38.71 with SMTP id z49mr173314wea.76.1290124703482; Thu,
 18 Nov 2010 15:58:23 -0800 (PST)
Received: by 10.216.91.8 with HTTP; Thu, 18 Nov 2010 15:58:23 -0800 (PST)
In-Reply-To: <AEA634773855ED4CAD999FBB1A66D0760136A1F3@CORPEXCH1.na.ads.idt.com>
References: <AEA634773855ED4CAD999FBB1A66D0760136A102@CORPEXCH1.na.ads.idt.com>
        <4CE57C92.6030705@mvista.com>
        <AEA634773855ED4CAD999FBB1A66D0760136A151@CORPEXCH1.na.ads.idt.com>
        <AANLkTinEXDoXQFa1gN6prRQYjqkvc9vSA_H7JOXPLsPw@mail.gmail.com>
        <AEA634773855ED4CAD999FBB1A66D0760136A1F3@CORPEXCH1.na.ads.idt.com>
Date:   Thu, 18 Nov 2010 23:58:23 +0000
X-Google-Sender-Auth: l3MTMKawxjN1te2EiGtNSwoKjCE
Message-ID: <AANLkTimqF-Zy6eQurPRq5m71waB=n4zyRfRbpxyCsWgn@mail.gmail.com>
Subject: Re: The new "real" console doesn't display printk() messages like
 "early" console!
From:   Ricardo Mendoza <ricmm@gentoo.org>
To:     "Ardelean, Andrei" <Andrei.Ardelean@idt.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <mendoza.ricardo@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ricmm@gentoo.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 18, 2010 at 10:01 PM, Ardelean, Andrei
<Andrei.Ardelean@idt.com> wrote:

> Hi Ricardo,
>
> I implemented serial platform driver taking as model serial.c from
> cavium-octeon.
>
> Here is my code:
>
> ...

Why use the Octeon code which has platform specific bits that might
have nothing to do with your platform? Build up from the simple ones.


     Ricardo
