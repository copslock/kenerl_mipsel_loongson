Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2004 15:23:07 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:37521 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225794AbUEKOXG>;
	Tue, 11 May 2004 15:23:06 +0100
Received: from drow by nevyn.them.org with local (Exim 4.33 #1 (Debian))
	id 1BNY9s-0003iB-6I; Tue, 11 May 2004 10:23:00 -0400
Date: Tue, 11 May 2004 10:23:00 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Bradley D. LaRonde" <brad@laronde.org>
Cc: Richard Sandiford <rsandifo@redhat.com>, uclibc@uclibc.org,
	linux-mips@linux-mips.org
Subject: Re: uclibc mips ld.so and undefined symbols with nonzero symbol table entry st_value
Message-ID: <20040511142300.GA14242@nevyn.them.org>
References: <01a901c436ce$7029d890$8d01010a@prefect> <87oeowkoa6.fsf@redhat.com> <02fd01c43709$981a24a0$8d01010a@prefect> <20040511140351.GA13367@nevyn.them.org> <046a01c43763$42feeeb0$8d01010a@prefect>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <046a01c43763$42feeeb0$8d01010a@prefect>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4980
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, May 11, 2004 at 10:21:33AM -0400, Bradley D. LaRonde wrote:
> How about the other copy reloc right below there:
> 
>     else if (sym->st_shndx == SHN_COMMON) {
>       *got_entry = (unsigned long) _dl_find_hash(strtab +
>         sym->st_name, tpnt->symbol_scope, ELF_RTYPE_CLASS_COPY);
>     }

I don't know anything about the uclibc linker code, so I'm not sure.
That's probably OK as future proofing against a copy reloc someday.

-- 
Daniel Jacobowitz
