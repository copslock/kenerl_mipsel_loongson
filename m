Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g083U1Y18852
	for linux-mips-outgoing; Mon, 7 Jan 2002 19:30:01 -0800
Received: from ocean.lucon.org (12-234-19-19.client.attbi.com [12.234.19.19])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g083Tvg18844
	for <linux-mips@oss.sgi.com>; Mon, 7 Jan 2002 19:29:57 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 4F090125CB; Mon,  7 Jan 2002 18:29:55 -0800 (PST)
Date: Mon, 7 Jan 2002 18:29:55 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: GNU libc hacker <libc-hacker@sources.redhat.com>,
   binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Re: Prelink for mips (Re: MIPS broken in 2.3)
Message-ID: <20020107182955.A11352@lucon.org>
References: <u8ellzsg3q.fsf@gromit.moeb> <20011213093958.A6057@lucon.org> <hou1uqclnk.fsf@gee.suse.de> <20011217123631.G542@sunsite.ms.mff.cuni.cz> <20011217091032.A29014@lucon.org> <20011217185215.K542@sunsite.ms.mff.cuni.cz> <20020107131604.A6383@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020107131604.A6383@lucon.org>; from hjl@lucon.org on Mon, Jan 07, 2002 at 01:16:04PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Jan 07, 2002 at 01:16:04PM -0800, H . J . Lu wrote:
> > I know, but from what I understood, quickstart e.g. just assumes there won't
> > be conflicts and if there are, their handling is very costly (their
> > conflicts are just symbol indices which need to be checked out).
> > prelink conflicts are ElfW(Rela) relocs against r_symndx 0.
> > 
> > To port prelink to a new architecture, you need basically:
> > 1) determine what you need to do with relocations and special CPU sections
> >    when relocating a shared library from one address to another one
> >    (e.g. you can link a shared libs once at VMA 0, once at VMA 0xdeadb000
> >    and see what changed) - these are *_adjust_* functions
> > 2) write routines which apply relocs (*_prelink_rel*)
> > 3) write routines which create conflict relocs
> > 4) as MIPS is rel, it needs to be figured out when it is needed to convert
> >    from Rel to Rela (in i386/arm case in most cases it can be avoided,
> >    the only relocs which require it are (on i386): R_386_32 with nonzero
> >    addend (otherwise R_386_GLOB_DAT does exactly the same thing) and
> >    R_386_PC32). This is needed, because otherwise the information about the
> >    original addend is lost when the final relocated value is stored at
> >    r_offset address. Original addend is needed, if prelink cannot be used,
> >    during dynamic linking. If MIPS has some place where it stashes this
> >    for Quickstart, then it could be reused, otherwise I'm afraid REL->RELA will
> >    happen more often on MIPS than on IA-32/ARM.
> > 5) write routines which apply relocs to a buffer or apply a conflict
> >    to a buffer (these are used when doing comparisons on relocated content)
> > 
> 
> As I unsterstand, MIPS only has R_MIPS_REL32 for GOT in DSO and EXE. Do you
> have any suggestions? 

The ld.so relocates R_MIPS_REL32 using GOT which is relocated first by
a special rule. There is no relocation information for GOT. Also there
is no symbol lookup for relocating R_MIPS_REL32. I am not sure how
it will work with the current prelink.


H.J.
