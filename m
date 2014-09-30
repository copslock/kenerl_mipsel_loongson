Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 14:28:54 +0200 (CEST)
Received: from mail-la0-f46.google.com ([209.85.215.46]:65443 "EHLO
        mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010174AbaI3M2xHdZmq convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 30 Sep 2014 14:28:53 +0200
Received: by mail-la0-f46.google.com with SMTP id gi9so9635325lab.19
        for <multiple recipients>; Tue, 30 Sep 2014 05:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=KEuYYJm89B+1ueimCRuX0IhvGco55isAWP/4R6UkAKw=;
        b=Uec8lejaOQbFfsxBYXsNiB/a9kvuPkrhBsn0fdhwzJyBn+YIRbW3c74RcR+cUAkIbz
         /ZLDxp4rhHNv/RIg/4u6GiRITZj1MGjLt3VZj7Zau3C5py6ppnBgeKT7qp1XZE/m95GM
         xp/IovBPjbJYrYII6yyFwoCZDJy/4Xxg1BM26W1y9Q3jgJ811ed8vrmGLqwsOeTIT22C
         WWOytcZuGhn3j1PfuGzqP9melAxA6+lj2bxkwsPLZ2sdrodAbNpBXbOoNLLPDkQxuZ4+
         qciHRJmtgXvQiH0AgBEACAGgFNsrCf1nYccak5k9qaNHasBwfnj9L6vv6PFwdNFVHXja
         YYyw==
MIME-Version: 1.0
X-Received: by 10.112.52.68 with SMTP id r4mr44756322lbo.31.1412080123215;
 Tue, 30 Sep 2014 05:28:43 -0700 (PDT)
Received: by 10.152.216.200 with HTTP; Tue, 30 Sep 2014 05:28:43 -0700 (PDT)
In-Reply-To: <1412079396-26005-1-git-send-email-thibaut.robert@gmail.com>
References: <1412079396-26005-1-git-send-email-thibaut.robert@gmail.com>
Date:   Tue, 30 Sep 2014 14:28:43 +0200
X-Google-Sender-Auth: -g26A-iLmbsVbjhkoLAXWlJCHak
Message-ID: <CAMuHMdXj=b0G7foTRkcEtRC_De8+WjVefxBfW=s1sjaXLeF5nQ@mail.gmail.com>
Subject: Re: [PATCH] tc: fix warning and coding style
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Thibaut Robert <thibaut.robert@gmail.com>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42897
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

Hi Thibaut,

On Tue, Sep 30, 2014 at 2:16 PM, Thibaut Robert
<thibaut.robert@gmail.com> wrote:
> Fix gcc warning:
> warning: format ‘%d’ expects argument of type ‘int’, but argument 4 has type ‘resource_size_t’ [-Wformat=]
>
> As resource_size_t can be 32 or 64 bits (depending on CONFIG_RESOURCES_64BIT), this patch uses "%lld" format along with a cast to u64 for printing resource_size_t values

Please use %pR instead (cfr. Documentation/printk-formats.txt).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
