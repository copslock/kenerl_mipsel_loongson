Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2018 02:14:11 +0100 (CET)
Received: from mail-ua1-x942.google.com ([IPv6:2607:f8b0:4864:20::942]:33620
        "EHLO mail-ua1-x942.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991112AbeKGBKp15lw3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2018 02:10:45 +0100
Received: by mail-ua1-x942.google.com with SMTP id s26so5289701uao.0
        for <linux-mips@linux-mips.org>; Tue, 06 Nov 2018 17:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1G1nbCiejA14GAk13kwpeV5uSd2+HoRj+vWp4s6EqY=;
        b=eFazb3c7zMawmEuLNjfsk/It40P/kZA634ojboNSO3So2qlyJ29LyFhO0/QW48NaB8
         kbrri3Yn351FGwvXfSV9Lfr6DEeUttVtBJgkrVmcocs0A5GwSrzSsyI2B3buzW3FuyJ/
         hyabXtsc8ANcHIyckTZ0GHWNuBf8WD4smIyJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1G1nbCiejA14GAk13kwpeV5uSd2+HoRj+vWp4s6EqY=;
        b=Iex3SiMZp1cfBnsINVMbxDRYwBnj35KCDkkCB95eSmzmPeLKht/U+swY2FgJVZ+lhm
         NhB9dPU8OhBNuBPP1TQ9cZn/UZfA5OCSkuHZ3slUyV7mtHMCtN5kgfQOmkVmCDxjefxy
         opwnb7CGQoUHrLU0AC0l8QWUUveN9wXeqsIoQY1Oo2crPz1o3edAfEjAQt6VwYnQ/rlW
         2n+CwjbbePnbw4i8Y5R4E6FBNabaS+/yNF9LrwOLwhDhoCBIbgk78IcJeZ3awyMjCB1o
         FRZJdrbiacV+SIX7s1/1+lPFrJ4AJsUSvHvlcav5sG70QWS8sam5gnHgqtwHR8BgNTzu
         0sfg==
X-Gm-Message-State: AGRZ1gIMMP/gMQUU0qzsg9b2qznwGH0omBuNvqy5XNxrL2u+TfEBt/0p
        K6K3ZQEoYGU0mGNO7ftRAaAFKRtZzZo=
X-Google-Smtp-Source: AJdET5f6m4Yj7vmUCp4OP0S2lHZ22xIiocvkqA/EXg6TjbNJyov01DMCGtmT7nmpwfb7M9LAkYG9kA==
X-Received: by 2002:a9f:314c:: with SMTP id n12mr3824136uab.33.1541553044387;
        Tue, 06 Nov 2018 17:10:44 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id d196-v6sm3439086vkf.23.2018.11.06.17.10.44
        for <linux-mips@linux-mips.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 17:10:44 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id u19so4231087uae.4
        for <linux-mips@linux-mips.org>; Tue, 06 Nov 2018 17:10:44 -0800 (PST)
X-Received: by 2002:a9f:386c:: with SMTP id q41mr3848271uad.27.1541552692505;
 Tue, 06 Nov 2018 17:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org> <20181031184050.sd5opni3mznaapkv@holly.lan>
 <CAD=FV=V1eHo7Wz31DTMMNi394qwEaESTxJCYVE60Q7hpDEqRmQ@mail.gmail.com> <20181103104503.eftn5btx7otgufro@holly.lan>
In-Reply-To: <20181103104503.eftn5btx7otgufro@holly.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 6 Nov 2018 17:04:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XbSm48ttzXvvhTir9ViKA9T7Huiho3CNuzprqAVpHyJg@mail.gmail.com>
Message-ID: <CAD=FV=XbSm48ttzXvvhTir9ViKA9T7Huiho3CNuzprqAVpHyJg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>, jhogan@kernel.org,
        linux-hexagon@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, dalias@libc.org,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will.deacon@arm.com>, paulus@samba.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        christophe.leroy@c-s.fr, mpe@ellerman.id.au, paul.burton@mips.com,
        LKML <linux-kernel@vger.kernel.org>, rkuo@codeaurora.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <dianders@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67118
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

On Sat, Nov 3, 2018 at 3:45 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, Oct 31, 2018 at 02:41:14PM -0700, Doug Anderson wrote:
> > > As mentioned in another part of the thread we can also add robustness
> > > by skipping a cpu where csd->flags != 0 (and adding an appropriately
> > > large comment regarding why). Doing the check directly is abusing
> > > internal knowledge that smp.c normally keeps to itself so an accessor
> > > of some kind would be needed.
> >
> > Sure.  I could add smp_async_func_finished() that just looked like:
> >
> > int smp_async_func_finished(call_single_data_t *csd)
> > {
> >   return !(csd->flags & CSD_FLAG_LOCK);
> > }
> >
> > My understanding of all the mutual exclusion / memory barrier concepts
> > employed by smp.c is pretty weak, though.  I'm hoping that it's safe
> > to just access the structure and check the bit directly.
> >
> > ...but do you think adding a generic accessor like this is better than
> > just keeping track of this in kgdb directly?  I could avoid the
> > accessor by adding a "rounding_up" member to "struct
> > debuggerinfo_struct" and doing something like this in roundup:
> >
> >   /* If it didn't round up last time, don't try again */
> >   if (kgdb_info[cpu].rounding_up)
> >     continue
> >
> >   kgdb_info[cpu].rounding_up = true
> >   smp_call_function_single_async(cpu, csd);
> >
> > ...and then in kgdb_nmicallback() I could just add:
> >
> >   kgdb_info[cpu].rounding_up = false
> >
> > In that case we're not adding a generic accessor to smp.c that most
> > people should never use.
>
> Whilst it is very tempting to make a sarcastic reply here ("Of course! What
> kgdb really needs is yet another set of condition variables") I can't
> because I actually agree with the proposal. I don't really want kgdb to
> be too "special" especially when it doesn't need to be.
>
> Only thing to note is that rounding_up will not be manipulated within a
> common spin lock so you might have to invest a bit of thought to make
> sure any races between the master and slave as the slave CPU clears the
> flag are benign.

OK, so I've hopefully got all this thought through and posted v3.
I've put most of my thoughts in the patch descriptions themselves so
let's continue the discussion there.

-Doug
