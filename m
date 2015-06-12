Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Jun 2015 18:25:23 +0200 (CEST)
Received: from mail-qc0-f170.google.com ([209.85.216.170]:36018 "EHLO
        mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007354AbbFLQZVVgaKS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Jun 2015 18:25:21 +0200
Received: by qcjl8 with SMTP id l8so12046387qcj.3
        for <linux-mips@linux-mips.org>; Fri, 12 Jun 2015 09:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GaPFpm1Ssq5OxKSEd8vAiATtFN8rUBiZlOWoaCBJp5Y=;
        b=gADy5zmmuL4GrH12zTUjl9eenhPIKut1+c0hgL++UDAofbd0oHFFI5qZoDTti7aDuI
         276GHu9u15ENNiETOjKW1xJispH0RWqlBGEXYLIE9hASRXuELEYpLGvyeVr7qlbO8w1K
         HAIYi+Q4GwG5UtSyw8jstCBe6/g1oxWJy169L3sYxguNetjinIKdoAVeHEG5oWTtVY7E
         24pnsDkNSzrI8bqjRA+y5+eZMgWWwawTzek6baxdmdgUTKzxuAAPXJpy5R3UKJ5iFSug
         U/2Ced737H0UCj0TyhyenukB5BtfuIYO0IOSG5opG6antl8u46GzcjR8w8aLbzLM2GhB
         ze2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GaPFpm1Ssq5OxKSEd8vAiATtFN8rUBiZlOWoaCBJp5Y=;
        b=nnaUVkdBoaypf6cQFQoUCdh6HrwLHQijhDKraVgr6CZVaFXqlMpDFzCXg05bNDzuie
         Mu3BGz3u0Ndsi6jB1D6iF8HTT0c+XwRCfh6gak8YZj7R9v0hmJupO9qMhzezAUSsfyy5
         Wl3AiFQCqy+F5/kIXj+cjiS5VW+sGMchRqhCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=GaPFpm1Ssq5OxKSEd8vAiATtFN8rUBiZlOWoaCBJp5Y=;
        b=QMexh+Iy8jDmW0YS3zIlnG60uTOLm6+XkWs4/IQaxvcwLm1W9DNjlos8x9SpsKr9Qg
         FYu26353ssPkkqfeRn+9eX3+N+M9prij1y5VYc4YwcYx6uqJI1esYufwqTwaYHRYwwSj
         gZHJbatnQqcVoERdbvjpveAj/C/G1bH5urIKFd3+9rCHYxIQIMFXpquTRXuYaqPVUaL3
         NIFEjb8zMXgu03z82trrEhim0gSnr1b/OXA+5bWGs18wao2Z+TXgnNjxJ2anfG3GY0Bq
         1Eg15o66ZiEGmk8oYlelA3MvLno1Ldec+oL7LLSgbKShCaoqkUPk/9hN0TOgc1wbmuXV
         2OSQ==
X-Gm-Message-State: ALoCoQkA+/ePW8KegO/OlE8TrW36Tg52xGqGTun8HXbsJ3djU9L5UMQ7SWR0+Ojt+XIBKD/lMHtM
MIME-Version: 1.0
X-Received: by 10.55.21.211 with SMTP id 80mr31432294qkv.11.1434126315585;
 Fri, 12 Jun 2015 09:25:15 -0700 (PDT)
Received: by 10.140.19.98 with HTTP; Fri, 12 Jun 2015 09:25:15 -0700 (PDT)
In-Reply-To: <1434096116-16750-1-git-send-email-rabin.vincent@axis.com>
References: <1434096116-16750-1-git-send-email-rabin.vincent@axis.com>
Date:   Fri, 12 Jun 2015 09:25:15 -0700
X-Google-Sender-Auth: Nv4kg9AuGA9v954R0JfSmwVmpYw
Message-ID: <CAL1qeaH59FwpRpOgxn+E=xMo4MKk0xSK2Z7kiFCyhHO0Syj7oQ@mail.gmail.com>
Subject: Re: [PATCH] irqchip: mips-gic: don't nest calls to do_IRQ()
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Rabin Vincent <rabin.vincent@axis.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rabin Vincent <rabinv@axis.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47938
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

On Fri, Jun 12, 2015 at 1:01 AM, Rabin Vincent <rabin.vincent@axis.com> wrote:
> The GIC chained handlers use do_IRQ() to call the subhandlers.  This
> means that irq_enter() calls get nested, which leads to preempt count
> looking like we're in nested interrupts, which in turn leads to all
> system time being accounted as IRQ time in account_system_time().
>
> Fix it by using generic_handle_irq().  Since these same functions are
> used in some systems (if cpu_has_veic) from a low-level vectored
> interrupt handler which does not go throught do_IRQ(), we need to do it
> conditionally.
>
> Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
