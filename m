Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 12:54:18 +0200 (CEST)
Received: from mail-it0-x22d.google.com ([IPv6:2607:f8b0:4001:c0b::22d]:38496
        "EHLO mail-it0-x22d.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990600AbdDFKyK5F3wE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 12:54:10 +0200
Received: by mail-it0-x22d.google.com with SMTP id y18so23750414itc.1
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 03:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JgfvGBibi9qt2/ohcX66Cv2/ZSh0mMU4LxstMG+Qcc0=;
        b=kOGxuQDgAxikZiLE9w/F7AoM48IKmS2RHUSao6XBe2AcFgEB4MN4gymM5V1bXduHgN
         DynEZU26NP/fUarAE9L1speG+xhG+CHFIPCDaQdDVWrPaefkAhT4OWbpobmSiU94rrQ3
         kLL2idjRJ7y40j0DjDFzglUQbkmcnpx3P6HGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JgfvGBibi9qt2/ohcX66Cv2/ZSh0mMU4LxstMG+Qcc0=;
        b=foRGegXFjmy1a79c4Ee8PoqX6/1quVhGo1jgroYgqM04IDtVpSLhidDyNzscb4xAju
         B9bPiDYZk5iQ7iJUqinCtoKmmj+StHAhwgOkTfhzZoL1Ilbwh5mcQuuVyyPqOAXoBxhj
         2jLimlLuLmmQ2t3EkMLVDoLqzUkn0mIBzHucDMP5SCpXyEkk/rTvaJJOHUi2UYyU/KLr
         AJIcSQwV3XcLxrXo3CAdi5m6BXS9ICpgL7Lh2te4gQOEkERnpxDWvfFRXcg4kk9me+/9
         BqD8pz0Ihbj7lwX9aODWbYeD2xmGodvSF44vSejzixArBqE6878hILFAbwz85jEB1JaC
         xpuQ==
X-Gm-Message-State: AFeK/H1UJeQqxEjKPfiAoKNIiUaVNi7gqlo6QX66JXL68eY3SncygN3C
        +MQHMqrPkshy+XP1Z9UNLOHqDChS8ZcZ
X-Received: by 10.36.194.67 with SMTP id i64mr26084226itg.68.1491476045054;
 Thu, 06 Apr 2017 03:54:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.33.200 with HTTP; Thu, 6 Apr 2017 03:53:24 -0700 (PDT)
In-Reply-To: <20170406092947.GQ31606@jhogan-linux.le.imgtec.org>
References: <1491388344-13521-1-git-send-email-amit.pundir@linaro.org>
 <1491388344-13521-5-git-send-email-amit.pundir@linaro.org> <20170406092947.GQ31606@jhogan-linux.le.imgtec.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Thu, 6 Apr 2017 16:23:24 +0530
Message-ID: <CAMi1Hd1c=yA=mmEwpUechAvquv9intSGePtyQkbSH1L-4N_UUA@mail.gmail.com>
Subject: Re: [PATCH v2 for-4.9 04/32] MIPS: Lantiq: Fix cascaded IRQ setup
To:     James Hogan <james.hogan@imgtec.com>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felix Fietkau <nbd@nbd.name>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <amit.pundir@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amit.pundir@linaro.org
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

On 6 April 2017 at 14:59, James Hogan <james.hogan@imgtec.com> wrote:
> Hi Amit,
>
> On Wed, Apr 05, 2017 at 04:01:56PM +0530, Amit Pundir wrote:
>> From: Felix Fietkau <nbd@nbd.name>
>>
>> With the IRQ stack changes integrated, the XRX200 devices started
>> emitting a constant stream of kernel messages like this:
>>
>> [  565.415310] Spurious IRQ: CAUSE=0x1100c300
>>
>> This is caused by IP0 getting handled by plat_irq_dispatch() rather than
>> its vectored interrupt handler, which is fixed by commit de856416e714
>> ("MIPS: IRQ Stack: Fix erroneous jal to plat_irq_dispatch").
>>
>> Fix plat_irq_dispatch() to handle non-vectored IPI interrupts correctly
>> by setting up IP2-6 as proper chained IRQ handlers and calling do_IRQ
>> for all MIPS CPU interrupts.
>>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> Acked-by: John Crispin <john@phrozen.org>
>> Cc: linux-mips@linux-mips.org
>> Patchwork: https://patchwork.linux-mips.org/patch/15077/
>> [james.hogan@imgtec.com: tweaked commit message]
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>>
>> (cherry picked from commit 6c356eda225e3ee134ed4176b9ae3a76f793f4dd)
>> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
>
> Is there a particular reason this is desired in stable? I was under the
> impression it was only helpful in the presence of a bug in the separate
> IRQ stack stuff in 4.11, which was fixed in the above mentioned commit
> de856416e714 ("MIPS: IRQ Stack: Fix erroneous jal to
> plat_irq_dispatch"), and otherwise just a nice to have cleanup.

I picked up this patch from Lede source tree
https://github.com/lede-project/source/ for stable 4.9.

>
> If you've cherry picked the IRQ stack work, have you also cherry-picked
> de856416e714?

Thanks for pointing it out. I indeed missed out on picking
de856416e714 ("MIPS: IRQ Stack: Fix erroneous jal to
plat_irq_dispatch") and dda45f701c9d ("MIPS: Switch to the irq_stack
in interrupts"). Should I pick them too for 4.9/4.10 stable or drop
these 3 IRQ stack patches altogether if they are not stable material?

Regards,
Amit Pundir

>
> Cheers
> James
