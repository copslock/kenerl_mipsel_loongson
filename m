Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2017 13:44:57 +0200 (CEST)
Received: from mail-it0-x22c.google.com ([IPv6:2607:f8b0:4001:c0b::22c]:35656
        "EHLO mail-it0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991976AbdDFLouu74hc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2017 13:44:50 +0200
Received: by mail-it0-x22c.google.com with SMTP id y18so99204119itc.0
        for <linux-mips@linux-mips.org>; Thu, 06 Apr 2017 04:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h4t5D9FZ/fTmyXB1GhhWmHOfMAU8KDufoo2MeCAkzvw=;
        b=Oa9UJpTiWZGTrhLZVSIY8NAvFYicrN8eq1xfEltMU1ldNYx7uCKeP1QdAFkwRldH6b
         vmvfEn/kk/4omvkNP5GGefCL93OGeRIw383d0WrXfkJwkIG1/k9kxfHzNVscwf2xst83
         rlZvGgaytBKY+3brBJIEs7G+4p7UAbMYT6rz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h4t5D9FZ/fTmyXB1GhhWmHOfMAU8KDufoo2MeCAkzvw=;
        b=ntz7gGa2FfSik84BGftTu1T74K+BfqVYGDOyDqBaOr4Gh62+NqPlSaXh56gpIk03hg
         Ony1wCqk2/2G7b3Ehr1ro1ru3+Bw0rS72gyONNn6yZWmNd1q3oMYqmBZCmqbijhYjyFX
         LFa5zM+UUxEUz1AjI+cwcIcZhtOQJyppcePveGvvDfmfN+iWnNMhyARJW/BiyFBqoF3v
         SdsSeml+6aoMnshs/DUkjRnpTzn/+ZvpYPszWwp16WpmIT9k43tk8z4y58fHYjfW2cXr
         d06rbvwPaJZaBrwCmqmxLLSpPLVqOq2/R8aFPZN1xEmWuGjDk2jWjH7lNYqPW7bTjfJD
         Jb/Q==
X-Gm-Message-State: AFeK/H1uL7y2HGoIfntjrkHuieioqkbqnr+lykQQf25qi2OoQxlu+Iyp
        IOtf8L4k10WYW6A6NzOT4g1TFsW/U/lO
X-Received: by 10.36.60.82 with SMTP id m79mr26294068ita.107.1491479084952;
 Thu, 06 Apr 2017 04:44:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.33.200 with HTTP; Thu, 6 Apr 2017 04:44:04 -0700 (PDT)
In-Reply-To: <20170406112517.GR31606@jhogan-linux.le.imgtec.org>
References: <1491388344-13521-1-git-send-email-amit.pundir@linaro.org>
 <1491388344-13521-5-git-send-email-amit.pundir@linaro.org>
 <20170406092947.GQ31606@jhogan-linux.le.imgtec.org> <CAMi1Hd1c=yA=mmEwpUechAvquv9intSGePtyQkbSH1L-4N_UUA@mail.gmail.com>
 <20170406112517.GR31606@jhogan-linux.le.imgtec.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Thu, 6 Apr 2017 17:14:04 +0530
Message-ID: <CAMi1Hd1vYOb33TQV0D99r+dUgs2Gz0V0L74Y-6bHDKj6s60c9A@mail.gmail.com>
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
X-archive-position: 57584
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

On 6 April 2017 at 16:55, James Hogan <james.hogan@imgtec.com> wrote:
> On Thu, Apr 06, 2017 at 04:23:24PM +0530, Amit Pundir wrote:
>> On 6 April 2017 at 14:59, James Hogan <james.hogan@imgtec.com> wrote:
>> > Is there a particular reason this is desired in stable? I was under the
>> > impression it was only helpful in the presence of a bug in the separate
>> > IRQ stack stuff in 4.11, which was fixed in the above mentioned commit
>> > de856416e714 ("MIPS: IRQ Stack: Fix erroneous jal to
>> > plat_irq_dispatch"), and otherwise just a nice to have cleanup.
>>
>> I picked up this patch from Lede source tree
>> https://github.com/lede-project/source/ for stable 4.9.
>>
>> >
>> > If you've cherry picked the IRQ stack work, have you also cherry-picked
>> > de856416e714?
>>
>> Thanks for pointing it out. I indeed missed out on picking
>> de856416e714 ("MIPS: IRQ Stack: Fix erroneous jal to
>> plat_irq_dispatch") and dda45f701c9d ("MIPS: Switch to the irq_stack
>> in interrupts"). Should I pick them too for 4.9/4.10 stable or drop
>> these 3 IRQ stack patches altogether if they are not stable material?
>
> I'd definitely drop this one.

Yes I'd drop this lone survivor too. I'll send the complete batch separately.

>
> Greg said he doesn't object to accepting the IRQ stack work once its
> been shaken out in mainline, at which point the fixes will be needed
> too:
>
> https://marc.info/?l=linux-mips&m=148449064421154&w=2
>
> Though note that its more than just the one patch:
>
> https://patchwork.linux-mips.org/project/linux-mips/list/?series=23&state=*
>
> (I seem to remember somebody saying LEDE had applied these patches).

I see all these patches in LEDE source too. Sorted out for both 4.4
and 4.9 already. I'll send them on stable shortly.

Regards,
Amit Pundir

>
> Cheers
> James
