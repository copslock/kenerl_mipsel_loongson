Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2017 17:55:07 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:3894 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992592AbdJLPzAW2VaZ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Oct 2017 17:55:00 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id AE45BBADCB3D9;
        Thu, 12 Oct 2017 16:54:49 +0100 (IST)
Received: from BADAG04.ba.imgtec.org (10.20.40.112) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 12 Oct 2017
 16:54:53 +0100
Received: from BADAG02.ba.imgtec.org ([fe80::1092:c22e:588e:c561]) by
 BADAG04.ba.imgtec.org ([fe80::b930:4082:95b0:e446%15]) with mapi id
 14.03.0266.001; Thu, 12 Oct 2017 08:54:50 -0700
From:   Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>
To:     James Hogan <james.hogan@mips.com>,
        Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>
CC:     Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        "Goran Ferenc" <Goran.Ferenc@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maciej Rozycki <Maciej.Rozycki@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: RE: [PATCH 1/2] MIPS: math-emu: Update debugfs FP exception stats
 for certain instructions
Thread-Topic: [PATCH 1/2] MIPS: math-emu: Update debugfs FP exception stats
 for certain instructions
Thread-Index: AQHTQ2jgJaFRiAUocEybJOX68Wkh9aLgV/ti
Date:   Thu, 12 Oct 2017 15:54:48 +0000
Message-ID: <EF5FA6C3467F85449672C3E735957B85015DA0B589@badag02.ba.imgtec.org>
References: <20171012101753.GB15235@jhogan-linux>
 <683c-59df7500-1-10d973a0@9889400>,<20171012144434.GF15235@jhogan-linux>
In-Reply-To: <20171012144434.GF15235@jhogan-linux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.117.201.26]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Aleksandar.Markovic@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60384
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Aleksandar.Markovic@imgtec.com
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

> Right, but its not going to even get to copcsr until this patch, so the
> SIGFPE handling is I think fixed by this patch, i.e. it isn't just about
> the stats.

On more detailed code inspection, you are right.

> This patch fixes something, I think it should
> a) be clear in the commit message what is fixed
> b) be tagged for stable (though that can always be done
> retrospectively)

If you agree, I am going to submit v2 of the series, that would fully
address these concerns.

Additionally, it seems to me that a new round of testing that tests
involved code paths under various scenarios would be appropriate
and I am going to do that.

> Note: thats the one in fpux_emu(), not fpu_emu() which this patch
> modifies.

Yes, my bad, wanting to respond as quickly as possible, I inserted
the segment from fpux_emu(), not fpu_emu() as I should have.

By the way, and not related to this patch, I see only 4 (out of 5)
exceptions are handled in fpux_emu() case (division-by-zero is not
handled), I presume this is fine (probably division-by-zero not
needed), isn't it?

I truly appreciate your analysis and help.

Aleksandar

________________________________________
From: James Hogan [james.hogan@mips.com]
Sent: Thursday, October 12, 2017 7:44 AM
To: Aleksandar Markovic
Cc: Miodrag Dinic; Paul Burton; Petar Jovanovic; Raghu Gandham; Ralf Baechle; Aleksandar Markovic; linux-mips@linux-mips.org; Douglas Leung; Goran Ferenc; linux-kernel@vger.kernel.org; Maciej Rozycki; Manuel Lauss; Masahiro Yamada
Subject: Re: [PATCH 1/2] MIPS: math-emu: Update debugfs FP exception stats for certain instructions

On Thu, Oct 12, 2017 at 03:57:50PM +0200, Aleksandar Markovic wrote:
>
> > Subject: Re: [PATCH 1/2] MIPS: math-emu: Update debugfs FP exception stats for certain instructions
> > Date: Thursday, October 12, 2017 12:17 CEST
> > From: James Hogan <james.hogan@mips.com>>@badag02.ba.imgtec.org>
> > > ...
> > > if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E)
> > > ...
> >
> > But just before that condition it does:
> >
> > ctx->fcr31 = (ctx->fcr31 & ~FPU_CSR_ALL_X) | rcsr;
> > I.e. it clears the X bits used in the condition, and overrides them,
> > based on rcsr, which is initialised to 0 and is only set after the
> > copcsr label and in a couple of other cases I don't think we'd be
> > hitting for MADDF.
> >
>
> The code is odd and deceiving here. Let's see the whole "copcsr label"
> code segment: copcsr:if (ieee754_cxtest(IEEE754_INEXACT)) {  MIPS_FPU_EMU_INC_STATS(ieee754_inexact);  rcsr |= FPU_CSR_INE_X | FPU_CSR_INE_S;}if (ieee754_cxtest(IEEE754_UNDERFLOW)) {  MIPS_FPU_EMU_INC_STATS(ieee754_underflow);  rcsr |= FPU_CSR_UDF_X | FPU_CSR_UDF_S;}if (ieee754_cxtest(IEEE754_OVERFLOW)) {  MIPS_FPU_EMU_INC_STATS(ieee754_overflow);  rcsr |= FPU_CSR_OVF_X | FPU_CSR_OVF_S;}  if (ieee754_cxtest(IEEE754_INVALID_OPERATION)) {  MIPS_FPU_EMU_INC_STATS(ieee754_invalidop);  rcsr |= FPU_CSR_INV_X | FPU_CSR_INV_S;} ctx->fcr31 = (ctx->fcr31 & ~FPU_CSR_ALL_X) | rcsr;if ((ctx->fcr31 >> 5) & ctx->fcr31 & FPU_CSR_ALL_E) {  /*printk ("SIGFPE: FPU csr = %08x\n",  ctx->fcr31); */  return SIGFPE;}

Note: thats the one in fpux_emu(), not fpu_emu() which this patch
modifies. In fpu_emu() the copying of bits from rcsr to fcr32 and the
SIGFPE checking takes place outside of the switch, after other stuff can
modify rcsr.

>
>
> Value of rcsr will be dictated by series of invocations to ieee754_cxtest(),
> which, in fact, means that exception bits will be copied from fcr31 to rcsr.
>
> Then, fcr31 exception bits are cleared and set to the values they had just
> before clearing.
>
> Obviously, this will not do anything in our scenarios.
>
> However, the patch is about correct setting of debugfs stats, and this code
> segment correctly does this.



>
> May I suggest that we accept my patch as is, and if anybody for any reason
> wants to deal further with related code, this should be done in a separate
> fix/patch?

This patch fixes something, I think it should
a) be clear in the commit message what is fixed
b) be tagged for stable (though that can always be done
retrospectively).

Cheers
James
