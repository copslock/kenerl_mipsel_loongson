Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2014 20:59:04 +0200 (CEST)
Received: from mail-oi0-f51.google.com ([209.85.218.51]:47778 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861354AbaGRS664oK4o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2014 20:58:58 +0200
Received: by mail-oi0-f51.google.com with SMTP id g201so2055451oib.38
        for <linux-mips@linux-mips.org>; Fri, 18 Jul 2014 11:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0Dv6dqJYZiig4EvR7vGqV4J0uV2pl2koA+oiYHK019I=;
        b=cNL2bg7qPHFNGMlM+d1fUFbsHBzS20TQLviBLJSa2X/1ioHH+xBJpPsTZSEyPQA03N
         8Fc0u5LBisiV3xgWEB6O2dwAVKRgFX4nTRUvuiV0KlC+LvyPQ0qK/ym8BAxZQMiLN49s
         0HcvXY7vHsMvha6hHBRjL33XbCBEuP5AxQzMqFLy1urwGXa6WCwupPcSaW53j/SZ1p1i
         pcUYqSFH1UwG0FFI2wo3ph0G2uo0b3NiFoH0tM4TZHFgsCWv9M5LrOWgXMJiX0xQXAM3
         efzEm/y+IGMRFFWJRToNsXtD+9GyjhIlc3G82WHUrwCew6c+e2JOEZBxtR+d+Rll0gbn
         xvFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0Dv6dqJYZiig4EvR7vGqV4J0uV2pl2koA+oiYHK019I=;
        b=kZViqD3Hl/B1gCQoa9mcyRiSKHOXoNNpCotwG7HgOsxsyqk2KV5I3fOMSMOB6ecrWX
         ad/6QTKR17dlSlPbfP4Ad+6+QlJCMmI/esSpuKmccKAsPBxvPoQhlarLoTWZ6XdEcrjv
         xN7SBolv8OvIyezQJ+gJocq5BSO/BRXfV45mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0Dv6dqJYZiig4EvR7vGqV4J0uV2pl2koA+oiYHK019I=;
        b=dh1xMGmF7eZS4nNDzt4etFYCmPgAltv6Z9zdrvBDdSZfDx9UubOdkHJVytWvSy8b1t
         mU4dtYTMlvfH5tPr3B2R3WoXZ5V1IH2mJ0wIUYT6n0XsibPN4gC9g2DZ80bhq1ts4fjq
         L24Ol0LGNtxmuVGZPNkjkaHROhqQGSVg5ivQzZpOFYNnuImeThTqt4JXlBuJAcH1u88j
         i4hjs1CATOUCtrVgkxMbFJWaZFXlFSoLVbITNpPJBbubX9TdYZxItBL2kLZ+qx6PQDTp
         qrnolWhgO1Yw9OMtUcBlDU7wR0lrVAbHChzf1UjLTAy0dTlaGaewB9MDEWn6fICfSbru
         FXRQ==
X-Gm-Message-State: ALoCoQmJhIRzEp6PVwfIemRC780v9v1wjurl8bmf/6AdvBZ6JfvMcg5viMED6FXpurReqFqjI5oW
MIME-Version: 1.0
X-Received: by 10.182.65.167 with SMTP id y7mr9869038obs.29.1405709932588;
 Fri, 18 Jul 2014 11:58:52 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Fri, 18 Jul 2014 11:58:52 -0700 (PDT)
In-Reply-To: <CALCETrWj-NJeeKe6+qTZd3QsvLNMV_K=2swoNXza7Ef2xHkXoQ@mail.gmail.com>
References: <1405620518-18495-1-git-send-email-keescook@chromium.org>
        <alpine.LRH.2.11.1407181325200.15709@namei.org>
        <CALCETrUv3G+C3PTOD1FJGOG8AQCA30hNkUiusCnQDGq6Kt_Feg@mail.gmail.com>
        <CAGXu5jL9wQ4ZJ1kDRx_Y_cyGQEjO_Ugmcc--Q71x32_x1q9ScA@mail.gmail.com>
        <CALCETrWj-NJeeKe6+qTZd3QsvLNMV_K=2swoNXza7Ef2xHkXoQ@mail.gmail.com>
Date:   Fri, 18 Jul 2014 11:58:52 -0700
X-Google-Sender-Auth: fuCvvmzPgfxmRfezjpzvlQBmDBE
Message-ID: <CAGXu5jK4vzx-8Wo==BONNGnbm1hdawv2wc2sJb2AFzMf52AgGg@mail.gmail.com>
Subject: Re: [PATCH v12 11/11] seccomp: add thread sync ability
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     James Morris <jmorris@namei.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Morris <james.l.morris@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Drysdale <drysdale@google.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        Linux API <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41331
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

On Fri, Jul 18, 2014 at 11:51 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Fri, Jul 18, 2014 at 11:13 AM, Kees Cook <keescook@chromium.org> wrote:
>> On Fri, Jul 18, 2014 at 10:17 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>>> On Thu, Jul 17, 2014 at 8:26 PM, James Morris <jmorris@namei.org> wrote:
>>>> On Thu, 17 Jul 2014, Kees Cook wrote:
>>>>
>>>>> Twelfth time's the charm! :)
>>>>
>>>> Btw, there doesn't seem to be an official seccomp maintainer.  Kees, would
>>>> you like to volunteer for this?  If so, send in a patch for MAINTAINERS,
>>>> and set up a git tree for me to pull from.
>>
>> Sure thing, I'll get this set up now. I wonder if I should include the
>> glob "arch/*/kernel/ptrace.c" in the MAINTAINERS entry. :P
>
> You might want to convince some arch maintainers first, and that's
> like herding cats.  Or Oleg, at least.  Also, do you really want to be
> asked to deal with the never-ending stream of bugs that people find in
> files matching that glob?

Yeah, I've opted for "K: \bsecure_computing" Seemed like a decent middle-ground.

>>> *snicker* :)
>>>
>>> Kees, if you take on this awesome responsibility, should I send you a
>>> rebased version of the fastpath stuff?  If so, I think that the
>>> arch-neutral part should go in through your shiny new tree (once it's
>>> reviewed to your satisfaction), and I'll ask hpa to pick up the x86
>>> part.
>>
>> Yeah, that sounds perfect.
>>
>>> I'd volunteer to be a "R:eviewer", but I don't think that the R tag
>>> has made it into MAINTAINERS yet.
>>
>> I'd love to have you listed. :)
>
> Feel free to pester me once "R" appears in case I forget.

I will indeed! :)

-Kees

>
> You might be able to convince me to co-maintain some day.  Hmm.
>
> --Andy
>
>>
>> -Kees
>>
>> --
>> Kees Cook
>> Chrome OS Security
>
>
>
> --
> Andy Lutomirski
> AMA Capital Management, LLC



-- 
Kees Cook
Chrome OS Security
