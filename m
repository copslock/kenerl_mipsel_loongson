Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jul 2014 21:05:00 +0200 (CEST)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:59978 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815921AbaGNTE7CSYKA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Jul 2014 21:04:59 +0200
Received: by mail-lb0-f180.google.com with SMTP id w7so3095087lbi.25
        for <linux-mips@linux-mips.org>; Mon, 14 Jul 2014 12:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=d8xZ7+7UkIxRic1Dxlu6MlBzMd9urkJ/Lo1Vqk6DRcc=;
        b=AxbgZ4GOeczzaseE4Bj9HhDx21jpcayFxJ7a+FEoUmzMWYP5c7NjN/XspdwL0kBdM8
         BCHSjiuIvWiBzeeOuFwtyNz7ShmOuMt/Uip3LReVbPoUv9Yq4nwYu+Tuqqt23zpZO6GM
         5BVTen5sUBS3vpMvOL31erpK9GdrUntwAGqXIPRtKfd9RXqWo/eOL6dazU8P4C4RPLhb
         yKOeiypZ+s8TesEYf1fm7FjmjyCtC8IIuPOVx/YXPCUcANeqgWpI3iCdE9wvtp4KjqN8
         UrCh9PQ1CydUaWrDvf4JgHWh1K9Z2bt3Y2dwL6O1xu+/GTBc+oRo67EHiCf0c6JVxpZy
         GJYw==
X-Gm-Message-State: ALoCoQmfQbzIWA3EyHwSeLpODZSJviRZ56Q5r40DX4XxL9V3aKIVAG9gjA+wSdIZlJ260kMICUq8
X-Received: by 10.112.180.70 with SMTP id dm6mr14836930lbc.32.1405364693370;
 Mon, 14 Jul 2014 12:04:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Mon, 14 Jul 2014 12:04:33 -0700 (PDT)
In-Reply-To: <CAGXu5jK-x0=Rr7kX2a=b4Z8ueA77uwmhNZZAayG8cwmNOKa8Ug@mail.gmail.com>
References: <1405017631-27346-1-git-send-email-keescook@chromium.org>
 <20140711164931.GA18473@redhat.com> <CAGXu5jK-x0=Rr7kX2a=b4Z8ueA77uwmhNZZAayG8cwmNOKa8Ug@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 14 Jul 2014 12:04:33 -0700
Message-ID: <CALCETrVXgA9a2f7VwnCYW4_XB+JAPRSR8xsuH_ZYbA82=ZozRw@mail.gmail.com>
Subject: Re: [PATCH v10 0/11] seccomp: add thread sync ability
To:     Kees Cook <keescook@chromium.org>
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
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41189
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

I think I'm happy with it.  Is it in git somewhere for easy perusal?
I have a cold, so my reviewing ability is a bit off, but I want to
take a look at the final version, and git is a little easier than
email for this.

--Andy
