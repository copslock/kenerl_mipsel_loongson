Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Oct 2018 23:20:38 +0100 (CET)
Received: from mail-ua1-x941.google.com ([IPv6:2607:f8b0:4864:20::941]:40438
        "EHLO mail-ua1-x941.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994272AbeJ3WUfO5BE9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Oct 2018 23:20:35 +0100
Received: by mail-ua1-x941.google.com with SMTP id n7so3005415uao.7
        for <linux-mips@linux-mips.org>; Tue, 30 Oct 2018 15:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AqTfYKV/PN6tpipO01Cdw/TMa+qHwi9432jSG/gesvY=;
        b=CyyABaBWYxdfD5jBmJfkaC05s4UGGrYnPnmnABccJ/fqRBCdi/DudqdFL8rvX8I4l8
         wzb7HFJJi4cK0lyQzBzFa3tytEpCk6tbo4rvIII4LwUc4l9Azi8hKCa5uld9pHcjOEBf
         afa1AyDniOpnh9vg6oqcO7mTFSCJ5Mg+GwSJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AqTfYKV/PN6tpipO01Cdw/TMa+qHwi9432jSG/gesvY=;
        b=a9yGhD6dAO54RwsdAxoIYlD8Hsrq3YnNXd+3D3AkwCnkBdQqy2V46fSgx4NDKkxG69
         xOL//cRKAGsvyRyc0aC2sw8Ep4G/aY3X/VbPAa+HEky85itjcD6mv69LwBtwkI9Q4nX0
         KUwrgcsUlND+lIAfe4V1Ai/52G/Jc0Dqac4OL0+ecJ5d1XPHyVeUQ60A2jCIQI9Ph800
         aE2QKaSFu0tqkgSJonzA2sjUzdMxIDljcIBLqFXVuDGA7eQUJe28zLGxCIZprFW38RCz
         rRlk/6corproaKnFoVjuw/XRr8qjn9O8AFhI3lctDOA+6NMC8twKyqjQfwACP7cdscLL
         gNUg==
X-Gm-Message-State: AGRZ1gKCKONEOX2sLuka1FzS892JVbj7xBfC8KsymCnTjJ1T6lRBf2bk
        oLC0Dw5HzLW0jNWNBGB5CP9ZYpOuBT4=
X-Google-Smtp-Source: AJdET5dqsAoe368Ab1ZmI+0XbO7dar5Cqu1kIjeXeGbPLsorGxPYQqMtjZIA/bqDer0FPurUpq4ULg==
X-Received: by 2002:ab0:1531:: with SMTP id o46mr277806uae.29.1540938028470;
        Tue, 30 Oct 2018 15:20:28 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id w132sm4803984vkd.37.2018.10.30.15.20.26
        for <linux-mips@linux-mips.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 15:20:27 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id t127so2691902vke.8
        for <linux-mips@linux-mips.org>; Tue, 30 Oct 2018 15:20:26 -0700 (PDT)
X-Received: by 2002:a1f:e3c7:: with SMTP id a190mr274756vkh.66.1540938026209;
 Tue, 30 Oct 2018 15:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181029180707.207546-1-dianders@chromium.org> <20181030115628.eqtyqdugkpkxvyr2@holly.lan>
In-Reply-To: <20181030115628.eqtyqdugkpkxvyr2@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 30 Oct 2018 15:20:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=URwUFep2UA7Xs1TxK6cZst+W-pfY2_BfKMZnGECHPZqw@mail.gmail.com>
Message-ID: <CAD=FV=URwUFep2UA7Xs1TxK6cZst+W-pfY2_BfKMZnGECHPZqw@mail.gmail.com>
Subject: Re: [PATCH 0/7] serial: Finish kgdb on qcom_geni; fix many lockdep
 splats w/ kgdb
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, Nishanth Menon <nm@ti.com>,
        linux-mips@linux-mips.org, dalias@libc.org,
        Catalin Marinas <catalin.marinas@arm.com>, vigneshr@ti.com,
        linux-aspeed@lists.ozlabs.org, linux-sh@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, mhocko@suse.com,
        paulus@samba.org, "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux@vger.kernel.org, marex@denx.de,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        ysato@users.sourceforge.jp, linux-hexagon@vger.kernel.org,
        x86@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
        pombredanne@nexb.com, Tony Lindgren <tony@atomide.com>,
        Ingo Molnar <mingo@redhat.com>, joel@jms.id.au,
        linux-serial@vger.kernel.org, rolf.evers.fischer@aptiv.com,
        jhogan@kernel.org, asierra@xes-inc.com,
        linux-snps-arc@lists.infradead.org,
        Dan Carpenter <dan.carpenter@oracle.com>, ying.huang@intel.com,
        riel@surriel.com, frederic@kernel.org,
        Jiri Slaby <jslaby@suse.com>, paul.burton@mips.com,
        rppt@linux.vnet.ibm.com, bp@alien8.de, luto@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        christophe.leroy@c-s.fr, andrew@aj.id.au,
        LKML <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, rkuo@codeaurora.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jeremy Kerr <jk@ozlabs.org>, mpe@ellerman.id.au,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>,
        kstewart@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <dianders@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66998
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

On Tue, Oct 30, 2018 at 4:56 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Oct 29, 2018 at 11:07:00AM -0700, Douglas Anderson wrote:
> > Looking back, this is pretty much two series squashed that could be
> > treated indepdently.  The first is a serial series and the second is a
> > kgdb series.
>
> Indeed.
>
> I couldn't work out the link between the first 5 patches and the last 2
> until I read this...
>
> Is anything in the 01->05 patch set even related to kgdb? From the stack
> traces it looks to me like the lock dep warning would trigger for any
> sysrq. I think separating into two threads for v2 would be sensible.

Yes, sorry about the mess.  Splitting this into two series makes the
most sense.  Then I can focus more on trying to get the CCs right and
people can just get the patches that matter to them.

OK, I've sent v2 of both series out now.  Please yell if you can't
find them for whatever reason.

-Doug

-Doug
