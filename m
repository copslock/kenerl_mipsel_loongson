Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 May 2004 15:04:02 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:23953 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225794AbUEKOEB>;
	Tue, 11 May 2004 15:04:01 +0100
Received: from drow by nevyn.them.org with local (Exim 4.33 #1 (Debian))
	id 1BNXrL-0003U6-IY; Tue, 11 May 2004 10:03:51 -0400
Date: Tue, 11 May 2004 10:03:51 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Bradley D. LaRonde" <brad@laronde.org>
Cc: Richard Sandiford <rsandifo@redhat.com>, uclibc@uclibc.org,
	linux-mips@linux-mips.org
Subject: Re: uclibc mips ld.so and undefined symbols with nonzero symbol table entry st_value
Message-ID: <20040511140351.GA13367@nevyn.them.org>
References: <01a901c436ce$7029d890$8d01010a@prefect> <87oeowkoa6.fsf@redhat.com> <02fd01c43709$981a24a0$8d01010a@prefect>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02fd01c43709$981a24a0$8d01010a@prefect>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, May 10, 2004 at 11:39:41PM -0400, Bradley D. LaRonde wrote:
> ----- Original Message ----- 
> From: "Richard Sandiford" <rsandifo@redhat.com>
> To: "Bradley D. LaRonde" <brad@laronde.org>
> Cc: <uclibc@uclibc.org>; <linux-mips@linux-mips.org>
> Sent: Monday, May 10, 2004 4:41 PM
> Subject: Re: uclibc mips ld.so and undefined symbols with nonzero symbol
> table entry st_value
> 
> 
> > "Bradley D. LaRonde" <brad@laronde.org> writes:
> > > I read this in the spec:
> > >
> > >     All externally visible symbols, both defined and undefined,
> > >     must be hashed into the hash table.
> > >
> > > Should libpthread's malloc stub be added to the hash table?
> >
> > Yes.
> >
> > > I guess not, but I think that might be happening (haven't verified),
> > > and libdl finding it in there and thinking it is the real deal, not
> > > realizing it is just a stub.
> >
> > If you have an undefined function symbol with st_value != 0, then
> > that st_value must be for a stub.  That's how the loader can (and is
> > supposed to) tell the difference.
> >
> > It's probably a good idea to look at how glibc handles this.
> 
> uClibc/ldso/ldso/mips/elfinterp.c around line 288 looks like this:
> 
> 
>     /* Relocate the global GOT entries for the object */
>     while(i--) {
>       if (sym->st_shndx == SHN_UNDEF) {
>         if (ELF32_ST_TYPE(sym->st_info) == STT_FUNC && sym->st_value)
>           *got_entry = sym->st_value + (unsigned long) tpnt->loadaddr;
>         else {
>           *got_entry = (unsigned long) _dl_find_hash(strtab +
>              sym->st_name, tpnt->symbol_scope, ELF_RTYPE_CLASS_COPY);
>         }
>      }
> 
> 
> If I change that ELF_RTYPE_CLASS_COPY to ELF_RTYPE_CLASS_PLT to tell
> _dl_find_hash to ignore stubs when resolving undefined functions without
> stubs, the dlopen tests all pass.  dlopen gets a pointer to the libc.so
> malloc instead of a pointer to the libpthread malloc stub.  Yay!  :-)
> 
> Does that look like the correct fix?

Probably, since MIPS doesn't have a copy reloc.

-- 
Daniel Jacobowitz
