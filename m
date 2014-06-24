Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 21:18:38 +0200 (CEST)
Received: from mail-oa0-f41.google.com ([209.85.219.41]:64466 "EHLO
        mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6854975AbaFXTSepgEpb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 21:18:34 +0200
Received: by mail-oa0-f41.google.com with SMTP id l6so885437oag.28
        for <linux-mips@linux-mips.org>; Tue, 24 Jun 2014 12:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5IQ/gyoX/kkCXBX+F9DKgnxHehj/YdAgSWYcA9uKdc8=;
        b=We7sheRUKNBumjPQqv6dKb4S8TykY4nPh8wfiPmuCbqd9zltTDUwS5d7VLT0TRHts4
         PoEd0JrQB1/raQXRJIB6bBOPGNGfEQCblzPEh1wE1eD1Seet0J92J7rjDJ9yl1Ht3/Dm
         kRFJDH1YQDj2hL+DODpGYUROfRYUcHMms4ImF7BtFzG2akcjatmfW8XzTq7xqcrvSleK
         zj0AQ2Kb27gzQ5HXX4Tv+TdKIgzOHOKPR9vhqsYe+NTxdqpTSynRj+idbvsR39VMI7gK
         QqKxbVMAaaeiqJ0KP/snCTjdhNHmybPvcgz3TmB8cv/eXB+n7pieYddcy73L33vr8Kq+
         ml3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=5IQ/gyoX/kkCXBX+F9DKgnxHehj/YdAgSWYcA9uKdc8=;
        b=O25Id20iWfHrNkZ5HyUvaWpyPXPeyiNcY+O9U8REKlWhy3irCaPXiyMNz5mua3pMpj
         etFeZyS6G0RnC8ID9Xq9P5LbLEuaGj3c50wUDd1mjUj8eE798Kjg/sJanePMeYl+W04s
         GIA7GvX5lcyD77Psdip7++9NmsDV9uc+C+2VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5IQ/gyoX/kkCXBX+F9DKgnxHehj/YdAgSWYcA9uKdc8=;
        b=clUNXtA5PsYhbFetDxwN6V+rzHTZnWkZIXiHTHuMr8HauYKsn/YOk0C4L220nysfCm
         Iu1HGL1GT4gCPw3SwmrcrKgIHzr00AIuhC6T4YcbgHmGp7JvcgUNedUlgiYcCOED0P0V
         4xHd41Sv0JR4MD0gsj3uVXZa2hGtH3Gvncqvcl3afCyYlrEKjFJjP9jq8xWIP6XUDTzY
         zzrAOAtNoJLfW6RzBWCYQ7FGXR2qg/bdRCCHRY9MakKSpFTNLBtnaUbDUHRx9R7ASCmL
         24bHuxTk1SvujymZwE5VxJ0RVlzAJrwPSvnssG43jRlIZTpG7eDCnuHBQ4Bkq32lANCS
         j8Rw==
X-Gm-Message-State: ALoCoQmZTKgnVAK81Rj5sw/qOt1WBy9LJRdKGrMPEk3gDbGjrpNwceji1P19BNsXaeSTpqdGMsXg
MIME-Version: 1.0
X-Received: by 10.60.52.77 with SMTP id r13mr2902409oeo.55.1403637505971; Tue,
 24 Jun 2014 12:18:25 -0700 (PDT)
Received: by 10.182.63.80 with HTTP; Tue, 24 Jun 2014 12:18:25 -0700 (PDT)
In-Reply-To: <CALCETrV=nAuWi8_Xj6KnJ6P1Yiaw36+n50-gHKaTgea4yH85Eg@mail.gmail.com>
References: <1403560693-21809-1-git-send-email-keescook@chromium.org>
        <20140623220150.GM5412@outflux.net>
        <CALCETrV=nAuWi8_Xj6KnJ6P1Yiaw36+n50-gHKaTgea4yH85Eg@mail.gmail.com>
Date:   Tue, 24 Jun 2014 12:18:25 -0700
X-Google-Sender-Auth: JX7tRFJh7_m8ndSDjRqFzOyR43o
Message-ID: <CAGXu5j+E1DVp+BDwTaTdexcOhPC=COE+uHXtj7yGdi2ewkrTTA@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] man-pages: seccomp.2: document syscall
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Linux API <linux-api@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40763
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

On Tue, Jun 24, 2014 at 11:06 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Mon, Jun 23, 2014 at 3:01 PM, Kees Cook <keescook@chromium.org> wrote:
>> Combines documentation from prctl, and in-kernel seccomp_filter.txt,
>> along with new details specific to the new syscall.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  man2/seccomp.2 |  333 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 333 insertions(+)
>>  create mode 100644 man2/seccomp.2
>>
>> diff --git a/man2/seccomp.2 b/man2/seccomp.2
>> new file mode 100644
>> index 0000000..de7fbf7
>> --- /dev/null
>> +++ b/man2/seccomp.2
>> @@ -0,0 +1,333 @@
>> +.\" Copyright (C) 2014 Kees Cook <keescook@chromium.org>
>> +.\" and Copyright (C) 2012 Will Drewry <wad@chromium.org>
>> +.\" and Copyright (C) 2008 Michael Kerrisk <mtk.manpages@gmail.com>
>> +.\"
>> +.\" %%%LICENSE_START(VERBATIM)
>> +.\" Permission is granted to make and distribute verbatim copies of this
>> +.\" manual provided the copyright notice and this permission notice are
>> +.\" preserved on all copies.
>> +.\"
>> +.\" Permission is granted to copy and distribute modified versions of this
>> +.\" manual under the conditions for verbatim copying, provided that the
>> +.\" entire resulting derived work is distributed under the terms of a
>> +.\" permission notice identical to this one.
>> +.\"
>> +.\" Since the Linux kernel and libraries are constantly changing, this
>> +.\" manual page may be incorrect or out-of-date.  The author(s) assume no
>> +.\" responsibility for errors or omissions, or for damages resulting from
>> +.\" the use of the information contained herein.  The author(s) may not
>> +.\" have taken the same level of care in the production of this manual,
>> +.\" which is licensed free of charge, as they might when working
>> +.\" professionally.
>> +.\"
>> +.\" Formatted or processed versions of this manual, if unaccompanied by
>> +.\" the source, must acknowledge the copyright and authors of this work.
>> +.\" %%%LICENSE_END
>> +.\"
>> +.TH SECCOMP 2 2014-06-23 "Linux" "Linux Programmer's Manual"
>> +.SH NAME
>> +seccomp \-
>> +operate on Secure Computing state of the process
>> +.SH SYNOPSIS
>> +.nf
>> +.B #include <linux/seccomp.h>
>> +.B #include <linux/filter.h>
>> +.B #include <linux/audit.h>
>> +.B #include <linux/signal.h>
>> +.B #include <sys/ptrace.h>
>> +
>> +.BI "int seccomp(unsigned int " operation ", unsigned int " flags ,
>> +.BI "            unsigned char *" args );
>
> At the very least, shouldn't this be void *args?

Yeah, good point. Fixed for the next version...

-Kees

-- 
Kees Cook
Chrome OS Security
