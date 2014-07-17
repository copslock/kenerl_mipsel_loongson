Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 19:53:16 +0200 (CEST)
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35691 "EHLO
        mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861343AbaGQRxCwkXfm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 19:53:02 +0200
Received: by mail-ig0-f178.google.com with SMTP id uq10so3367433igb.11
        for <linux-mips@linux-mips.org>; Thu, 17 Jul 2014 10:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1EHY10ueA/v3A3yfqj9C0Zk06gCcw9Fh4Xi8MOCPXr4=;
        b=OEVTNmMS5VjhwuanS8Hf9Jyv16yIx1Xz6ftDL+fWHSm7AUierF82HZSuW2Dig5lp4g
         WoHlouBPCX2ynAziGzF2AdJ77zQMLcdcnogOKa2p918m//7wqhdl1FbdZ09ICVgKuKMb
         4p8VViaUsXtcxcHMQH6YQPIMOAgdLElhdDgWYzo9LzZAY3ENw3SfjtI+L62043u5DmOe
         n1Jb81t3pQIbJL/IP9qMvPdAGNhaZhlnI40d3pVAq4IgwGp0dypYyCWqKVw5vucayJOp
         tgjsXKATlgw3LUhjWonkxggWdgOhtye5QtedQPx/y5bIeUZm9N6DF4MhotZjSn+nFqTG
         EsBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1EHY10ueA/v3A3yfqj9C0Zk06gCcw9Fh4Xi8MOCPXr4=;
        b=gllNpAmBWceIvGlRc+3QkB5xoucVMgyKAZ7Uemqw2Yvxb58EcjCFtJLluKqXiaUuwi
         DKCbx4nCYEmAYAFmz+Gaf18EmZAe1OQ57RsJPhoGSH5q2SHLqrRDX5zLkOlLjSBMXS6b
         1DoB5HYLBf1MGssn0R7Huzi5gEzGZwdVXJV3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1EHY10ueA/v3A3yfqj9C0Zk06gCcw9Fh4Xi8MOCPXr4=;
        b=PfTpUiIn+YKt8jkWrQtzhjpD+Y/e6BV/npgXgAJTlmnZFw54y0hUo4jyF/pA6XdshU
         WKJaw9q38JaG+WYMWOwzjy3qagyffAVaBcyFZoj/07wAc/ehPpbm+s+Ko8n0pxgfFLom
         0VnDSPkgPQmbNrrBLkg1dRwonoULBEf10iKRDAh2gEOZnEUrwqJ+QCWtyOgkzki+FAVM
         ehCbRrz6mMUbyMgWtkQdBTaXMDH6x5q4fwh54dl9P6HLLE/57MLtb2hd7fU+kh2fQpJ/
         5Z1J5LwEME1el8KHzElZJ0MhqeBdrk91v8Dqht8EbtfZDKpXT+6oMYZuNUsAF1NqhFrX
         UfMA==
X-Gm-Message-State: ALoCoQk3KTOlcLwLxheFwpIsKw7CgPIFgkBRE1PM7XkbtQEmVl+iUrT+7HlEoOLvAvRwfJQOpNnZ
MIME-Version: 1.0
X-Received: by 10.60.132.171 with SMTP id ov11mr47230936oeb.46.1405619570246;
 Thu, 17 Jul 2014 10:52:50 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Thu, 17 Jul 2014 10:52:50 -0700 (PDT)
In-Reply-To: <CAGXu5j+dFZdnnK8f-HRrUs2vLeyhWyHh_AY-OynDcp-Ye+dy7Q@mail.gmail.com>
References: <1405547442-26641-1-git-send-email-keescook@chromium.org>
        <1405547442-26641-12-git-send-email-keescook@chromium.org>
        <CAHse=S_32tmusk4ceY4U6GbNpX4PkX12iPPDZFVZ7qgv-RAooA@mail.gmail.com>
        <CAGXu5j+dFZdnnK8f-HRrUs2vLeyhWyHh_AY-OynDcp-Ye+dy7Q@mail.gmail.com>
Date:   Thu, 17 Jul 2014 10:52:50 -0700
X-Google-Sender-Auth: KwEl5vREJ8PxLoz3tkJp49kBaV8
Message-ID: <CAGXu5jJy0pW9X8YMhnfChtBO55EZKW6J7-+svKMBYP7WGM4PaA@mail.gmail.com>
Subject: Re: [PATCH v11 11/11] seccomp: implement SECCOMP_FILTER_FLAG_TSYNC
From:   Kees Cook <keescook@chromium.org>
To:     David Drysdale <drysdale@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41283
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

On Thu, Jul 17, 2014 at 8:45 AM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Jul 17, 2014 at 8:04 AM, David Drysdale <drysdale@google.com> wrote:
>> On Wed, Jul 16, 2014 at 10:50 PM, Kees Cook <keescook@chromium.org> wrote:
>>> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
>>> index 9065d2c79c56..2125b83ccfd4 100644
>>> +/**
>>> + * seccomp_can_sync_threads: checks if all threads can be synchronized
>>> + *
>>> + * Expects sighand and cred_guard_mutex locks to be held.
>>> + *
>>> + * Returns 0 on success, -ve on error, or the pid of a thread which was
>>> + * either not in the correct seccomp mode or it did not have an ancestral
>>> + * seccomp filter.
>>> + */
>>> +static inline pid_t seccomp_can_sync_threads(void)
>>> +{
>>> +       struct task_struct *thread, *caller;
>>> +
>>> +       BUG_ON(!mutex_is_locked(&current->signal->cred_guard_mutex));
>>> +       BUG_ON(!spin_is_locked(&current->sighand->siglock));
>>> +
>>> +       if (current->seccomp.mode != SECCOMP_MODE_FILTER)
>>> +               return -EACCES;
>>
>> Quick question -- is it possible to apply the first filter and also synchronize
>> it across threads in the same operation?  If so, does this arm also need to
>> cope with seccomp.mode being SECCOMP_MODE_DISABLED?
>>
>> [seccomp_set_mode_filter() looks to call this via seccomp_attach_filter()
>> before it does seccomp_assign_mode()]
>
> I don't entirely understand what you're asking. The threads gain the
> filter and the mode before the current thread may gain the mode (if
> it's the first time this has been called). Due to all the locks,
> though, this isn't a problem. Is there a situation you see where there
> might be a problem?

Just to follow up for posterity on lkml: the problem was that mode was
being set in "current" _after_ sync, so the mode check in can_sync
would fail if "current" was not yet in filter mode. (i.e. the first
attached filter could not have the TSYNC flag.) This check was
redundant with the attach_filter entry point checks, and protected
nothing, so it has been removed and a new test added to the seccomp
regression test suite. :)

I sent it as a new patch on top of v11, instead of respinning
everything as v12. If that's not preferred, I can send v12 with this
fix incorporated.

Thanks!

-Kees

-- 
Kees Cook
Chrome OS Security
