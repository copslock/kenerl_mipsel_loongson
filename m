Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 19:41:03 +0100 (CET)
Received: from mail-qg0-f53.google.com ([209.85.192.53]:34772 "EHLO
        mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010678AbbAPSkz47CGr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 19:40:55 +0100
Received: by mail-qg0-f53.google.com with SMTP id a108so9173477qge.12
        for <linux-mips@linux-mips.org>; Fri, 16 Jan 2015 10:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zNIo5VjIEEKU7D8/jI1XGAoRUe2XPQI8g/GuSLf1r6A=;
        b=EuqN/YIEdK7iL6kR+8a03TH4zXAp4f0N1pmo2ayE36jlXRBRXKhtj8s7jXyMiEGgph
         HeHXUPql018gg3Xb0H1A16cLHSS9SEqLnMqPlK0qJWwDZZDq5BjNpzIZzo3IUsBlhTa1
         J3QnvRoLVTWvyTIMMG9H9qg6R/iUuceo7xFYaERYWrDO0lW141DWR8Ik7iyEw34CziWp
         9RW6CINuMIn0EDcCoPP9ldFH/phVZeW1QOklWtZmLNDdf0Qu72JzyLsSnPaprqyMZLbr
         L+6bc6fxErJR1oo0S7Auzxzi+VAbuhg8zCqdW122a0Jf4uSv/lXBkUqgaBBJ0ejf/r2V
         G9+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zNIo5VjIEEKU7D8/jI1XGAoRUe2XPQI8g/GuSLf1r6A=;
        b=CcN5E46iiS0W1hUB/S54lCsll1hGD6ePB7eKa96ZpECCma38ETH8HMMpHQpCkkZna3
         lABjgF4yw/nGJoexb5B6vA28a/LBNfD8b0p6cuBLWmCvPrt19z2vfgre+b4r73QpyRVm
         UEWYlGu/OPKstWOPOnka054Xu9Gn7issn/1Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zNIo5VjIEEKU7D8/jI1XGAoRUe2XPQI8g/GuSLf1r6A=;
        b=BkldNGyhQSOvoF5TsGeDok5N/1aHCYt4fi9snEYqp2AV6SrsvY3VYIdXrJV9t9xI89
         ImkzIquNqiGZOWklVRPh3FhsEKed+IWPnrw0uQXXONqu3hOLyvL3CCyVcU+kj2UTo/Wd
         HctDoDKqmuYrELUTKl4e9PINPjhnh6P18Aq+KrgBQS/UP9a2j9YFHWiNHih5XinsvdbB
         AMhFGdpnLPOU5/y/ktZeisbWMrykj9Ikx2b6TSPv2geMoMZWp2N2Pp4IBsgQ0Cw2qGTc
         0OSiXzqjUCYOgfEGpKWSfAmVi4klRY1AjEFeX41W3bPp6IGZTwuoNA2tl19Py1LcGfBy
         jc9Q==
X-Gm-Message-State: ALoCoQlcJOvvLLAQqROTSb1hhTvSmVEaIQS1+Ww5n0mCZNP7r3Ra+5ykm1ZjEI6phx0rw2lHUgkB
MIME-Version: 1.0
X-Received: by 10.140.91.45 with SMTP id y42mr25815941qgd.90.1421433649893;
 Fri, 16 Jan 2015 10:40:49 -0800 (PST)
Received: by 10.140.19.72 with HTTP; Fri, 16 Jan 2015 10:40:49 -0800 (PST)
In-Reply-To: <1421406646-28920-1-git-send-email-james.hogan@imgtec.com>
References: <1421406646-28920-1-git-send-email-james.hogan@imgtec.com>
Date:   Fri, 16 Jan 2015 10:40:49 -0800
X-Google-Sender-Auth: xIoSxoX3UbB6c2l9rBph-B5EDOw
Message-ID: <CAL1qeaFuUZDt9STQWgvf9yJ5tGV6UCHoohQM63_rT6_vpw3r1w@mail.gmail.com>
Subject: Re: [PATCH v3.19] MIPS: smp-mt,smp-cmp: Enable all HW IRQs on
 secondary CPUs
From:   Andrew Bresticker <abrestic@chromium.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45233
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

On Fri, Jan 16, 2015 at 3:10 AM, James Hogan <james.hogan@imgtec.com> wrote:
> Commit 18743d2781d0 ("irqchip: mips-gic: Stop using per-platform mapping
> tables") in v3.19-rc1 changed the routing of IPIs through the GIC to go
> to the HW0 IRQ pin along with the rest of the GIC interrupts, rather
> than to HW1 and HW2 pins.
>
> This breaks SMP boot using the CMP or MT SMP implementations because HW0
> doesn't get unmasked when secondary CPUs are initialised so the IPIs
> will never interrupt secondary CPUs (nor any other interrupts routed
> through the GIC).
>
> Commit ff1e29ade4c6 ("MIPS: smp-cps: Enable all hardware interrupts on
> secondary CPUs") fixed this in advance for the CPS SMP implementation by
> unmasking all hardware interrupt lines for secondary CPUs, so lets do
> the same for the CMP and MT implementations.
>
> Fixes: 18743d2781d0 ("irqchip: mips-gic: Stop using per-platform mapping tables")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Andrew Bresticker <abrestic@chromium.org>
> Cc: Qais Yousef <qais.yousef@imgtec.com>
> Cc: linux-mips@linux-mips.org

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>

> Note that CMP is still broken with Malta since the GIC driver now routes
> the local timer interrupt to a different IRQ pin to that expected by the
> CMP wait loop (see commit e9de688dac65 ("irqchip: mips-gic: Support
> local interrupts")), so the secondary CPU never completes its wait
> instruction to poll the LAUNCH_FGO flag, but that is a different issue.

I'm guessing this wait loop is in firmware?  Should the GIC just leave
the timer IRQ routing alone then?
