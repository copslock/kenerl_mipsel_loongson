Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2014 19:02:17 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34415 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816676AbaG2RCN1UJDR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2014 19:02:13 +0200
Received: by mail-lb0-f177.google.com with SMTP id s7so6978877lbd.8
        for <linux-mips@linux-mips.org>; Tue, 29 Jul 2014 10:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=3ozsNUn3dVZ874+GK/hntWHe+LITNyA26i4fD3XqLKc=;
        b=cs1JduRh92BJhS++1n7txkKg6g0TG0GwVpcbKpiBwBWwtDKZTYsBrXIgdYe1S+bIJ3
         Xlif/rWN5XLrOyBSE8ltxdvZUnkg3kVnRQW4t5RN3KtVV/Zi1/bkCFf+0o8MGMCPawFQ
         Xjmx5rsY6HSsuDaTGv0iFeTErzbyXWN5GFPzUcIye9xZJY7R2O+Eq3AC2dzvnkhzriDR
         l3Cuvc9Zygh8NPFMhe5ew3fjsYWJkmJ2dZ+oBf8DXsXamFqyHfekyiQz7yO28MGtjyhe
         wX86aklh1xi0Xxmyok+deQtsGtgaPneP+zm21k3oZldM9hkTQs4UOaWZ19/qvUM+gNZQ
         3oLg==
X-Gm-Message-State: ALoCoQm6LWBfFl3LKVWpVYX3Gh9QuGs2U7w1/drfrv03UYT6sVeQiWMcDodtg7LGctG+lD9gIcNo
X-Received: by 10.152.29.202 with SMTP id m10mr3965539lah.4.1406653327454;
 Tue, 29 Jul 2014 10:02:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.36.106 with HTTP; Tue, 29 Jul 2014 10:01:47 -0700 (PDT)
In-Reply-To: <20140729165416.GA967@redhat.com>
References: <cover.1405992946.git.luto@amacapital.net> <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net>
 <20140728173723.GA20993@redhat.com> <CALCETrWUFo_zXcAZja-vdL4_MgJDd=1ed5Vt54eyUuim930xAw@mail.gmail.com>
 <20140729165416.GA967@redhat.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 29 Jul 2014 10:01:47 -0700
Message-ID: <CALCETrWBU-=zqLTCP7B1feZ9J-e4u-Boic+e1EEn1rL-ijeEKg@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] x86: Split syscall_trace_enter into two phases
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41791
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

On Tue, Jul 29, 2014 at 9:54 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 07/28, Andy Lutomirski wrote:
>>
>> On Mon, Jul 28, 2014 at 10:37 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>> > Hi Andy,
>> >
>> > I am really sorry for delay.
>> >
>> > This is on top of the recent change from Kees, right? Could me remind me
>> > where can I found the tree this series based on? So that I could actually
>> > apply these changes...
>>
>> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
>>
>> The first four patches are already applied there.
>
> Thanks!
>
>> > If I understand correctly, syscall_trace_enter() can avoid _phase2() above.
>> > But we should always call user_exit() unconditionally?
>>
>> Damnit.  I read that every function called by user_exit, and none of
>> them give any indication of why they're needed for traced syscalls but
>> not for untraced syscalls.  On a second look, it seems that TIF_NOHZ
>> controls it.
>
> Yes, just to trigger the slow path, I guess.
>
>> I'll update the code to call user_exit iff TIF_NOHZ is
>> set.
>
> Or perhaps it would be better to not add another user of this (strange) flag
> and just call user_exit() unconditionally(). But, yes, you need to use
> from "work = flags & (_TIF_WORK_SYSCALL_ENTRY & ~TIF_NOHZ)" then.\

user_exit looks slow enough to me that a branch to try to avoid it may
be worthwhile.  I bet that explicitly checking the flag is
actually both faster and clearer.  That's what I did for v4.

--Andy

>
>> > And we should always set X86_EFLAGS_TF if TIF_SINGLESTEP? IIRC, TF can be
>> > actually cleared on a 32bit kernel if we step over sysenter insn?
>>
>> I don't follow.  If TIF_SINGLESTEP, then phase1 will return a nonzero
>> value,
>
> Ah yes, thanks, I missed this.
>
> Oleg.
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
