Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 04:51:30 +0200 (CEST)
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35560 "EHLO
        mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006583AbbGMCv2VSJcu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 04:51:28 +0200
Received: by pdrg1 with SMTP id g1so83691597pdr.2
        for <linux-mips@linux-mips.org>; Sun, 12 Jul 2015 19:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=jQfQd88R3CHCX+9tPuoEMyT7CLR57O16EbaXHXec/Qk=;
        b=FPFv9nHT+JsFfNDCdJ8+QTzlS/Lw8KKPUopzy3hbOM/cB1Kubn8R1EBE8NPOU6XKp3
         zajCeBJiAoaKav8OcsS4lmdL76DkTALOoxqrTfjqVKZqjU4no82BnXA2315MwVxQDkog
         9zwOAomQ+g/hvETQ1dMkvt8Du/wI1yHg9p8y2Gx6/CqzA0DwopajjqKLT6toTsFCw9ga
         /4Qer7bnzRRXKgWwVHixZUMPthqawAkdgoLXwIy8Gd7GxMLVgncSLiLX0llt91n98TsV
         AhFkNbyYzAyU5qEDJi1yfkZb/wh5MMiQexH5AcWD7uh/q/VMn/fOfFO2YpJJsc5Fo5zF
         xBCw==
X-Gm-Message-State: ALoCoQlFMO6mH6RPJ32bXfze9CC8kOA1qkphITryIpOLe6mbO7mNJEnXsoxogN0q3CSb8O98VjIr
X-Received: by 10.66.142.199 with SMTP id ry7mr64727041pab.14.1436755881427;
        Sun, 12 Jul 2015 19:51:21 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by smtp.gmail.com with ESMTPSA id pp6sm16509288pbb.79.2015.07.12.19.51.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 12 Jul 2015 19:51:20 -0700 (PDT)
Date:   Mon, 13 Jul 2015 08:21:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linaro-kernel@lists.linaro.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>,
        Hongliang Tao <taohl@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        James Hogan <james.hogan@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Michael Opdenacker <michael.opdenacker@free-electrons.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Valentin Rothberg <valentinrothberg@gmail.com>
Subject: Re: [PATCH 00/14] MIPS: Migrate clockevent drivers to 'set-state'
Message-ID: <20150713025116.GE10415@linux>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1436180306.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48214
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

On 06-07-15, 16:41, Viresh Kumar wrote:
> Hi Guys,
> 
> This series migrates MIPS clockevent drivers (present in arch/mips/
> directory), to the new set-state interface. This would enable these
> drivers to use new states (like: ONESHOT_STOPPED, etc.) of a clockevent
> device (if required), as the set-mode interface is marked obsolete now
> and wouldn't be expanded to handle new states.
> 
> Rebased over: v4.2-rc1
> 
> Following patches:
>   MIPS/alchemy/time: Migrate to new 'set-state' interface
>   MIPS/jazz/timer: Migrate to new 'set-state' interface
>   MIPS/cevt-r4k: Migrate to new 'set-state' interface
>   MIPS/sgi-ip27/timer: Migrate to new 'set-state' interface
>   MIPS/sni/time: Migrate to new 'set-state' interface
> 
> must be integrated to mainline kernel via clockevents tree, because of
> dependency on:
>   352370adb058 ("clockevents: Allow set-state callbacks to be optional")

@Ralf: This dependency patch is applied to 4.2-rc2 now and you can
pick all the patches from this series.

-- 
viresh
