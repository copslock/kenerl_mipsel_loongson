Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 21:46:11 +0200 (CEST)
Received: from mail-oa0-f47.google.com ([209.85.219.47]:60534 "EHLO
        mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6855803AbaFXTqHTxITy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 21:46:07 +0200
Received: by mail-oa0-f47.google.com with SMTP id n16so924821oag.34
        for <linux-mips@linux-mips.org>; Tue, 24 Jun 2014 12:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=L1mNwd2GycbUNUcOZlOrKJTHj/gnnaI7n31XjcP5Fj4=;
        b=XE15McF039dyfHa3gskY1+XCTWpdkZHzCrskUSQF16n2vyzZwm7bZdRUZB8Yz67QhB
         XKH1yE3ghr24pYQFLHR+4fVZHJAMYqEKdNrT6KVMGOzUQayk8EL9D8Bky2UYGcNv4vU1
         tJKAuGbtX/svNDmAIH6CVjzGgK9FBg9vDGXjuS/N5Ji12GDgB71uIFNiH6Nf6SnDlxYq
         feJzJ/hrwTGq1UU6iujd94ii9sUYw0EwZwzUXiLFkOXCV0dzpY9uBlCvRF0iu9ECe7zw
         10VRMG+rDQPGiskpcPMjeBgtVe9PMo452YmfXza2yDquNjDy/Ab5d+8psFsNqPHe3n8t
         CtkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=L1mNwd2GycbUNUcOZlOrKJTHj/gnnaI7n31XjcP5Fj4=;
        b=UxBTKNz+0JSo7C68dtlnALd316Ihtl/yLdLoI4URlftf+kGrXleQpzt4bzgxxUY/6E
         +PmfS5OOa/4B7lIyHuEIkdzrtCsjDTRwkcy/oqtT6b09UhNYxIzjZOBXN6YwcDk5/wwQ
         PJP0O3DSKAfS/WvS+k+Wu+83O6FYjSWQ591/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=L1mNwd2GycbUNUcOZlOrKJTHj/gnnaI7n31XjcP5Fj4=;
        b=OAhA/9BCSQFk6l4nvbpqB6h96saDjKlKTf/L7jRHoxf/tIRd5ufESr7uHXZbualg6v
         Km8ct1f1mgvqXF2r63x5eM4u8M7FybhNZ4EMB8M/iZDtK+XhpJoLP/CdlsVnoREMk4IP
         c6/jrWhhdW7ClFu1DAKYP7+v/rakoH1R+bi+Rv8DmYaRohC0W2j6CvaWsBuGFzDjk5gy
         VzkWhSYgOiPaITh4DruYcO3eaAJ8TZt+rmcJhByBZAAvzn5+4A3oMgNIJo465GCjm69r
         WZqUT0nkfhuOM3PuCv1xvk6W7IB6s9EKG1MMiC1TDLjRb3IsU1GGcLNzfHvE6ro8/05Z
         IAZQ==
X-Gm-Message-State: ALoCoQlLLTzZ7Sz/r3N6GIiehnVWeEoy6efMeNVMcL+ekWME6GhEKGoN5CqGeydsQkfm9NLBseT2
MIME-Version: 1.0
X-Received: by 10.60.52.77 with SMTP id r13mr3070474oeo.55.1403639161203; Tue,
 24 Jun 2014 12:46:01 -0700 (PDT)
Received: by 10.182.63.80 with HTTP; Tue, 24 Jun 2014 12:46:01 -0700 (PDT)
In-Reply-To: <20140624183024.GA1258@redhat.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
        <1403560693-21809-4-git-send-email-keescook@chromium.org>
        <20140624183024.GA1258@redhat.com>
Date:   Tue, 24 Jun 2014 12:46:01 -0700
X-Google-Sender-Auth: DvLfigLX9yAwX06Up2bO3zGXK9Y
Message-ID: <CAGXu5j+Khz+HH3QvfNWa3FdUspTEf-xLchBMLyCC_QN42xpLZA@mail.gmail.com>
Subject: Re: [PATCH v7 3/9] seccomp: introduce writer locking
From:   Kees Cook <keescook@chromium.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
X-archive-position: 40769
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

On Tue, Jun 24, 2014 at 11:30 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> I am puzzled by the usage of smp_load_acquire(),

It was recommended by Andy Lutomirski in preference to ACCESS_ONCE().

> On 06/23, Kees Cook wrote:
>>
>>  static u32 seccomp_run_filters(int syscall)
>>  {
>> -     struct seccomp_filter *f;
>> +     struct seccomp_filter *f = smp_load_acquire(&current->seccomp.filter);
>>       struct seccomp_data sd;
>>       u32 ret = SECCOMP_RET_ALLOW;
>>
>>       /* Ensure unexpected behavior doesn't result in failing open. */
>> -     if (WARN_ON(current->seccomp.filter == NULL))
>> +     if (WARN_ON(f == NULL))
>>               return SECCOMP_RET_KILL;
>>
>>       populate_seccomp_data(&sd);
>> @@ -186,9 +186,8 @@ static u32 seccomp_run_filters(int syscall)
>>        * All filters in the list are evaluated and the lowest BPF return
>>        * value always takes priority (ignoring the DATA).
>>        */
>> -     for (f = current->seccomp.filter; f; f = f->prev) {
>> +     for (; f; f = smp_load_acquire(&f->prev)) {
>>               u32 cur_ret = SK_RUN_FILTER(f->prog, (void *)&sd);
>> -
>>               if ((cur_ret & SECCOMP_RET_ACTION) < (ret & SECCOMP_RET_ACTION))
>>                       ret = cur_ret;
>
> OK, in this case the 1st one is probably fine, altgough it is not
> clear to me why it is better than read_barrier_depends().
>
> But why do we need a 2nd one inside the loop? And if we actually need
> it (I don't think so) then why it is safe to use f->prog without
> load_acquire ?

You're right -- it should not be possible for for any of the ->prev
pointers to change.

>>  void get_seccomp_filter(struct task_struct *tsk)
>>  {
>> -     struct seccomp_filter *orig = tsk->seccomp.filter;
>> +     struct seccomp_filter *orig = smp_load_acquire(&tsk->seccomp.filter);
>>       if (!orig)
>>               return;
>
> This one looks unneeded.
>
> First of all, afaics atomic_inc() should work correctly without any barriers,
> otherwise it is buggy. But even this doesn't matter.
>
> With this changes get_seccomp_filter() must be called under ->siglock, it can't
> race with add-filter and thus tsk->seccomp.filter should be stable.

Excellent point, yes. I'll remove that.

>>       /* Reference count is bounded by the number of total processes. */
>> @@ -361,7 +364,7 @@ void put_seccomp_filter(struct task_struct *tsk)
>>       /* Clean up single-reference branches iteratively. */
>>       while (orig && atomic_dec_and_test(&orig->usage)) {
>>               struct seccomp_filter *freeme = orig;
>> -             orig = orig->prev;
>> +             orig = smp_load_acquire(&orig->prev);
>>               seccomp_filter_free(freeme);
>>       }
>
> This one looks unneeded too. And note that this patch does not add
> smp_load_acquire() to read tsk->seccomp.filter.

Hrm, yes, that should get added.

> atomic_dec_and_test() adds mb(), we do not need more barriers to access
> ->prev ?

Right, same situation as the run_filters loop. Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
