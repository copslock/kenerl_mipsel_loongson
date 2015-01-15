Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2015 17:58:13 +0100 (CET)
Received: from mail-qa0-f51.google.com ([209.85.216.51]:49681 "EHLO
        mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010580AbbAOQ6L0Mrsc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2015 17:58:11 +0100
Received: by mail-qa0-f51.google.com with SMTP id f12so11044746qad.10
        for <linux-mips@linux-mips.org>; Thu, 15 Jan 2015 08:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vqGr7b30Qh8E9yCssqrhFIkOkDB+rF5Ultnq8P5gzb8=;
        b=PHmCgqlWoHnkQkmM/X2ylN6no3n+b5KCALhh90iQ/asnwTEcUUVgT4nZ/fU7vCuoSu
         OlEunXY6elPJfCIAtQzF6pYWPnOYeZ035Wx7J0Q/q452egQVr81T8Kevdq8TYXh6Ns8v
         gfA8BWMoveLKc2cd0hvo/0RW85VK7u7PZPONfMfi+pzv8o3UuGciNh93+bHqmTLAq0E4
         7DoHkmKCBXmlgVPVq0HqGfSwCp7EEVEatwXQBTxBkuwfQgTCsSeYJC21Im/FvshRmG0b
         MqEagHPVOjvVXu7aYIc43R6PfjlJQKqXR4YgpShjTYQ1iqUL3wGlwRWdMum7xo15G5Jn
         ypVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vqGr7b30Qh8E9yCssqrhFIkOkDB+rF5Ultnq8P5gzb8=;
        b=HX5u7WOapd93xADEJ56RETzRNOKfoJ/MKpMNPszJJLbLFPQ1lG0+faYCTyl0dEYHQ2
         doE6p4opc+erjoJhhZR/jJwzHxA/WaGPb7jpm2LqzSK43r0vr3PQ0QD7vuFGcg0dvOel
         keZsEXW1qJ+V4OlYqYBhkAY6eGN0cYjgioz6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vqGr7b30Qh8E9yCssqrhFIkOkDB+rF5Ultnq8P5gzb8=;
        b=X0gp3A1FWHTSP2HY67YkaMZd1rcLhoLl+GhMymx7QZ7x11rWIExoM86mnv3pqsuWlx
         Lh3cvJzwldxCDkUGbXYrc+sHSR1qpYyueJljKtsSHofRtKJnMEnOa+RIXnY3vnfhFlVG
         n1DUouN9xJM1vc+SwSGB2ojSJxNyKB0kl5VdFsFE207egFttpiBFCWyz2dsJP5cWq0fH
         3EP6bMcZ/NNzKmSloREq0MT74qTYyKKdJniVNAw3gBtWQxPJo0EMIz5sY2d7B/kgHNz2
         +KKsv+YaOuI5DZJxowvjfXpyud1SpHRUEwijpaCgPphPBU1Ga15kWLCo3FDDSNugDq71
         eb1w==
X-Gm-Message-State: ALoCoQnDiOT6XX4JDH7RAq6eu0SgcKzCiMcsSfKGfwerA1Jkz48kijLxlbg44+Ox9HYQrLo8Lx6s
MIME-Version: 1.0
X-Received: by 10.140.91.45 with SMTP id y42mr16635604qgd.90.1421341085766;
 Thu, 15 Jan 2015 08:58:05 -0800 (PST)
Received: by 10.140.19.72 with HTTP; Thu, 15 Jan 2015 08:58:05 -0800 (PST)
In-Reply-To: <54B7EC8D.5050505@imgtec.com>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
        <1411076851-28242-19-git-send-email-abrestic@chromium.org>
        <54B7AB95.4080501@imgtec.com>
        <54B7EAE6.8040503@imgtec.com>
        <54B7EC8D.5050505@imgtec.com>
Date:   Thu, 15 Jan 2015 08:58:05 -0800
X-Google-Sender-Auth: NHM7yHQR3tBJfNVFDDTrSrROODU
Message-ID: <CAL1qeaFZvtc1sv4HQ+PLHFjm4OgUiNcAhzcFtQeeGbB8Byhj3g@mail.gmail.com>
Subject: Re: [PATCH V2 18/24] irqchip: mips-gic: Stop using per-platform
 mapping tables
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Qais Yousef <qais.yousef@imgtec.com>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45130
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

Hi James, Qais,

On Thu, Jan 15, 2015 at 8:36 AM, Qais Yousef <qais.yousef@imgtec.com> wrote:
> On 01/15/2015 04:29 PM, James Hogan wrote:
>>
>> On 15/01/15 11:59, James Hogan wrote:
>>>
>>> Hi Andrew,
>>>
>>> On 18/09/14 22:47, Andrew Bresticker wrote:
>>>>
>>>> Now that the GIC properly uses IRQ domains, kill off the per-platform
>>>> routing tables that were used to make the GIC appear transparent.
>>>>
>>>> This includes:
>>>>   - removing the mapping tables and the support for applying them,
>>>>   - moving GIC IPI support to the GIC driver,
>>>>   - properly routing the i8259 through the GIC on Malta, and
>>>>   - updating IRQ assignments on SEAD-3 when the GIC is present.
>>>>
>>>> Platforms no longer will pass an interrupt mapping table to gic_init.
>>>> Instead, they will pass the CPU interrupt vector (2 - 7) that they
>>>> expect the GIC to route interrupts to.  Note that in EIC mode this
>>>> value is ignored and all GIC interrupts are routed to EIC vector 1.
>>>>
>>>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>>>> Acked-by: Jason Cooper <jason@lakedaemon.net>
>>>> Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
>>>> Tested-by: Qais Yousef <qais.yousef@imgtec.com>
>>>
>>> This commit (18743d2781d01d34d132f952a2e16353ccb4c3de) appears to break
>>> boot of interAptiv, dual core, dual vpe per core, on malta with
>>> malta_defconfig.
>>>
>>> It gets to here:
>>> ...
>>> CPU1 revision is: 0001a120 (MIPS interAptiv (multi))
>>> FPU revision is: 0173a000
>>> Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
>>> Primary data cache 64kB, 4-way, PIPT, no aliases, linesize 32 bytes
>>> MIPS secondary cache 1024kB, 8-way, linesize 32 bytes.
>>> Synchronize counters for CPU 1: done.
>>> Brought up 2 CPUs
>>>
>>> and then appears to just hang. Passing nosmp works around it, allowing
>>> it to get to userland.
>>>
>>> Is that a problem you've already come across?
>>>
>>> I'll keep debugging.
>>
>> Right, it appears the CPU IRQ line that the GIC is using doesn't get
>> unmasked (STATUSF_IP2) when a new VPE is brought up, so only the first
>> CPU will actually get any interrupts after your patch (including the
>> rather critical IPIs), i.e. hacking it in vsmp_init_secondary() in
>> smp-mt.c allows it to boot.
>>
>> Hmm, I'll have a think about what the most generic fix is, since
>> arbitrary stuff may or may not have registered handlers for the raw CPU
>> interrupts (timer, performance counter, gic etc)...
>>
>> Cheers
>> James
>>
>
> Is this similar to the issue addressed by this (ff1e29ade4c6 MIPS: smp-cps:
> Enable all hardware interrupts on secondary CPUs)?

I believe so.

James, I think you can apply a similar patch to smp-mt.c:vsmp_init_secondary.

Thanks,
Andrew
