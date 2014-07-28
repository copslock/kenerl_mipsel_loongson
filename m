Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 03:08:47 +0200 (CEST)
Received: from mail-oa0-f53.google.com ([209.85.219.53]:53329 "EHLO
        mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861520AbaG1XyoT948k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2014 01:54:44 +0200
Received: by mail-oa0-f53.google.com with SMTP id j17so9610748oag.40
        for <linux-mips@linux-mips.org>; Mon, 28 Jul 2014 16:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TnsNPqoJMqkbItRLyWDK4udpqANUE2goqXTZSWQlZiI=;
        b=BsGdx1z3l1FLcu+VDM9i1tVQeDphtAxvDXn8Ii11NfDlEoeMeNSDzaRgMdBxiinyQh
         z/xhIPbKenLKzCJV5PYLggLRAO7Ows/Fs42L8iSxqEHYoCwMEaLdADJZ6PWbcf7OxjI9
         kM8GKdgL2gdnbHJGzijiasChsyFWBzR7GCgd1onjI+MH/B0bNO1pPhZ5bk09ojytEsGE
         BDvNS+YvZCxCOdwXAOBcuDfCFpa+/VX7u5j6wOQkUsGzMEKhmqvoXA8Ftl9bdM4e4jLS
         bYepkx/aWhHU4fWwUm27WOreyhuNpU+fgNaSSbC0lsaRnvV543CN6V0EAMxqZNVx/Z5C
         3Ngw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=TnsNPqoJMqkbItRLyWDK4udpqANUE2goqXTZSWQlZiI=;
        b=L2/HZorgzTvkh/owlFxg1wBlMva+FLA8jWr1zfJKlFOyc35ubeLYfg3WbCSXgdDjef
         Ti+oSu3wU1W6MoV+VXkRU9ElPyeE8sFqFLUK/ZIoEye6TTJ14WlioX0Q+a+CFLmaLgKe
         XN+suwkvfIptj4/13r3HolDCsEvABesVhVYzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TnsNPqoJMqkbItRLyWDK4udpqANUE2goqXTZSWQlZiI=;
        b=b8jMluBo0MGpAP0CQ+9+tFtV+vWS7XmA43AxYMfLN8mbXPKlIMgj+mhrgZzwBM9F9F
         u6ofy+7cOTnk2NRHfDFK87uplzxCKhKWwr8IV1staeWmWmc/NK0JYNcwYQFyDopjL18x
         SUICempf8LmhkffAnTOcqx53IFmDvGR2u9bQFdaS+sMrvhQAK3D8msO5yJ+SVAmhf9wx
         yTSUphN8wA2S0YitT3yDS48kyVK+RDgffDTWul0gklzhipeC4Z2zTZo/wE9iU5rWUBbx
         QxrZR+OIt2dLP7hp1dH5Motr+PWaxtvK78hidW9A2JIYSQCMWWal6an2t0EeZ4N6Sw0c
         7G6A==
X-Gm-Message-State: ALoCoQlua9d+Z7piWkxvzy0TZBpj4b6JRHMSkybaIk3Ya2wVf449FRr5rSrvE6EHRfWEuEtfIzOe
MIME-Version: 1.0
X-Received: by 10.60.52.5 with SMTP id p5mr54009081oeo.55.1406591678268; Mon,
 28 Jul 2014 16:54:38 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Mon, 28 Jul 2014 16:54:38 -0700 (PDT)
In-Reply-To: <53D6E07F.7090806@zytor.com>
References: <cover.1405992946.git.luto@amacapital.net>
        <CAGXu5jJ93-vto9voMENc4jX5itcd_Rm5AZjeChF57fpMYnWocA@mail.gmail.com>
        <CALCETrVwqDeRbFOw=k_OhQZ4V6Pn5v3t8ODw75UuE7HKPFz=Sw@mail.gmail.com>
        <53D68F91.4000106@zytor.com>
        <CAGXu5jKJOrtjY9JsCBUvUbj_y4Hv+AeMEmGwWZZ18FmiZmAbbQ@mail.gmail.com>
        <53D6DE1E.1060501@zytor.com>
        <CAGXu5jLjmHczeQiJN1Q+aGQKn_B+08FEXHWxjku6QedkGDhDTg@mail.gmail.com>
        <53D6E07F.7090806@zytor.com>
Date:   Mon, 28 Jul 2014 16:54:38 -0700
X-Google-Sender-Auth: Mcou2ELHP4zx9cJIbdNjhWuAnKk
Message-ID: <CAGXu5jJA=gN+5gQs5wNUdsnqiK3kRVvYnpBB6DkdhmVCsenugQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Two-phase seccomp and x86 tracing changes
From:   Kees Cook <keescook@chromium.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Will Drewry <wad@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alexei Starovoitov <ast@plumgrid.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41739
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

On Mon, Jul 28, 2014 at 4:45 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 07/28/2014 04:42 PM, Kees Cook wrote:
>> On Mon, Jul 28, 2014 at 4:34 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>>> On 07/28/2014 04:29 PM, Kees Cook wrote:
>>>> On Mon, Jul 28, 2014 at 10:59 AM, H. Peter Anvin <hpa@zytor.com> wrote:
>>>>> On 07/23/2014 12:20 PM, Andy Lutomirski wrote:
>>>>>>
>>>>>> It looks like patches 1-4 have landed here:
>>>>>>
>>>>>> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
>>>>>>
>>>>>> hpa, what's the route forward for the x86 part?
>>>>>>
>>>>>
>>>>> I guess I should discuss this with Kees to figure out what makes most
>>>>> sense.  In the meantime, could you address Oleg's question?
>>>>
>>>> Since the x86 parts depend on the seccomp parts, I'm happy if you
>>>> carry them instead of having them land from my tree. Otherwise I'm
>>>> open to how to coordinate timing.
>>>>
>>>
>>> You mean for me to carry the seccomp part as well?
>>
>> If that makes sense as far as the coordination, that's fine with me.
>> Otherwise I'm not sure how x86 can build without having the seccomp
>> changes in your tree.
>>
>
> Exactly.  What I guess I'll do is set up a separate tip branch for this,
> pull your branch into it, and then put the x86 patches on top.  Does
> that make sense for everyone?

Sounds good to me. Once Oleg and Andy are happy, we'll be set.

-Kees


-- 
Kees Cook
Chrome OS Security
