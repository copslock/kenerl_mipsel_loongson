Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Feb 2015 00:49:16 +0100 (CET)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:42662 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012700AbbBEXtOeDtSv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Feb 2015 00:49:14 +0100
Received: by mail-ob0-f177.google.com with SMTP id wp18so9852759obc.8
        for <linux-mips@linux-mips.org>; Thu, 05 Feb 2015 15:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hJsYoA/iSeaF6hUQ6nza2OK89ydIZSPWcYlrPzyjbDY=;
        b=ZYiuEh/Fidl0t2hOAJXaRftphzF2x4FZ+oIRuzUx9zZfUlMMABOkhsCt/3VwKU9QgD
         91HFPnrflBnWKd7/yEHqiL5QJxAa0uPqfBWmjGBexASuGoQO9pZQeYnhn6xE3fyZTcZQ
         B7/dtwFQcQFiNGeQEOdFRxW2jjg2x9bUtRWBhhMlK0DIzfAj+BLqIviRSwSVp6AWXx0x
         uBqJvGh3Pu3ORrqbPC0GiWF2gRsAtDwAiLTi1MALYSQZSIks6zZ7jPV2snJZycrm2pt/
         kd38CrglPaJqIKd2PIh1jKo0xRalz65EAVfcxFxtOnuuQIUFORIsFqbJWpCqK8QJFeqQ
         gIuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hJsYoA/iSeaF6hUQ6nza2OK89ydIZSPWcYlrPzyjbDY=;
        b=SLQhYpfbk8YGOWGFlfYp2r7eCakmIs3ZB20nNQe4c7WcGKF7DgQs3hSLxRVrZWFs/O
         5SAA16mxpeuRuWuZ2sER7XdUVc+2ebji4Ka3imCXdgKtncKBbek9ICn0lSuyqIK/lT6S
         VOhscQYU3Bf9bZwif+KWLS8gedPUrL3Fto3kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hJsYoA/iSeaF6hUQ6nza2OK89ydIZSPWcYlrPzyjbDY=;
        b=g6akT+mSKReEIB9Z19dY9uiKXsF9FrXQVXg12CzpHYWPhKUGXL0EtYXGje+D4Tr+U+
         ldtpSzaChOP34iqzEK4caq2yLmHqldr8okYvlzeN8kU++TpvFId9OxQ0QZHZQ815p8Oy
         KcpSwl2lmNhp54Dsd0zbDwuavH8P4XuQx0xT8FHDlJ7Hu93OtefY40r18aDbEd7UZSMU
         lu14w5lIzFWe53h1JZln5um0dJ91VrXMaMD5LfNCLnqug4i9zA/j20krLhBWoNtrEXRa
         Xq105Q9fTy2uGPWpI8JFG9jv9v8lLYYBDEsXZQUTUsZx23Mm9xYgU96+BxDLDWZJgPqQ
         moVQ==
X-Gm-Message-State: ALoCoQmMe5JXhHXffIWzb8dQZrxqzIzziNTWZ/i1xHwnMdkH1oqHoj3meAi6s1zFHv7jEjEZKza4
MIME-Version: 1.0
X-Received: by 10.202.214.210 with SMTP id n201mr510072oig.38.1423180148623;
 Thu, 05 Feb 2015 15:49:08 -0800 (PST)
Received: by 10.182.87.201 with HTTP; Thu, 5 Feb 2015 15:49:08 -0800 (PST)
In-Reply-To: <20150205233945.GA31540@altlinux.org>
References: <cover.1409954077.git.luto@amacapital.net>
        <2df320a600020fda055fccf2b668145729dd0c04.1409954077.git.luto@amacapital.net>
        <20150205211916.GA31367@altlinux.org>
        <CAGXu5j+aXxt55LsxxbNkfGGF719ubXBZ2JAFwUPNARwKMVFgng@mail.gmail.com>
        <20150205214027.GB31367@altlinux.org>
        <CALCETrXFzcXngHsX=_72hYZqms32Zf7oFYDBgC3XNw7zOGdDCA@mail.gmail.com>
        <CAGXu5jJtHT9o8WMoynifN13=uZoARt4G9iVcgZsc9xYOBEwWsg@mail.gmail.com>
        <20150205233945.GA31540@altlinux.org>
Date:   Thu, 5 Feb 2015 15:49:08 -0800
X-Google-Sender-Auth: zKlYstbER-AufXXEn3I33pj2cwA
Message-ID: <CAGXu5jLTH+mUF0JxeR2qA_r=ocWjPHPSK2OPgE0Fu_JKoQyQ9w@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] x86: Split syscall_trace_enter into two phases
From:   Kees Cook <keescook@chromium.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@plumgrid.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45743
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

On Thu, Feb 5, 2015 at 3:39 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> On Thu, Feb 05, 2015 at 03:12:39PM -0800, Kees Cook wrote:
>> On Thu, Feb 5, 2015 at 1:52 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> > On Thu, Feb 5, 2015 at 1:40 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>> >> On Thu, Feb 05, 2015 at 01:27:16PM -0800, Kees Cook wrote:
>> >>> On Thu, Feb 5, 2015 at 1:19 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
>> >>> > Hi,
>> >>> >
>> >>> > On Fri, Sep 05, 2014 at 03:13:54PM -0700, Andy Lutomirski wrote:
>> >>> >> This splits syscall_trace_enter into syscall_trace_enter_phase1 and
>> >>> >> syscall_trace_enter_phase2.  Only phase 2 has full pt_regs, and only
>> >>> >> phase 2 is permitted to modify any of pt_regs except for orig_ax.
>> >>> >
>> >>> > This breaks ptrace, see below.
>> >>> >
> [...]
>> >>> >> +             ret = seccomp_phase1(&sd);
>> >>> >> +             if (ret == SECCOMP_PHASE1_SKIP) {
>> >>> >> +                     regs->orig_ax = -1;
>> >>> >
>> >>> > How the tracer is expected to get the correct syscall number after that?
>> >>>
>> >>> There shouldn't be a tracer if a skip is encountered. (A seccomp skip
>> >>> would skip ptrace.) This behavior hasn't changed, but maybe I don't
>> >>> see what you mean? (I haven't encountered any problems with syscall
>> >>> tracing as a result of these changes.)
>> >>
>> >> SECCOMP_RET_ERRNO leads to SECCOMP_PHASE1_SKIP, and if there is a tracer,
>> >> it will get -1 as a syscall number.
>> >>
>> >> I've found this while testing a strace parser for
>> >> SECCOMP_MODE_FILTER/SECCOMP_SET_MODE_FILTER, so the problem is quite real.
>> >
>> > Hasn't it always been this way?
>>
>> As far as I know, yes, it's always been this way. The point is to the
>> skip the syscall, which is what the -1 signals. Userspace then reads
>> back the errno.
>
> There is a clear difference: before these changes, SECCOMP_RET_ERRNO used
> to keep the syscall number unchanged and suppress syscall-exit-stop event,
> which was awful because userspace cannot distinguish syscall-enter-stop
> from syscall-exit-stop and therefore relies on the kernel that
> syscall-enter-stop is followed by syscall-exit-stop (or tracee's death, etc.).
>
> After these changes, SECCOMP_RET_ERRNO no longer causes syscall-exit-stop
> events to be suppressed, but now the syscall number is lost.

Ah-ha! Okay, thanks, I understand now. I think this means seccomp
phase1 should not treat RET_ERRNO as a "skip" event. Andy, what do you
think here?

-Kees

-- 
Kees Cook
Chrome OS Security
