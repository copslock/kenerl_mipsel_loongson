Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 13:31:02 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26185 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010717AbcBXMa7jzyg2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 13:30:59 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id EF16B727596B2;
        Wed, 24 Feb 2016 12:30:51 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Wed, 24 Feb 2016
 12:30:53 +0000
Date:   Wed, 24 Feb 2016 12:30:52 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Daniel Sanders <daniel.sanders@imgtec.com>,
        Scott Egerton <Scott.Egerton@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mips: Avoid a form of the .type directive that is not
 supported by LLVM's Integrated Assembler
In-Reply-To: <20160224015058.GA25673@linux-mips.org>
Message-ID: <alpine.DEB.2.00.1602240328360.15885@tp.orcam.me.uk>
References: <1455723429-26459-1-git-send-email-daniel.sanders@imgtec.com> <alpine.DEB.2.00.1602171944410.15885@tp.orcam.me.uk> <20160224015058.GA25673@linux-mips.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52189
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

On Wed, 24 Feb 2016, Ralf Baechle wrote:

> >  If LLVM strives to be GNU toolchain compatible, then this looks like a 
> > bug in their scanner as generic ELF support in GAS (gas/config/obj-elf.c) 
> > has this, in `obj_elf_type':
> > 
> >   if (*input_line_pointer == ',')
> >     ++input_line_pointer;
> > 
> > so the comma is entirely optional.  I realise this is undocumented, but 
> > there you go.  It must have been there since forever.
> 
> It contradicts documentation.  The gas manual says:
> 
> * Type::                        `.type <INT | NAME , TYPE DESCRIPTION>'
> 
> And the SGI assembler manual I dug up as ".type name, value".  So maybe
> gas is too generous here?

 I find it interesting that you mention SGI here as the commit which might 
be responsible for the current interpretation is this:

Mon Sep 12 17:51:39 1994  Ian Lance Taylor  (ian@sanguine.cygnus.com)

	* config/obj-elf.c (obj_elf_type): Rewrite to accept syntax
	reportedly to be used on Irix 6.

Given its age I doubt further information can be found, it might be just 
sloppy coding.

> Either way, I think the patch is right and I've just applied v2.

 Sure, thanks!

  Maciej
