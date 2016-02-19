Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Feb 2016 11:07:03 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39408 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007495AbcBSKHBp4-Lm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 19 Feb 2016 11:07:01 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 90BA6AEC0A57E;
        Fri, 19 Feb 2016 10:06:52 +0000 (GMT)
Received: from hhmail02.hh.imgtec.org ([fe80::5400:d33e:81a4:f775]) by
 HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3%26]) with mapi id
 14.03.0266.001; Fri, 19 Feb 2016 10:06:53 +0000
From:   Daniel Sanders <Daniel.Sanders@imgtec.com>
To:     Maciej Rozycki <Maciej.Rozycki@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Scott Egerton <Scott.Egerton@imgtec.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        "Markos Chandras" <Markos.Chandras@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH] mips: Avoid a form of the .type directive that is not
 supported by LLVM's Integrated Assembler
Thread-Topic: [PATCH] mips: Avoid a form of the .type directive that is not
 supported by LLVM's Integrated Assembler
Thread-Index: AQHRaZkU+k5Y1OCoL0aZtPCBvTihB58wqaGAgAJuAlw=
Date:   Fri, 19 Feb 2016 10:06:52 +0000
Message-ID: <E484D272A3A61B4880CDF2E712E9279F467708C2@hhmail02.hh.imgtec.org>
References: <1455723429-26459-1-git-send-email-daniel.sanders@imgtec.com>,<alpine.DEB.2.00.1602171944410.15885@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.00.1602171944410.15885@tp.orcam.me.uk>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [82.153.31.74]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Daniel.Sanders@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52128
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Daniel.Sanders@imgtec.com
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

Hi Maceij,

> Hi Daniel,
> Please try to fit your patch summary (subject) in 75 characters to avoid
> line wrapping in GIT.

Ok, I'll fix this in my next version.

> > The target independent parts of the LLVM Lexer considers 'fault@function'
> > to be a single token representing the 'fault' symbol with a 'function'
> > modifier. However, this is not the case in the .type directive where
> > 'function' refers to STT_FUNC from the ELF standard.
> 
>  If LLVM strives to be GNU toolchain compatible, then this looks like a
> bug in their scanner as generic ELF support in GAS (gas/config/obj-elf.c)
> has this, in `obj_elf_type':
> 
>   if (*input_line_pointer == ',')
>     ++input_line_pointer;
> 
> so the comma is entirely optional.  I realise this is undocumented, but
> there you go.  It must have been there since forever.

It's not just about the comma, the problem arises when there's nothing separating the symbol from the '@function'.
Adding a single whitespace is also sufficient to avoid the problem but we chose to add the comma as well.

> > This is the only example of this form of '.type' that we are aware of in
> > MIPS source so we'd prefer to make this small source change rather than
> > complicate the target independent parts of LLVM's assembly lexer with
> > directive and/or target specific exceptions to the lexing rules.
> 
>  So this has nothing to do with the MIPS target really.

I suppose it depends how you view it. You're correct that the underlying issue is probably relevant to more targets than just MIPS.
From my perspective this is a MIPS thing since my goal is to get the MIPS Integrated Assembler to a good enough state to be
able to make it our default assembler and on this occasion we're making a small change to MIPS-specific kernel sources to make
that easier.

I'll rewrite the last paragraph anyway though.

>  As to the change itself I agree it seems rather pointless to have this
> single oddity, which I suspect has been a finger slip which has only
> survived because GAS is happy to accept this form.  So:
> 
> Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
> 
> although please make the same change to arch/mips/kernel/r2300_fpu.S (the
> same patch should apply there cleanly) for consistency and resend with the
> last paragraph rewritten so as not to confuse people this has anything to
> do with our target.
> 
>  For the record this was introduced with commit 0ae8dceaebe3 ("Merge with
> 2.3.10.").

Ok

>   Maciej
