Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2014 20:23:19 +0200 (CEST)
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33359 "EHLO
        mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861102AbaGPSXRoVL8J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2014 20:23:17 +0200
Received: by mail-ie0-f171.google.com with SMTP id at1so1156382iec.30
        for <linux-mips@linux-mips.org>; Wed, 16 Jul 2014 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=D4CINuHNceuhWe2aU2FVGgYjOsuPL4AC+7e3ZccUnsQ=;
        b=aDu9gp6Pj4lL3MqJx2sOUXut72jolkU0gTo0jzlQ87rupRy8lFVPXy3NFUBtBZ0IVf
         Jhk/uegyey/iDYMgpWgi2cp5xrQvUqX3V1v/ydn+CJ1FOo5M8gedV2M7fzSqEs4KvQbZ
         CXQy04vGWAi9RJA7fH4fbMaRG7aqSjvuOqR3pLuZn29eOn7mD9C37TaggwHjXu5Pz6Tn
         WNfnpbL+TCwsj5Ra7YkUf8+dIHea/eYI/3jp6g3bZn42xMgroTr2tVWWveO7bl9i7TIX
         n/QUr4bEt40MuD8YOI2BbzgeJr73qm6NL5gzyHYgBSiVuo5+jVy02dwDmpSCEDoH3Bma
         jyvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=D4CINuHNceuhWe2aU2FVGgYjOsuPL4AC+7e3ZccUnsQ=;
        b=kKI+15+SuQQx+jVF+YglRN4fFlRnKivJvsIFwGvTnlN9F8dGhsLS5cRxrhr4k2irm+
         8w+Lg4y+X6xzckIntuV+SjBJw9siBwkrpKFepUpENaYTtkB2yk2ewnO5AgxxFljIRelZ
         JcqKFdt5s0pyequK7bkQ3/qJMKqv4vpJWTxg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=D4CINuHNceuhWe2aU2FVGgYjOsuPL4AC+7e3ZccUnsQ=;
        b=J639jNmfgLjWXZInpAoDQRDdkin3ltntLm3Uy4zgFSk5eM9fsRKll0SCeyJ8f977gT
         Iqg7rY7Eo9vpDZ7Zy5RafnXEPkRVkAmBy/lCVKQmYglx3R3HhmnUNkgrhn9XZjkPKbPN
         oeQ/S/P1JJDvgOSJ2LTFSgCuKVVFqfYg46GolG2rwiU6VOhN9JLWQK1UHi8jBAQgNXU7
         +T83VM4234uzHeumDPKbfY5OFj8mR0HAqsp+VKkUmEkG3GyvsNqCStWrQmZfqofLgpc2
         d7juBvvxJ4FHeb6Blm8GKP/JqGwD3ji+lBdvaohRE9Bk3hPhJS87ETYiKLe2c55PeQY7
         yo1g==
X-Gm-Message-State: ALoCoQlH5NCEzJ7wVPIQdv72qVL4iKxe7IJiDkJQj81/l2yVCkV82X17nVSKRfCayZvSXSgfjiFF
MIME-Version: 1.0
X-Received: by 10.60.70.205 with SMTP id o13mr37658305oeu.38.1405533278191;
 Wed, 16 Jul 2014 10:54:38 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Wed, 16 Jul 2014 10:54:38 -0700 (PDT)
In-Reply-To: <CALCETrVXgA9a2f7VwnCYW4_XB+JAPRSR8xsuH_ZYbA82=ZozRw@mail.gmail.com>
References: <1405017631-27346-1-git-send-email-keescook@chromium.org>
        <20140711164931.GA18473@redhat.com>
        <CAGXu5jK-x0=Rr7kX2a=b4Z8ueA77uwmhNZZAayG8cwmNOKa8Ug@mail.gmail.com>
        <CALCETrVXgA9a2f7VwnCYW4_XB+JAPRSR8xsuH_ZYbA82=ZozRw@mail.gmail.com>
Date:   Wed, 16 Jul 2014 10:54:38 -0700
X-Google-Sender-Auth: KV_u_iHFw9rjTZrhARfqeCQroVA
Message-ID: <CAGXu5j+r-CpJiXipCT=j09+ZfJjF9jTc3kuZFAH3ZxgUEvktTA@mail.gmail.com>
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
X-archive-position: 41229
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

Hi Andy,

Have you had a chance to look v10 over? I'd like to send a v11 with
Oleg's Reviewed-by added (at James Morris's request). Should I add one
from you as well?

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
