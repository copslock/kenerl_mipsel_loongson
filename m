Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBHIcpI27264
	for linux-mips-outgoing; Mon, 17 Dec 2001 10:38:51 -0800
Received: from sunsite.ms.mff.cuni.cz (sunsite.ms.mff.cuni.cz [195.113.19.66])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBHIcio27253
	for <linux-mips@oss.sgi.com>; Mon, 17 Dec 2001 10:38:44 -0800
Received: (from jj@localhost)
	by sunsite.ms.mff.cuni.cz (8.9.3/8.9.3) id SAA07672;
	Mon, 17 Dec 2001 18:52:15 +0100
Date: Mon, 17 Dec 2001 18:52:15 +0100
From: Jakub Jelinek <jakub@redhat.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Andreas Jaeger <aj@suse.de>,
   GNU libc hacker <libc-hacker@sources.redhat.com>,
   binutils@sourceware.cygnus.com, linux-mips@oss.sgi.com
Subject: Re: Prelink for mips (Re: MIPS broken in 2.3)
Message-ID: <20011217185215.K542@sunsite.ms.mff.cuni.cz>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <u8ellzsg3q.fsf@gromit.moeb> <20011213093958.A6057@lucon.org> <hou1uqclnk.fsf@gee.suse.de> <20011217123631.G542@sunsite.ms.mff.cuni.cz> <20011217091032.A29014@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <20011217091032.A29014@lucon.org>; from H . J . Lu on Mon, Dec 17, 2001 at 09:10:32AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Dec 17, 2001 at 09:10:32AM -0800, H . J . Lu wrote:
> On Mon, Dec 17, 2001 at 12:36:31PM +0100, Jakub Jelinek wrote:
> 
> > instead (well, best would be if somebody ported prelink to mips;
> > I'll try to answer any questions and help).
> 
> Do you have some documentations how prelink works?

So far not too much. Some info is in prelink(8) man page, some info
was posted to binutils mailing list.
The rest can be done if you ask questions, I'll answer them and save the
answers (and compile something from them in the future).

> > I skipped mips because it is way too different from how any other ELF
> > architecture works (e.g. using a single dynamic reloc type for everything
> > with various meanings, etc.) and I have no access to it.
> 
> That is what I am afraid of. The MIPS ABI supports "quickstart".

I know, but from what I understood, quickstart e.g. just assumes there won't
be conflicts and if there are, their handling is very costly (their
conflicts are just symbol indices which need to be checked out).
prelink conflicts are ElfW(Rela) relocs against r_symndx 0.

To port prelink to a new architecture, you need basically:
1) determine what you need to do with relocations and special CPU sections
   when relocating a shared library from one address to another one
   (e.g. you can link a shared libs once at VMA 0, once at VMA 0xdeadb000
   and see what changed) - these are *_adjust_* functions
2) write routines which apply relocs (*_prelink_rel*)
3) write routines which create conflict relocs
4) as MIPS is rel, it needs to be figured out when it is needed to convert
   from Rel to Rela (in i386/arm case in most cases it can be avoided,
   the only relocs which require it are (on i386): R_386_32 with nonzero
   addend (otherwise R_386_GLOB_DAT does exactly the same thing) and
   R_386_PC32). This is needed, because otherwise the information about the
   original addend is lost when the final relocated value is stored at
   r_offset address. Original addend is needed, if prelink cannot be used,
   during dynamic linking. If MIPS has some place where it stashes this
   for Quickstart, then it could be reused, otherwise I'm afraid REL->RELA will
   happen more often on MIPS than on IA-32/ARM.
5) write routines which apply relocs to a buffer or apply a conflict
   to a buffer (these are used when doing comparisons on relocated content)

Write the glibc part, which for REL arches means write rela variants of
routines and figure what if anything needs to be done to undo prelinked PLT
slots.

> I don't know if we can add prelink to mips without breaking/changing
> the MIPS ABI. I don't want to spend my time on it if it can't be done
> at all.

	Jakub
