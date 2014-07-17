Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jul 2014 17:46:01 +0200 (CEST)
Received: from mail-ig0-f172.google.com ([209.85.213.172]:64265 "EHLO
        mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6861330AbaGQPp7Jbjwk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Jul 2014 17:45:59 +0200
Received: by mail-ig0-f172.google.com with SMTP id h15so6399378igd.5
        for <linux-mips@linux-mips.org>; Thu, 17 Jul 2014 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=w0B5WlNsQdlmhxYK5OpgpnO67I4w45JsvT3UwAp6EQ4=;
        b=UKti0yWB758ppUoOgtjlOnwgzZt3kgkisJpuJlHVTnFs/Q69QPmDEHuCNlPEUkv6ZV
         lfeRUW3oYG4fnPAhKk4cfyTPUJEmJcjAIxgZ69MHsEFlSZWcSCpHfpWEG1Q7v8cCObug
         KmpTbTMp/Ym6lhHT9l0Tfy3Q6H4CqKCUeR8+XWibankRvZVjPMQrs/dxR7kk4ZIMQeId
         ehM7dBSDYIiLRtNO2cA7KSOVU1MAJRp0Eap9tm74g+xWP+s5x6Hs8GCTspY2Y3O7bkFx
         Fw5dot/kwZgByxfZ4T/WRSNrxw04RK86ddAtkUDKO53FTOZyUKLx0JNA2TkiAa90IBAt
         tA3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=w0B5WlNsQdlmhxYK5OpgpnO67I4w45JsvT3UwAp6EQ4=;
        b=i4Ak8zUIIvHsSDyqS/Gx3/Ili2WauTkHG1zA7dTI3iU+9BWYa8bXqTYadd6NYq08jH
         MEZg3RFfTx28o+HPCuUf4OW+qpgD02Myi5IDvCS3b0DVWKob8MM970fsFWD0oJGaHRKX
         8hCh122hvlhkdsrQoEOQ5rqOy61Ap/vAo1pRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=w0B5WlNsQdlmhxYK5OpgpnO67I4w45JsvT3UwAp6EQ4=;
        b=mtrCmXRKJ8JuubvNg02O7X4KsqQko9lfLc+pt8a0YVCVwN8Nle3D6dLFePwn4kRUaO
         fGjVbDJF3Dmgko/4qVVC+Q+YQ/a1CRvjdLRHzg7wZVg0FnTnDGR/fG7OKG3vz9jpBS1C
         D2r0ToEcv7mnVmSG8DA5Sp9NlLrEVGy7W/WXTG0u0/kUtDBcJu8krExWqFw/00YSeGnr
         /EGMByKaFWX48Ma+CMWT8tX2PYF745usJPfmt86rHSiPP8mBYiJeNXex55uId/iDOo0O
         mUFtPacAsMvIRFqV7hkAZnIyrxhIrTjwfAklRM9oZyQIZg7YMz6zCBtxE6bNi5NkF9fq
         MRFQ==
X-Gm-Message-State: ALoCoQnL4dCGlGYn4IO9lYavLVnNr0Jz3trGfydCvnAv8c5yTHXWRRuBqpRq0yXeno+pRZ7ZE6Ri
MIME-Version: 1.0
X-Received: by 10.60.70.205 with SMTP id o13mr45712799oeu.38.1405611952985;
 Thu, 17 Jul 2014 08:45:52 -0700 (PDT)
Received: by 10.182.85.103 with HTTP; Thu, 17 Jul 2014 08:45:52 -0700 (PDT)
In-Reply-To: <CAHse=S_32tmusk4ceY4U6GbNpX4PkX12iPPDZFVZ7qgv-RAooA@mail.gmail.com>
References: <1405547442-26641-1-git-send-email-keescook@chromium.org>
        <1405547442-26641-12-git-send-email-keescook@chromium.org>
        <CAHse=S_32tmusk4ceY4U6GbNpX4PkX12iPPDZFVZ7qgv-RAooA@mail.gmail.com>
Date:   Thu, 17 Jul 2014 08:45:52 -0700
X-Google-Sender-Auth: VbcorqEVvXf1lIOTdG3CFZWNg8w
Message-ID: <CAGXu5j+dFZdnnK8f-HRrUs2vLeyhWyHh_AY-OynDcp-Ye+dy7Q@mail.gmail.com>
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
X-archive-position: 41279
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

On Thu, Jul 17, 2014 at 8:04 AM, David Drysdale <drysdale@google.com> wrote:
> On Wed, Jul 16, 2014 at 10:50 PM, Kees Cook <keescook@chromium.org> wrote:
>> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
>> index 9065d2c79c56..2125b83ccfd4 100644
>> +/**
>> + * seccomp_can_sync_threads: checks if all threads can be synchronized
>> + *
>> + * Expects sighand and cred_guard_mutex locks to be held.
>> + *
>> + * Returns 0 on success, -ve on error, or the pid of a thread which was
>> + * either not in the correct seccomp mode or it did not have an ancestral
>> + * seccomp filter.
>> + */
>> +static inline pid_t seccomp_can_sync_threads(void)
>> +{
>> +       struct task_struct *thread, *caller;
>> +
>> +       BUG_ON(!mutex_is_locked(&current->signal->cred_guard_mutex));
>> +       BUG_ON(!spin_is_locked(&current->sighand->siglock));
>> +
>> +       if (current->seccomp.mode != SECCOMP_MODE_FILTER)
>> +               return -EACCES;
>
> Quick question -- is it possible to apply the first filter and also synchronize
> it across threads in the same operation?  If so, does this arm also need to
> cope with seccomp.mode being SECCOMP_MODE_DISABLED?
>
> [seccomp_set_mode_filter() looks to call this via seccomp_attach_filter()
> before it does seccomp_assign_mode()]

I don't entirely understand what you're asking. The threads gain the
filter and the mode before the current thread may gain the mode (if
it's the first time this has been called). Due to all the locks,
though, this isn't a problem. Is there a situation you see where there
might be a problem?

-Kees

-- 
Kees Cook
Chrome OS Security
