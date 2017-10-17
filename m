Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 14:23:50 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.150.246]:60941 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990505AbdJQMXlLpK80 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Oct 2017 14:23:41 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 17 Oct 2017 12:23:35 +0000
Received: from [10.20.78.215] (10.20.78.215) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Tue, 17 Oct 2017
 05:23:12 -0700
Date:   Tue, 17 Oct 2017 13:23:22 +0100
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
In-Reply-To: <20171015163937.GA2239@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1710171301160.3886@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk> <20170916133423.GB32582@localhost.localdomain> <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk> <20170920140715.GA9255@localhost.localdomain> <alpine.DEB.2.00.1709201604400.16752@tp.orcam.me.uk>
 <20170922163753.GA2415@localhost.localdomain> <alpine.DEB.2.00.1709300024350.12020@tp.orcam.me.uk> <20170930182608.GB7714@localhost.localdomain> <alpine.DEB.2.00.1709301929060.12020@tp.orcam.me.uk> <20171006202838.GA26707@localhost.localdomain>
 <20171015163937.GA2239@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1508243014-637138-899-413939-1
X-BESS-VER: 2017.12-r1710102214
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186053
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
X-archive-position: 60425
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

Hi Fredrik,

> Debian-based Black Rhino libc.so.6 declares "ELF 32-bit LSB MIPS-III
> version 1" but functions such as strcmp contain both 64-bit and multimedia
> instructions (presumably hand coded in assembly for the R5900):
> 
> 	6005ea90 <strcmp>:
> 	...
> 	6005eb50:	78880000 	lq	t0,0(a0)
> 	6005eb54:	710043a9 	pcpyud	t0,t0,zero
> 	6005eb58:	1000000c 	b	6005eb8c <strcmp+0xfc>
> 	6005eb5c:	71204ba9 	pcpyud	t1,t1,zero
> 	6005eb60:	dc880000 	ld	t0,0(a0)
> 	6005eb64:	24840008 	addiu	a0,a0,8
> 	6005eb68:	dca90000 	ld	t1,0(a1)
> 	6005eb6c:	710072a8 	pceqb	t6,t0,zero
> 	6005eb70:	71207aa8 	pceqb	t7,t1,zero
> 	6005eb74:	01cf7025 	or	t6,t6,t7
> 	6005eb78:	71097aa8 	pceqb	t7,t0,t1
> 	...
> 
> Hence corruption and register sign-extension failures. One can also note
> that according to the TX-79 manual, for a 32-bit kernel, several MIPS I
> instruction operations are undefined unless registers are sign-extended.

 That's a standard architectural requirement, not related to the kernel 
being 32-bit or 64-bit.  Overall all 32-bit ALU operations, except for SLL 
and SLLV, mandate that their input operands have been sign-extended from 
bit #31.

 I think you need to find another libc (or the whole userland), as I 
previously suggested.  I don't think we want to enable non-standard 
userland semantics, not as yet at least.  Having code supported like the 
snippet you have quoted above would I believe essentially boil down to 
Linux o64 ABI support, and anyway I think GAS should reject MMI 
instructions in the o32 assembly mode (which is something that was missed 
in R5900 support review).  I'll think on a suitable fix for GAS.

> It is unfortunate that these instructions seem untrappable by the R5900,
> instead silently causing strange behaviour and invalid results.

 Indeed, there's no way to trap with operations that break the 32-bit 
sign-extension requirement.  That's no different though from how the 
64-bit Linux kernel has operated for o32 software since forever; we don't 
clear the CP0.Status.UX bit for o32 tasks, although a discussion has been 
underway about changing it as it breaks indexed addressing (not a concern 
for the R5900, as a MIPS IV+ feature, e.g. LDXC1).  This has complications
though as we'd have to implement a TLB refill handler along with the XTLB 
refill handler, which is already taking space the former requires.

> Still left to explain is why the kernel stumbles on registers during
> initialisation, before user applications are invoked.

 Good luck!

  Maciej
