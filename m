Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jan 2015 18:19:43 +0100 (CET)
Received: from mail-ie0-f175.google.com ([209.85.223.175]:42780 "EHLO
        mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010151AbbAHRTknsdvX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Jan 2015 18:19:40 +0100
Received: by mail-ie0-f175.google.com with SMTP id x19so10580051ier.6
        for <linux-mips@linux-mips.org>; Thu, 08 Jan 2015 09:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2MQfTbBrSX5K3fdGPZDQx9O5KZrSOOD5Z1uK/5MmwOs=;
        b=nd/NmqafkHXTna8fPZ4c26gpnNK3DdfpqN2HnvY9jCAIrOVNrim+rFX2jJ7YG246uM
         ULH8WrEm9ZMLu699hIa0apYJQT2d+N9UeNLa+BEp7P77Mt8K3fIe/SDZfZGeA2ijvSmq
         7WrKTnwIlkQMYUwL9Rp5l+NyfOk7qHqAxCzqUkWpNVcxl45uejDoCRPN1UyJdAG2IuL3
         ZDfTT/bFuNklNI+CsfxOn5lc9GC2noCDNkRyA8vMZQl8Jan1YYP3WFLp4zzyDmHrBUrz
         MFhWvwQVuoWoi1loyqLEelf8p/aeGJbHAeszReBkjYw8/CfL4cqZfvWYYUiqBsxSsq6H
         FZ1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2MQfTbBrSX5K3fdGPZDQx9O5KZrSOOD5Z1uK/5MmwOs=;
        b=ifbgy173mj+n0JQTx7hsLieBjH8J2Rrc6w6rtFj1FvCJlzObH4LgEukaG92FwFLVYs
         R1h/m+T0+zdU6/fdydnU+GZN6Cx/n2KqheyRSawvTn3pJJPGxD9c1/DUS5437suE43Fs
         zIFBFDaGQpAkSu26AB42m/Z2hDcnZrneH9hL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2MQfTbBrSX5K3fdGPZDQx9O5KZrSOOD5Z1uK/5MmwOs=;
        b=BtkvjutxhP2ePAo1EWgaeio62uARMHtRQyO/2ws5eE0KQ0hcYLCITRdy5teZ2n5hls
         W1YQcIPXwc8Jn/tBpzuFfvtWUBngMwZaHXQ76igEUlwaUD24tsD46bCeIZxZDwOaF+8J
         OZDIkHCo76xq8awEWJFCZQgWh1grTlZHAfppfTQzDRRNaDNhqUJZu1K+W+hM8PkqGiwp
         GuWzuSJvycnkwxF/A50G2WmNQkIE+701LhXnKHPjBrer4JlZyRS5hxRySOVi6D8ogHNE
         xEAINK40M1eWyzIzvx33out8iyKTOHRRhgSw0CHwKMNuVcPEsU2WRADsp/4uRMDLBtcX
         ZP6A==
X-Gm-Message-State: ALoCoQnkLPohOTeZoJcifIS5ZpXGCg7uIr/eMa2BzRKVMQq6Wu9FNsfWZ5qNG6j3dFJmHyyLVDbr
MIME-Version: 1.0
X-Received: by 10.42.62.71 with SMTP id x7mr8880369ich.61.1420737574639; Thu,
 08 Jan 2015 09:19:34 -0800 (PST)
Received: by 10.64.230.234 with HTTP; Thu, 8 Jan 2015 09:19:34 -0800 (PST)
In-Reply-To: <1420729599-22034-1-git-send-email-james.hogan@imgtec.com>
References: <1420729599-22034-1-git-send-email-james.hogan@imgtec.com>
Date:   Thu, 8 Jan 2015 09:19:34 -0800
X-Google-Sender-Auth: akOjKz0GgUAi_dOdJX1r8EsKdJA
Message-ID: <CAL1qeaHWce-oiFe-oe3NLUaio_Fsqx2rvb_amS2OViDFD2=9Og@mail.gmail.com>
Subject: Re: [PATCH] MIPS: cevt-r4k: Use Cause.TI for timer pending
From:   Andrew Bresticker <abrestic@chromium.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45014
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

On Thu, Jan 8, 2015 at 7:06 AM, James Hogan <james.hogan@imgtec.com> wrote:
> The cevt-r4k driver used to call into the GIC driver to find whether the
> timer was pending, but only with External Interrupt Controller (EIC)
> mode, where the Cause.IP bits can't be used as they encode the interrupt
> priority level (Cause.RIPL) instead.
>
> However commit e9de688dac65 ("irqchip: mips-gic: Support local
> interrupts") changed the condition from cpu_has_veic to gic_present.
> This fails on cores such as P5600 which have a GIC but the local
> interrupts aren't routable by the GIC, causing c0_compare_int_usable()
> to consider the interrupt unusable so r4k_clockevent_init() fails.
>
> The previous behaviour wasn't really correct either though since P5600
> apparently supports EIC mode too, so lets use the Cause.TI bit instead
> which should be present since release 2 of the MIPS32/MIPS64
> architecture. In fact multiple interrupts can be routed to that same CPU
> interrupt line (e.g. performance counter and fast debug channel
> interrupts), so lets use Cause.TI in preference to Cause.IP on all cores
> since release 2.
>
> Fixes: e9de688dac65 ("irqchip: mips-gic: Support local interrupts")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Andrew Bresticker <abrestic@chromium.org>
> Cc: Qais Yousef <qais.yousef@imgtec.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mips@linux-mips.org

Thanks for catching this!

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
