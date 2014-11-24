Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 20:29:47 +0100 (CET)
Received: from mail-vc0-f180.google.com ([209.85.220.180]:58100 "EHLO
        mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006914AbaKXT3qbdUAa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 20:29:46 +0100
Received: by mail-vc0-f180.google.com with SMTP id im6so4327231vcb.25
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 11:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qw3T/y5Q9k0lxRnqEY2jSGesVJk6xD0aQyArmqjYRVE=;
        b=EeIOxVzrKA62a9GBkhP26fINc3uuyhv8Nx6+PVoIMHddAQ+zS5KXy68S3UJzQZmmjo
         ju/Io3EaWpNt2wXx5b4/0Ia941+ZFeWjTEW85/faz7WWw+caJWsFMrnzIsJIBpVt3Qul
         uyzxHts5CBN3VI4PNmiUBGF5zNDM1G49A72BA1ZA784wvULcYRBTMmOQ2SRDI7P9Sx7Y
         VItnzDHz0rtsZyM2qvy2LXLx2vl8PVsCs/ai3W6FG5NRt8yjJI2aB+qeFDpDMeJaeJmY
         wHzNqp7FQp0DKSHtcxdqcnvvwAbzyrSrk8dFXXo79ftRGcBP9xLE45L8DlJXSJTqqMrj
         PVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qw3T/y5Q9k0lxRnqEY2jSGesVJk6xD0aQyArmqjYRVE=;
        b=g5o0Dv0qAtuFpBFjCMKL+qOkEQu36op/tolnqbwnU1wntJv8Z5/l/KSilIstk/nAHX
         o3pvhz7mHb5c1YPxQMOYcycheSAqeDogx+hJwTJKnG1sEhx1/WHRo1M2jiyT48bddxoN
         ujrx0+oVlK46/meY13TX1lwhAXVrAuTrNI5mH84ADO0qMFyLM3qncGaEfeXtODeApHBd
         EtHjvuXp/A4XuCTQIyfFTPVym+2xhcjcYXrzVAYrArk1CpwXeoLOdxHRfWPKB/5jUUe+
         wJXn6+MyvfYjjUwiYQE0de5D0U4c/QbL76tbTcAkf8elOKmkEdtjZdpZzHUHT6om9DGY
         g3PA==
X-Gm-Message-State: ALoCoQmzEbvGcnXdNHRCQX9iWERMeESxxstvQcwF4ujRZ9LE67Fz+FOu6Zb5YoSbWPywy6S4GGCp
MIME-Version: 1.0
X-Received: by 10.221.38.66 with SMTP id th2mr12779744vcb.21.1416857380723;
 Mon, 24 Nov 2014 11:29:40 -0800 (PST)
Received: by 10.52.168.200 with HTTP; Mon, 24 Nov 2014 11:29:40 -0800 (PST)
In-Reply-To: <1416796846-28149-12-git-send-email-cernekee@gmail.com>
References: <1416796846-28149-1-git-send-email-cernekee@gmail.com>
        <1416796846-28149-12-git-send-email-cernekee@gmail.com>
Date:   Mon, 24 Nov 2014 11:29:40 -0800
Message-ID: <CAL1qeaG+cmQDW3ceqq4kGgWBsf4RgfFpQ76OG0dg3SJy6nitgw@mail.gmail.com>
Subject: Re: [PATCH V3 11/11] MIPS: Add multiplatform BMIPS target
From:   Andrew Bresticker <abrestic@google.com>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>, jfraser@broadcom.com,
        Dmitry Torokhov <dtor@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Jonas Gorski <jogo@openwrt.org>, Arnd Bergmann <arnd@arndb.de>,
        computersforpeace@gmail.com,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44394
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@google.com
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

> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c

> +void __init plat_time_init(void)
> +{
> +       struct device_node *np;
> +       u32 freq;
> +
> +       np = of_find_node_by_name(NULL, "cpus");
> +       if (!np)
> +               panic("missing 'cpus' DT node");
> +       if (of_property_read_u32(np, "mips-hpt-frequency", &freq) < 0)
> +               panic("missing 'mips-hpt-frequency' property");
> +       of_node_put(np);
> +
> +       mips_hpt_frequency = freq;
> +}

Could you use common clock framework for this?  Isn't the HPT just a
fixed factor of the CPU clock?  I'm planning on doing something very
similar for ImgTec MIPS SoCs, so perhaps this could go in a common
place, like the r4k clocksource driver?
