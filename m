Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Nov 2017 11:40:47 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:56423 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990504AbdKXKkkBfXqG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Nov 2017 11:40:40 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 24 Nov 2017 10:40:32 +0000
Received: from [10.20.78.172] (10.20.78.172) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Fri, 24 Nov 2017
 02:39:40 -0800
Date:   Fri, 24 Nov 2017 10:39:29 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Fredrik Noring <noring@nocrew.org>, John Crispin <john@phrozen.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
In-Reply-To: <alpine.DEB.2.00.1711240958370.3865@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1711241038320.3865@tp.orcam.me.uk>
References: <20170916133423.GB32582@localhost.localdomain> <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk> <20170918192428.GA391@localhost.localdomain> <alpine.DEB.2.00.1709182055090.16752@tp.orcam.me.uk> <20170920145440.GB9255@localhost.localdomain>
 <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk> <20170927172107.GB2631@localhost.localdomain> <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk> <20170930065654.GA7714@localhost.localdomain> <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171030175516.GA18586@localhost.localdomain> <alpine.DEB.2.00.1711240958370.3865@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1511520032-452059-26972-777329-9
X-BESS-VER: 2017.14.1-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187255
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

Fredrik, John --

[Sending again, with John's address corrected.]

 John: can you please see the question below on the machine type you 
previously fiddled with?

> >  Given that the R5900 does not expand DSP support anyhow that sounds 
> > suspicious to me.
> 
> I've taken a closer look at the R5900 changes to the DSP kernel code now:
> 
> The R5900 has four three-operand instructions: MADD, MADDU, MULT and MULTU.
> In addition, it has ten instructions for pipeline 1: MULT1, MULTU1, DIV1,
> DIVU1, MADD1, MADDU1, MFHI1, MFLO1, MTHI1 and MTLO1. Those are the reason
> (parts of) the cpu_has_dsp infrastructure is used, as shown in the patch
> below. What are your thoughts on this?
> 
> The instructions are specific to the R5900, and notably incompatible with
> similar ones in the base MIPS32 architecture. They are also distinct from
> the (also R5900 specific) 128-bit multimedia instructions.

 They're still upper halves of the architectural HI/LO accumulator and 
also used by the 128-bit multiply and divide instructions.  I think they 
should be handled analogously to the 128-bit GPRs, rather than pretending 
they're a crippled version of the DSP ASE.

> By the way, "machine" is set to "Unknown" and "ASEs implemented" is empty
> in /proc/cpuinfo. What would be the proper values for the R5900?

 I have no idea what the machine type is supposed to be set to and why it 
is not omitted by default, given this piece:

		if (mips_get_machine_name())
			seq_printf(m, "machine\t\t\t: %s\n",
				mips_get_machine_name());

I think commit 9169a5d01114 ("MIPS: move mips_{set,get}_machine_name() to 
a more generic place") broke things.  Cc-ing the author for possible 
input.

 ASEs OTOH are specific to MIPS32 and MIPS64 architectures, as per 
respective architecture specification volumes (the MIPS16 ASE might be a 
prominent exception, having been defined as the first ASE ever mid way 
through between the MIPS IV and MIPS32/MIPS64 ISAs).  As the R5900 is not 
a MIPS32 or MIPS64 processor (and has no MIPS16 support) it does not have 
any ASEs implemented.  Vendor-specific architecture extensions do not 
count as ASEs.

  Maciej
