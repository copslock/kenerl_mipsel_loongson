Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 23:40:14 +0200 (CEST)
Received: from mail-lb0-f176.google.com ([209.85.217.176]:54550 "EHLO
        mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860088AbaGQVkMnCs0k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 23:40:12 +0200
Received: by mail-lb0-f176.google.com with SMTP id u10so1977838lbd.35
        for <linux-mips@linux-mips.org>; Thu, 17 Jul 2014 14:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=wrahysN0MkFRHxTmKq7O5h0YpvuKZju3S7+yd578Ftk=;
        b=ZRfZF7YqC8w+B2XNAug+MtJNgcOnxk1SVSZBErk/IcX6OA76uLGAvRZjby190PGkL9
         BZutACP9tcaAiS8t/qclH4042rCjLrHkRbzYHGdX/+SudL5fUHZ03dhFaGD4H4xtAg3v
         s0Ag7pA6gC3zLmzZHSlhoacW0WPzP4foRUt7ZRN1knx53GP7msIAllCB9EnzbNmAlrNF
         erGhCc/+dg+9/WuabgDdZwftRLCQ1ApnLNjb2YfWjnAi6NoLuLT8marbDIZMwNpnJZeT
         DtK8IhUBy7GAiugVQV1qGn6Tupyh7klADCFdNiCmXS05l8P/k79zMECjJvBW4+vSEGQC
         7Ilw==
X-Gm-Message-State: ALoCoQmUIIoi4QBckNvmLbcRZxIAnlcAfDauqH/xWj/+aBIy+FBjaPMmmYRrgJqkBB8PrLIcrbOv
X-Received: by 10.152.207.36 with SMTP id lt4mr104237lac.72.1405633206656;
 Thu, 17 Jul 2014 14:40:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Thu, 17 Jul 2014 14:39:46 -0700 (PDT)
In-Reply-To: <53C48986.5010109@oracle.com>
References: <1405017631-27346-1-git-send-email-keescook@chromium.org>
 <20140711164931.GA18473@redhat.com> <CAGXu5jK-x0=Rr7kX2a=b4Z8ueA77uwmhNZZAayG8cwmNOKa8Ug@mail.gmail.com>
 <CAGXu5jJJsiTxxn5UijkBz7jpWgqg01BS=Zc0WbHXbs0vH_xPMQ@mail.gmail.com> <53C48986.5010109@oracle.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 17 Jul 2014 14:39:46 -0700
Message-ID: <CALCETrUf-Tei+R32SR-KKLD50zWa89Vrfu4S4uZ+4jh4eEFOdg@mail.gmail.com>
Subject: Re: [PATCH v10 0/11] seccomp: add thread sync ability
To:     James Morris <james.l.morris@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
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
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41299
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

On Mon, Jul 14, 2014 at 6:53 PM, James Morris <james.l.morris@oracle.com> wrote:
> On 07/15/2014 04:59 AM, Kees Cook wrote:
>>
>> Hi James,
>>
>> Is this series something you would carry in the security-next tree?
>> That has traditionally been where seccomp features have landed in the
>> past.
>>
>> -Kees
>>
>>
>> On Fri, Jul 11, 2014 at 10:55 AM, Kees Cook <keescook@chromium.org> wrote:
>>>
>>> On Fri, Jul 11, 2014 at 9:49 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>>>
>>>> On 07/10, Kees Cook wrote:
>>>>>
>>>>>
>>>>> This adds the ability for threads to request seccomp filter
>>>>> synchronization across their thread group (at filter attach time).
>>>>> For example, for Chrome to make sure graphic driver threads are fully
>>>>> confined after seccomp filters have been attached.
>>>>>
>>>>> To support this, locking on seccomp changes via thread-group-shared
>>>>> sighand lock is introduced, along with refactoring of no_new_privs.
>>>>> Races
>>>>> with thread creation are handled via delayed duplication of the seccomp
>>>>> task struct field and cred_guard_mutex.
>>>>>
>>>>> This includes a new syscall (instead of adding a new prctl option),
>>>>> as suggested by Andy Lutomirski and Michael Kerrisk.
>>>>
>>>>
>>>> I do not not see any problems in this version,
>>>
>>>
>>> Awesome! Thank you for all the reviews. :) If Andy and Michael are
>>> happy with this too, I think this is in good shape. \o/
>>>
>>> -Kees
>>>
>>>>
>>>> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>>>>
>>>
>>>
>>>
>>> --
>>> Kees Cook
>>> Chrome OS Security
>>
>>
>>
>>
>
> Yep, certainly.
>

Any ETA?  I'm currently blocking on having stable commit hashes for these.

If you're planning on pulling from Kees' tree instead of importing the
patches, I can work with that, too.

Thanks,
Andy
