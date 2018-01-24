Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 08:27:47 +0100 (CET)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:35511
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992821AbeAXH1gG5icS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2018 08:27:36 +0100
Received: by mail-lf0-x243.google.com with SMTP id a204so3873422lfa.2;
        Tue, 23 Jan 2018 23:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nYbd/dImqKIjZuqUw1YeF8PGwKUpzegZMAiv2XI1PVQ=;
        b=nEitd+l4RdSE2siv1DPe5JbMUeMyzOOhNQsKPeVdf2Zgpwfu9GCG4QMc4h9UREfrFS
         jAZmAj+9JFE3PSfN+GdumDbRYfpR1H1pXkMAP5LW/dQLWMg0Om2xbdHVZShGvYqQSXau
         hpBgLzi57rORsZDL6TP04XlUU3d2RZbc8xtZi4+zk1lB99SwhZ5LNFX69eQwN5hvR5uR
         JHWVQmaKyVmOR8HnBezMGYm/gjYSX8mUt5KvWVfyA6Wvm/bx/1VjSptOMXWCK4kDNhIF
         XYd4AS7DabSfJ4g3Ou/SASX67ap0pDqfzkXzneYSZ1l4/a4jHUwZ7m758hKt7j4drLiO
         4y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nYbd/dImqKIjZuqUw1YeF8PGwKUpzegZMAiv2XI1PVQ=;
        b=N43del9vezI9Icjxo1vRgeoBa1bilqYlmbKhdEtosYUVaCU1zCbXU7eFKYbFYmN3ZL
         tpiJcpZfG127nTA69JreqlP8IBfYY/84LuSbqMwY6KIMtsVExO2FksxL9rTMBGBGyBOC
         Qa5sGDnjgXAUmO/jRGZTXYYIRx4HZ09dHcAWfa/S4aknpktowC/tTCb2Khp5b8egsyk1
         mI5/Kp3zifzf8msR+Wcrbn/HOGmdxroEHOOqB6UwWWgsl5M0z8NO98mivpVsBJ9pT0Rk
         yZJUX4dva+xxnjb97Uv3V75dMTP9MU17JBbalepXxdd4AAP/VhqHkdya0J1MrMQOS7d6
         AE+w==
X-Gm-Message-State: AKwxyteSN8DgR+TaoQtnFujYBcJ6N7FhQhDQz4Jl1JXAqgrkkHYgm0eK
        uw72IScwAHvcPdWNxnMFqOo=
X-Google-Smtp-Source: AH8x224iB2Ct4M3t7T8i6A4x2SONnnBvLCCkUu4wgRwL52icCvvq0OMMgz4pe8Zf7uShlcRByyl8sw==
X-Received: by 10.46.93.130 with SMTP id v2mr2740899lje.63.1516778850467;
        Tue, 23 Jan 2018 23:27:30 -0800 (PST)
Received: from mobilestation ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id y198sm419045lfd.62.2018.01.23.23.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 23:27:29 -0800 (PST)
Date:   Wed, 24 Jan 2018 10:27:43 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Marcin Nowakowski <marcin.nowakowski@mips.com>
Cc:     ralf@linux-mips.org, miodrag.dinic@mips.com, jhogan@kernel.org,
        goran.ferenc@mips.com, david.daney@cavium.com,
        paul.gortmaker@windriver.com, paul.burton@mips.com,
        alex.belits@cavium.com, Steven.Hill@cavium.com,
        alexander.sverdlin@nokia.com, matt.redfearn@mips.com,
        kumba@gentoo.org, James.hogan@mips.com, Peter.Wotton@mips.com,
        Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/14] MIPS: memblock: Mark present sparsemem sections
Message-ID: <20180124072743.GA31120@mobilestation>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180117222312.14763-8-fancer.lancer@gmail.com>
 <7246ebaa-0ffa-f012-c18e-269b1e0130e6@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7246ebaa-0ffa-f012-c18e-269b1e0130e6@mips.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62302
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

Hello Marcin

On Wed, Jan 24, 2018 at 07:13:03AM +0100, Marcin Nowakowski <marcin.nowakowski@mips.com> wrote:
> Hi Serge,
> 
> On 17.01.2018 23:23, Serge Semin wrote:
> >If sparsemem is activated all sections with present pages must
> >be accordingly marked after memblock is fully initialized.
> >
> >Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> >---
> >  arch/mips/kernel/setup.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> >diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> >index b121fa702..6df1eaf38 100644
> >--- a/arch/mips/kernel/setup.c
> >+++ b/arch/mips/kernel/setup.c
> >@@ -778,7 +778,7 @@ static void __init request_crashkernel(struct resource *res)
> >  static void __init arch_mem_init(char **cmdline_p)
> >  {
> >-	struct memblock_region *reg;
> >+	struct memblock_region *reg __maybe_unused;
> 
> nit: reg is used here. It becomes __maybe_unused in patch 8.
> 

Right. I'll move __maybe_unused change to the patch 8.

-Sergey

> 
> Marcin
