Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 02:51:01 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58988 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013108AbcBXBu7yIsGt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2016 02:50:59 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u1O1oxTx026094;
        Wed, 24 Feb 2016 02:50:59 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u1O1owGc026093;
        Wed, 24 Feb 2016 02:50:58 +0100
Date:   Wed, 24 Feb 2016 02:50:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Daniel Sanders <daniel.sanders@imgtec.com>,
        Scott Egerton <Scott.Egerton@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] mips: Avoid a form of the .type directive that is not
 supported by LLVM's Integrated Assembler
Message-ID: <20160224015058.GA25673@linux-mips.org>
References: <1455723429-26459-1-git-send-email-daniel.sanders@imgtec.com>
 <alpine.DEB.2.00.1602171944410.15885@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1602171944410.15885@tp.orcam.me.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Wed, Feb 17, 2016 at 08:04:31PM +0000, Maciej W. Rozycki wrote:

>  If LLVM strives to be GNU toolchain compatible, then this looks like a 
> bug in their scanner as generic ELF support in GAS (gas/config/obj-elf.c) 
> has this, in `obj_elf_type':
> 
>   if (*input_line_pointer == ',')
>     ++input_line_pointer;
> 
> so the comma is entirely optional.  I realise this is undocumented, but 
> there you go.  It must have been there since forever.

It contradicts documentation.  The gas manual says:

* Type::                        `.type <INT | NAME , TYPE DESCRIPTION>'

And the SGI assembler manual I dug up as ".type name, value".  So maybe
gas is too generous here?

Either way, I think the patch is right and I've just applied v2.

  Ralf
