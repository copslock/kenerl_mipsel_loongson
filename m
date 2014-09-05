Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 23:14:47 +0200 (CEST)
Received: from mail-la0-f46.google.com ([209.85.215.46]:40437 "EHLO
        mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008229AbaIEVOqZB007 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 5 Sep 2014 23:14:46 +0200
Received: by mail-la0-f46.google.com with SMTP id pv20so14608824lab.19
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 14:14:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=xp1gJxjemus0Dr3zJO6MFFdbFIMvVhpOCF1W6UaARrc=;
        b=KK1o5b2wsxqgnHNqK4o59XCqwvPDJsLrq6xFAzvwOc/dXz7HQcq4XO3tFbTlt+cDU6
         S2l0kRwSkul5r6hl5Xw4yViW0EkLeLRRrOO7/nHL1UXwqx/dJZgKzqXTKPAwyvDQrNfQ
         wLF4x5HIxs0aNUznlPWIUXAl9MdDEYPPEET12KCeYBsolEi4sYxW83jVsg9pubTGQ7nF
         /P5pDbscwKrMPA49joimDmVnOAqtnxiIfg49qHDGDWROJtiNqqLNn4zcSqvY0Qk1OOjR
         Q5wM/GhJxT2qcF9VajUzk00Esonrtenj7IPn3LinSPTZBwC009Sv6ZWv9jcd15oz/sY8
         XaZA==
X-Gm-Message-State: ALoCoQmYDbSZSAZhfbHLKw2cYzWY0qrGZmAWlRx8hoZ+suObbrWslVobs9YcpAgw/+2Y5slzyZb9
X-Received: by 10.152.163.199 with SMTP id yk7mr14264521lab.85.1409951680748;
 Fri, 05 Sep 2014 14:14:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.36.106 with HTTP; Fri, 5 Sep 2014 14:14:20 -0700 (PDT)
In-Reply-To: <540A2080.8050404@zytor.com>
References: <CALCETrUaZ8w92g96SmFEZDE0Jr+0Moeo+S24-TyW8crrK5reSg@mail.gmail.com>
 <540A1800.3000005@zytor.com> <540A2080.8050404@zytor.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 5 Sep 2014 14:14:20 -0700
Message-ID: <CALCETrXFD=D=W6pjQfhzzWU-ZOZzkJ=ZMxF5=sKxFx7NAg7xng@mail.gmail.com>
Subject: Re: Post-merge-window ping (Re: [PATCH v4 0/5] x86: two-phase syscall
 tracing and seccomp fastpath)
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42453
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

On Fri, Sep 5, 2014 at 1:43 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 09/05/2014 01:07 PM, H. Peter Anvin wrote:
>> On 08/26/2014 06:32 PM, Andy Lutomirski wrote:
>>> On Mon, Jul 28, 2014 at 8:38 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>>> This applies to:
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git seccomp-fastpath
>>>>
>>>> Gitweb:
>>>> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
>>>
>>> Hi all-
>>>
>>> AFAIK the only thing that's changed since I submitted it is that the
>>> 3.17 merge window is closed.  Kees rebased the tree this applies to,
>>> but I think the patches all still apply.  What, if anything, do I need
>>> to do to help this along for 3.18?
>>>
>>
>> Just put this stuff in a branch and running through my personal test
>> battery now.
>>
>
> ... and they fail build testing.  Specifically, both i386 and x86-64
> allnoconfig fail with:

OK, that's embarrassing.  Also, this has been sitting on
git.kernel.org forever and kbuild never spotted it either.  Hmm.

Anyway, updates coming.

--Andy

>
> arch/x86/kernel/ptrace.c: In function ‘syscall_trace_enter_phase2’:
>   LD      fs/quota/built-in.o
> ../arch/x86/kernel/ptrace.c:1579:2: error: implicit declaration of
> function ‘seccomp_phase2’ [-Werror=implicit-function-declaration]
>   if (phase1_result > 1 && seccomp_phase2(phase1_result)) {
>   ^
> cc1: some warnings being treated as errors
>   CC      arch/x86/kernel/step.o
> make[4]: *** [arch/x86/kernel/ptrace.o] Error 1
>
>         -hpa
>
>



-- 
Andy Lutomirski
AMA Capital Management, LLC
