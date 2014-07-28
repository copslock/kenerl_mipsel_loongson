Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 02:27:50 +0200 (CEST)
Received: from mail-oa0-f47.google.com ([209.85.219.47]:39305 "EHLO
        mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861498AbaG1XmkwSMhr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2014 01:42:40 +0200
Received: by mail-oa0-f47.google.com with SMTP id g18so9535198oah.20
        for <linux-mips@linux-mips.org>; Mon, 28 Jul 2014 16:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CEsCW3v3oK6k7OVrOhd+zsQZ0XMXur1jEHAKB8A7+hs=;
        b=AkK3Dtrm7wLsFntMxe9+dIqSDlpQJJtzEAe4fH9mp5nduK3C9+nRG4+vp1EzZLzW7j
         VVOeJ+OmZAMpj9XBwgiotnf6eTaoUkBb/HN4dcGsK/0obUf5Kl7/nCVVCCMdzQL1QA4T
         QS8jr5S7VozTKJ06/m+iNlIervu+p7YQEUbQTMqTvE7RQmElfJAmEehkK0x4PL5YeBF7
         pQF0wbEqRFvjddznqFj4aqX8ZRW3cXsz8FDTj5U4JGMmey0XIhmTk3fZs95pKMp5W44a
         D/8s6IRkMRX7KkSCaDamQD6YH4v7sEwU9dHbMRlbPWUa9vGCrVfcz0f65m9He1XH+B4T
         wZtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CEsCW3v3oK6k7OVrOhd+zsQZ0XMXur1jEHAKB8A7+hs=;
        b=VdAmzWvccuC+4+aDrXNZ0C53dM7Cctp8DpCDIvizTSPAom7CmJ4B4aStMpzFa0zelY
         K/7Xf5uhKoOOSe/vIJPD87sd9sWkOtyFsovuQNCuR7/scU3QWwvP/TaExZrwe0DiHl+K
         BOY/MxN5piAVALcquJEyrmcZWcitCUCgrmVlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=CEsCW3v3oK6k7OVrOhd+zsQZ0XMXur1jEHAKB8A7+hs=;
        b=KvD50sZp5miVX7s37fc8YEyex0+OzV8P+v4XQsRIP08KDR7iJCCEH91w7NnAZjPP/I
         uwCHGRPJCpdXwnw4+LSjWqdjrPUKEaB755TDF0MxdH+cChpbkZEW3fircGHF8b7HFprK
         wulb+YeR5x2qY46hVokY8xYGqtPsdwrCNeckBa5qXDhJJrYYsrvAjGo2YVtZio5KHs9U
         QnLW1A6WYzmdr93gbPM+2xV4L6pHfCSqTGTZpzSNa72nSm0lG3aGr0rQcs5QsDci8PS3
         QA3qGOl5TM55fU4i30vhSDJHlYRi4N6wCf0ry5xDYn+Wh2M4GoVzjfyhf6a5o1DbKOou
         2x8Q==
X-Gm-Message-State: ALoCoQkUVGoDGMiVPqww/RPczcmKtwNcYGYR2Xpcm/V2QXvQ0Rb7yd+0uMCkbIMFmaAW04wM3mr5
MIME-Version: 1.0
X-Received: by 10.182.3.100 with SMTP id b4mr36912960obb.79.1406590954635;
 Mon, 28 Jul 2014 16:42:34 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Mon, 28 Jul 2014 16:42:34 -0700 (PDT)
In-Reply-To: <53D6DE1E.1060501@zytor.com>
References: <cover.1405992946.git.luto@amacapital.net>
        <CAGXu5jJ93-vto9voMENc4jX5itcd_Rm5AZjeChF57fpMYnWocA@mail.gmail.com>
        <CALCETrVwqDeRbFOw=k_OhQZ4V6Pn5v3t8ODw75UuE7HKPFz=Sw@mail.gmail.com>
        <53D68F91.4000106@zytor.com>
        <CAGXu5jKJOrtjY9JsCBUvUbj_y4Hv+AeMEmGwWZZ18FmiZmAbbQ@mail.gmail.com>
        <53D6DE1E.1060501@zytor.com>
Date:   Mon, 28 Jul 2014 16:42:34 -0700
X-Google-Sender-Auth: jjhL89ts5dzu-ozkrOYEnHdDtcU
Message-ID: <CAGXu5jLjmHczeQiJN1Q+aGQKn_B+08FEXHWxjku6QedkGDhDTg@mail.gmail.com>
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
X-archive-position: 41735
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

On Mon, Jul 28, 2014 at 4:34 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 07/28/2014 04:29 PM, Kees Cook wrote:
>> On Mon, Jul 28, 2014 at 10:59 AM, H. Peter Anvin <hpa@zytor.com> wrote:
>>> On 07/23/2014 12:20 PM, Andy Lutomirski wrote:
>>>>
>>>> It looks like patches 1-4 have landed here:
>>>>
>>>> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
>>>>
>>>> hpa, what's the route forward for the x86 part?
>>>>
>>>
>>> I guess I should discuss this with Kees to figure out what makes most
>>> sense.  In the meantime, could you address Oleg's question?
>>
>> Since the x86 parts depend on the seccomp parts, I'm happy if you
>> carry them instead of having them land from my tree. Otherwise I'm
>> open to how to coordinate timing.
>>
>
> You mean for me to carry the seccomp part as well?

If that makes sense as far as the coordination, that's fine with me.
Otherwise I'm not sure how x86 can build without having the seccomp
changes in your tree.

-Kees


-- 
Kees Cook
Chrome OS Security
