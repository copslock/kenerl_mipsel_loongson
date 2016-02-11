Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Feb 2016 15:59:04 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:1630 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011033AbcBKO7Cp0dHv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Feb 2016 15:59:02 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 757D65772ADEF;
        Thu, 11 Feb 2016 14:58:54 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Thu, 11 Feb 2016
 14:58:56 +0000
Date:   Thu, 11 Feb 2016 14:58:55 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Daniel Wagner <daniel.wagner@bmw-carit.de>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v4 2/2] mips: Differentiate between 32 and 64 bit ELF
 header
In-Reply-To: <alpine.DEB.2.00.1602111153320.15885@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1602111430530.15885@tp.orcam.me.uk>
References: <56BAD881.9000208@bmw-carit.de> <1455096081-7176-1-git-send-email-daniel.wagner@bmw-carit.de> <1455096081-7176-3-git-send-email-daniel.wagner@bmw-carit.de> <20160211104903.GD11091@linux-mips.org>
 <alpine.DEB.2.00.1602111153320.15885@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-7"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52006
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

On Thu, 11 Feb 2016, Maciej W. Rozycki wrote:

> > > Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
> > > Suggested-by: Maciej W. Rozycki <macro@imgtec.com>
> > > Reviewed-by: Maciej W. Rozycki <macro@imgtec.com>
> > > Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> > 
> > Thanks, applied.
> > 
> > I'm getting a less spectacular warning from gcc 5.2:
> > 
> >   CC      fs/proc/vmcore.o
> > fs/proc/vmcore.c: In function �parse_crash_elf64_headers�:
> > fs/proc/vmcore.c:939:47: warning: initialization from incompatible pointer type [-Wincompatible-pointer-types]
> 
>  Yes, the temporaries still need to have their pointed types changed, to 
> `Elf32_Ehdr' and `Elf64_Ehdr' respectively, as in the original change.
> 
>  I had it mentioned in a WIP version of my review (stating that it would 
> verify that the correct type is used by the caller), but then deleted that 
> part inadvertently, sigh.

 Hold on, I was right in dropping it actually.

 With your v4 change in place all `parse_crash_elf64_headers' is supposed 
to call is `mips_elf_check_machine' and that doesn't make any 
intialisations, it just dereferences the pointer passed once.  This error 
does not make any sense to me and line 939 isn't even in 
`parse_crash_elf64_headers', which starts at line 999, it's in 
`process_ptload_program_headers_elf32'.

 So Ralf, what tree are you using that is off from LMO/Linus by 60 lines?

 BTW line 939 at LMO and in Linus's tree looks like:

	Elf32_Phdr *phdr_ptr;

and the pointer is assigned to at line 944 like this:

	phdr_ptr = (Elf32_Phdr*)(elfptr + sizeof(Elf32_Ehdr)); /* PT_NOTE hdr */

so this does not explain the error.  I get a clean build with this version 
of Daniel's patches, both 32-bit and 64-bit, and FAOD with 
CONFIG_PROC_VMCORE=y.

 Daniel, please hold on with further updates, before this is cleared.  
Your v4 looks fine to me AFAICT, no need to change types.  Sorry about 
this all confusion, something's clearly broken somewhere -- maybe due to 
someone else's unpublished patch.

  Maciej
