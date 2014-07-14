Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2014 20:59:17 +0200 (CEST)
Received: from mail-ob0-f175.google.com ([209.85.214.175]:55997 "EHLO
        mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815921AbaGNS7PbwoBJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2014 20:59:15 +0200
Received: by mail-ob0-f175.google.com with SMTP id wp18so4705031obc.34
        for <linux-mips@linux-mips.org>; Mon, 14 Jul 2014 11:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uhhJdYVdKfO1n2PcPWEzzOogaSj6aH34TkN+2WE8K4c=;
        b=JnF7aB6DAe2yrBdCOxZobHll7jTwxAK+uiemY5hC2AfE93V4gM0iaf4mSdr2Vca7O4
         /pyiEyPt2J66fkdJA8udWWvB3juaffBk9NWpiZKzEKj8BxfdNxG0pQ62Ea1rIlAMPztG
         CulrfeJAK0yXgZw5tacSY4JEFkPe30iKndBAAq8USEPBDgT5pESjt7XoDEzLLOwA/vzI
         E2PvaR5GLsURbzefWaGHhYReYbFfQCS0wq/yb8iflYiMdczQ0MleRc5tcpazhoWNG+EK
         jPN6dsF8xNbo199Cpfl/MF/doF8aq9+BXmJNLErCP9Y918zKhWNZVSRpZYPBuN2bnl5q
         K+vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uhhJdYVdKfO1n2PcPWEzzOogaSj6aH34TkN+2WE8K4c=;
        b=n7EN/XUzlvPBamv5exPbR/E50w4SQzAPFpEH1DA6fbQXHt1bbGCIHnOOrR0J+86Ekj
         0Hu2YN7PB7rBMICHMJaEx9rbRS6EnBDfpA5BDit8/9lDDfTBaOM4GarBk2dEK2vvz/+p
         L3YjZm782ndjzUqsNZaUsgZDXqS0E0LSNQa40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=uhhJdYVdKfO1n2PcPWEzzOogaSj6aH34TkN+2WE8K4c=;
        b=Cdotfht0f1yVD/BXiEf1j3Xk0GlEnMaIxc5NuD2Dj7UU+pntv4cs9KrlhyV/dNlb4w
         wu/MWDKI2RInEg4lfDkpZx29PkZu2w8VHeTQ3QNl6qcBmR3eL+RjH6Bbe0fGDIf/T5PU
         AIqtzUUq2ol41vjqt6e2FGfVCdvAUGWcHNG8YeyPVEJrISHk762SMwRc8+gHRKf2RbvM
         5uiy06UmNSjhEgqsPNEK2XkzNgxLri5mwUxPuNt2axhi6e+F5mOaFKhgxdFojhuMzPzg
         P/FAsHiTRtZhPf4+7jpf0jv7eenHoCK4zqMhhY82XDJdX5uxkz7h4JrwPoqTbfASrjZe
         JZog==
X-Gm-Message-State: ALoCoQklB0MBZTIrs+QjHtY+HqFSzrmKlL59zsO9OZx5ospnYpO9redAeYUX4vHtp/TfWdd4C4zD
MIME-Version: 1.0
X-Received: by 10.60.80.229 with SMTP id u5mr19899702oex.62.1405364348955;
 Mon, 14 Jul 2014 11:59:08 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Mon, 14 Jul 2014 11:59:08 -0700 (PDT)
In-Reply-To: <CAGXu5jK-x0=Rr7kX2a=b4Z8ueA77uwmhNZZAayG8cwmNOKa8Ug@mail.gmail.com>
References: <1405017631-27346-1-git-send-email-keescook@chromium.org>
        <20140711164931.GA18473@redhat.com>
        <CAGXu5jK-x0=Rr7kX2a=b4Z8ueA77uwmhNZZAayG8cwmNOKa8Ug@mail.gmail.com>
Date:   Mon, 14 Jul 2014 11:59:08 -0700
X-Google-Sender-Auth: zs_UTEa_Y_JdKgssJCB-nUIhbeM
Message-ID: <CAGXu5jJJsiTxxn5UijkBz7jpWgqg01BS=Zc0WbHXbs0vH_xPMQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/11] seccomp: add thread sync ability
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <james.l.morris@oracle.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41188
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

Hi James,

Is this series something you would carry in the security-next tree?
That has traditionally been where seccomp features have landed in the
past.

-Kees


On Fri, Jul 11, 2014 at 10:55 AM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Jul 11, 2014 at 9:49 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> On 07/10, Kees Cook wrote:
>>>
>>> This adds the ability for threads to request seccomp filter
>>> synchronization across their thread group (at filter attach time).
>>> For example, for Chrome to make sure graphic driver threads are fully
>>> confined after seccomp filters have been attached.
>>>
>>> To support this, locking on seccomp changes via thread-group-shared
>>> sighand lock is introduced, along with refactoring of no_new_privs. Races
>>> with thread creation are handled via delayed duplication of the seccomp
>>> task struct field and cred_guard_mutex.
>>>
>>> This includes a new syscall (instead of adding a new prctl option),
>>> as suggested by Andy Lutomirski and Michael Kerrisk.
>>
>> I do not not see any problems in this version,
>
> Awesome! Thank you for all the reviews. :) If Andy and Michael are
> happy with this too, I think this is in good shape. \o/
>
> -Kees
>
>>
>> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>>
>
>
>
> --
> Kees Cook
> Chrome OS Security



-- 
Kees Cook
Chrome OS Security
