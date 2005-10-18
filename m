Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Oct 2005 12:04:19 +0100 (BST)
Received: from extgw-uk.mips.com ([62.254.210.129]:51717 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133616AbVJRLEC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Oct 2005 12:04:02 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id j9IB3uml010921;
	Tue, 18 Oct 2005 12:03:56 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id j9IB3tac010920;
	Tue, 18 Oct 2005 12:03:55 +0100
Date:	Tue, 18 Oct 2005 12:03:55 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: OProfile cannot be loaded as module...
Message-ID: <20051018110355.GB2656@linux-mips.org>
References: <43470BCF.1070709@avtrex.com> <20051013225520.GA3234@linux-mips.org> <43540609.4000105@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43540609.4000105@avtrex.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 17, 2005 at 01:14:01PM -0700, David Daney wrote:

> >>arch/mips/oprofile/common.c defines several symbols (op_model_mipsxx and 
> >>op_model_rm9000) with __attribute__((weak)).  It then assumes that ELF 
> >>linking conventions will prevail and there will be no problems if they 
> >>are undefined.
> >>
> >>The problem is if you try to load oprofile as a module.  The kernel 
> >>module linker evidentially does not understand weak symbols and refuses 
> >>to load the module because they are undefined.
> >
> >
> >Actually it contains code to handle weak symbols so this is a bit
> >surprising not last because STB_WEAK handling happen in the generic
> >module loader code and is being used by other architectures as well.
> >
> >So if there's a problem with the module loader I'd prefer to solve that
> >instead of starting to kludge around it.
> >
> 
> Fine, but what exactly are the semantics of __attribute__((weak)) in 
> modules?  It gets resolved when linking with other objects that make up 
> the module.  But what if the weak symbol can be resolved at module load 
> time against symbols in either the kernel proper or other modules?

Yes.

> What happens if the weak symbol can be resolved by a symbol in a module
> that is loaded after the one with the weak symbol?  Does it get fixed up
> when the new module is loaded?

No, it won't - and I don't think that would be a good idea.  The potencial
for bugs is just too large.

  Ralf
