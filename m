Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 Jun 2014 23:53:45 +0200 (CEST)
Received: from mail-ob0-f172.google.com ([209.85.214.172]:46008 "EHLO
        mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843091AbaFMVxncXIuG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 Jun 2014 23:53:43 +0200
Received: by mail-ob0-f172.google.com with SMTP id uy5so3448538obc.3
        for <linux-mips@linux-mips.org>; Fri, 13 Jun 2014 14:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Cvd41i5S1ZeYSIMTcOqPGqQfKGdYbmMOQISgXGVcd88=;
        b=YnRj1ubfamXqBgPbq8Ro4ZeirfnJEmLnjh68blkbQ7F/dy9GhrIJ+58ZongAspZg5K
         1IfZnRfbUN1K09SOcIJzbNd+CPBpCaXKg4Dg8RzsHQ42CDXYJTXX7mXvKTzFGQFYOmww
         kEqpypNcxsJiyuC8cqw9AFKFPyx1tMVL9BkYbMi0CzIbEeLTws9Ii27uEUu6fhKHAbL6
         y5z72ZIug/Yqm8sjGHFStYogWqTc7NtdMAGoOwtwQ9xLUP733qNFNFPpPTIdqumTHMdU
         dsQ7U1oYg2X7VM1icxb6bNTQYpShvd9CC9QZaFzyWq83kIPHpxRUhvd+qbJ0qRDkzYBK
         HgcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Cvd41i5S1ZeYSIMTcOqPGqQfKGdYbmMOQISgXGVcd88=;
        b=YdVLJPy5ZQiY3+uMWH0pfQvuwllwhv/ebxE3bjmN3S9iZkKpNqd1qbK+K1pZnBdIbv
         YVg5V/jSpMfI7u1AAqliUfp3xrADZ0wWuiybsYVAZyer++Ov5LTh1nPm+Cwu/znVx94a
         CfJBL8m6wk+IRLUXPJWB694Lz9fOe+PEJ2xTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Cvd41i5S1ZeYSIMTcOqPGqQfKGdYbmMOQISgXGVcd88=;
        b=Looxnrke5PtP63z5AsmROAKMSJ6FJsgqChZFUZrYgepDIAXY0GLomB2w/iNgd+znjI
         1+xGEyGAIBGqP3m7bX8NeAUcJFzBKOv0E5nUJKmzrYRB5gJlKPHbyMgFcqbk2+tbPuNa
         Xyn7uzpVvIdoGX0AXfRo4umeSaJgiGDmJzohNNWJLY/d8wc3F75b8He4WZeyZkyknPaX
         Jl72hWIXjc7hulFKhLb8QFqIKxwmtYn/Fb9oLeliBC2rB1Emy1Bu7pNQhxsqJdphf0Md
         IlyJVCd8bO8rCvsQp6s0t+9VLbMJN07WAK3WLX+d8CwQ+yAvH/MNOQP/mJ9vQPGoZ9jt
         bZgQ==
X-Gm-Message-State: ALoCoQmG62JE2ACnB9tpHx4/+YKFG8L3Onmq+Crkj2BADmyt4oGgkuKgY2kGGRFCvwlPDHTbUguZ
MIME-Version: 1.0
X-Received: by 10.182.95.100 with SMTP id dj4mr4987573obb.87.1402696417087;
 Fri, 13 Jun 2014 14:53:37 -0700 (PDT)
Received: by 10.182.63.80 with HTTP; Fri, 13 Jun 2014 14:53:37 -0700 (PDT)
In-Reply-To: <CAMEtUuwKRUYN_qdnCj42G3Z1UT3vMYPoJqXd2_PjV+_J3WA+8w@mail.gmail.com>
References: <1402457121-8410-1-git-send-email-keescook@chromium.org>
        <1402457121-8410-7-git-send-email-keescook@chromium.org>
        <CAMEtUuwKRUYN_qdnCj42G3Z1UT3vMYPoJqXd2_PjV+_J3WA+8w@mail.gmail.com>
Date:   Fri, 13 Jun 2014 14:53:37 -0700
X-Google-Sender-Auth: sexcRDaW_cNzEnCzgNZJNOiBu1I
Message-ID: <CAGXu5jJjq=Yw4+fax6nEKyLxKR4N9wd5ReNgU+bUb266GFUEgw@mail.gmail.com>
Subject: Re: [PATCH v6 6/9] seccomp: add "seccomp" syscall
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <ast@plumgrid.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
X-archive-position: 40520
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

On Fri, Jun 13, 2014 at 2:22 PM, Alexei Starovoitov <ast@plumgrid.com> wrote:
> On Tue, Jun 10, 2014 at 8:25 PM, Kees Cook <keescook@chromium.org> wrote:
>> This adds the new "seccomp" syscall with both an "operation" and "flags"
>> parameter for future expansion. The third argument is a pointer value,
>> used with the SECCOMP_SET_MODE_FILTER operation. Currently, flags must
>> be 0. This is functionally equivalent to prctl(PR_SET_SECCOMP, ...).
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> Cc: linux-api@vger.kernel.org
>> ---
>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> index b0881a0ed322..1713977ee26f 100644
>> --- a/include/linux/syscalls.h
>> +++ b/include/linux/syscalls.h
>> @@ -866,4 +866,6 @@ asmlinkage long sys_process_vm_writev(pid_t pid,
>>  asmlinkage long sys_kcmp(pid_t pid1, pid_t pid2, int type,
>>                          unsigned long idx1, unsigned long idx2);
>>  asmlinkage long sys_finit_module(int fd, const char __user *uargs, int flags);
>> +asmlinkage long sys_seccomp(unsigned int op, unsigned int flags,
>> +                           const char __user *uargs);
>
> It looks odd to add 'flags' argument to syscall that is not even used.

FWIW, "flags" is given use in the next patch to support the tsync option.

-Kees

-- 
Kees Cook
Chrome OS Security
