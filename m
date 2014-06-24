Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 21:50:12 +0200 (CEST)
Received: from mail-oa0-f43.google.com ([209.85.219.43]:59372 "EHLO
        mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6855803AbaFXTuJLZ3L0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 21:50:09 +0200
Received: by mail-oa0-f43.google.com with SMTP id o6so931374oag.30
        for <linux-mips@linux-mips.org>; Tue, 24 Jun 2014 12:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Z9jSbZGI30cBcYbEsBgVjUCmwhBAUZcdO6aydXHoahE=;
        b=P/Us+goGIpQr9vuf/q0HSb+nb+oRuEdSL/hincPT2A2AgUBqkAWPQ4Td8GY4l8kasZ
         swCBY0/jnyKN2NsZicrga00g7kZNZhmegdkD/ZWyNx79beJ8S+Um8+ZiSsG7tNjxsyQB
         y/0TfeJ4JkEaaTxntgiYKSy4cnkDFDs8GBBHVhrSRVfC2iBK3aal7JAj1a2XaB9Db3Zn
         357+qbO8yKGNnoR1qkesXvWc8VgbayD4xjzcqQPn3hRibcmhrdLwIystttm5gdcLOBkV
         HmcrIZb1GFAjDj1iAodYYkbNHIaRP2k20g6JFgdbGYFpSjDU3fEljs56dkt3fvH6kLfy
         Y+LQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Z9jSbZGI30cBcYbEsBgVjUCmwhBAUZcdO6aydXHoahE=;
        b=aTVuOuCzjGYmJygq62OAPp9YBn5OxK/6/9sOPJEhRZdeiEbJPXPBAXh7uyG4hool6S
         EsHRqNOVZ+wT9cafkXgn+AGtkZZ64GB+Os8+i8a2g0bPl6cHbA3jYsNmXzsi5VKWMjdy
         e1bPdodcHrnIAcsjb2/8fo70PCVKKP11zVwjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Z9jSbZGI30cBcYbEsBgVjUCmwhBAUZcdO6aydXHoahE=;
        b=I0gXSGBG5KNz9TqMBgIIG+xFsXjjKtBIerfnUZ3U5z0FhVZBTzV0uXr319E5zd2LUf
         pmmFPQD+x54RCFoedd39H3cjxuQ4t77nUDPZX+1Ed54/W8U/4pb1U0f6310AYyGrHCle
         aPV/P03sPZfWJ0oKEh7ycZ7xt+mbQHY0f7kHb4BTyIWMc8ilWF9jc+W6h7lZvRuPNtkf
         Ih1Zo9AeI4y+Qh30f1SWPzdtse3DRq898UcKW8MwYMiQMhSX+sTdIMayZpHirtX9I9hN
         quHvyT/sdRklbODXH52GWNXWTHEBBAkPeuqoh+FyoadZ1N6ov/WhCGUBUZZxy4VQlnZU
         yPyQ==
X-Gm-Message-State: ALoCoQkI4CCXdZPUAMzoeauXfKVhJAnX7nX1D+ObsbLLXieCbf84JG/Fx1RvFz2Pq0A67RPZk4Yu
MIME-Version: 1.0
X-Received: by 10.182.191.106 with SMTP id gx10mr3136858obc.69.1403639402931;
 Tue, 24 Jun 2014 12:50:02 -0700 (PDT)
Received: by 10.182.63.80 with HTTP; Tue, 24 Jun 2014 12:50:02 -0700 (PDT)
In-Reply-To: <CALCETrU9x05ADgz9JToiw_BuCPz1h0xmOh=1R3eojL9far1aEA@mail.gmail.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
        <1403560693-21809-5-git-send-email-keescook@chromium.org>
        <20140624191815.GA3623@redhat.com>
        <CALCETrVgpP=zOtiQafVgcic2T95TdEM5DTvHYXWTbcZ14xBqHQ@mail.gmail.com>
        <20140624193055.GA4482@redhat.com>
        <CALCETrU9x05ADgz9JToiw_BuCPz1h0xmOh=1R3eojL9far1aEA@mail.gmail.com>
Date:   Tue, 24 Jun 2014 12:50:02 -0700
X-Google-Sender-Auth: Fg6ZM_azFWW4XQ6zDsbyHxkkglo
Message-ID: <CAGXu5jJjuNmf=FRzUPMChvL4D_xkg034pUbRAbaK38f37GYC0A@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] seccomp: move no_new_privs into seccomp
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
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
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Tue, Jun 24, 2014 at 12:34 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Tue, Jun 24, 2014 at 12:30 PM, Oleg Nesterov <oleg@redhat.com> wrote:
>> On 06/24, Andy Lutomirski wrote:
>>>
>>> On Tue, Jun 24, 2014 at 12:18 PM, Oleg Nesterov <oleg@redhat.com> wrote:
>>> >>
>>> >> -struct seccomp { };
>>> >> +struct seccomp {
>>> >> +     unsigned long flags;
>>> >> +};
>>> >
>>> > A bit messy ;)
>>> >
>>> > I am wondering if we can simply do
>>> >
>>> >         static inline bool current_no_new_privs(void)
>>> >         {
>>> >                 if (current->no_new_privs)
>>> >                         return true;
>>> >
>>> >         #ifdef CONFIG_SECCOMP
>>> >                 if (test_thread_flag(TIF_SECCOMP))
>>> >                         return true;
>>> >         #endif
>>>
>>> Nope -- privileged users can enable seccomp w/o nnp.
>>
>> Indeed, I am stupid.
>>
>> Still it would be nice to cleanup this somehow. The new member is only
>> used as a previous ->no_new_privs, just it is long to allow the concurent
>> set/get. Logically it doesn't even belong to seccomp{}.
>
> We could add an unsigned long atomic flags field to task_struct.

I thought that had gotten shot down originally, but given the current
state of the patch series, it would be effectively identical, since my
earlier attempt at keeping sizes the same (with alternate accessors)
was too messy. I will change this as well.

> Grr.  Why isn't there an unsigned *int* atomic bitmask type?  Even u64
> would be better.  unsigned long is useless.

Useless beyond 32 bits. ;)

-Kees

-- 
Kees Cook
Chrome OS Security
