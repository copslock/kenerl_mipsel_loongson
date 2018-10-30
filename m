Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2018 23:30:15 +0100 (CET)
Received: from mail-vk1-xa43.google.com ([IPv6:2607:f8b0:4864:20::a43]:43964
        "EHLO mail-vk1-xa43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994198AbeJ3WaLj4nuy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Oct 2018 23:30:11 +0100
Received: by mail-vk1-xa43.google.com with SMTP id g144so1975507vke.10
        for <linux-mips@linux-mips.org>; Tue, 30 Oct 2018 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bImqfsi8wLzHdpxcSUnzMo8Inz8+K2mhWJsVdXrdeuE=;
        b=jcKtztE2YqHIN/ivS3T1ZCw84PseggOPg6ZMa6O+Xwi3o8ePR9CuItoF1UQkA4p71Q
         AGZsRypdJ3G1dlog6rYXRUmhTbTueRGExx76PbPoqNk4VZEgIpuWOJayPkTqJ742AM58
         KK7v5W/wbozKkaVztZ4jBMT+ZKckAgfW1zzOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bImqfsi8wLzHdpxcSUnzMo8Inz8+K2mhWJsVdXrdeuE=;
        b=fuwQ6mLxqCPYSIaYhagJL3gr6cJnMZYg4ePAfeoZoYGv3K7dBY5zTcUltUmGUg4C+A
         T/+Y/Y5cmFALxCkT4sFpec0syTU43X2qSTm+oPg5NI5oEoSqEi0Obg3AafMyIglbMo1R
         q5JsQ67fxICdcs4XrEHWo9GdLf7+CdJAOhRfOtg+ibxFPOPwL7c/h3/7IXR4yjutTFzX
         dH0KhtcNWO9mgnSkSpqYhxCTsacrMz9h8ZWky0zAjT7R0KEPlN30YuaYTNpf7bLim7nP
         66U010dCSgp7F48KgscJcjOPc5VmHhIoC7eSkZxamlzP0xx5HLQnCUrRsfxzFUtJeCLt
         Qmow==
X-Gm-Message-State: AGRZ1gIIFAx4O7FMFOgaSptXPMx4If1xI2Dc4j7XJ6Eo+E4NAhJI+RXf
        9TFQLd+j3VeJlQWORJW/s6uS8CrsHwU=
X-Google-Smtp-Source: AJdET5ffDmnP8WDUd+UB9wrKvfCO0rl3HWI5fLxqxf3ZxMgWtbbRDjhnr5DrSv08EtoF45lsEnh4Mg==
X-Received: by 2002:a1f:2d07:: with SMTP id t7mr264727vkt.45.1540938603354;
        Tue, 30 Oct 2018 15:30:03 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id n63sm63765vsd.26.2018.10.30.15.30.03
        for <linux-mips@linux-mips.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 15:30:03 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id k77so3438781vke.12
        for <linux-mips@linux-mips.org>; Tue, 30 Oct 2018 15:30:03 -0700 (PDT)
X-Received: by 2002:a1f:8ac6:: with SMTP id m189mr251182vkd.79.1540938171170;
 Tue, 30 Oct 2018 15:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181029180707.207546-8-dianders@chromium.org> <20181030114603.xdvyvayzw2an5c3q@holly.lan>
In-Reply-To: <20181030114603.xdvyvayzw2an5c3q@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Oct 2018 15:22:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WxoJ2LgUyR7Jm=xJHTqWGMvan7o18gOK-qPKdCrRRQtw@mail.gmail.com>
Message-ID: <CAD=FV=WxoJ2LgUyR7Jm=xJHTqWGMvan7o18gOK-qPKdCrRRQtw@mail.gmail.com>
Subject: Re: [PATCH 7/7] kgdb: Remove irq flags and local_irq_enable/disable
 from roundup
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, kstewart@linuxfoundation.org,
        linux-mips@linux-mips.org, dalias@libc.org,
        linux-sh@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, mhocko@suse.com,
        paulus@samba.org, "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        ysato@users.sourceforge.jp, mpe@ellerman.id.au, x86@kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>, jhogan@kernel.org,
        linux-snps-arc@lists.infradead.org, ying.huang@intel.com,
        rppt@linux.vnet.ibm.com, bp@alien8.de,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        christophe.leroy@c-s.fr, pombredanne@nexb.com,
        Ralf Baechle <ralf@linux-mips.org>, rkuo@codeaurora.org,
        paul.burton@mips.com, Vineet Gupta <vgupta@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <dianders@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dianders@chromium.org
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

Hi,

On Tue, Oct 30, 2018 at 4:46 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Oct 29, 2018 at 11:07:07AM -0700, Douglas Anderson wrote:
> > The function kgdb_roundup_cpus() was passed a parameter that was
> > documented as:
> >
> > > the flags that will be used when restoring the interrupts. There is
> > > local_irq_save() call before kgdb_roundup_cpus().
> >
> > Nobody used those flags.  Anyone who wanted to temporarily turn on
> > interrupts just did local_irq_enable() and local_irq_disable() without
> > looking at them.  So we can definitely remove the flags.
>
> On the whole I'd rather that this change...
>
>
> > Speaking of calling local_irq_enable(), it seems like a bad idea and
> > it caused a nice splat on my system with lockdep turned on.
> > Specifically it hit:
> >   DEBUG_LOCKS_WARN_ON(current->hardirq_context)
>
> ... and fixes for this this were in separate patches. They don't appear
> especially related.

Agreed that this is cleaner.  Done for v2.

-Doug
