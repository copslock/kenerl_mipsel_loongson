Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Apr 2017 14:55:47 +0200 (CEST)
Received: from mail-pg0-x242.google.com ([IPv6:2607:f8b0:400e:c05::242]:34789
        "EHLO mail-pg0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993543AbdDXMzk5xr0m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Apr 2017 14:55:40 +0200
Received: by mail-pg0-x242.google.com with SMTP id t7so473125pgt.1
        for <linux-mips@linux-mips.org>; Mon, 24 Apr 2017 05:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7I08Yqr367W9gc66oZ09XBywlQfUzWHfvA4dBjZAQEk=;
        b=AN2a3X5zzgwu1zXHzDxSbsyw3riVXWQLvRuxq6bubqTJMFKI+h7kMHplVagTNraVS/
         DEeHGiN1Xq3rLj9WAbMCMOB+4VCSlHdMyLgWkb+zChGfkqZXX/Nj13AgIYwLlZK3Alx3
         OgqTv03A3AQAwlpet1KD3tarPt/H0+O2oZeKZoE9jhCP3cuern+IpB63V0axg4Rzwziq
         07Ot+Kf3yLTCwC23qGj5Mj0EGpuJeVVhtroWHmLuGyFH1XT3Gn5WlJILtY7uDDM886vQ
         diy+vyATgjztKwxoRTXQ6bwbsWUpsPRKfPuzzAdLhLdqaQUYrhHyQxBk9uy0i9y8yLy8
         f7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7I08Yqr367W9gc66oZ09XBywlQfUzWHfvA4dBjZAQEk=;
        b=trGtA3VSDg8xtftTlsD1LAJY2YiUUFjij8uMmKIvt+mCpgdQfMraFahD5tsjby1UqU
         kxtqtXjllefnWDVsmzVj/REmbsJMMD95QxODjBWoPMupyrWZViSvB0OBF9iC3jblMYO4
         SK4MhF5fdvg2nGBGxWRC/IyW4Y4HuBRsognsnPERPZSjJKww90STTPf7Excmg6I3/EU1
         78qQ4Cp8T6ZLnhUda783z9JK5QzKfFQTp46QfoboorWVj1ZtQ6sSjIsSHYaj8KARxarP
         6HDQlRyHlxbDOJfCLazc6Ff/W4cKMzACAS4eApBSr/TQr4CAxUkFxfVtsXFliZOpBpNC
         pQSA==
X-Gm-Message-State: AN3rC/5LAsAAzuQkG0QKTzRvQHEb5X0K9WmrzBhmkZ36L7/YNpPKGzKt
        gQ5cqLKlg9uVtw==
X-Received: by 10.99.122.81 with SMTP id j17mr5531361pgn.111.1493038535051;
        Mon, 24 Apr 2017 05:55:35 -0700 (PDT)
Received: from mint-host ([180.102.125.8])
        by smtp.gmail.com with ESMTPSA id n65sm30936406pga.8.2017.04.24.05.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 05:55:33 -0700 (PDT)
From:   Yang Ling <gnaygnil@gmail.com>
X-Google-Original-From: Yang Ling <gnaygnail@gmail.com>
Date:   Mon, 24 Apr 2017 20:55:26 +0800
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Yang Ling <gnaygnil@gmail.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2 1/2] pwm: loongson1: Add PWM driver for Loongson1 SoC
Message-ID: <20170424125436.GA3949@mint-host>
References: <20170215144531.GA39000@ubuntu>
 <20170406161835.GA19312@ulmo.ba.sec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406161835.GA19312@ulmo.ba.sec>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <gnaygnil@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gnaygnil@gmail.com
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

Hi, Thierry,

I am sorry for the late reply.

For some historical reasons, Loongson1x series SoCs is still unable to support the device tree.
So drivers need to rely on some register-related macro definitions in loongson1.h(arch/mips/include/asm/mach-loongson32/loongson1.h).
The driver is currently tested on the Loongson1C development board.
We plan to solve the problem together after the SoCs bootloader supports the device tree.

Thanks for your friendly reminder.

Yang

On Thu, Apr 06, 2017 at 06:18:35PM +0200, Thierry Reding wrote:
> On Wed, Feb 15, 2017 at 10:45:31PM +0800, Yang Ling wrote:
> > Add support for the PWM controller present in Loongson1 family of SoCs.
> > 
> > Signed-off-by: Yang Ling <gnaygnil@gmail.com>
> > 
> > ---
> > V2:
> >   Remove ls1x_pwm_channel.
> >   Remove period_ns/duty_ns check.
> >   Add return values check.
> > ---
> >  drivers/pwm/Kconfig         |   9 +++
> >  drivers/pwm/Makefile        |   1 +
> >  drivers/pwm/pwm-loongson1.c | 148 ++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 158 insertions(+)
> >  create mode 100644 drivers/pwm/pwm-loongson1.c
> 
> Looks like this doesn't compile because it uses register definitions
> from loongson1.h that aren't what the driver expects. Looks like the
> driver wants parameterized ones, but those present in the kernel are
> not.
> 
> Any plans on fixing that? How did you build-test this?
> 
> Thierry
