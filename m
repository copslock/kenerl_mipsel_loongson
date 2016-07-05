Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jul 2016 18:18:24 +0200 (CEST)
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36281 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992461AbcGEQSSRyWbL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jul 2016 18:18:18 +0200
Received: by mail-vk0-f51.google.com with SMTP id m127so211426368vkb.3
        for <linux-mips@linux-mips.org>; Tue, 05 Jul 2016 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wiPXgG7GKwbfKqxJ5k6nF4l7J9pyftAL1bjjkwjhXsk=;
        b=XfYdPCjtExzQbWk9bii/JEOVlJR7dEPSnDwBNL7Zi0JCyiBaxPUj0H61/rmCbKywP9
         zcfI4x3d/iOKEOosKlnaGOs9foyoCvqDppSqn3fIo8BR3czprsD84KLKazoEoios0TnP
         3G++nyz1dY7w22j0yjpSZ3PYnoc6/JUvVZelCOD2dfS+iAbpOijeMoCHAT03ZZKMhwxT
         vzvOAfg5a453TqN3pqDWIa93cy6DURKO+F8inPkcUMaf94vKB54vI1NulQJlCkCGH8I2
         wLMvS6H3aQ3xJ8vlEQUeramMp9+r5QtqyN/F9VHgqE6iOzzR/SS5hF5xDHDnkamH+1Mz
         WVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wiPXgG7GKwbfKqxJ5k6nF4l7J9pyftAL1bjjkwjhXsk=;
        b=ZNncMS7mH0KBajctY2IfdLYlNtU6PxuzDgSK4NPyXc6DGuDJ1V3hH1cQ6k1szIRy4A
         wJV894o1yX7KVCDZTbGP5PPqWsF4fxSqmYmpfMx3/L1XznMS3CpFlCDddHIjTfhOq6D7
         dcvnWqgahd8qlZE967S0EwbnYn+rvum3usCJ7a4fkLbtivdX2lVKtFRWPUKZnh3sUBLQ
         akjtx9iaowLcylny4klRU/WKcFI2FjvRU9yZCQAxPVgFY4HaqbBhHJQvHs0WYzx24nw+
         KfC3Oy/ILv65X++U5lk1tU0hIxlb2Wm/IaBKgr6wCorxFuAVTW2qBFMUr2CNE8tpLg6a
         auEA==
X-Gm-Message-State: ALyK8tILGV6shAa3LOCkVXQoecDP5gBNtkBKepWWHinKV+yrwYmJm6SZZuVf3v5Vd6GHCy6WSkSbWIiLaHVuEyIe
X-Received: by 10.176.0.118 with SMTP id 109mr1833206uai.101.1467735492059;
 Tue, 05 Jul 2016 09:18:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.76.6 with HTTP; Tue, 5 Jul 2016 09:17:49 -0700 (PDT)
In-Reply-To: <943222fa-1355-14cc-5d03-16873283420f@imgtec.com>
References: <1466856870-17153-1-git-send-email-prasannatsmkumar@gmail.com> <943222fa-1355-14cc-5d03-16873283420f@imgtec.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 5 Jul 2016 09:17:49 -0700
Message-ID: <CALCETrWio8FO2yJXdsRUYDNQFwuF-ihr=EbopM6bOkfXnsrWPg@mail.gmail.com>
Subject: Re: [RFC] mips: Add MXU context switching support
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Alex Thorlton <athorlton@sgi.com>, zhaoxiu.zeng@gmail.com,
        Ingo Molnar <mingo@kernel.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        chenhc@lemote.com, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Zubair.Kakakhel@imgtec.com, alex.smith@imgtec.com,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        f.fainelli@gmail.com, Mateusz Guzik <mguzik@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Hocko <mhocko@suse.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Kees Cook <keescook@chromium.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Serge Hallyn <serge.hallyn@ubuntu.com>,
        John Stultz <john.stultz@linaro.org>,
        James Hogan <james.hogan@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        David Daney <david.daney@cavium.com>,
        Jiri Slaby <jslaby@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54229
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

On Jul 5, 2016 5:35 AM, "Paul Burton" <paul.burton@imgtec.com> wrote:
>
> Hi PrasannaKumar,
>
>
> On 25/06/16 13:14, PrasannaKumar Muralidharan wrote:
>>
>> From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>>
>> This patch adds support for context switching Xburst MXU registers. The
>> registers are named xr0 to xr16. xr16 is the control register that can
>> be used to enable and disable MXU instruction set. Read and write to
>> these registers can be done without enabling MXU instruction set by user
>> space. Only when MXU instruction set is enabled any MXU instruction
>> (other than read or write to xr registers) can be done. xr0 is always 0.
>
>
> Do you have any examples of userland programs making use of MXU? They would be useful in allowing people to test this patch.
>
> How have you tested this?
>
>
>> Kernel does not know when MXU instruction is enabled or disabled. So
>> during context switch if MXU is enabled in xr16 register then MXU
>> registers are saved, restored when the task is run.
>
>
> I'm not convinced this is the right way to go. It seems complex & fragile vs the alternatives, the simplest of which could be to just always save & restore MXU context in kernels with MXU support. Is there a significant performance cost to just unconditionally saving & restoring the MXU context? That is after all what Ingenic's vendor kernel, which it looks like large parts of your patch are taken from, does.
>
>
>> When user space
>> application enables MXU, it is not reflected in other threads
>> immediately. So for convenience the applications can use prctl syscall
>> to let the MXU state propagate across threads running in different CPUs.
>
>
> Surely it wouldn't be reflected at all, since each thread has its own MXU context? Would you expect applications to actually want to enable MXU on one thread & make use of it from other already running threads? Off the top of my head I can't think of why that would be useful, so I'm wondering whether it would be better to just let each thread handle enabling MXU if it wants & leave the kernel out of it. If we just save & restore unconditionally then this becomes a non-issue anyway.
>

I don't know much about MIPS, but switching save/restore off depending
on a bit of *user* state sounds like a gaping security hole.
