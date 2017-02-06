Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2017 07:39:07 +0100 (CET)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:32775
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991532AbdBFGi75s0k9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2017 07:38:59 +0100
Received: by mail-qt0-x241.google.com with SMTP id n13so13702272qtc.0
        for <linux-mips@linux-mips.org>; Sun, 05 Feb 2017 22:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mmayer-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HNrMNXy2NDcuJxaijFpvu9TEDpfrwGrM9AhsVPVNyKA=;
        b=QO2h3HZqXgncuO4SNPj0IENEq4ClDWb/JudkzWb0SaRktOisBulxKvaOUFAfwQMQGl
         Z8Uyb48AmQFSpUXMItkHIIrv6YNCJzjaebPrvlWkkXrDfpgGl+BZtboJ7E+1DZYjQaVd
         CjCqx9lqSeoKyLGnVVlFFqINVliu3nZ9BySoF0J9NSGAyfoV1u7eYhCkyreJzC8w+cPR
         rz6qDxkJL+fv0NG/4WkFNldJpln6ahSYDu898Pf9m0prEfXF28BfeXGY+WttSEByX8vH
         aJ7B4ByPym/jatQW6wHRYPAJqQ11p9R0IEpZVAPbXbY3gQKZ13PuvV5/i17ssTGFWvK0
         /DYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=HNrMNXy2NDcuJxaijFpvu9TEDpfrwGrM9AhsVPVNyKA=;
        b=oPVOrb5OSbaVpAMPGwjfqlVWbXayGOxFLEmjt+pDPdxlJqH/HjZg8LQytiZtxcFkKp
         pj7LCB/+NkJwYIdbQTFKyDRnBrOkAMPcMPXhcKR8ptz/7okz2SqpmsZMbkAjoBotaA8X
         o7HNF/ZdMdg94EK3gZARCFAZOG328zzOEeTUv9HcS7dhtdBlBG38fb34jDWwdNiXgxW3
         fHTyXYAg6EidutXKp/mGO+lIt8MnOq9HSB+ofK0moXlh+UhdgG/wvZe0dT9bS8abe6mf
         HhFzl0vt3V2u2zfH5ZCbK1iG8P3HzffcW3ObkNTmwXfX8s0OesmcEF8ccXY2kyyN+zis
         nZnw==
X-Gm-Message-State: AMke39mhrYj4JbGOfVOtuvfwsVG15tVhozrwAMzLNVuBVneuvSf93w/VLb9Y0MO5rbVICzaDA0UZuLTZoy79LA==
X-Received: by 10.200.48.206 with SMTP id w14mr8718931qta.50.1486363134112;
 Sun, 05 Feb 2017 22:38:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.152.150 with HTTP; Sun, 5 Feb 2017 22:38:53 -0800 (PST)
In-Reply-To: <20170206033511.GC3131@vireshk-i7>
References: <20170202010601.75995-1-code@mmayer.net> <20170202010601.75995-4-code@mmayer.net>
 <20170203042917.GL7458@vireshk-i7> <CAGt4E5vk6ciXPjh+ck-feyqmNu7cNRst3rArJ4MD7e8JWBfWMw@mail.gmail.com>
 <20170206033511.GC3131@vireshk-i7>
From:   Markus Mayer <code@mmayer.net>
Date:   Sun, 5 Feb 2017 22:38:53 -0800
X-Google-Sender-Auth: Bbg074ZTOXDt3h02u7i36V5MXUw
Message-ID: <CANEuBv7+BB+VwkUME2EQ9J_02UZLDX-mjteSobkRyMGfe011WA@mail.gmail.com>
Subject: Re: [PATCH 3/3] MIPS: BMIPS: enable CPUfreq
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Markus Mayer <markus.mayer@broadcom.com>,
        Markus Mayer <code@mmayer.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <mmayer@mmayer.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56648
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: code@mmayer.net
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

On 5 February 2017 at 19:35, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-02-17, 17:00, Markus Mayer wrote:
> > On 2 February 2017 at 20:29, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > On 01-02-17, 17:06, Markus Mayer wrote:
> > >> From: Markus Mayer <mmayer@broadcom.com>
> > >>
> > >> Enable all applicable CPUfreq options.
> > >>
> > >> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> > >> ---
> > >>  arch/mips/configs/bmips_stb_defconfig | 10 ++++++++++
> > >>  1 file changed, 10 insertions(+)
> > >>
> > >> diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
> > >> index 4eb5d6e..6fda604 100644
> > >> --- a/arch/mips/configs/bmips_stb_defconfig
> > >> +++ b/arch/mips/configs/bmips_stb_defconfig
> > >> @@ -26,6 +26,16 @@ CONFIG_INET=y
> > >>  # CONFIG_INET_XFRM_MODE_BEET is not set
> > >>  # CONFIG_INET_LRO is not set
> > >>  # CONFIG_INET_DIAG is not set
> > >> +CONFIG_CPU_FREQ=y
> > >> +CONFIG_CPU_FREQ_STAT=y
> > >> +CONFIG_CPU_FREQ_STAT_DETAILS=y
> > >> +CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> > >> +CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> > >> +CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> > >> +CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> > >> +CONFIG_CPU_FREQ_GOV_USERSPACE=y
> > >> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> > >> +CONFIG_BMIPS_CPUFREQ=y
> > >>  CONFIG_CFG80211=y
> > >>  CONFIG_NL80211_TESTMODE=y
> > >>  CONFIG_MAC80211=y
> > >
> > > Rebase your stuff over pm/linux-next and you will see some changes here. Also
> > > schedutil is the new governor in town, you must give it a try.
> >
> > I'll definitely turn on SCHEDUTIL. As for the changes in next, I don't
> > see any conflicts. My series applied fine on top of linux-next from
> > https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/. Did
> > I use the wrong tree?
>
> No, but you didn't follow the right process. You should use 'make
> savedefconfig' to update the defconfig.
>
> The symbol CONFIG_CPU_FREQ_STAT_DETAILS is removed from the kernel
> now.

Okay. Got it. Will do.

-Markus
