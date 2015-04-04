Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Apr 2015 02:07:49 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27006895AbbDDAHr1GLoI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Apr 2015 02:07:47 +0200
Date:   Sat, 4 Apr 2015 01:07:47 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 18/48] MIPS: math-emu: Factor out CFC1/CTC1 emulation
In-Reply-To: <551F233E.4040602@cogentembedded.com>
Message-ID: <alpine.LFD.2.11.1504040058570.21028@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org> <alpine.LFD.2.11.1504030318150.21028@eddie.linux-mips.org> <551F233E.4040602@cogentembedded.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Sat, 4 Apr 2015, Sergei Shtylyov wrote:

> > +	if (MIPSInst_RD(ir) == FPCREG_CSR) {
> > +		value = ctx->fcr31;
> > +		pr_debug("%p gpr[%d]<-csr=%08x\n",
> > +			 (void *)xcp->cp0_epc,
> > +			 MIPSInst_RT(ir), value);
> > +	} else if (MIPSInst_RD(ir) == FPCREG_RID)
> > +		value = 0;
> > +	else
> > +		value = 0;
> 
>    CodingStyle: all arms of the *if* statement shouyld have {} if at leats one
> has them.
> 
> > +	if (MIPSInst_RT(ir))
> > +		xcp->regs[MIPSInst_RT(ir)] = value;
> > +}
> > +
> > +/*
> > + * Emulate a CTC1 instruction.
> > + */
> > +static inline void cop1_ctc(struct pt_regs *xcp, struct mips_fpu_struct
> > *ctx,
> > +			    mips_instruction ir)
> > +{
> > +	u32 value;
> > +
> > +	if (MIPSInst_RT(ir) == 0)
> > +		value = 0;
> > +	else
> > +		value = xcp->regs[MIPSInst_RT(ir)];
> > +
> > +	/* we only have one writable control reg
> > +	 */
> 
>    This comment would fit on a single line.

 Thanks for your comments.

 These patches move lots of preexisting code around, in some cases copying 
preexiting problems.  These problems are addressed as code is updated by 
later changes, so please have a look there too before pointing out issues.  
If I missed anything and a problem remains in code being poked at after 
all the changes have been applied, then please do let me know, I'll 
correct it.

 Thanks for your assistance with keeping our code clean!

  Maciej
