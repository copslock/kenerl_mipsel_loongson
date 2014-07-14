Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2014 22:34:46 +0200 (CEST)
Received: from mail-oa0-f43.google.com ([209.85.219.43]:38884 "EHLO
        mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860902AbaGNUemdBQkj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2014 22:34:42 +0200
Received: by mail-oa0-f43.google.com with SMTP id i7so3915041oag.2
        for <linux-mips@linux-mips.org>; Mon, 14 Jul 2014 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QvYh8syuSjteDO69aUGiDBzZYan9OC894hVDfW69uwA=;
        b=kzqNkDFg7zg1986ehdS5ZJ3++gakUtYjkv0fG/RYOJIvNSBNEQrta5JNYZwSEPI6M7
         +n3d3tyls5Vp7dM1ESli3VBl1yvIl6cvmMtPjtssHbfQisHSWF6ltBV1KYluASzxyJcL
         g+MQ6C1QdBf2fXUNNwE5MxdUKAvcSPCLtt6BnOvEIANwM/PYeq145OuzEwSCwddMkt76
         3yWhcb17aV7pjsNuUT9LF63ZWoJNHmCDt4xasnHEAnHmVV6kfL3lvDABqyfuLb88AIUT
         8QUctnTbpaDau4QXR78elUC8Qq33TunqugZTUNZF5z6xFQ8vzPXbde5EQrJdiZ/qzkWj
         Fk/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QvYh8syuSjteDO69aUGiDBzZYan9OC894hVDfW69uwA=;
        b=c3JgqppQy30EKS7oThwkQri+8KWwhvmcimYQip1hg2Gbhznr/N2XFle9RtIEHk7PlP
         HN1Y5TcJPcEY4jZIGYSK9US91/I8JlfV3nsa7maevkURe2NOZ5pCMIMkayvXJCIfs7sN
         rhsHReH7YsO/otC337bLvCQLOBp6TqoIMcV5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=QvYh8syuSjteDO69aUGiDBzZYan9OC894hVDfW69uwA=;
        b=iay5w5CXBGZwS+Fdq0BgdIYAfzZL6pN3MQZftZt8Vlvf+hXofpQkRFbV+koe8ByWfH
         geAlZMcrB/EJKdgmYdb0MuvWHj34jbdrhNUg2SHu3SR3+vHaMXQOBLoaix+ft8BWn78B
         kL6UcJyiilxpOrZijGAGqxQld0yGaWV14zLs+xpb06ho1Ub9hBayb53LwawDdwsSXuDZ
         yAE2NZePm8vUtpAwJv9NjpK8P2fAaREVL6oR5GDnv7GLbLpcNnuX60EANtOEnOkkWMad
         ltW0Ys97UUCWQ6yWb4DOSzRHfMyfeeGWmWFCutsnrGOnW6i3oVWP6xPLGKVYSMPsh7k3
         mWwA==
X-Gm-Message-State: ALoCoQmrGxmgq9ApVdJYSwazM4pUYr0WwG0T1ov5KAkPNhGIawY80HlRnnHngXompdS/KJTwib6S
MIME-Version: 1.0
X-Received: by 10.182.181.42 with SMTP id dt10mr10936346obc.69.1405370076306;
 Mon, 14 Jul 2014 13:34:36 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Mon, 14 Jul 2014 13:34:36 -0700 (PDT)
In-Reply-To: <CALCETrVXgA9a2f7VwnCYW4_XB+JAPRSR8xsuH_ZYbA82=ZozRw@mail.gmail.com>
References: <1405017631-27346-1-git-send-email-keescook@chromium.org>
        <20140711164931.GA18473@redhat.com>
        <CAGXu5jK-x0=Rr7kX2a=b4Z8ueA77uwmhNZZAayG8cwmNOKa8Ug@mail.gmail.com>
        <CALCETrVXgA9a2f7VwnCYW4_XB+JAPRSR8xsuH_ZYbA82=ZozRw@mail.gmail.com>
Date:   Mon, 14 Jul 2014 13:34:36 -0700
X-Google-Sender-Auth: L2LwMaN6y4oQ9mLh4H0z5d9XniM
Message-ID: <CAGXu5j+A0GodNCnjqpYQXC2HL+S08_yP5H_n_v51VpE4UnnK7A@mail.gmail.com>
Subject: Re: [PATCH v10 0/11] seccomp: add thread sync ability
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Oleg Nesterov <oleg@redhat.com>,
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
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41190
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

On Mon, Jul 14, 2014 at 12:04 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Fri, Jul 11, 2014 at 10:55 AM, Kees Cook <keescook@chromium.org> wrote:
>> On Fri, Jul 11, 2014 at 9:49 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>> On 07/10, Kees Cook wrote:
>>>>
>>>> This adds the ability for threads to request seccomp filter
>>>> synchronization across their thread group (at filter attach time).
>>>> For example, for Chrome to make sure graphic driver threads are fully
>>>> confined after seccomp filters have been attached.
>>>>
>>>> To support this, locking on seccomp changes via thread-group-shared
>>>> sighand lock is introduced, along with refactoring of no_new_privs. Races
>>>> with thread creation are handled via delayed duplication of the seccomp
>>>> task struct field and cred_guard_mutex.
>>>>
>>>> This includes a new syscall (instead of adding a new prctl option),
>>>> as suggested by Andy Lutomirski and Michael Kerrisk.
>>>
>>> I do not not see any problems in this version,
>>
>> Awesome! Thank you for all the reviews. :) If Andy and Michael are
>> happy with this too, I think this is in good shape. \o/
>
> I think I'm happy with it.  Is it in git somewhere for easy perusal?
> I have a cold, so my reviewing ability is a bit off, but I want to
> take a look at the final version, and git is a little easier than
> email for this.

Yes, absolutely:
https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp-tsync

Thanks for looking it over, and I hope you feel better soon!

-Kees

-- 
Kees Cook
Chrome OS Security
