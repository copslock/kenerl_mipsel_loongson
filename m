Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Oct 2018 10:58:07 +0200 (CEST)
Received: from mail-qk1-x743.google.com ([IPv6:2607:f8b0:4864:20::743]:39871
        "EHLO mail-qk1-x743.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990945AbeJXI6CH10ci (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Oct 2018 10:58:02 +0200
Received: by mail-qk1-x743.google.com with SMTP id e4so2650928qkh.6
        for <linux-mips@linux-mips.org>; Wed, 24 Oct 2018 01:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5D5+wbYvFpm0tdJgRcE+2WrrJ+FHACmNE2eQnVA+Rs=;
        b=T0jxbwQ/IMtXTPmiRhxrz1dyHOaxB0otLcS6qSCgIoj/ZIb3gqrvQ8n0BBzlqTgQtv
         n2w94rrDc0HbzNRZo3fF9wCbHhKFY/okTC0mLazTecjsg6yeew3DOh6ZQFMB5gT8jiSm
         fbe+ePGG5l0r9wTKn+fKuAJC1lbS5y/F81yJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5D5+wbYvFpm0tdJgRcE+2WrrJ+FHACmNE2eQnVA+Rs=;
        b=UNOPue9Wm1OaCg/zRAW3s12HIXNrYB24cKaTTy9X3jJt+LVAwxK4Ak5izX5Y+/ZL1P
         NIFzmIn8p+k4lExPA2NMygjiVuArwlZ7CpLYo8wr45OIBnWflRYYhHjLJlY6ayOTzuBm
         AfRJl7r9rS4AESwQid3ojnve/nmvXn/g09youj9CSzsbbjx3ZAaqPMaQQCKU5SwR/T45
         CNzre6vUBIzC/Fmn9fY8VZ4woyl8Mc7oipxlqeWksUQaVYl0mtgtumpF99ZiT12W8TfN
         xJ+l+QqRPw2NOGt7LuNIbzFUXXJW3JFKyoJeo9RF8wjFGaPacXnfiAqQgQDcBy+CaDuU
         WOaw==
X-Gm-Message-State: AGRZ1gKiroEFg338g06a+7ekYNZMErKhHH7HXbOUafbCT7nY6Kb8z26t
        V6jM2eIDk446olQwAYVRwGaZf0VW4VcSAgBN71Lb5g==
X-Google-Smtp-Source: AJdET5e9VvhF6uwwaf7KJaXHG6ft6oCIpV7twnhvj5/91jdS+1Uk2+5SdTALGVsyBN2FJrWuHdYEDwZOODMoFMEZNEI=
X-Received: by 2002:a37:1b46:: with SMTP id b67mr1512491qkb.144.1540371475912;
 Wed, 24 Oct 2018 01:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
 <20180929181725.GB27441@fifo99.com> <CAMT6-xiQ0vGcKpA+SiWHQWQFwU9Oo9j=Zin+UXDoPqKTz5fbeA@mail.gmail.com>
 <CAMT6-xj1rjVAy1AWFiMHc5wH36eu=TUSMtdKU=-qRtUbwr9bkg@mail.gmail.com> <20181023144815.GP30658@n2100.armlinux.org.uk>
In-Reply-To: <20181023144815.GP30658@n2100.armlinux.org.uk>
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
Date:   Wed, 24 Oct 2018 11:57:44 +0300
Message-ID: <CAMT6-xhvqy5PeQmkQ8tsLRiML_pNJTxyq7dizRRvZTEqc7uzgg@mail.gmail.com>
Subject: Re: [PATCH 0/8] add generic builtin command line
To:     Russell King <linux@armlinux.org.uk>
Cc:     Daniel Walker <dwalker@fifo99.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
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
X-archive-position: 66915
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

Do you mean, that you haven't seen patch for ARM, which I sent on
September 27 along with cover and patch 1? It is strange, because
you was the one from recipients. If so, you can see this patch here:
https://lore.kernel.org/patchwork/patch/992779/
On Tue, Oct 23, 2018 at 5:48 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Tue, Oct 23, 2018 at 05:43:18PM +0300, Maksym Kokhan wrote:
> > We still have no response to patches for x86, arm, arm64 and powerpc.
> > Is current generic command line implementation appropriate for these
> > architectures?
> > Is it possible to merge these patches in the current form (for x86,
> > arm, arm64 and powerpc)?
>
> You may wish to consider your recipients - I seem to only have received
> the cover and patch 1 (which doesn't include any ARM specific bits).
> It may be that you're not getting responses because people haven't seen
> your patches.
>
> Thanks.
>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
