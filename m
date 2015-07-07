Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jul 2015 07:38:43 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34782 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008435AbbGGFil3FGnv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Jul 2015 07:38:41 +0200
Received: by pabvl15 with SMTP id vl15so107233565pab.1
        for <linux-mips@linux-mips.org>; Mon, 06 Jul 2015 22:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=UjN6LdQWxnpkR+GSjGIWyikDKHtw7icUE/G2ztR7whw=;
        b=OH7g5ZiwsVJrgzi7v30icHoT0583T4kpjkwP5WQaB7gNeMoxkNFpecBNU+UpgOlxr0
         kzuQr8nkEqqKBy5bhQ0CGfmMpUm7wrPXweZLrIE1ZU04B+DRxHJLekE27KeEa08Apvdw
         mMDbNigGJUTzWo6YdMbHnbXaW9ScQob/jv5OXsuFu5g+GGTvdsQvn26UWrQCC4Y/MKAF
         HQl2wruAiLymXPur44b0T1XkRC4C6TX6ccYGHxcdFe/Erc1xHY3oxKSZ0PUxE3I6SEFL
         Ft98caEuoyWonb7UI6WUnJTDvYkt3rRAKnu7nXBScMufGkFLgglVwVSdvCWwAGh+H6rP
         aXZA==
X-Gm-Message-State: ALoCoQl4FRPSIXCuwWjoDmKmXPorwuqLvBHoxiSUlQ/EwfeRKL6g+5cNQRuja0gzlDwhgvM0G7dG
X-Received: by 10.68.202.7 with SMTP id ke7mr5190237pbc.114.1436247515256;
        Mon, 06 Jul 2015 22:38:35 -0700 (PDT)
Received: from localhost ([122.171.186.190])
        by mx.google.com with ESMTPSA id r4sm20460270pap.8.2015.07.06.22.38.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 22:38:34 -0700 (PDT)
Date:   Tue, 7 Jul 2015 11:08:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        linaro-kernel@lists.linaro.org,
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
Message-ID: <20150707053828.GC14598@linux>
References: <cover.1436180306.git.viresh.kumar@linaro.org>
 <559AEA71.3020502@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <559AEA71.3020502@cogentembedded.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <viresh.kumar@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48095
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

On 06-07-15, 23:52, Sergei Shtylyov wrote:
> On 07/06/2015 02:11 PM, Viresh Kumar wrote:
> 
> >This series migrates MIPS clockevent drivers (present in arch/mips/
> >directory), to the new set-state interface. This would enable these
> >drivers to use new states (like: ONESHOT_STOPPED, etc.) of a clockevent
> >device (if required), as the set-mode interface is marked obsolete now
> >and wouldn't be expanded to handle new states.
> 
> >Rebased over: v4.2-rc1
> 
> >Following patches:
> >   MIPS/alchemy/time: Migrate to new 'set-state' interface
> >   MIPS/jazz/timer: Migrate to new 'set-state' interface
> >   MIPS/cevt-r4k: Migrate to new 'set-state' interface
> >   MIPS/sgi-ip27/timer: Migrate to new 'set-state' interface
> >   MIPS/sni/time: Migrate to new 'set-state' interface
> 
> >must be integrated to mainline kernel via clockevents tree, because of
> >dependency on:
> >   352370adb058 ("clockevents: Allow set-state callbacks to be optional")
> 
>    I had a hard time finding this by ID, since it hasn't landed in
> any official trees still.

For others who might struggle as well:
http://marc.info/?l=linux-kernel&m=143409604825833&w=2

Sorry to waste your time because of this dependency. The best I could
have done is to mention the dependency in cover-letter, which I did
(though should have included a link as well).

Anyway, thanks :)

-- 
viresh
