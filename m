Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Feb 2015 21:16:25 +0100 (CET)
Received: from mail-ob0-f171.google.com ([209.85.214.171]:50668 "EHLO
        mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012783AbbBFUQYg5ozy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Feb 2015 21:16:24 +0100
Received: by mail-ob0-f171.google.com with SMTP id gq1so15486400obb.2
        for <linux-mips@linux-mips.org>; Fri, 06 Feb 2015 12:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=OmEW8NmE0d0lJEJgxfAmDraXxW9dIT5Pojrzxpe8hQo=;
        b=nE0qoTnl2Yv1xAZZn8n/3EGtyx629kciJEYomJm1b5g2Z+Bo1z2hv97RYJS66uACwR
         ouivn05AOFYud9lhEdjsD6XwnMtnL2S9F+5CuaD89KvduAPaT9T9S9NLQTElS0RoGgqh
         ncxFmRObDKyAnZOsAd7eIAXeUcxepM56vKY3p+UVN5CcMWuuqrKULDm0r0YNMMfY8Ngh
         dWDSojvAMqrX0VDbo9ToA2SMmdOfJNKSriJAfXNaKKnf7R9SPez0nsqONANQRiJ5G8+i
         u1469qq8oYufKf8jTDciDdIZQIKwu8nsKz6AHvhe8HVOKtUL/0+YCWXHwzL/RTcD71ky
         XGRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=OmEW8NmE0d0lJEJgxfAmDraXxW9dIT5Pojrzxpe8hQo=;
        b=Iaz0amKT/0Gzwg+LuV4XECehfZDXjXXiDV5im0e6RMOpnzxcMTeF1Yq0s9rwXE8uhu
         79H/tDuQFFf+0kqenL+aS/7TOyNMQkej2Ik+mUFv/AQnTHrNhZ79P0ndC6Y+PkBhESO1
         R9sMJ8gaRZJ0VnwrzyNpHY7sHoDl3U9Quq5+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=OmEW8NmE0d0lJEJgxfAmDraXxW9dIT5Pojrzxpe8hQo=;
        b=a8IlQOL/PB/bbEb1k3rk3FBwzVb/UBsttaqeeh1+FpYg8Jbntver32ER7ZAnPhoBmV
         3F4JT8Y2b5Mpb6x/v2OnLq4fQ2qnmKnb9/SQmlu4elurPvvPuIObCsRqZe6etuih1K4c
         SOEVgL2DhAY7DbsoBLqQcc+2MX5sXJ+krA0VJ31fMGxzrG1a9IqezOE3j1cilpH5qwZT
         y1+QwXgh/lbEo4KHbeERB9FscwPvfon9jDBhgvWXHNmi2fcolYHQzoGtI2SHbbCrB1M2
         Mw/vNlmh4JXk6c1uiarRelvgLtgF5T/jYBcgstzkaE4rGAKRIHaPkntMGKmq27QRNto8
         J3Lg==
X-Gm-Message-State: ALoCoQnq7euIpTNv+sbkObAxV5ebgBnyz1wX/Lu9FOs+/E/vadmrW2MOBoXQkmLWnjbjYBzx0BA9
MIME-Version: 1.0
X-Received: by 10.60.51.165 with SMTP id l5mr3688234oeo.69.1423253777714; Fri,
 06 Feb 2015 12:16:17 -0800 (PST)
Received: by 10.182.87.201 with HTTP; Fri, 6 Feb 2015 12:16:17 -0800 (PST)
In-Reply-To: <CALCETrUmMA9sK4SJCSiF24iAiPLMBf=-JBw6TcLV+aLt_eN=Sw@mail.gmail.com>
References: <cover.1409954077.git.luto@amacapital.net>
        <2df320a600020fda055fccf2b668145729dd0c04.1409954077.git.luto@amacapital.net>
        <20150205211916.GA31367@altlinux.org>
        <CAGXu5j+aXxt55LsxxbNkfGGF719ubXBZ2JAFwUPNARwKMVFgng@mail.gmail.com>
        <20150205214027.GB31367@altlinux.org>
        <CALCETrXFzcXngHsX=_72hYZqms32Zf7oFYDBgC3XNw7zOGdDCA@mail.gmail.com>
        <CAGXu5jJtHT9o8WMoynifN13=uZoARt4G9iVcgZsc9xYOBEwWsg@mail.gmail.com>
        <20150205233945.GA31540@altlinux.org>
        <CAGXu5jLTH+mUF0JxeR2qA_r=ocWjPHPSK2OPgE0Fu_JKoQyQ9w@mail.gmail.com>
        <CALCETrXsCUje+_V=Ud+TB4A2jH2M7yqyoCFMLEyxOD6pd7Di5w@mail.gmail.com>
        <20150206023249.GB31540@altlinux.org>
        <CALCETrWTnqKDoatK+5FN=yYDOeENoW5=r5YMToYKhZ8Zfv5wWA@mail.gmail.com>
        <CAGXu5j+nopAMFukwMu=Cy0GOapziOLTb-ryJhA-aywk_uerg9A@mail.gmail.com>
        <CALCETrVaF+3ETn5nfcbvyWKUYb71jNXK-zo9V6uOK0cEW4TCNQ@mail.gmail.com>
        <CAGXu5jJXspS_34KBJ5VxvyKuj4bA+zg267dNiEkqR1LuvjoA1Q@mail.gmail.com>
        <CALCETrUmMA9sK4SJCSiF24iAiPLMBf=-JBw6TcLV+aLt_eN=Sw@mail.gmail.com>
Date:   Fri, 6 Feb 2015 12:16:17 -0800
X-Google-Sender-Auth: 5v3CfARRM9OQToCOkPqnGZK4Hno
Message-ID: <CAGXu5jKuLUCwptoL=5Hcz7ME-SKdVcuYoRPw+JJ2nktz5273-w@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] x86: Split syscall_trace_enter into two phases
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
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
        Frederic Weisbecker <fweisbec@gmail.com>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45758
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

On Fri, Feb 6, 2015 at 12:12 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Fri, Feb 6, 2015 at 12:07 PM, Kees Cook <keescook@chromium.org> wrote:
>> On Fri, Feb 6, 2015 at 11:32 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>>> On Fri, Feb 6, 2015 at 11:23 AM, Kees Cook <keescook@chromium.org> wrote:
>>>> And especially since a ptracer
>>>> can change syscalls during syscall-enter-stop to any syscall it wants,
>>>> bypassing seccomp. This condition is already documented.
>>>
>>> If a ptracer (using PTRACE_SYSCALL) were to get the entry callback
>>> before seccomp, then this oddity would go away, which might be a good
>>> thing.  A ptracer could change the syscall, but seccomp would based on
>>> what the ptracer changed the syscall to.
>>
>> I want kill events to trigger immediately. I don't want to leave the
>> ptrace surface available on a SECCOMP_RET_KILL. So maybe it can be
>> seccomp phase 1, then ptrace, then seccomp phase 2? And pass more
>> information between phases to determine how things should behave
>> beyond just "skip"?
>
> I thought so too, originally, but I'm far less convinced now, for two reasons:
>
> 1. I think that a lot of filters these days use RET_ERRNO heavily, so
> this won't benefit them.
>
> 2. I'm not convinced it really reduces the attack surface for anyone.
> Unless your filter is literally "return SECCOMP_RET_KILL", then the
> seccomp-filtered task can always cause the ptracer to get a pair of
> syscall notifications.  Also, the task can send itself signals (using
> page faults, breakpoints, etc) and cause ptrace events via other
> paths.

What are you thinking for a solution?

As for capping SECCOMP_RET_ERRNO to MAX_ERRNO, how about this (sorry
if gmail butchers the paste):

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 4ef9687ac115..c88148d20bd5 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -629,7 +629,9 @@ static u32 __seccomp_phase1_filter(int this_syscall, struct

        switch (action) {
        case SECCOMP_RET_ERRNO:
-               /* Set the low-order 16-bits as a errno. */
+               /* Set the low-order bits as a errno. */
+               if (data > MAX_ERRNO)
+                       data = MAX_ERRNO;
                syscall_set_return_value(current, task_pt_regs(current),
                                         -data, 0);
                goto skip;


-- 
Kees Cook
Chrome OS Security
