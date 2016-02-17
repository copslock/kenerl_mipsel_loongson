Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Feb 2016 21:04:40 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59580 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012373AbcBQUEib95WU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Feb 2016 21:04:38 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 26CC37DB7FF23;
        Wed, 17 Feb 2016 20:04:29 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Wed, 17 Feb 2016
 20:04:31 +0000
Date:   Wed, 17 Feb 2016 20:04:31 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Daniel Sanders <daniel.sanders@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Scott Egerton <Scott.Egerton@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] mips: Avoid a form of the .type directive that is not
 supported by LLVM's Integrated Assembler
In-Reply-To: <1455723429-26459-1-git-send-email-daniel.sanders@imgtec.com>
Message-ID: <alpine.DEB.2.00.1602171944410.15885@tp.orcam.me.uk>
References: <1455723429-26459-1-git-send-email-daniel.sanders@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52108
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

Hi Daniel,

 Please try to fit your patch summary (subject) in 75 characters to avoid 
line wrapping in GIT.

> The target independent parts of the LLVM Lexer considers 'fault@function'
> to be a single token representing the 'fault' symbol with a 'function'
> modifier. However, this is not the case in the .type directive where
> 'function' refers to STT_FUNC from the ELF standard.

 If LLVM strives to be GNU toolchain compatible, then this looks like a 
bug in their scanner as generic ELF support in GAS (gas/config/obj-elf.c) 
has this, in `obj_elf_type':

  if (*input_line_pointer == ',')
    ++input_line_pointer;

so the comma is entirely optional.  I realise this is undocumented, but 
there you go.  It must have been there since forever.

> This is the only example of this form of '.type' that we are aware of in
> MIPS source so we'd prefer to make this small source change rather than
> complicate the target independent parts of LLVM's assembly lexer with
> directive and/or target specific exceptions to the lexing rules.

 So this has nothing to do with the MIPS target really.

 As to the change itself I agree it seems rather pointless to have this 
single oddity, which I suspect has been a finger slip which has only 
survived because GAS is happy to accept this form.  So:

Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>

although please make the same change to arch/mips/kernel/r2300_fpu.S (the 
same patch should apply there cleanly) for consistency and resend with the 
last paragraph rewritten so as not to confuse people this has anything to 
do with our target.

 For the record this was introduced with commit 0ae8dceaebe3 ("Merge with 
2.3.10.").

  Maciej
