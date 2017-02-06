Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2017 04:35:28 +0100 (CET)
Received: from mail-pg0-x22f.google.com ([IPv6:2607:f8b0:400e:c05::22f]:36633
        "EHLO mail-pg0-x22f.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990924AbdBFDfVN4dI1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2017 04:35:21 +0100
Received: by mail-pg0-x22f.google.com with SMTP id v184so24185531pgv.3
        for <linux-mips@linux-mips.org>; Sun, 05 Feb 2017 19:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lSx8KkqB6aoTRftiVkPCGxFSI18Uqj7mr7M4NLYUCVw=;
        b=Ek4oNov3FIXI6DlxRo4R3+3gPdRkZaGY5CTz87On7jGtZxuIDInNRk9osDfGSPcvQT
         DFSw0b6fohU4hfYBycIf1Q4aHZL3RQcnpRPTwXmD16wcpUWGDrDg9lLkKOAOoNkZQMeT
         gnEv8CmV7LeNPfEF0esprUlzTfcVkv3SYqjN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lSx8KkqB6aoTRftiVkPCGxFSI18Uqj7mr7M4NLYUCVw=;
        b=rqxQcq9zDJASd8YeXqq1vkpspmIMuj8OogTQvdzcZlxiD90+zW0wk2mkxeCwSDE94Z
         D92gAEc8UT1hSeex4LnI+hkbgU5etSAqsZ+7DDSi3sQxO87eJuaUJXGEr4ZAcFDom9ac
         KFwlQpLcImy1gtXeItB5ZwpVOkg/c8w4Sikbiv0Jr+kMZdHlF156xS4OpZM5SznZ1s7e
         +XG4BdW4QSS9B94DX8DBSD2hm1bF6is0dFNoPB72svefgxPx9Bk9PPT8PAFl/dR3n7KQ
         2Mqnr9s4UdD/bospIYjnywuPtbQU+mAYEX5lBlByb1K4j0BZoL9m/XnLx/fhSsW2KStY
         Rp0Q==
X-Gm-Message-State: AIkVDXIg9NnPzSnMuY034DfbOGLOpH8D17hdo4Kk/GXT/IaXcYy4JF8Nd6uJwcFojaQLNwHx
X-Received: by 10.98.138.155 with SMTP id o27mr10854370pfk.113.1486352114856;
        Sun, 05 Feb 2017 19:35:14 -0800 (PST)
Received: from localhost ([122.172.165.189])
        by smtp.gmail.com with ESMTPSA id c64sm84159868pfa.45.2017.02.05.19.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Feb 2017 19:35:13 -0800 (PST)
Date:   Mon, 6 Feb 2017 09:05:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Markus Mayer <markus.mayer@broadcom.com>
Cc:     Markus Mayer <code@mmayer.net>, Ralf Baechle <ralf@linux-mips.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        MIPS Linux Kernel List <linux-mips@linux-mips.org>,
        Power Management List <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] MIPS: BMIPS: enable CPUfreq
Message-ID: <20170206033511.GC3131@vireshk-i7>
References: <20170202010601.75995-1-code@mmayer.net>
 <20170202010601.75995-4-code@mmayer.net>
 <20170203042917.GL7458@vireshk-i7>
 <CAGt4E5vk6ciXPjh+ck-feyqmNu7cNRst3rArJ4MD7e8JWBfWMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGt4E5vk6ciXPjh+ck-feyqmNu7cNRst3rArJ4MD7e8JWBfWMw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: viresh.kumar@linaro.org
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

On 03-02-17, 17:00, Markus Mayer wrote:
> On 2 February 2017 at 20:29, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 01-02-17, 17:06, Markus Mayer wrote:
> >> From: Markus Mayer <mmayer@broadcom.com>
> >>
> >> Enable all applicable CPUfreq options.
> >>
> >> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> >> ---
> >>  arch/mips/configs/bmips_stb_defconfig | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
> >> index 4eb5d6e..6fda604 100644
> >> --- a/arch/mips/configs/bmips_stb_defconfig
> >> +++ b/arch/mips/configs/bmips_stb_defconfig
> >> @@ -26,6 +26,16 @@ CONFIG_INET=y
> >>  # CONFIG_INET_XFRM_MODE_BEET is not set
> >>  # CONFIG_INET_LRO is not set
> >>  # CONFIG_INET_DIAG is not set
> >> +CONFIG_CPU_FREQ=y
> >> +CONFIG_CPU_FREQ_STAT=y
> >> +CONFIG_CPU_FREQ_STAT_DETAILS=y
> >> +CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> >> +CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> >> +CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> >> +CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> >> +CONFIG_CPU_FREQ_GOV_USERSPACE=y
> >> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> >> +CONFIG_BMIPS_CPUFREQ=y
> >>  CONFIG_CFG80211=y
> >>  CONFIG_NL80211_TESTMODE=y
> >>  CONFIG_MAC80211=y
> >
> > Rebase your stuff over pm/linux-next and you will see some changes here. Also
> > schedutil is the new governor in town, you must give it a try.
> 
> I'll definitely turn on SCHEDUTIL. As for the changes in next, I don't
> see any conflicts. My series applied fine on top of linux-next from
> https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/. Did
> I use the wrong tree?

No, but you didn't follow the right process. You should use 'make
savedefconfig' to update the defconfig.

The symbol CONFIG_CPU_FREQ_STAT_DETAILS is removed from the kernel
now.

-- 
viresh
