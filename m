Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Jun 2011 09:15:28 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:60487 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490990Ab1FHHPW convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 8 Jun 2011 09:15:22 +0200
Received: by bwz1 with SMTP id 1so236288bwz.36
        for <multiple recipients>; Wed, 08 Jun 2011 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HyCPtasq1mEL8RpJh3+rxHOvuA5tAlu9LXtcb1OnjFk=;
        b=JoewlpG7yZt0YJU4yvrgwfUhFmE6jukhLbH6aM9BX4zzCldzgRMhHc7ZqHaXCdrN0t
         Ltju/JX6FK9qOfv3VTDJWXhXQSM7Yc8b3jSvSQuweV+jswBKNnmDLbDOzgmPg6ETd5O8
         YuwHF/jCnPFxtCm1ZQDvlVBm/fAXph+czr8OQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=gaHqG3InZQFpC+Wp0W8tcvjRUq7OgDVWHpRMZJTHcfvcSwou7Xp/iJsONAhK+rvMPF
         B/jdrk+ge1SnMIewB19AdFd5jqKV3NRRiw7Gqkar5MtpZjZQpPTcxfmYgsct4H1EGqUu
         K+yRXqsLcZJe3sLdrxy2Nu4QI02FWj4ji8cUU=
MIME-Version: 1.0
Received: by 10.204.170.193 with SMTP id e1mr610613bkz.136.1307517314521; Wed,
 08 Jun 2011 00:15:14 -0700 (PDT)
Received: by 10.204.127.132 with HTTP; Wed, 8 Jun 2011 00:15:14 -0700 (PDT)
In-Reply-To: <20110607230218.GA23552@dvomlehn-lnx2.corp.sa.net>
References: <20110606010753.GA16202@linux-mips.org>
        <BANLkTik1mRWTcX8WgO5s6mFrUGYwBRmSow@mail.gmail.com>
        <20110607230218.GA23552@dvomlehn-lnx2.corp.sa.net>
Date:   Wed, 8 Jun 2011 09:15:14 +0200
X-Google-Sender-Auth: Ma49VKy_DcB_wE4UiQzupGsBxLI
Message-ID: <BANLkTikjgj-QH=8u6NeGbWHy5hi1jiiU6Q@mail.gmail.com>
Subject: Re: Converting MIPS to Device Tree
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     David VomLehn <dvomlehn@cisco.com>
Cc:     Grant Likely <grant.likely@secretlab.ca>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Imre Kaloz <kaloz@openwrt.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        "Dezhong Diao (dediao)" <dediao@cisco.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6540

On Wed, Jun 8, 2011 at 01:02, David VomLehn <dvomlehn@cisco.com> wrote:
> I took a look at the issue of passing device trees to the kernel and started
> by surveying the methods currently in use for passing information from the
> bootloader to the kernel. I came up with the ten approaches:
>
> How MIPS Bootloaders Pass Information to the Kernel
> ---------------------------------------------------
> Apologies for any errors; this was meant more to be a quick survey
> rather than a detailed analysis.

> 6.      a0 - argc
>        a1 - argv
>        a2 - non-standard envp
>        Command line created by concatenating argv strings, starting at
>        argv[1]. The envp is a pointer to a list of char ptr to name/char
>        ptr pairs.
>        Platforms: txx9

This depends on the actual boot loader. My rbtx4927 has a VxWorks boot loader,
which just doesn't pass anything.

Cfr. commit 97b0511ce125b0cb95d73b198c1bdbb3cebc4de2 ("MIPS: TXx9:
Make firmware parameter passing more robust").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
