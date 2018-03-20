Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2018 22:43:22 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:45977 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990520AbeCTVnN5T1Kr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Mar 2018 22:43:13 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 20 Mar 2018 21:43:08 +0000
Received: from [10.20.78.116] (10.20.78.116) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Tue, 20 Mar 2018
 14:43:13 -0700
Date:   Tue, 20 Mar 2018 21:41:47 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     James Hogan <jhogan@kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Set ISA bit in entry-y for microMIPS kernels
In-Reply-To: <20180308222206.GB24558@saruman>
Message-ID: <alpine.DEB.2.00.1803202136390.2163@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1708212102200.17596@tp.orcam.me.uk> <20180308222206.GB24558@saruman>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1521582188-298554-15302-8448-1
X-BESS-VER: 2018.3-r1803192001
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191243
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
X-archive-position: 63084
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

Hi James,

> > +# Sign-extend the entry point to 64 bits if retrieved as a 32-bit number.
> > +entry-y		= $(shell $(OBJDUMP) -f vmlinux 2>/dev/null \
> > +			| sed -n '/^start address / { \
> > +				s/^.*0x\([0-7].......\)$$/0x00000000\1/; \
> > +				s/^.*0x\(........\)$$/0xffffffff\1/; p }')
> 
> This leaves the "start address " on the beginning if the address is
> already 64 bits wide, e.g.:
> 
> VMLINUX_LOAD_ADDRESS=0xffffffff80100000 VMLINUX_ENTRY_ADDRESS=start address 0xffffffff80832720 ...

 Right, sorry about it.

> The following seems to work, to drop the "start address " first then
> work purely on the hex value (i.e. no need for .* at the front of the
> sign extension regexes any more):
> 
> +entry-y		= $(shell $(OBJDUMP) -f vmlinux 2>/dev/null \
> +			| sed -n '/^start address / { \
> +				s/^.* //; \
> +				s/^0x\([0-7].......\)$$/0x00000000\1/; \
> +				s/^0x\(........\)$$/0xffffffff\1/; p }')
> 
> Look reasonable? Is there a cleaner way?

 Then there's no need to match the beginning again with `^' either.  
Otherwise I think it's reasonable enough.  I'll post v3.

 Thanks for your input!

  Maciej
