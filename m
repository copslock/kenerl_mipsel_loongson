Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Nov 2018 05:46:10 +0100 (CET)
Received: from mail-it1-x143.google.com ([IPv6:2607:f8b0:4864:20::143]:33599
        "EHLO mail-it1-x143.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990947AbeK3EqBIhRtq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Nov 2018 05:46:01 +0100
Received: by mail-it1-x143.google.com with SMTP id m8so1040556itk.0
        for <linux-mips@linux-mips.org>; Thu, 29 Nov 2018 20:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vIAI16RWvHVDoEJapc7NJY6TWPbkzlrPdpU8HIv23OQ=;
        b=PVBoaMXeooyrt/QXhiKwRFgimq0aYvgyk25mjWBUmTWtrB8pIJbJRt1F56iDQKqCIe
         gCSOYC+1gPStIrQfA/HU+crBH/esa/aHFCRerLbkA9RTaeUE8v339AhZPVEMjfNaDpUh
         2FXviQXfDKkkNPPkSObTBy07Vlc3qSWBpvfA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vIAI16RWvHVDoEJapc7NJY6TWPbkzlrPdpU8HIv23OQ=;
        b=OfqY+zQ0OheCK6TMfs1N88RNRFQzjSDKLIkEUNHViTWyFByENNHAwnweEherkuQVbk
         qczX0Jupmw4qPktBhl7oavFkKSca4eii+F/L48XFj51jAIBHfQKHhD0hP0BfcLXZRCjM
         UGUXbwIBJJsJq3s9jVF6ZcLsIMThyQVXMoQ0rjnQEkp+l8RheRfiQhuK090OtZqeZAOq
         S0Tp6SEo4g4owbgKntgI7N2TATAygJTQM8RebBJTSJ9Kh5nNh080HMos1u1pxFINrcNG
         VPXJmknETI0QTgNrWdqXfvTOHqa4UhlP7evpD1TB3sc/2325ln+QmjL5W9TB5PoFZDWL
         nzgQ==
X-Gm-Message-State: AA+aEWYtURbaodSVkYRouV27uZrlykB+RoluHQO9CoBwJ0GDhdTwn35J
        CJb+j8V7D1TgIddSWNrpX553X91R+Hyme5M3fpQL5w==
X-Google-Smtp-Source: AFSGD/Vz57qCVZYwJC/LBMmIhh5dfqpZAJ63RO9enhbURgbxnkH5QDt7JL0BQu9Z26eYRyJv0Nhyb2Qttoljd1gO6zE=
X-Received: by 2002:a24:5a8f:: with SMTP id v137mr3941657ita.65.1543553160332;
 Thu, 29 Nov 2018 20:46:00 -0800 (PST)
MIME-Version: 1.0
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
 <1543481016-18500-2-git-send-email-firoz.khan@linaro.org> <CAK8P3a1Pq=Y83p-cN9bf+m-2ZAmJdEYRaAY9FfEkVHvfSwNWNg@mail.gmail.com>
In-Reply-To: <CAK8P3a1Pq=Y83p-cN9bf+m-2ZAmJdEYRaAY9FfEkVHvfSwNWNg@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Fri, 30 Nov 2018 10:15:48 +0530
Message-ID: <CALxhOniC95bKe5vLvNFdjwrzLa+mWw6hMvzESXG3MkUfVsrOzA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mips: add __NR_syscalls along with __NR_Linux_syscalls
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
X-archive-position: 67553
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

Thanks for your email.

On Thu, 29 Nov 2018 at 19:41, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Nov 29, 2018 at 9:44 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> >  arch/mips/include/uapi/asm/unistd.h | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
> > index f25dd1d..6914be5 100644
> > --- a/arch/mips/include/uapi/asm/unistd.h
> > +++ b/arch/mips/include/uapi/asm/unistd.h
> > @@ -391,11 +391,14 @@
> >  #define __NR_rseq                      (__NR_Linux + 367)
> >  #define __NR_io_pgetevents             (__NR_Linux + 368)
> >
> > +#ifdef __KERNEL__
> > +#define __NR_syscalls                  368
> > +#endif
> >
> >  /*
> >   * Offset of the last Linux o32 flavoured syscall
> >   */
> > -#define __NR_Linux_syscalls            368
> > +#define __NR_Linux_syscalls            __NR_syscalls
>
> This seems odd: you define __NR_Linux_syscalls outside of
> #ifdef __KERNEL__, but the definition only works
> with __NR_syscalls being defined first, which it isn't in
> user space.
>
> Since the macros are completely unused as well as unusable
> now, how about removing them together with the other
> ones removed in patch 2?

Yes, good point, will update asap.

Firoz

>
>       Arnd
