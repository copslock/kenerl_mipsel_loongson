Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 09:28:25 +0100 (CET)
Received: from mail-lf0-x242.google.com ([IPv6:2a00:1450:4010:c07::242]:39104
        "EHLO mail-lf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990474AbeAXI2SNmAFP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2018 09:28:18 +0100
Received: by mail-lf0-x242.google.com with SMTP id w27so2800809lfd.6;
        Wed, 24 Jan 2018 00:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cIQ47jZjsehZRMwfhXsS74qYUBnrcIAHpJWbG70dS1Q=;
        b=Ompz72UDTTbyKBmVharPusG07VYHxKZWVR2A0wSrWAMH5klCdlecO8fom7zrH7Sl4M
         oxzevqzbgoil+WpTB39gRSCC3gNkO8RHlJAy/xJXe8WJ2ppcw8rNhHUrRnxBERTphilh
         dqCCrFwR4q/nKJ5yjzXDuSARweoOd0l2YPMUwc+hj/l/KVyNRxgeDDAG+DFLw/+TGNm2
         vHwIkmVGyeYu/0vSQg0gWozoepeXOW6guW0S0mNowanvWgwpPnTCfCTUFmB+V6do8rib
         hRT5MEiINlu220tzbrEmRJLPwHDwdEJbv3LZky4eRLyJD4rZ6/ARwkN22hMZ5+LMi5WD
         mKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cIQ47jZjsehZRMwfhXsS74qYUBnrcIAHpJWbG70dS1Q=;
        b=sOa4LAnve1H2pfWvuleiDBEEIkY57+ky9rXAkMngQOPIXJHOPkif80GHpXGw9c0aEy
         q/3mw9ExCD/KPXYy9u8XvZfLKcz7m80a0GBRjGNIv5uJB03RKqX+vMnopyyRT65t0ZXd
         XEeUatUdfmjTSYm8w9wxCxpgNR+bzaAmWyCI5yuuxAU2wFFP0iZzHmEAMv58QVExFd3v
         3D1jB0OJrfWae7csa2wCLlhdo5ufKo9b3TUutPRy1oNJ4PxQcRFZXgRu1UV6oO9eVQkm
         SAppk5mhqvv5MT9jkGhiu/OIFAnlqXgv+/fQrL4pS5O2pIsfSGmoD1UR5QBcjT6PmqsT
         UpHg==
X-Gm-Message-State: AKwxytdLNZjFkcTgnGmbvO5U3gRtZVhsdApPVxpTEoH+kmy7WBFlJh8v
        TIkxXImCUV3nkoMcjzyxnNU=
X-Google-Smtp-Source: AH8x225H1TG0lJf0gdY/OxXgbyykTApiNTV/taCyuFd9KmsWxSuvzOd8FPBklNaRkTcQnfsmZLR+rg==
X-Received: by 10.46.54.19 with SMTP id d19mr2747916lja.72.1516782492524;
        Wed, 24 Jan 2018 00:28:12 -0800 (PST)
Received: from mobilestation ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id k86sm3407590ljb.23.2018.01.24.00.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 00:28:11 -0800 (PST)
Date:   Wed, 24 Jan 2018 11:28:26 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     James Hogan <jhogan@kernel.org>
Cc:     ralf@linux-mips.org, miodrag.dinic@mips.com, goran.ferenc@mips.com,
        david.daney@cavium.com, paul.gortmaker@windriver.com,
        paul.burton@mips.com, alex.belits@cavium.com,
        Steven.Hill@cavium.com, alexander.sverdlin@nokia.com,
        matt.redfearn@mips.com, kumba@gentoo.org,
        marcin.nowakowski@mips.com, Peter.Wotton@mips.com,
        Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] MIPS: memblock: Deactivate bootmem allocator
Message-ID: <20180124082826.GC31120@mobilestation>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180117222312.14763-15-fancer.lancer@gmail.com>
 <20180123235934.GA5446@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180123235934.GA5446@saruman>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62303
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

On Tue, Jan 23, 2018 at 11:59:35PM +0000, James Hogan <jhogan@kernel.org> wrote:
> On Thu, Jan 18, 2018 at 01:23:12AM +0300, Serge Semin wrote:
> > Memblock allocator can be successfully used from now for early
> > memory management
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> 
> Am I correct that intermediate commits in this patchset (i.e. bisection)
> may not work correctly, since bootmem will have been stripped out but
> NO_BOOTMEM=n and memblock may not be properly operational yet?
> 

Yes. You're absolutely right. The kernel will be buildable, but most
likely isn't operable until the PATCH 14 deactivates bootmem allocator.

> If so, is there a way to switch without breaking bisection that doesn't
> involve squashing most of the series into a single atomic commit?
> 

I don't think so. There is no way to switch without squashing at all,
at least since the alteration involves arch and platforms code, which
all relied on the bootmem allocator. Here is the list of patches, which
need to be combined to have the bisection unbroken:
[PATCH 03/14] MIPS: memblock: Reserve initrd memory in memblock
[PATCH 04/14] MIPS: memblock: Discard bootmem initialization
[PATCH 05/14] MIPS: memblock: Add reserved memory regions to memblock
[PATCH 06/14] MIPS: memblock: Reserve kdump/crash regions in memblock
[PATCH 07/14] MIPS: memblock: Mark present sparsemem sections
[PATCH 08/14] MIPS: memblock: Simplify DMA contiguous reservation
[PATCH 09/14] MIPS: memblock: Allow memblock regions resize
[PATCH 12/14] MIPS: memblock: Discard bootmem from Loongson3 code
[PATCH 13/14] MIPS: memblock: Discard bootmem from SGI IP27 code
[PATCH 14/14] MIPS: memblock: Deactivate bootmem allocator

So the patches 03-09 imply the functional alterations so the arch code
would work correctly with memblock, the patches 13-14 alter the
platforms code of the specific NUMA devices like Loongson and
SGI IP27. After it's done the bootmem can be finally deactivated.

Regards,
-Sergey

> Cheers
> James
> 
> > ---
> >  arch/mips/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 725b5ece7..a6c4fb6b6 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -4,7 +4,6 @@ config MIPS
> >  	default y
> >  	select ARCH_BINFMT_ELF_STATE
> >  	select ARCH_CLOCKSOURCE_DATA
> > -	select ARCH_DISCARD_MEMBLOCK
> >  	select ARCH_HAS_ELF_RANDOMIZE
> >  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> >  	select ARCH_MIGHT_HAVE_PC_PARPORT
> > @@ -57,6 +57,7 @@ config MIPS
> >  	select HAVE_IRQ_TIME_ACCOUNTING
> >  	select HAVE_KPROBES
> >  	select HAVE_KRETPROBES
> > +	select NO_BOOTMEM
> >  	select HAVE_MEMBLOCK
> >  	select HAVE_MEMBLOCK_NODE_MAP
> >  	select HAVE_MOD_ARCH_SPECIFIC
> > -- 
> > 2.12.0
> > 
