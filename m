Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2018 22:11:47 +0100 (CET)
Received: from mail-qk1-x741.google.com ([IPv6:2607:f8b0:4864:20::741]:45899
        "EHLO mail-qk1-x741.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994272AbeJ3VLj2DGjU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Oct 2018 22:11:39 +0100
Received: by mail-qk1-x741.google.com with SMTP id d135so7188921qkc.12;
        Tue, 30 Oct 2018 14:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Geo1F+rcWiR1yH6tDsVfLVgB6tNCnOzh06qBDUj6Wpw=;
        b=merO8jjfclSY449GGyNc6gtmZYe754ISceV1K31uiUFYlIxBKsX4XOzF/ieVUOw6EC
         uyClrdDEs5K3WWkxEm7oOwwBgPEt3pGbSYH9Pb0Ok/Jdn6mjb7vMza/JdKwvoFLonvM0
         2KEZ2rzsKPpGjrDQ8uczOHylITpy9YxSp8K58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Geo1F+rcWiR1yH6tDsVfLVgB6tNCnOzh06qBDUj6Wpw=;
        b=albB0sMo5t/em4YTGbxulLO6gWstpukeJKo/lkHZ1DM6Z/qgyJ6rsUfbO2KJ7D6ItD
         3sp8UteWCkefry4IDtaFBTaqLGaABtHz/UGKgTWY+4ofqponWpqTi2Bsgd7oUtb7ZkhE
         J/dSSjOYzDCv9icYt1KSJEgyMZYAM9eMyWfkUun41F9oufIqQ6qpfHhKeZ+c+XrgON1l
         MCs152I16vFByo/WgEcyGZvzqiNIUknczZ4rweUCyuTa6kBKmNbqXwbfLdn5a2J1wgUL
         a67EdEINctroHr7twKdsP/oRCMWgvno13Py1EodeGnCgFYUXOxE9Ak2UMRkQDDkBYVa+
         0hCA==
X-Gm-Message-State: AGRZ1gJj45py4dIGGh5ozmaPofoDBYr4T+LcL/xvktH/2E6sMTlgXkyH
        6ZHT8OkFekQLwQg8zb21/SMAIbHt1zobfkb9O5c=
X-Google-Smtp-Source: AJdET5fq9zBHJ2GMvSSou9qc8qDiQ88IpkB04UUhK5+9PcLbHPJxQrdFkeqWWLTSVgzxPmVRDzWsFfWLZfpY/nwV/rU=
X-Received: by 2002:ae9:ef8a:: with SMTP id d132mr306114qkg.11.1540933893205;
 Tue, 30 Oct 2018 14:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <1540905994-6073-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1540905994-6073-1-git-send-email-yamada.masahiro@socionext.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 31 Oct 2018 07:41:21 +1030
Message-ID: <CACPK8Xf4+M9Q1zC5GBC0PBJBZnim14m_s5HoQJQOn5Dc-uCDag@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: replace cc-name test with CONFIG_CC_IS_CLANG
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, linux-mips@linux-mips.org,
        Michal Marek <michal.lkml@markovi.net>, jhogan@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ralf@linux-mips.org, paul.burton@mips.com,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <joel.stan@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joel@jms.id.au
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

On Tue, 30 Oct 2018 at 23:58, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Evaluating cc-name invokes the compiler every time even when you are
> not compiling anything, like 'make help'. This is not efficient.
>
> The compiler type has been already detected in the Kconfig stage.
> Use CONFIG_CC_IS_CLANG, instead.

Thanks, I didn't know about this.

>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

Acked-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
