Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Mar 2015 07:12:52 +0100 (CET)
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34370 "EHLO
        mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007196AbbCYGMtHXIAq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Mar 2015 07:12:49 +0100
Received: by qgep97 with SMTP id p97so26898442qge.1
        for <linux-mips@linux-mips.org>; Tue, 24 Mar 2015 23:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ee3rY/zY1RsleLAxexSpvlTC29CmUgMX7tEOeFFxFd8=;
        b=GOQOp96zvyH7W6oJkmoQGU97tmhBMHCEBfBLOHNRAQhEAL5bh3PWn//jazfYQM3UDs
         ZwmEgR9O0WGaWGBgUASWV4fTk/Xf8xFhiyOyrn74rknCaYCZj33F+kUgBxqB8TKXSFmW
         h+k6U+GesMTjNq99615Hgt/IMg2CK9o0xNoH4Jaihew/WRBgS5ifxG5Z8DS8Bm9EXky3
         JDqKQHzegIzXXhbge/PwLo68Ef/5VCBZHLsy3k+O1rtewtIydKYLU1MAfAC0+reHPn3q
         hTN6OZCsKqwPiE6qnRhWHMJ+ik8O0a924SCv47C6yFLsN0akAUxaG4uhY6AuliqwcnDm
         2a4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ee3rY/zY1RsleLAxexSpvlTC29CmUgMX7tEOeFFxFd8=;
        b=ZjkGPCL5aqu1DB6gF8xNA4CtmqD1+f03gYPlJJxtUuNq3DZ6myWI4j40iU1w5Jr4io
         LQCvO+c4ixbjvmlp+qrdjM4WulXL6yFBg+7ixg7GlIstbAnbXpYcO6W2zAHA2qBFFjto
         hkvehLXReHJ6gThgcucMw/dyrk+QGxaCngTaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Ee3rY/zY1RsleLAxexSpvlTC29CmUgMX7tEOeFFxFd8=;
        b=OIwqbL7XUVbWDHSmjzeGmTO1b5Tgd6Wez0J0HuIE4R9BvPoekKvxaKKzS6sXkuZSH5
         74i+FKGLkMAm+URcaqoDemWfeIeJzFiVBlTDb/SdsqdLAOY9lnQ7o9wjDChYrr48NOV0
         if3vy+K/KRS+EnJXNk3WyI3w/bYQiOeibg261RpNzXJPvQwiDLM+bqcWQkiQ7YbF51Ls
         wntRPcppenAO3e9MOXsCy6uohWaWsmSR4w8dN6QezY7loqsnPGV0/m9bdjczihyx8oJP
         DMWZO2yUDWbkZ1PwsyDrA52cZ2ygXMIrudIJw7BuxHjZscqQczEh0Q9nLLMqILwAfcfh
         S7tQ==
X-Gm-Message-State: ALoCoQnRPaT7mFSaiLgJDgGbywUH0TgpLGNN4Oj4gs4tNlXNB9eJpyrNZD3+q0AiUXV0GZCVe28G
MIME-Version: 1.0
X-Received: by 10.55.23.220 with SMTP id 89mr16941259qkx.56.1427263964237;
 Tue, 24 Mar 2015 23:12:44 -0700 (PDT)
Received: by 10.140.19.104 with HTTP; Tue, 24 Mar 2015 23:12:44 -0700 (PDT)
In-Reply-To: <5511731E.5000901@imgtec.com>
References: <1425513563-9897-1-git-send-email-abrestic@chromium.org>
        <5511731E.5000901@imgtec.com>
Date:   Tue, 24 Mar 2015 23:12:44 -0700
X-Google-Sender-Auth: k0FJADYA1-ni3jRmrjc2sl0hF5g
Message-ID: <CAL1qeaHorX6AJxNrD0R7QN9aGsfb1RUTjXeVDFox=WMD3T-3Ew@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Provide fallback reboot/poweroff/halt implementations
From:   Andrew Bresticker <abrestic@chromium.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

On Tue, Mar 24, 2015 at 7:22 AM, James Hogan <james.hogan@imgtec.com> wrote:
> Hi Andrew,
>
> On 04/03/15 23:59, Andrew Bresticker wrote:
>> If a machine-specific hook is not implemented for restart, poweroff,
>> or halt, fall back to halting secondary CPUs, disabling interrupts,
>> and spinning.  In the case of restart, attempt to restart the system
>> via do_kernel_restart() (which will call any registered restart
>> handlers) before halting.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> ---
>>  arch/mips/kernel/reset.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
>> index 07fc524..87b1f08 100644
>> --- a/arch/mips/kernel/reset.c
>> +++ b/arch/mips/kernel/reset.c
>> @@ -29,16 +29,36 @@ void machine_restart(char *command)
>>  {
>>       if (_machine_restart)
>>               _machine_restart(command);
>> +
>> +#ifdef CONFIG_SMP
>> +     smp_send_stop();
>
> Maybe local_irq_disable should be before smp_send_stop() to avoid
> deadlocks (same below)?
>
> See for example commit 44424c34049f41123a3a8b4853822f47f4ff03a2 ("ARM:
> 7803/1: Fix deadlock scenario with smp_send_stop()").

Actually, disabling IRQs before calling smp_send_stop() triggers the
WARN in kernel/smp.c:smp_call_function_many(), but I think we can
simply disable preemption to prevent the deadlock.
