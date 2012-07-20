Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jul 2012 20:38:22 +0200 (CEST)
Received: from mail-gh0-f177.google.com ([209.85.160.177]:45332 "EHLO
        mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903749Ab2GTSiS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Jul 2012 20:38:18 +0200
Received: by ghbf11 with SMTP id f11so4605410ghb.36
        for <linux-mips@linux-mips.org>; Fri, 20 Jul 2012 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=SzHJQa5QdLG5kknwCbcecVjwR89k0CMoMYL+8oL2Mq0=;
        b=GOSQwXJQ3PH5Cd7wGdbWdoUR1KCsPeKak+Yg39zj2EUZq95olGFc1vBYzPTRA6iTPY
         1aeSrr3DVxckIjR76kGMHZ+SCxZsUZUffqYy4zd2losPf3HA2p6fehBIwC9Z1+S22Yp4
         wnwiXn1PpqjeFxxJTBHwmoyGbx15MuWK2R5CqPBtQSFCRIYOYgCXwfIDbcO5HB7BtfIM
         dy1mjjGxEnkrhukdXoXZtiufxs0WCnHlEKxH+Xah49W1jhHp4FS2QY/uuWG5LL017u7N
         MQZTyAVNpWy5rPmB/blrBImR9pfUxV+7StJBEdx/tAll9QfjUuqPaYx7bjQ4S1251HYb
         d8eA==
MIME-Version: 1.0
Received: by 10.50.178.33 with SMTP id cv1mr1944954igc.1.1342809491607; Fri,
 20 Jul 2012 11:38:11 -0700 (PDT)
Received: by 10.231.135.1 with HTTP; Fri, 20 Jul 2012 11:38:11 -0700 (PDT)
In-Reply-To: <20120713121053.0637219f@pyramind.ukuu.org.uk>
References: <20120713141345.f71b7c01f720d616d74721dd@canb.auug.org.au>
        <20120713121053.0637219f@pyramind.ukuu.org.uk>
Date:   Fri, 20 Jul 2012 20:38:11 +0200
X-Google-Sender-Auth: WmGuH-U86p9zNLpFIA2TZy7dA-4
Message-ID: <CAMuHMdWRM0y07r1nL-9fXB3nLKXMgftqhiruEeuEe4QYDA2o9Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the tty tree
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Daney <david.daney@cavium.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, Greg KH <greg@kroah.com>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 33946
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi Alan, David,

On Fri, Jul 13, 2012 at 1:10 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Fri, 13 Jul 2012 14:13:45 +1000
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>> After merging the tty tree, today's linux-next build (x86_64 allmodconfig)
>> failed like this:
>>
>> drivers/char/mwave/mwavedd.c: In function 'register_serial_portandirq':
>> drivers/char/mwave/mwavedd.c:472:2: error: implicit declaration of function 'serial8250_register_port' [-Werror=implicit-function-declaration]
>> cc1: some warnings being treated as errors
>> drivers/misc/ibmasm/uart.c: In function 'ibmasm_register_uart':
>> drivers/misc/ibmasm/uart.c:57:2: error: implicit declaration of function 'serial8250_register_port' [-Werror=implicit-function-declaration]
>> cc1: some warnings being treated as errors
>>
>> Caused by commit 2655a2c76f80 ("8250: use the 8250 register interface not
>> the legacy one").  Grep is your friend.
>
> My fault on that one not GregKH's. I'll wrap that into the updated patch
> series. I thought I had them all but I forgot to grep off in drivers/misc.

Today's build failed because there's a new user in the MIPS tree:
arch/mips/cavium-octeon/serial.c

http://kisskb.ellerman.id.au/kisskb/buildresult/6739341/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
