Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Jan 2018 15:27:18 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:33213
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990439AbeASO1LIzaKZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Jan 2018 15:27:11 +0100
Received: by mail-lf0-x244.google.com with SMTP id t139so2324955lff.0;
        Fri, 19 Jan 2018 06:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=spV4CuHMSF1gRaZrohj5QorcwxDTML8S0GqjujVSTIM=;
        b=JXHUdetFMoqvprPdxOcIjWUP75SlLV+DCAkixqIhW4o8JHqxT0jis/gMdfbDsrWbWe
         ygoroVY8W+YEXW02hh0g0YMPvL0HCA+cMtP5IbuzhE00Fg8lw9HlXSBayAOdKUD2MawS
         PYRfjgE5z/clO48t90lWtjkVWE9SICU1kkCFSQa+cNV+kPBHgrodiaDez0RbCinZK6PT
         CduwBMHH6RP+N2ylTHVVTnXS7WTmY73gXbjTfEd5ClL9XWIIWcUNLCxlwfaPl+tR70nh
         8wfIzGze+U1MlTzbyLL7PhCpav+hTLGD/Ae7FJy13dhZBt/3HCc15IIEbqpMfhRWDVqv
         zz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=spV4CuHMSF1gRaZrohj5QorcwxDTML8S0GqjujVSTIM=;
        b=DT+YUcKIcUnbrxleVOAbyplUI4fIkPVpq4QqAzERgNNfVtYrX6YNjILFyiemxUj+ou
         6LqcNRvES3kynJnujoY8fomhpP3MdRU6x56+E8UUoVqb/IsAnvCJ6iBfYOoywRiqx66n
         +5W+jxIDJ2GdFIp1PqbnmfG5i1ESaWReI/4x7dxqTcesSNn65biGfWCy1Vtwe5eKhTY7
         ylwcIgdH/j/oNoOChBWdR258RKRV37LrsKQiY61cFdo2S5jKIH3OP7M76tyMrDmislhM
         qZGBbALKR1slc25FbEXa7yzGfR1ZmkMWA0ctFg1oLeanQgRcqLdWSrSlpdvoIXzhWlcR
         cDPg==
X-Gm-Message-State: AKwxytccmvFVKPhJVsuOPKeKF591vqSh96UKDAJ9YoOaFSXgLGMCDrDT
        1Xq5ZKwhaeB2rgobYY8j7Ow=
X-Google-Smtp-Source: AH8x225VQGwdfoc9oF56BydO6H2Y+lS5fNyKICkVIMXzdym8gMqo3ePHJXidPR8gsnOqFU1j0l1Hmg==
X-Received: by 10.46.126.5 with SMTP id z5mr711443ljc.84.1516372025223;
        Fri, 19 Jan 2018 06:27:05 -0800 (PST)
Received: from mobilestation ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id v17sm1738360ljv.38.2018.01.19.06.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jan 2018 06:27:04 -0800 (PST)
Date:   Fri, 19 Jan 2018 17:27:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, ralf@linux-mips.org,
        miodrag.dinic@mips.com, jhogan@kernel.org, goran.ferenc@mips.com,
        david.daney@cavium.com, paul.gortmaker@windriver.com,
        paul.burton@mips.com, alex.belits@cavium.com,
        Steven.Hill@cavium.com, alexander.sverdlin@nokia.com,
        kumba@gentoo.org, marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] MIPS: memblock: Print out kernel virtual mem layout
Message-ID: <20180119142712.GA3101@mobilestation>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180117222312.14763-12-fancer.lancer@gmail.com>
 <cce36f73-4381-f830-3422-1cef8ad9e622@gmail.com>
 <20180118201856.GA996@mobilestation>
 <b2797958-d217-9c8d-10ca-b9bc43ae585b@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2797958-d217-9c8d-10ca-b9bc43ae585b@mips.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

On Fri, Jan 19, 2018 at 07:59:43AM +0000, Matt Redfearn <matt.redfearn@mips.com> wrote:

Hello Matt,

> Hi Serge,
> 
> 
> 
> On 18/01/18 20:18, Serge Semin wrote:
> >On Thu, Jan 18, 2018 at 12:03:03PM -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>On 01/17/2018 02:23 PM, Serge Semin wrote:
> >>>It is useful to have the kernel virtual memory layout printed
> >>>at boot time so to have the full information about the booted
> >>>kernel. In some cases it might be unsafe to have virtual
> >>>addresses freely visible in logs, so the %pK format is used if
> >>>one want to hide them.
> >>>
> >>>Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> >>
> >>I personally like having that information because that helps debug and
> >>have a quick reference, but there appears to be a trend to remove this
> >>in the name of security:
> >>
> >>https://patchwork.kernel.org/patch/10124007/
> >>
> >>maybe hide this behind a configuration option?
> >
> >Yeah, arm code was the place I picked the function up.) But in my case
> >I've used %pK so the pointers would disappear from logging when
> >kptr_restrict sysctl is 1 or 2.
> >I agree, that we might need to make the printouts optional. If there is
> >any kernel config, which for instance increases the kernel security we
> >could also use it or anything else to discard the printouts at compile
> >time.
> 
> 
> Certainly, when KASLR is active it would be preferable to hide this
> information, so you could use CONFIG_RELOCATABLE. The existing KASLR stuff
> additionally hides this kind of information behind CONFIG_DEBUG_KERNEL, so
> that only people actively debugging the kernel see it:
> 
> http://elixir.free-electrons.com/linux/v4.15-rc8/source/arch/mips/kernel/setup.c#L604

Ok. I'll hide the printouts behind both of that config macros in the next patchset
version.

Regards,
-Sergey

> 
> Thanks,
> Matt
> 
> >
> >>-- 
> >>Florian
