Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 21:52:11 +0200 (CEST)
Received: from mail-la0-f43.google.com ([209.85.215.43]:52343 "EHLO
        mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6842554AbaFXTwJVuMZQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 21:52:09 +0200
Received: by mail-la0-f43.google.com with SMTP id e16so30183lan.16
        for <linux-mips@linux-mips.org>; Tue, 24 Jun 2014 12:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=uCBeUVV1vr0m7P40huB+AllgkcR83uAYn8bkPPb2ZiM=;
        b=l5Rij5elK1DCoLlmQjyooF7xA+f1wmAvfK5TCDXs8KlweHnVlS8z++OjFKCDv8IesH
         11KIBxCVw4NGexRGK7e7RU6mIx5zURXmkUXAmuXMpy16c5WcR4S+49aTLK6534MFxFCi
         zh774qLKlbz0HFipdP5fVZH1LIWXqduwZTseS8qUMN90F2FHFafB6+Dfd+dVora98PMG
         ruBojrOHM6Ui+6jFbkQOUwLhEE4x0IfmO4q8T7ScitNY9yklWN0e/D6FLuyw3tFV0qK8
         qXf5jDsAjAW50g0dAGUtNN282X+N69t4qw9Mpvb+1Z6PCswWLZPbq6xM7EQYCOnEfvIR
         +1Aw==
X-Gm-Message-State: ALoCoQmCsNLiVPnOPvgl2RgLUfM85xgrxJxfNEQmLU4WfO+04lecfLjpgKUndQsVVrgW4Six8HPE
X-Received: by 10.152.207.11 with SMTP id ls11mr2145672lac.62.1403639523822;
 Tue, 24 Jun 2014 12:52:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Tue, 24 Jun 2014 12:51:43 -0700 (PDT)
In-Reply-To: <CAGXu5jJjuNmf=FRzUPMChvL4D_xkg034pUbRAbaK38f37GYC0A@mail.gmail.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
 <1403560693-21809-5-git-send-email-keescook@chromium.org> <20140624191815.GA3623@redhat.com>
 <CALCETrVgpP=zOtiQafVgcic2T95TdEM5DTvHYXWTbcZ14xBqHQ@mail.gmail.com>
 <20140624193055.GA4482@redhat.com> <CALCETrU9x05ADgz9JToiw_BuCPz1h0xmOh=1R3eojL9far1aEA@mail.gmail.com>
 <CAGXu5jJjuNmf=FRzUPMChvL4D_xkg034pUbRAbaK38f37GYC0A@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 24 Jun 2014 12:51:43 -0700
Message-ID: <CALCETrUCK0g3nTQP+Oh7-JXh-mODAC-Bemr1fCYMJyDvjFPcjQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] seccomp: move no_new_privs into seccomp
To:     Kees Cook <keescook@chromium.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Linux API <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Tue, Jun 24, 2014 at 12:50 PM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Jun 24, 2014 at 12:34 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Tue, Jun 24, 2014 at 12:30 PM, Oleg Nesterov <oleg@redhat.com> wrote:
>>> On 06/24, Andy Lutomirski wrote:
>>>>
>>>> On Tue, Jun 24, 2014 at 12:18 PM, Oleg Nesterov <oleg@redhat.com> wrote:
>>>> >>
>>>> >> -struct seccomp { };
>>>> >> +struct seccomp {
>>>> >> +     unsigned long flags;
>>>> >> +};
>>>> >
>>>> > A bit messy ;)
>>>> >
>>>> > I am wondering if we can simply do
>>>> >
>>>> >         static inline bool current_no_new_privs(void)
>>>> >         {
>>>> >                 if (current->no_new_privs)
>>>> >                         return true;
>>>> >
>>>> >         #ifdef CONFIG_SECCOMP
>>>> >                 if (test_thread_flag(TIF_SECCOMP))
>>>> >                         return true;
>>>> >         #endif
>>>>
>>>> Nope -- privileged users can enable seccomp w/o nnp.
>>>
>>> Indeed, I am stupid.
>>>
>>> Still it would be nice to cleanup this somehow. The new member is only
>>> used as a previous ->no_new_privs, just it is long to allow the concurent
>>> set/get. Logically it doesn't even belong to seccomp{}.
>>
>> We could add an unsigned long atomic flags field to task_struct.
>
> I thought that had gotten shot down originally, but given the current
> state of the patch series, it would be effectively identical, since my
> earlier attempt at keeping sizes the same (with alternate accessors)
> was too messy. I will change this as well.
>
>> Grr.  Why isn't there an unsigned *int* atomic bitmask type?  Even u64
>> would be better.  unsigned long is useless.
>
> Useless beyond 32 bits. ;)

It basically guarantees 32 wasted bits on 64-bit systems.

I guess that unsigned long foo[64/BITS_PER_LONG] would work, bit that's hideous.

--Andy
