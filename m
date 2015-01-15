Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2015 15:11:33 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56251 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011689AbbAOOLbUp0U0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2015 15:11:31 +0100
Date:   Thu, 15 Jan 2015 14:11:31 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     James Cowgill <James.Cowgill@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: ELF: fix loading o32 binaries on 64-bit kernels
In-Reply-To: <1421253434-49869-1-git-send-email-James.Cowgill@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501151349280.28301@eddie.linux-mips.org>
References: <1421253434-49869-1-git-send-email-James.Cowgill@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45125
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Wed, 14 Jan 2015, James Cowgill wrote:

> Commit 90cee759f08a ("MIPS: ELF: Set FP mode according to .MIPS.abiflags")
> introduced checking of the .MIPS.abiflags ELF section but did so through
> the native sized "elfhdr" and "elf_phdr" structures regardless whether the
> ELF was actually 32-bit or 64-bit. This produces wrong results when trying
> to use a 64-bit kernel to load o32 ELF files.
> 
> Change the uses of the generic elf structures to their 32-bit versions.
> Since the code bails out on any 64-bit cases, this is OK until they are
> implemented.

 I'd say this will never happen as FR=0 with n64/n32 makes no sense.  So 
the fix itself looks good to me as it stands and hence here's my:

Reviewed-by: Maciej W. Rozycki <macro@linux-mips.org>

 I have some concerns about the original change that I think need 
addressing though:

1. This piece in `arch_check_elf':

	/* Ignore non-O32 binaries */
	if (config_enabled(CONFIG_64BIT) &&
	    (ehdr->e_ident[EI_CLASS] != ELFCLASS32))
		return 0;

   is incomplete, contrary to the comment the check only trips on n64
   binaries, but lets n32 ones through (as a side note `o32' would IMO 
   better be spelled with a lowercase `o' as this is the original spelling 
   of the names of the MIPS ABIs and they only way it was spelled for at 
   least a decade from its inception BTW; though I realise there's been 
   confusion about the spelling that happened sometime in the recent 
   past).  Similarly in `arch_elf_pt_proc'.

2. Code added with 90cee759f08a lacks commentary that would make the use 
   of `elf32_hdr', etc. obvious and might have prevented the bugs this fix 
   corrects from happening in the first place.  While not a requirement 
   for Linux (unlike for some other free software) it's always good to 
   write a sentence or two above a function definition to say what it is
   supposed to do.

 Paul -- I think the two concerns are action items for you!

  Maciej
