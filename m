Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2012 22:31:42 +0200 (CEST)
Received: from mail-qa0-f49.google.com ([209.85.216.49]:56318 "EHLO
        mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903348Ab2ILUbi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2012 22:31:38 +0200
Received: by qafk1 with SMTP id k1so1417399qaf.15
        for <linux-mips@linux-mips.org>; Wed, 12 Sep 2012 13:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=4bXrofJBvKD27Thx87qmEQ7uxo2cJaabolvZNLZypjQ=;
        b=awlzqzcB02rlBn3JqComf8hBzs4VnpiB9hS0HuZFKnhPdGvskWSzTjpU2L5FjTSHgg
         82fma0NI9PEG/q/oBpTcs+b7ir9FYWCcK36++aQsa+pfJVbggafOfwV3tq1bQUk2iPFU
         +7T8d3k40HNcsqladnJKjcK5tqVAsb24sA7XOmba9tVA9vEQTQFcd6W7z8O7+kzCmnJ1
         1PVpzXhyIrxKdMPd9TwDbOgLZmzFsBbCZwPi9NApFi7dBesyqDfu1zpTYzsDiSp6EtaZ
         KhJQD6T/dWT3crDPVnOoWVg0b8DWLuXUW+RtgHw6tQIweU3kbMxzF1eqWPzMfxf35JSH
         L1YQ==
Received: by 10.224.214.67 with SMTP id gz3mr698356qab.70.1347481892171;
        Wed, 12 Sep 2012 13:31:32 -0700 (PDT)
Received: from xanadu.home (modemcable149.196-201-24.mc.videotron.ca. [24.201.196.149])
        by mx.google.com with ESMTPS id a13sm11255754qad.18.2012.09.12.13.31.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Sep 2012 13:31:31 -0700 (PDT)
Date:   Wed, 12 Sep 2012 16:31:29 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Rob Herring <robherring2@gmail.com>
cc:     Cyril Chemparathy <cyril@ti.com>,
        devicetree-discuss@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux@openrisc.net, linuxppc-dev@lists.ozlabs.org,
        microblaze-uclinux@itee.uq.edu.au, x86@kernel.org,
        david.daney@cavium.com, benh@kernel.crashing.org,
        bigeasy@linutronix.de, grant.likely@secretlab.ca,
        paul.gortmaker@windriver.com, paulus@samba.org, hpa@zytor.com,
        m.szyprowski@samsung.com, jonas@southpole.se,
        linux@arm.linux.org.uk, a-jacquiot@ti.com, mingo@redhat.com,
        suzuki@in.ibm.com, mahesh@linux.vnet.ibm.com,
        linus.walleij@linaro.org, arnd@arndb.de, msalter@redhat.com,
        rob.herring@calxeda.com, tglx@linutronix.de, blogic@openwrt.org,
        dhowells@redhat.com, monstr@monstr.eu, ralf@linux-mips.org,
        tj@kernel.org
Subject: Re: [PATCH] of: specify initrd location using 64-bit
In-Reply-To: <5050EF3F.6030003@gmail.com>
Message-ID: <alpine.LFD.2.02.1209121629260.28681@xanadu.home>
References: <1347465937-7056-1-git-send-email-cyril@ti.com> <5050EF3F.6030003@gmail.com>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Gm-Message-State: ALoCoQnekanbUMWQw6esCiKCfk07hXJe9kdlUWp666woH7Lrg4upM3HSkdk2b/wZDoiJZJJ8rMA0
X-archive-position: 34486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nicolas.pitre@linaro.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, 12 Sep 2012, Rob Herring wrote:

> On 09/12/2012 11:05 AM, Cyril Chemparathy wrote:
> > On some PAE architectures, the entire range of physical memory could reside
> > outside the 32-bit limit.  These systems need the ability to specify the
> > initrd location using 64-bit numbers.
> > 
> > This patch globally modifies the early_init_dt_setup_initrd_arch() function to
> > use 64-bit numbers instead of the current unsigned long.
> 
> S-o-B?
> 
> > ---
> >  arch/arm/mm/init.c            |    2 +-
> >  arch/c6x/kernel/devicetree.c  |    3 +--
> >  arch/microblaze/kernel/prom.c |    3 +--
> >  arch/mips/kernel/prom.c       |    3 +--
> >  arch/openrisc/kernel/prom.c   |    3 +--
> >  arch/powerpc/kernel/prom.c    |    3 +--
> >  arch/x86/kernel/devicetree.c  |    3 +--
> >  drivers/of/fdt.c              |   10 ++++++----
> >  include/linux/of_fdt.h        |    3 +--
> >  9 files changed, 14 insertions(+), 19 deletions(-)
> > 
> > diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> > index ad722f1..579792c 100644
> > --- a/arch/arm/mm/init.c
> > +++ b/arch/arm/mm/init.c
> > @@ -76,7 +76,7 @@ static int __init parse_tag_initrd2(const struct tag *tag)
> >  __tagtable(ATAG_INITRD2, parse_tag_initrd2);
> >  
> >  #ifdef CONFIG_OF_FLATTREE
> > -void __init early_init_dt_setup_initrd_arch(unsigned long start, unsigned long end)
> > +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
> 
> phys_initrd_start/size need to change too. Not sure about similar things
> on other arches.

size ?


Nicolas
