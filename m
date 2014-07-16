Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 23:57:30 +0200 (CEST)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:41758 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861357AbaGPV50YzEeS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2014 23:57:26 +0200
Received: by mail-ig0-f173.google.com with SMTP id h18so4902706igc.12
        for <linux-mips@linux-mips.org>; Wed, 16 Jul 2014 14:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=UU2yG5L7U9baLikMmFfwkQvQVzxlwuKX2yW/xye1NDk=;
        b=Q6ZD3ISvmrJzYeMJujK/9BrL0djpJczt3icfr7aF+4+vXjLecAeETHck+U4xN1v2T7
         2JOofJPwECoiXrSFhAEtkkF/mS/FbnChhJ3A0+P16XgA8gS+yLxVrPRMueAfth9WfyZl
         BRoCz0IJ8GGkY4tsHagYFnhV2plXIXgbzo3PT8OOdi8qCJhFt573z7K9Bq/oyroit7j1
         0SSv/R5VAcWzJWTbr3r/8fpfK6sV15EaYXxhWR+FcvWh6Uq4MXgVxceB0V54HafvLhuw
         QlOFn1CFXzN48sm33bd7QkbmhacQtlj75En5w5skbQT0QNxx5E5HUdSxadTMPh8ABoSd
         LcHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=UU2yG5L7U9baLikMmFfwkQvQVzxlwuKX2yW/xye1NDk=;
        b=A1DgBwlHVveZnC+k09Q60WTg7PSyAPArRv/Gq6te40YMheLGqrbPMXKts4wHiHVvRh
         aIqQhWdE+SWb082Ndcj+TARVqIFxOci1+/PZRwUK9B/saX0s9CQ/SspC8hvqZl3/1sjC
         9aLAjLQfHdCG9ruLJVKVKbqylPLFtEgv4VMTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UU2yG5L7U9baLikMmFfwkQvQVzxlwuKX2yW/xye1NDk=;
        b=DaF2ZqgHLo6zRqI1B0TjlRDOqX0P4JW4cQi+vAf7UZU5B1MUpdyPhr2A79gcVdiO+j
         aP1tQ29QH+4YVPyU8BXXH79hlNYv7nyGqhbhJZ6nzzcI04LSgOOqt8173qRt9PH2Fv0F
         j3c1VVxHYUlzZG6r5XXVhpL0fApgNKca4PQ0RkPXOAlYDd0HaQ15sj8YMVHVzCS1Dpvq
         TGH0+kMZQLbJeM31R7qvyp6BWGISxh2p4VJHeVYVr4aCAJBxgqPhGYaISjSKkUlJyMRv
         NYwK/o7hAEl5FKwQKH7louTMurm6KlbktSXHdaHtli6DsyrPosSwQ7TFwGpjY5+BK2fo
         kJvA==
X-Gm-Message-State: ALoCoQmDiznlsZAai4cPSxL5V88siRCT9AY2zos3x0/rKCZj5RAzCTpLplX2syfpKj+ywTUwOTRW
MIME-Version: 1.0
X-Received: by 10.60.174.3 with SMTP id bo3mr39234449oec.31.1405547840248;
 Wed, 16 Jul 2014 14:57:20 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Wed, 16 Jul 2014 14:57:20 -0700 (PDT)
In-Reply-To: <CALCETrWuWxZANoKAR=FG55EOHtzvTHmc3euMdtf8yfibtK-QYw@mail.gmail.com>
References: <cover.1405452484.git.luto@amacapital.net>
        <bd4e2efb7cd97f2bf9d4f1e2065f16c9091d799a.1405452484.git.luto@amacapital.net>
        <CAGXu5jJornzMJjyPXVZB_eYi-FRet=bXcJWJDa1vnB_oU9ZA_Q@mail.gmail.com>
        <CALCETrWuWxZANoKAR=FG55EOHtzvTHmc3euMdtf8yfibtK-QYw@mail.gmail.com>
Date:   Wed, 16 Jul 2014 14:57:20 -0700
X-Google-Sender-Auth: 9ijIB9RcfMZoIQgeduQ4ao4CJVU
Message-ID: <CAGXu5jLcbWDJiLbpejJTERbV2CkCk2dVZ7jwq7Xw_jYUicBFjQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] x86: Split syscall_trace_enter into two phases
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        James Morris <james.l.morris@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41254
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

On Wed, Jul 16, 2014 at 2:15 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Wed, Jul 16, 2014 at 1:21 PM, Kees Cook <keescook@chromium.org> wrote:
>> On Tue, Jul 15, 2014 at 12:32 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>>
>>> +
>>> +               ret = seccomp_phase1(&sd);
>>> +               if (ret == SECCOMP_PHASE1_SKIP) {
>>> +                       regs->orig_ax = -ENOSYS;
>>
>> Before, seccomp didn't touch orig_ax on a skip. I don't see any
>> problem with this, and it's probably more clear this way, but are you
>> sure there aren't unexpected side-effects from this?
>
> It's necessary to cause the syscall to be skipped -- see syscall_trace_enter.
>
> That being said, setting it to -ENOSYS is nonsense and probably
> confused you at least as much as it confused me.  It should be
> regs->orig_ax = -1.

Yes, I think that would be better.

-Kees

-- 
Kees Cook
Chrome OS Security
