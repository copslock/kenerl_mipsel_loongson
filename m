Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Oct 2017 11:12:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27744 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990432AbdJBJLzhYDYs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Oct 2017 11:11:55 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 22FA1268F573F;
        Mon,  2 Oct 2017 10:11:47 +0100 (IST)
Received: from [10.20.78.129] (10.20.78.129) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.361.1; Mon, 2 Oct 2017
 10:11:48 +0100
Date:   Mon, 2 Oct 2017 10:11:35 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
In-Reply-To: <20170930182608.GB7714@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1709301929060.12020@tp.orcam.me.uk>
References: <20170911151737.GA2265@localhost.localdomain> <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk> <20170916133423.GB32582@localhost.localdomain> <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk> <20170920140715.GA9255@localhost.localdomain>
 <alpine.DEB.2.00.1709201604400.16752@tp.orcam.me.uk> <20170922163753.GA2415@localhost.localdomain> <alpine.DEB.2.00.1709300024350.12020@tp.orcam.me.uk> <20170930182608.GB7714@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.129]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

> > > I suspect 63:32 are the critical bits of the upper 96 bits since SD/LD
> > > is sufficient. Summery of observations thus far: save/restore works with
> > > SQ/LQ and SD/LD, but not SW/LW, in a 32-bit kernel ceteris paribus.
> > 
> >  This does look intriguing.
> 
> I believe the simple answer to this mystery is that addresses are not
> supposed to be sign-extended, given the look of $31 below. What are
> your thoughts on this?
[...]
> $28   :
>  ffffffff81f70000
>  ffffffff81f71bf8
>  ffffffff815010f8
>  00000000800bed80
> Hi    : 00000000
> Lo    : 00000048
> epc   : 800beeb0 unmap_page_range+0x3cc/0x664
> ra    : 00000000800bed80 unmap_page_range+0x29c/0x664

 Hmm, this looks consistent with the TX79 manual:

"6.2.1 Virtual Address Space

The C790 only implements 32 bits of virtual address space.  There is no 
requirement for address sign extension and no checking will be done on the 
upper 32 bits of the address."

and then say in the JAL instruction description:

"I: GPR[31] 63..0 <- zero_extend (PC + 8)"

It does not matter for the user mode where bit #31 is 0 and therefore both 
zero-extension and sign-extension produce the same result, so the typical 
PIC code sequence used to determine its own location, i.e.:

	la	$2, 0f
	bltzal	$0, 0f
0:
	subu	$2, $31, $2

will work correctly, not causing UB with the SUBU instruction.

 However it does cause complications for the kernel in that the value of 
$ra retrieved cannot be readily used for 32-bit calculations and has to be 
treated with SLL by 0 first.  You'll have to audit the arch/mips subtree 
for any such $ra use for calculation; hopefully are there's none.

 I wonder why they broke it like this -- was it a silly deliberate choice 
or merely an oversight (erratum) they chose to document rather than fix? 
For a change they do implement MFC0 with sign-extension, so retrieving 
e.g. CP0.EPC will see kernel addresses correctly sign-extended.

 Anyway, as noted above that shouldn't cause a problem with user software 
and I think that any corruption you can see comes from elsewhere.  You'll 
have to paper this $ra non-sign-extension issue over somehow to proceed 
though.

  Maciej
