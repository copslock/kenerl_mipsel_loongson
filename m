Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Oct 2017 17:40:27 +0100 (CET)
Received: from 5pmail.ess.barracuda.com ([64.235.150.217]:39625 "EHLO
        5pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992181AbdJ3QkUSZptk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Oct 2017 17:40:20 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 30 Oct 2017 16:40:07 +0000
Received: from localhost (10.20.1.18) by mips01.mipstec.com (10.20.43.31) with
 Microsoft SMTP Server id 14.3.361.1; Mon, 30 Oct 2017 09:35:28 -0700
Date:   Mon, 30 Oct 2017 09:36:16 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Paul Burton <paul.burton@mips.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/8] irqchip: mips-gic: Use irq_cpu_online to (un)mask
 all-VP(E) IRQs
Message-ID: <20171030163616.tsti7thormxlnxuo@pburton-laptop>
References: <20171025233730.22225-1-paul.burton@mips.com>
 <20171025233730.22225-3-paul.burton@mips.com>
 <86mv495alz.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86mv495alz.fsf@arm.com>
User-Agent: NeoMutt/20171013
X-BESS-ID: 1509381509-298554-30597-286950-8
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186423
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Marc,

On Mon, Oct 30, 2017 at 08:00:08AM +0000, Marc Zyngier wrote:
> >  static int __init gic_of_init(struct device_node *node,
> >  			      struct device_node *parent)
> > @@ -768,6 +806,8 @@ static int __init gic_of_init(struct device_node *node,
> >  		}
> >  	}
> >  
> > -	return 0;
> > +	return cpuhp_setup_state(CPUHP_AP_IRQ_GIC_STARTING,
> > +				 "irqchip/mips/gic:starting",
> > +				 gic_cpu_startup, NULL);
> 
> I'm wondering about this. CPUHP_AP_IRQ_GIC_STARTING is a symbol that is
> used on ARM platforms. You're very welcome to use it (as long as nobody
> builds a system with both an ARM GIC and a MIPS GIC...), but I'm a bit
> worried that we could end-up breaking things if one of us decides to
> reorder it in enum cpuhp_state.
> 
> The safest option would be for you to add your own state value, which
> would allow the two architecture to evolve independently.

I had figured that if something like that ever happens it'd be easy to split
into 2 states at that point, but sure - I'm happy to add a MIPS-specific state
now to avoid anyone needing to worry about it.

Thanks,
    Paul
