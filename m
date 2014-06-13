Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2014 18:29:36 +0200 (CEST)
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36747 "EHLO
        mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834695AbaFMQ3cvBqhY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jun 2014 18:29:32 +0200
Received: by mail-ie0-f182.google.com with SMTP id rp18so2685643iec.41
        for <linux-mips@linux-mips.org>; Fri, 13 Jun 2014 09:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=R8uSF/aLWGE+QWN164RiQyvgEaGl0CsBXsexEK/t5Ys=;
        b=SDCX9Ut8k9sfW49E+8IgN0f7Bh3xXbLe9HqtRIpbbbtkGJdGDkQraOucMv0+SWsCrY
         OvpZnHXELOIzfIBDqusmpUF4iS5nVCKk+CjxByV1tkz5h1U6sEkv/5RtEUTGG/0WaMOL
         N/z/bRH99D6PouQMwEOWCCijCjX4ShP7srd1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=R8uSF/aLWGE+QWN164RiQyvgEaGl0CsBXsexEK/t5Ys=;
        b=Es3NPHNyHk4R+UejPAtXJiOUy4+TgXRUkSWvMFLsUgr38894pU/hOcPtl3kFcxm9U6
         p/P9lc9Sc4X/atbO6iblm+pYjClKDH8Jc+qwdLMufWy7+5VUSSqgwQBMvpNutuNdBXE4
         RZerPhSQKopvf4mZHgqaayPMAgDPd2GDJkc+1u+dDQj1eckKx/1L97wwk8JZDn1ZrF4g
         gfMvHXhMxHD7t1pivNWVeO8Tg5xpnUlgXm9YvUGwX/PKBu5ukfwPPSFvtdP10m/VrTO5
         9VxZSPXMa5q108L84VgXTJPHBZoXVlcB1lPu+smo6vN4q0/Df6k4i6uJNq+1pipPG8ec
         RL+w==
X-Gm-Message-State: ALoCoQkxxPhmlQT5l4vhddlyIE8p9AjbWIBhlMPIGkC+qg6xcDOy/8F4PMT9hCMBF9N/IxmbUtO6
MIME-Version: 1.0
X-Received: by 10.42.58.130 with SMTP id i2mr4640313ich.66.1402676966517; Fri,
 13 Jun 2014 09:29:26 -0700 (PDT)
Received: by 10.50.253.37 with HTTP; Fri, 13 Jun 2014 09:29:26 -0700 (PDT)
In-Reply-To: <CAGXu5jL86C1yvWynBrp20CxT9COorc5++nT6OhwYCwqc7UJyHg@mail.gmail.com>
References: <cover.1402517933.git.luto@amacapital.net>
        <9e11cd988a0f120606e37b5e275019754e2774da.1402517933.git.luto@amacapital.net>
        <CAADnVQKt5FnShkZeQewbfnU1kHM-gLs3hCZMf5xcgFzyRDLX7A@mail.gmail.com>
        <CALCETrXoqqKC=T5Wvj+CDYQFte1s_=npDvQ2UYW0j=AanEgR1g@mail.gmail.com>
        <5398D59A.3030900@zytor.com>
        <CALCETrVMxkHcPXsEGtEc0Pr=Z80CzC0zWaQ9OdVdxi1CGuB4kQ@mail.gmail.com>
        <5398D7B4.5000303@zytor.com>
        <CALCETrWaQZc124=6r4h+fTAY4H4LzWGFw=MB7KY5TBtB0jx9hA@mail.gmail.com>
        <CAGXu5jL86C1yvWynBrp20CxT9COorc5++nT6OhwYCwqc7UJyHg@mail.gmail.com>
Date:   Fri, 13 Jun 2014 11:29:26 -0500
Message-ID: <CABqD9hbgPCSgXNCOreSV3b+yBsO9fLYtYr-ShtfOoH=uZEYa3w@mail.gmail.com>
Subject: Re: [RFC 5/5] x86,seccomp: Add a seccomp fastpath
From:   Will Drewry <wad@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <wad@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wad@chromium.org
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

On Wed, Jun 11, 2014 at 5:32 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Jun 11, 2014 at 3:28 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Wed, Jun 11, 2014 at 3:27 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>>> On 06/11/2014 03:22 PM, Andy Lutomirski wrote:
>>>> On Wed, Jun 11, 2014 at 3:18 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>>>>> On 06/11/2014 02:56 PM, Andy Lutomirski wrote:
>>>>>>
>>>>>> 13ns is with the simplest nonempty filter.  I hope that empty filters
>>>>>> don't work.
>>>>>>
>>>>>
>>>>> Why wouldn't they?
>>>>
>>>> Is it permissible to fall off the end of a BPF program?  I'm getting
>>>> EINVAL trying to install an actual empty filter.  The filter I tested
>>>> with was:
>>>>
>>>
>>> What I meant was that there has to be a well-defined behavior for the
>>> program falling off the end anyway, and that that should be preserved.
>>>
>>> I guess it is possible to require that all code paths must provably
>>> reach a termination point.
>>>
>>
>> Dunno.  I haven't ever touched any of the actual BPF code.  This whole
>> patchset only changes the code that invokes the BPF evaluator.
>
> Yes, this is how BPF works: runs to the end or exit early. With
> seccomp BPF specifically, the return value defaults to kill the
> process. If a filter was missing (NULL), or empty, or didn't
> explicitly return with a new value, the default (kill) should be
> taken.

Yup - this is just a property of BPF (and a nice one :)

On seccomp_attach_filter this check fires:
  if (fprog->len == 0 || fprog->len > BPF_MAXINSNS)
    return -EINVAL;

As well as in sk_chk_filter:
  if (flen == 0 || flen > BPF_MAXINSNS)
    return -EINVAL;

And:
  /* last instruction must be a RET code */
  switch (filter[flen - 1].code) {
    case BPF_S_RET_K:
    case BPF_S_RET_A:
      return check_load_and_stores(filter, flen);
  }

cheers!
will
