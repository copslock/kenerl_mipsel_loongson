Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Oct 2018 20:01:48 +0200 (CEST)
Received: from mail-qt1-x844.google.com ([IPv6:2607:f8b0:4864:20::844]:36397
        "EHLO mail-qt1-x844.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeJHSBpbcotO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 8 Oct 2018 20:01:45 +0200
Received: by mail-qt1-x844.google.com with SMTP id u34-v6so21905273qth.3
        for <linux-mips@linux-mips.org>; Mon, 08 Oct 2018 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f2k0TKw50pOrfGHnaXCp0SuI47IFEOzwJuYb7aXgCKE=;
        b=QS3VYTGf0fifLHmLBkzjBLN6hwaoWTOL6tOK/hCr6D9GzABipc1gMf/rBnbXU5OqD/
         AI5x+qdVEjfbocSHtF1haSOC2Dbd4Gxji7qFMSsvsImKB/Duxy61dIMGNKfRZNrWzXmb
         GuYIvayBgnfeJBlsFBYuXM054yaCNuA636iRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f2k0TKw50pOrfGHnaXCp0SuI47IFEOzwJuYb7aXgCKE=;
        b=clmAnuOihrHGJAdHse+MJdEOPGFPaESd9wrt7fI78Qc3jZ28t6FwXckm5mvaj7SMaw
         jaqVfE/fS7L7wj7kG99gYiqiWe+B2zE2eVlXsCJFcV5ALixapgUEM7YqA0pcaD2oHMJg
         tUY5VuDfX3Dna1L+dYtDCBQDnj5qvm7fPi9p7ht1NeeJG8FgiJElYisXx5RX2bR7YXWz
         n9rqKFFSJL3RfHgW/8DTKacclUOpG80Ia64xLPGjflItDCyMMCzih02y6ci9AuC4zqLv
         c/lESXUGIFUtYRm0C5ZOxL/oPM96bVhkF25aksSUu/s+UZznNAsDuDgLyfNoEncy/e2A
         asfA==
X-Gm-Message-State: ABuFfoipaNbJem1LgNbHQywbVWEj/1+Ne46/hpFFuy1mM2KcOrkSMy7t
        KkjutkQS7zYAdHACY2robgweOWtrJgJbKcqJtLwtlQ==
X-Google-Smtp-Source: ACcGV60GO9C0aLzJZoqpTqN40b/nvsrtaoyXynAbWGKEBEAgXKyUwq1A+V0K76QFGVdbvejiMcEMz712iVnZLIy9qJk=
X-Received: by 2002:aed:2e04:: with SMTP id j4-v6mr19136647qtd.47.1539021699631;
 Mon, 08 Oct 2018 11:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com> <20180929181725.GB27441@fifo99.com>
In-Reply-To: <20180929181725.GB27441@fifo99.com>
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
Date:   Mon, 8 Oct 2018 21:01:28 +0300
Message-ID: <CAMT6-xiQ0vGcKpA+SiWHQWQFwU9Oo9j=Zin+UXDoPqKTz5fbeA@mail.gmail.com>
Subject: Re: [PATCH 0/8] add generic builtin command line
To:     Daniel Walker <dwalker@fifo99.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <maksym.kokhan@globallogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66731
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksym.kokhan@globallogic.com
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

Hi, Daniel

On Sat, Sep 29, 2018 at 9:17 PM <dwalker@fifo99.com> wrote:
>
> On Thu, Sep 27, 2018 at 07:55:08PM +0300, Maksym Kokhan wrote:
> > Daniel Walker (7):
> >   add generic builtin command line
> >   drivers: of: ifdef out cmdline section
> >   x86: convert to generic builtin command line
> >   arm: convert to generic builtin command line
> >   arm64: convert to generic builtin command line
> >   mips: convert to generic builtin command line
> >   powerpc: convert to generic builtin command line
> >
>
> When I originally submitted these I had a very good conversion with Rob Herring
> on the device tree changes. It seemed fairly clear that my approach in these
> changes could be done better. It effected specifically arm64, but a lot of other
> platforms use the device tree integrally. With arm64 you can reduce the changes
> down to only Kconfig changes, and that would likely be the case for many of the
> other architecture. I made patches to do this a while back, but have not had
> time to test them and push them out.

Can you please share this patches? I could test them and use to improve this
generic command line implementation.

> In terms of mips I think there's a fair amount of work needed to pull out their
> architecture specific mangling into something generic. Part of my motivation for
> these was to take the architecture specific feature and open that up for all the
> architecture. So it makes sense that the mips changes should become part of
> that.

This is really makes sense, and we have intentions to implement it
afterward. It would be easier to initially merge this simple
implementation and then develop it step by step.

> The only changes which have no comments are the generic changes, x86, and
> powerpc. Those patches have been used at Cisco for years with no issues.
> I added those changes into my -next tree for a round of testing. Assuming there
> are no issues I can work out the merging with the architecture maintainers.
> As for the other changes I think they can be done in time, as long as the
> generic parts of upstream the rest can be worked on by any of the architecture
> developers.

Thanks,
Maksym
