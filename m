Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Oct 2017 18:40:07 +0200 (CEST)
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:36471 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990398AbdJOQkBTRLMY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 15 Oct 2017 18:40:01 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 07AC33F7D9;
        Sun, 15 Oct 2017 18:39:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tYBJkpMUDMtd; Sun, 15 Oct 2017 18:39:52 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id A17793F753;
        Sun, 15 Oct 2017 18:39:42 +0200 (CEST)
Date:   Sun, 15 Oct 2017 18:39:38 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: Add basic R5900 support
Message-ID: <20171015163937.GA2239@localhost.localdomain>
References: <alpine.DEB.2.00.1709141423180.16752@tp.orcam.me.uk>
 <20170916133423.GB32582@localhost.localdomain>
 <alpine.DEB.2.00.1709171001160.16752@tp.orcam.me.uk>
 <20170920140715.GA9255@localhost.localdomain>
 <alpine.DEB.2.00.1709201604400.16752@tp.orcam.me.uk>
 <20170922163753.GA2415@localhost.localdomain>
 <alpine.DEB.2.00.1709300024350.12020@tp.orcam.me.uk>
 <20170930182608.GB7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301929060.12020@tp.orcam.me.uk>
 <20171006202838.GA26707@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171006202838.GA26707@localhost.localdomain>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Maciej,

> >  Anyway, as noted above that shouldn't cause a problem with user software 
> > and I think that any corruption you can see comes from elsewhere.  You'll 
> > have to paper this $ra non-sign-extension issue over somehow to proceed 
> > though.
> 
> I've extended do_IRQ with a register check under the condition that
> user_mode(get_irq_regs()) is true, with the following sample results
> where registers $2-$25 are printed if they are not sign-extended
> properly (there is a certain amount of randomness to this):
> 
>     $10 : 00005f6362696c5f
>     epc = 0fb6db00 in ld.so.1[fb60000+19000]

Debian-based Black Rhino libc.so.6 declares "ELF 32-bit LSB MIPS-III
version 1" but functions such as strcmp contain both 64-bit and multimedia
instructions (presumably hand coded in assembly for the R5900):

	6005ea90 <strcmp>:
	...
	6005eb50:	78880000 	lq	t0,0(a0)
	6005eb54:	710043a9 	pcpyud	t0,t0,zero
	6005eb58:	1000000c 	b	6005eb8c <strcmp+0xfc>
	6005eb5c:	71204ba9 	pcpyud	t1,t1,zero
	6005eb60:	dc880000 	ld	t0,0(a0)
	6005eb64:	24840008 	addiu	a0,a0,8
	6005eb68:	dca90000 	ld	t1,0(a1)
	6005eb6c:	710072a8 	pceqb	t6,t0,zero
	6005eb70:	71207aa8 	pceqb	t7,t1,zero
	6005eb74:	01cf7025 	or	t6,t6,t7
	6005eb78:	71097aa8 	pceqb	t7,t0,t1
	...

Hence corruption and register sign-extension failures. One can also note
that according to the TX-79 manual, for a 32-bit kernel, several MIPS I
instruction operations are undefined unless registers are sign-extended.

It is unfortunate that these instructions seem untrappable by the R5900,
instead silently causing strange behaviour and invalid results.

Still left to explain is why the kernel stumbles on registers during
initialisation, before user applications are invoked.

Fredrik
