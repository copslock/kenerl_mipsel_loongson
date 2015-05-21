Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 00:24:47 +0200 (CEST)
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34015 "EHLO
        mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013595AbbEUWYpKU7O4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 00:24:45 +0200
Received: by qctt3 with SMTP id t3so699275qct.1
        for <linux-mips@linux-mips.org>; Thu, 21 May 2015 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=U4vPuth0hlgzPEhxBhXOl/y2tVde95zhR1ikfZPNps4=;
        b=VOKCjLlVzHNL8JFv6qxpAwqtwS5SOIz7AGllFk1ff081kN+3GGIyYMKCscRfM0l27L
         saulvG+2f2U4sWGXw0qZ7cye8WyrYs6ES3ZAee8ZorRH1eAM1IQXqhBsZykztSs7vo9f
         tXrYZgXzY64WxyZU/ooEhONNPrXnx5ukJs8hYVM0TR3jKXu1+ggh/z+Uf6cEvBx5A0xt
         /bWO2ew+O/Lv0FDd+44JD/jvGlCEB4BJv4J4NgFxk8BkbWM81HSI6CgEMH5p2YYfr5S+
         q+MnWP4T02Sly3f7jwUHXZQKpchoZQ9qtkV6CAWT//T74r61NMNPDtDs60pQ3dnzX5QP
         HE6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=U4vPuth0hlgzPEhxBhXOl/y2tVde95zhR1ikfZPNps4=;
        b=Rw+KALprXuudWDx7tplbP0NuO82MBLG520uNXpcM3dDpVFS1viHMA2bRqdgWMVXdNT
         fqRAC+F26AwQe7Uz2GRMEuT464yBo+pHSkNoDi5O7lCxnGVxhXX58RXiNfVBYq8tPWVv
         SVtcc/679GT5jDLOBoZtAb21z0BcTF+BKuvS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=U4vPuth0hlgzPEhxBhXOl/y2tVde95zhR1ikfZPNps4=;
        b=SpGadnCAllvtZNg6k+HwFDxBU06rABvco225kDn34uLZ9f3o4GhKkpqAMFun+jju71
         o70MXqe5oQ7XZX+usEOMAEdDo0TJ+1Hm+NRyxkvHAfo8tFKFhMHUHMp0PR2UEGEjwkrv
         mvV3DwbZGKEvkbezDF3sgHvLG6dcBZIzUwQgSLPYw+g5b2aE05u5JZ9AWy9iMCztlUj+
         nVcbCtrp7B9XdausU162WRjraEJBh3D980gxWKyX++EML8Y2WpRzV8fJAwlFVXKF/Gp6
         Xn9ZTfskosvsIlZIYbI/7j3fDsZ1xN6wQLfWS3ovEQbtChXCeBdTvTxQC6+qUbGWV/9Z
         xrzQ==
X-Gm-Message-State: ALoCoQmnrYRVGpJOM2ZINbdvePaeJyF559yE0UfD0xLcws8yLxytz01hWmxC/qQ0OS5S7jasuKA5
MIME-Version: 1.0
X-Received: by 10.55.31.168 with SMTP id n40mr11827634qkh.56.1432247081954;
 Thu, 21 May 2015 15:24:41 -0700 (PDT)
Received: by 10.140.23.72 with HTTP; Thu, 21 May 2015 15:24:41 -0700 (PDT)
In-Reply-To: <1432244260-14908-4-git-send-email-ezequiel.garcia@imgtec.com>
References: <1432244260-14908-1-git-send-email-ezequiel.garcia@imgtec.com>
        <1432244260-14908-4-git-send-email-ezequiel.garcia@imgtec.com>
Date:   Thu, 21 May 2015 15:24:41 -0700
X-Google-Sender-Auth: sJ5FYrkBLo1nwJ24WlvIzxbkuDE
Message-ID: <CAL1qeaFkzpH+nGqRPOuY-L62jP8NgZWP0WxKTYKXZDpe1sSojg@mail.gmail.com>
Subject: Re: [PATCH 3/7] clocksource: mips-gic: Split clocksource and
 clockevent initialization
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47532
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

On Thu, May 21, 2015 at 2:37 PM, Ezequiel Garcia
<ezequiel.garcia@imgtec.com> wrote:
> This is preparation work for the introduction of clockevent frequency
> update with a clock notifier. This is only possible when the device
> is passed a clk struct, so let's split the legacy and devicetree
> initialization.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> ---
>  drivers/clocksource/mips-gic-timer.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
> index c4352f0..22a4daf 100644
> --- a/drivers/clocksource/mips-gic-timer.c
> +++ b/drivers/clocksource/mips-gic-timer.c
> @@ -142,11 +142,6 @@ static void __init __gic_clocksource_init(void)
>         ret = clocksource_register_hz(&gic_clocksource, gic_frequency);
>         if (ret < 0)
>                 pr_warn("GIC: Unable to register clocksource\n");
> -
> -       gic_clockevent_init();
> -
> -       /* And finally start the counter */
> -       gic_start_count();
>  }

Instead of duplicating this bit in both the OF and non-OF paths, maybe
it would be better to do the notifier registration in
gic_clockevent_init(), either by passing around the struct clk or
making it a global?
