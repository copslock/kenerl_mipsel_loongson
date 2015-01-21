Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 15:16:33 +0100 (CET)
Received: from mail-qc0-f177.google.com ([209.85.216.177]:34248 "EHLO
        mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012044AbbAUOQb4ItpS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 15:16:31 +0100
Received: by mail-qc0-f177.google.com with SMTP id p6so11045595qcv.8
        for <linux-mips@linux-mips.org>; Wed, 21 Jan 2015 06:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VgagbcO96ukvY5IsLRNgQJalOj0A8n5gVmFefHDxxP4=;
        b=jJ3eoi9iCegSzMThw7zuyr5g5odRdA2JljTqhb2mmO770J5pgKZRjBjgGbp5JRAHtR
         SjIDXfgvG72B/YfI4KLUF+TbI2rfpYEw/LN6Urle9nC5oXtTHjV2tlfA91LQN/xTuTc7
         jRxlsxPFkPcFP6Xh+p/hJq7LQ8rLyTPZAMeFFgianBGYC4pmlwqU+bSUocWNOx98h/A9
         1Q4ISDGjQbqDPGd+sx4lLBm0SgYghji2S8rlgc+hDKJsKpJSGvcbdvE8RV0/9LpOmcqw
         HV/KkoovieyqSAxRpJ9IuN1UImLRqbvifGx6m2r1WVUy4RyGMgMgj196YeddWdHXBrNU
         Vm4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VgagbcO96ukvY5IsLRNgQJalOj0A8n5gVmFefHDxxP4=;
        b=NE4cNrivnbgWhdj+BD57I/pFC19xdhpkUtvEwKQEcmu/4qNHwaQp70h4zJmPO6NSKM
         JDlrjn1rEl522T85HT48Tc+jgs2MW9ewyWwOtp0dWxXQxaD70R1HafI0EF9lod3KAeWb
         PkjE2DPv+Il5gwEVg4H8lGJBkt0MmNfGzMGd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VgagbcO96ukvY5IsLRNgQJalOj0A8n5gVmFefHDxxP4=;
        b=hN+aw2HFlphtMPJLD4/EdpTn5rEfVkkDafxQmF5/6dP90vkny5JgOFRtUfOAXfn9ve
         MfvpfLG9X7OB7GZct7QPleiM8P90SQopMPADUQ9yi2HZhyY999/ULrRUuNyOk5i2T+aJ
         HADcRWXLwACeO+Dg769i1vIrb5fqDt7L7RqW4culf6r8YO3/W3tdW16Ewl1D28dA8pvY
         eiWmeb8WRT0YKMkEoVLxJBFKK9QbNOZuO/8s1jKpnk5HhCdbIXYMXiF/pldPzTQPmMrI
         P3TrX9kzjousXmFhE4BuTH+XvJEwOJIQXKpXjYOCMYUxM75r1tTbGHrUXvarzNd/5d4y
         y3aA==
X-Gm-Message-State: ALoCoQmg30xjdIAYcVzUrgeNevqkgnoU6wSivQyS+JbZeld/qY5Wuh08PkQnMMR2ehFm0TwjUHGN
MIME-Version: 1.0
X-Received: by 10.224.137.129 with SMTP id w1mr66769262qat.91.1421849786104;
 Wed, 21 Jan 2015 06:16:26 -0800 (PST)
Received: by 10.140.19.72 with HTTP; Wed, 21 Jan 2015 06:16:25 -0800 (PST)
In-Reply-To: <1421681904-20881-1-git-send-email-james.hogan@imgtec.com>
References: <1421681904-20881-1-git-send-email-james.hogan@imgtec.com>
Date:   Wed, 21 Jan 2015 06:16:25 -0800
X-Google-Sender-Auth: E4TNoS34gGCmPT3ntkkGZn8J50E
Message-ID: <CAL1qeaFS2W=wabEd2Y=XEg9M=gwbTGgbv4wGfWv85Lj85NevZQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip: mips-gic: Avoid rerouting timer IRQs for smp-cmp
From:   Andrew Bresticker <abrestic@chromium.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45410
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

On Mon, Jan 19, 2015 at 7:38 AM, James Hogan <james.hogan@imgtec.com> wrote:
> Commit e9de688dac65 ("irqchip: mips-gic: Support local interrupts")
> changed the GIC irqchip driver so that all local interrupts were routed
> to the same CPU pin used for external interrupts. Unfortunately this
> causes a regression when smp-cmp is used. The CPUs are started by the
> bootloader and put in a timer based waiting poll loop, but when their
> timer interrupts are rerouted to a different IRQ pin which is not
> unmasked they never wake up.
>
> Since smp-cmp support is deprecated and everybody who was using it
> should be switching to smp-cps which brings up the secondary CPUs
> without bootloader assistance, I've gone for the simple fix which can be
> easily removed once smp-cmp is removed, rather than a fully generic fix.
>
> In __gic_init() the local GIC_VPE_TIMER_MAP register is read to find the
> boot-time routing of the local timer interrupt, and a chained handler is
> added to that CPU pin as well as the normal one.
>
> Fixes: e9de688dac65 ("irqchip: mips-gic: Support local interrupts")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Andrew Bresticker <abrestic@chromium.org>
> Cc: Qais Yousef <qais.yousef@imgtec.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mips@linux-mips.org

Looks good to me.

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
