Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Nov 2018 03:36:08 +0100 (CET)
Received: from conssluserg-05.nifty.com ([210.131.2.90]:21231 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992965AbeKWCfZBCgMH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Nov 2018 03:35:25 +0100
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wAN2ZBuT014810
        for <linux-mips@linux-mips.org>; Fri, 23 Nov 2018 11:35:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wAN2ZBuT014810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1542940511;
        bh=RrugNZBXEysMhtL3UZ+37m+8Wd+NK/UsR7hC/dwXJf0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hvwizNgjiAwz2FA0ew+WTSmalXBXveMEDZE/2TDxOaLsyjHhDdCBFDvCVHpDkpjrV
         q655IT+Jc1eR8CRf6t61hUOpgQy0TGZtyt26mII+/a1ZlZAigD25jT92qub9fPZm47
         yVZHgrxD2oU51PiCamHN8svZOVYvzYsmS6XMF2FjPSebW74FdZ4ovLusRGN0W/x/5r
         LvCboua3MRD989y4FlaaiJna5bLhUYaRmz8qR42/n+Uo8Cgt/nUixrt+3Xrq4YkBeZ
         /42ggr9jrCFEvg9d/HlkQ43F6mF3RcNPFYHyAelBTnTEy9ALW1WQBpLr3A2YCm/eUi
         jSRA/b1sfnf9Q==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id g68so6351906vsd.11
        for <linux-mips@linux-mips.org>; Thu, 22 Nov 2018 18:35:11 -0800 (PST)
X-Gm-Message-State: AGRZ1gL3ql8X8GPpQblxwFnDA8k68yG0qYHK74tQvl0NAGY+TtmWnJsZ
        Q2WDW1PtGTAiNHiqqQUQsVK6gG/tSYlfI9JS1Vo=
X-Google-Smtp-Source: AJdET5cIw+vbbs97NyNbwhbBUn15tsgvQyNHCrBWj31uLObQRxlkco6LuTOOVkaJBTEBijL6YB6Yzgf83zElAgHI88Q=
X-Received: by 2002:a67:385a:: with SMTP id f87mr5827099vsa.179.1542940510387;
 Thu, 22 Nov 2018 18:35:10 -0800 (PST)
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de> <20181115190538.17016-10-hch@lst.de>
In-Reply-To: <20181115190538.17016-10-hch@lst.de>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 23 Nov 2018 11:34:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ01oHpZHJ2Zb49o7pUU_vB5+-262MhueTLQg+t29W3nw@mail.gmail.com>
Message-ID: <CAK7LNAQ01oHpZHJ2Zb49o7pUU_vB5+-262MhueTLQg+t29W3nw@mail.gmail.com>
Subject: Re: [PATCH 9/9] eisa: consolidate EISA Kconfig entry in drivers/eisa
To:     Christoph Hellwig <hch@lst.de>
Cc:     mporter@kernel.crashing.org, Alex Bounine <alex.bou9@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pci@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-alpha@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <yamada.masahiro@socionext.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yamada.masahiro@socionext.com
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

On Fri, Nov 16, 2018 at 4:06 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Let architectures opt into EISA support by selecting HAS_EISA and

I locally fixed the commit log (HAS_EISA -> HAVE_EISA)
so that it matches to the code.

Thanks.



> handle everything else in drivers/eisa.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> ---

--
Best Regards
Masahiro Yamada
