Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Mar 2017 11:16:13 +0100 (CET)
Received: from mail-it0-x22c.google.com ([IPv6:2607:f8b0:4001:c0b::22c]:38300
        "EHLO mail-it0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992289AbdCOKQDegvFG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Mar 2017 11:16:03 +0100
Received: by mail-it0-x22c.google.com with SMTP id m27so16123240iti.1
        for <linux-mips@linux-mips.org>; Wed, 15 Mar 2017 03:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fH2HIWl9VeNxHlgCmQdSYSLtnZ8l66zMKX9CEtpGduw=;
        b=YRiVSLwTwTHqoCwxl63vCB/ObO+U1JxIxiQpfzsQWcvwosdknx/T3EWYsaoLoqDEx3
         vY+sgyzkr9+a2rc/tTgv/BAr2lZ184bTITJWdCg0DAWtmdKG6VyTHaK9ace1aCMDonsU
         3QuN9VdiSJYUUgp6uLHnq4YSiiBnwH3/5A2t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fH2HIWl9VeNxHlgCmQdSYSLtnZ8l66zMKX9CEtpGduw=;
        b=IbxyPFOdeF9QCR0BiEvx/o4xMYT2AOmYZOaIY7MMOL7PzQwmwSuvlL7eghQp/nW9qe
         dMpXqZfVp8PdHo/kIKmILSyF+0Pk2RWnjLX6QkaRYsv4L5rNvU4y5/5LliyCIOktFEJI
         aosRAt8Kyvnvxh0KWzKh80ThDznxI64ukxEeeLC/ReCOI8jxDFoliqxQ7a112aBVtkKl
         b2fMDRVIaqE2TAaD++MU2hcVqO/8u41KfPKC4UxGuNXGKwo1ybi2oyOgsTkx5W1w/zIR
         QsVP7mlvyJtjOHrx7TnDPVRmvmKuSJYE/Zu52fY8Kf8cZxN4v2jnnA4/Lj8MS5rhQrSg
         iatA==
X-Gm-Message-State: AFeK/H34bJZLnd2sF+82UsWLqTyfKw2hS8oyOwevZjUcrhCm082FdOhZU2ndt6nJrBhEaOhD4adwg9w/Z5du48va
X-Received: by 10.36.181.3 with SMTP id v3mr1894917ite.25.1489572957782; Wed,
 15 Mar 2017 03:15:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.134.193 with HTTP; Wed, 15 Mar 2017 03:15:56 -0700 (PDT)
In-Reply-To: <1489001744-26545-2-git-send-email-nathan.sullivan@ni.com>
References: <1489001744-26545-1-git-send-email-nathan.sullivan@ni.com> <1489001744-26545-2-git-send-email-nathan.sullivan@ni.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Mar 2017 11:15:56 +0100
Message-ID: <CACRpkdYfaigjtzcp6aeiQS5BCLyEQqOuHFzDP52Wmie+cu=fiw@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mmio: add support for NI 169445 NAND GPIO
To:     Nathan Sullivan <nathan.sullivan@ni.com>
Cc:     Alexandre Courbot <gnurou@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57288
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Wed, Mar 8, 2017 at 8:35 PM, Nathan Sullivan <nathan.sullivan@ni.com> wrote:

> The GPIO-based NAND controller on National Instruments 169445 hardware
> exposes a set of simple lines for the control signals.
>
> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>

Oh a newer patch with comments exist. I take out the other patch then
and wait for v3.

Yours,
Linus Walleij
