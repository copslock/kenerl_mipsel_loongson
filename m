Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Mar 2015 17:31:24 +0100 (CET)
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33742 "EHLO
        mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009672AbbCXQbTvGRYP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Mar 2015 17:31:19 +0100
Received: by qgfa8 with SMTP id a8so204421035qgf.0
        for <linux-mips@linux-mips.org>; Tue, 24 Mar 2015 09:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=t/6wu9mvWGuCQT6dmSdNYx137vaat9gg1yT7wMwkBsE=;
        b=aitOlLLlQoA7gHz1JU964IQnXcl6E5+3RRi1uFmUoC3Ob3BBXJsBsesu2hZIR1OwlV
         UdSlRbX+UZ0PsWTxB8ddOvKtOmPzHDulmU0u1F/dXgF/yze9KYBgT5bksqQUESm5ae8H
         BPgNlIyF9pNSsH0fEqHC6vGSBSGj1SrS3yOG5UJ1ie4oi56y/lxwpAAYtqWeHe/1PY+L
         I/BL8d1qVWerun5KvQIXSlsaRr6Y7zhJHjleaPMvurn1wlX01Obfpx124k3EiAz399TS
         6LcrQJ9DNa0ekHafemB6eiQh8JKK6iis7aFWH+ZEDfhNhaenvDWH7Vz4lrPp58kSCRoi
         SCEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=t/6wu9mvWGuCQT6dmSdNYx137vaat9gg1yT7wMwkBsE=;
        b=n9fnIyexwT3lQ/zBjNcEjkxmCKuIhHhFWdtPWs4I33KRrsWEldCahxZG59sm7xZS+c
         aFcMQmm5p6utx0qhQCfltnmgm1pUrmwo/JPMSVbdCTtWWMZLR/VmSIZYhl/wS7G1PFN0
         aR0mFqY+V7xRz1FQE0fCJxKznGqum11iKuzaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=t/6wu9mvWGuCQT6dmSdNYx137vaat9gg1yT7wMwkBsE=;
        b=FRSz3+EQRWizqHDl0D4xRHmyysfD9Izu9mVl67Zjaq8JW8PLJNKpm3l2NPwcH5hL8i
         m1JJRCZbPnV7+Ma/yUAPbpSU/YjnOPw9EdbcKjakjt8kerlqdvSKsw8IlqKCTw/AM2qa
         tyNWhWwQEMZVn8Ij5liEUvrrEy7KjlwkCxYAiDOhXKix9r1VjQD2d98oH3rgIlWKKJWY
         1szu7z4yftpR0UAjZDTtvSY3yLXu1T8l1rUKadhSoGhKVmGLeM8FIV4ng6FYqd0BK9OO
         tej7DAhXIva1qVd4sWQg/+kvMLalfBmmHd/EkHMrJWmrhvfNcqdCdVcoQPavVE8UMMSn
         ylNg==
X-Gm-Message-State: ALoCoQkLpPtFou6AyixbJpuBfPG/a23e3tlrdarmyOL1yYhTB4qVrFDD0zA8mmCAyHSDCCg6hRPg
MIME-Version: 1.0
X-Received: by 10.140.91.71 with SMTP id y65mr6514106qgd.90.1427214651810;
 Tue, 24 Mar 2015 09:30:51 -0700 (PDT)
Received: by 10.140.19.104 with HTTP; Tue, 24 Mar 2015 09:30:51 -0700 (PDT)
In-Reply-To: <5511731E.5000901@imgtec.com>
References: <1425513563-9897-1-git-send-email-abrestic@chromium.org>
        <5511731E.5000901@imgtec.com>
Date:   Tue, 24 Mar 2015 09:30:51 -0700
X-Google-Sender-Auth: uao3OzQyz8MAg7jpx44L5eV646E
Message-ID: <CAL1qeaG5+15w1FZX549k++PjFnXV7PZ7by03xNA7irQ8aNzM5A@mail.gmail.com>
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
X-archive-position: 46508
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

Hi James,

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

Ah right, good catch.

>> +#endif
>> +     do_kernel_restart(command);
>> +     pr_emerg("Reboot failed -- System halted\n");
>
> Perhaps we could have a grace period like ARM does here:
>
>> /* Give a grace period for failure to restart of 1s */
>> mdelay(1000);
>
> Otherwise with this patch a reboot on Malta usually shows some/all of
> this pr_emerg message prior to actually restarting. (Arguably thats a
> failing of Malta's _machine_restart not to have a delay... thoughts?).

Yes, I think it's reasonable to put a delay here.

Thanks,
Andrew
