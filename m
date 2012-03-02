Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2012 20:07:59 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:48995 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903744Ab2CBTHx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Mar 2012 20:07:53 +0100
Received: by pbbro2 with SMTP id ro2so3086149pbb.36
        for <linux-mips@linux-mips.org>; Fri, 02 Mar 2012 11:07:46 -0800 (PST)
Received-SPF: pass (google.com: domain of grant.likely@secretlab.ca designates 10.68.203.73 as permitted sender) client-ip=10.68.203.73;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of grant.likely@secretlab.ca designates 10.68.203.73 as permitted sender) smtp.mail=grant.likely@secretlab.ca
Received: from mr.google.com ([10.68.203.73])
        by 10.68.203.73 with SMTP id ko9mr19508266pbc.130.1330715266811 (num_hops = 1);
        Fri, 02 Mar 2012 11:07:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.68.203.73 with SMTP id ko9mr16281973pbc.130.1330715266675;
        Fri, 02 Mar 2012 11:07:46 -0800 (PST)
Received: from localhost (S0106d8b37715ee14.cg.shawcable.net. [68.146.14.168])
        by mx.google.com with ESMTPS id g3sm5678693pbt.41.2012.03.02.11.07.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 11:07:45 -0800 (PST)
Received: by localhost (Postfix, from userid 1000)
        id 571E03E1C63; Fri,  2 Mar 2012 13:07:44 -0600 (CST)
From:   Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v6 4/5] MIPS: Octeon: Setup irq_domains for interrupts.
To:     David Daney <david.daney@cavium.com>,
        Rob Herring <robherring2@gmail.com>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Rob Herring <rob.herring@calxeda.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <4F510B8E.3070201@cavium.com>
References: <1330563422-14078-1-git-send-email-ddaney.cavm@gmail.com> <1330563422-14078-5-git-send-email-ddaney.cavm@gmail.com> <4F50D7C2.7080204@gmail.com> <4F510B8E.3070201@cavium.com>
Date:   Fri, 02 Mar 2012 12:07:44 -0700
Message-Id: <20120302190744.571E03E1C63@localhost>
X-Gm-Message-State: ALoCoQnnrE+cHXqSuvV7ois99yw/yg0c1G9yutriSn+iMCI28BHZvndNjU4M6Wx2WVhMUaTAj0yK
X-archive-position: 32596
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, 02 Mar 2012 10:03:58 -0800, David Daney <david.daney@cavium.com> wrote:
> On 03/02/2012 06:22 AM, Rob Herring wrote:
> [...]
> >> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> >> index ce30e2f..01344ae 100644
> >> --- a/arch/mips/Kconfig
> >> +++ b/arch/mips/Kconfig
> >> @@ -1432,6 +1432,7 @@ config CPU_CAVIUM_OCTEON
> >>   	select WEAK_ORDERING
> >>   	select CPU_SUPPORTS_HIGHMEM
> >>   	select CPU_SUPPORTS_HUGEPAGES
> >> +	select IRQ_DOMAIN
> >
> > IIRC, Grant has a patch cued up that enables IRQ_DOMAIN for all of MIPS.
> >
> 
> Indeed, I now see it in linux-next.  I will remove this one.
> 
> >>   	help
> >>   	  The Cavium Octeon processor is a highly integrated chip containing
> >>   	  many ethernet hardware widgets for networking tasks. The processor
> >> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
> >> index bdcedd3..e9f2f6c 100644
> >> --- a/arch/mips/cavium-octeon/octeon-irq.c
> >> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> [...]
> >> +static void __init octeon_irq_set_ciu_mapping(unsigned int irq,
> >> +					      unsigned int line,
> >> +					      unsigned int bit,
> >> +					      struct irq_domain *domain,
> >>   					      struct irq_chip *chip,
> >>   					      irq_flow_handler_t handler)
> >>   {
> >> +	struct irq_data *irqd;
> >>   	union octeon_ciu_chip_data cd;
> >>
> >>   	irq_set_chip_and_handler(irq, chip, handler);
> >> -
> >>   	cd.l = 0;
> >>   	cd.s.line = line;
> >>   	cd.s.bit = bit;
> >>
> >>   	irq_set_chip_data(irq, cd.p);
> >>   	octeon_irq_ciu_to_irq[line][bit] = irq;
> >> +
> >> +	irqd = irq_get_irq_data(irq);
> >> +	irqd->hwirq = line<<  6 | bit;
> >> +	irqd->domain = domain;
> >
> > I think the domain code will set these.
> 
> It is my understanding that the domain code only does this for:
> 
> o irq_domain_add_legacy()
> 
> o irq_create_direct_mapping()
> 
> o irq_create_mapping()
> 
> We use none of those.  So I do it here.
> 
> If there is a better way, I am open to suggestions.

irq_create_mapping is called by irq_create_of_mapping() which is
in turn called by irq_of_parse_and-map().  irq_domain always
manages the hwirq and domain values.  Driver code cannot manipulate
them manually.

g.
