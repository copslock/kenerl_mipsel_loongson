Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2018 07:42:23 +0100 (CET)
Received: from mail-it1-x142.google.com ([IPv6:2607:f8b0:4864:20::142]:50652
        "EHLO mail-it1-x142.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990509AbeKTGmUuwuh4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2018 07:42:20 +0100
Received: by mail-it1-x142.google.com with SMTP id a185so1875400itc.0
        for <linux-mips@linux-mips.org>; Mon, 19 Nov 2018 22:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JLe0vHfmoqtCyZ5txdsfsOS6gzKRYIMzVK3kdH4JNM0=;
        b=RseZA7eGWURaXAjaCT4AaNorCFWlXXzdhDxROWqiMEiWFevE+dzqQr4Vji0hORKE0l
         eK8C65QsQ9HUAgZAh/7T1J/4RBBUPqTmRRe22wfuG77i8TCWicVSOP5vSeg+5RdL+oQk
         Bt2dgclJQVVcHwr67ThCNSQZGjo3xxwCQvhTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JLe0vHfmoqtCyZ5txdsfsOS6gzKRYIMzVK3kdH4JNM0=;
        b=H9dvHWHmarOK8h8SIWyJY1mEEYYxhNkDB5jrOfiMXAeH24qtYNZyEwGRSSGUUin/VH
         XL7sD+Z16GSxUNWICofzxK3c5giihDHRxOTQNU9rQhAV0YMtA74LiMB0aMQZEUiXOaAs
         0UG8TprRdt+qgUS6HD5Tx9rcC9J3HmkawJvaAhoUGtPN6Bdo4tQQaUMpimEC0cQScHfB
         +s/xb0xLfa8wk09SjQPvWAgh7KCFhSEx0XKz/ZELhFyFHZPFCR4ZHqX6XK/4TZXOuHy1
         BauFNI7S5zz5nQRUvLKC3WjTKIPvyUBh+m79flLqleo44ZzLp4IukfPorc1Wo+1D3YXv
         w+fQ==
X-Gm-Message-State: AGRZ1gKEFNQvlMFz2n0nYJJPE8xujsoA2lGdC/B9ae1LOZjpLmT+dPAM
        rhKnBQ1ulFx+t944Fz4dEeeVa0RT5UVXbMWFFx/jiA==
X-Google-Smtp-Source: AFSGD/WF5K019AquhpgFZx0uzEObS93WLZOx/sCvBYzy50dYyzknznRHhld9i4tNdmj9ddDmKvXRfStXtpXuNBUi0Oo=
X-Received: by 2002:a05:660c:a1a:: with SMTP id e26mr1097947itk.83.1542696140027;
 Mon, 19 Nov 2018 22:42:20 -0800 (PST)
MIME-Version: 1.0
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
 <1542262461-29024-2-git-send-email-firoz.khan@linaro.org> <CAK8P3a2CuryCoZKaOXz=nH_WTAZ7VneNoUYHkKFDLQNQvrkWUg@mail.gmail.com>
In-Reply-To: <CAK8P3a2CuryCoZKaOXz=nH_WTAZ7VneNoUYHkKFDLQNQvrkWUg@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 20 Nov 2018 12:12:08 +0530
Message-ID: <CALxhOnjrXLjWNqrAtChw+k5vv5iu39wqAJNqJ9xDdzdv=xihhA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mips: add __NR_syscalls along with __NR_Linux_syscalls
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <firoz.khan@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: firoz.khan@linaro.org
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

Hi Arnd,

On Mon, 19 Nov 2018 at 21:22, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Nov 15, 2018 at 7:14 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > The 2nd option will be the recommended one. For that, I
> > added the __NR_syscalls macro in uapi/asm/unistd.h along
> > with __NR_Linux_syscalls. The macro __NR_syscalls also
> > added for making the name convention same across all
> > architecture. While __NR_syscalls isn't strictly part of
> > the uapi, having it as part of the generated header to
> > simplifies the implementation. We also need to enclose
> > this macro with #ifdef __KERNEL__ to avoid side effects.
>
> I fear this doesn't work the way you hoped:
>
> > --- a/arch/mips/include/uapi/asm/unistd.h
> > +++ b/arch/mips/include/uapi/asm/unistd.h
> > @@ -391,16 +391,19 @@
> >  #define __NR_rseq                      (__NR_Linux + 367)
> >  #define __NR_io_pgetevents             (__NR_Linux + 368)
> >
> > +#ifdef __KERNEL__
> > +#define __NR_syscalls                  368
> > +#endif
>
> We now have three different definitions of __NR_syscalls,
> one for each ABI. User space previously saw the correct
> one (now it doesn't see any, but that's ok).
>
> >  /*
> >   * Offset of the last Linux o32 flavoured syscall
> >   */
> > -#define __NR_Linux_syscalls            368
> > +#define __NR_Linux_syscalls            __NR_syscalls
>
> so this part part again is ok.
>
> >  #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
> >
> >  #define __NR_O32_Linux                 4000
> > -#define __NR_O32_Linux_syscalls                368
> > +#define __NR_O32_Linux_syscalls                __NR_syscalls
>
> but this part is not: Now __NR_O32_Linux_syscalls is defined
> to __NR_syscalls, which may be one of the three values.
> Any usage of __NR_O32_Linux_syscalls in a 64-bit kernel
> is then clearly wrong.
>
> >  #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
> >
> >  #define __NR_N32_Linux                 6000
> > -#define __NR_N32_Linux_syscalls                332
> > +#define __NR_N32_Linux_syscalls                __NR_syscalls
>
> Same for this one.

Thanks for the feedback. Will address all the comments.

Firoz

>
>        Arnd
