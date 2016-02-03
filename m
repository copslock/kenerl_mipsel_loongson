Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 16:46:44 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39482 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012267AbcBCPqmDFoDQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 16:46:42 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 911792D4AD5EA;
        Wed,  3 Feb 2016 15:46:33 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Wed, 3 Feb 2016 15:46:35 +0000
Received: from localhost (10.100.200.164) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 3 Feb
 2016 15:46:35 +0000
Date:   Wed, 3 Feb 2016 15:46:34 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        "Matt Redfearn" <matt.redfearn@imgtec.com>,
        <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH 06/15] MIPS: CM: Fix mips_cm_max_vp_width for UP kernels
Message-ID: <20160203154634.GC30470@NP-P-BURTON>
References: <1454469335-14778-1-git-send-email-paul.burton@imgtec.com>
 <1454469335-14778-7-git-send-email-paul.burton@imgtec.com>
 <20160203145858.GH5464@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20160203145858.GH5464@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.164]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51696
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Wed, Feb 03, 2016 at 02:58:59PM +0000, James Hogan wrote:
> On Wed, Feb 03, 2016 at 03:15:26AM +0000, Paul Burton wrote:
> > Fix mips_cm_max_vp_width for UP kernels where it previously referenced
> > smp_num_siblings, which is not declared for UP kernels. This led to
> > build errors such as the following:
> > 
> >   drivers/built-in.o: In function `$L446':
> >   irq-mips-gic.c:(.text+0x1994): undefined reference to `smp_num_siblings'
> >   drivers/built-in.o:irq-mips-gic.c:(.text+0x199c): more undefined references to `smp_num_siblings' follow
> > 
> > On UP kernels simply return 1, leaving the reference to smp_num_siblings
> > in place only for SMP kernels.
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> 
> Need tagging for stable v4.3+?

It happens that there were no uses of mips_cm_max_vp_width in UP
kernels, but some are added later in this series (the next patch for
instance). So I don't see a need to backport to stable branches. Sorry
that could have been clearer.

> I do wonder if this should be handled in the header files though...

As in you don't think it should be handled in headers? It seems like the
logical place to do it to me...

Or do you mean smp_num_siblings should be defined as 1 for UP kernels? I
did consider that approach, but thought this possibly more semantically
correct since smp isn't in use at all so neither is smp_num_siblings.

Thanks,
    Paul

> Cheers
> James
> 
> > ---
> > 
> >  arch/mips/include/asm/mips-cm.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
> > index 1395bbc..3fdb6c9 100644
> > --- a/arch/mips/include/asm/mips-cm.h
> > +++ b/arch/mips/include/asm/mips-cm.h
> > @@ -462,7 +462,10 @@ static inline unsigned int mips_cm_max_vp_width(void)
> >  	if (mips_cm_revision() >= CM_REV_CM3)
> >  		return read_gcr_sys_config2() & CM_GCR_SYS_CONFIG2_MAXVPW_MSK;
> >  
> > -	return smp_num_siblings;
> > +	if (config_enabled(CONFIG_SMP))
> > +		return smp_num_siblings;
> > +
> > +	return 1;
> >  }
> >  
> >  /**
> > -- 
> > 2.7.0
> > 
> > 
