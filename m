Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9F03fe19946
	for linux-mips-outgoing; Sun, 14 Oct 2001 17:03:41 -0700
Received: from mailin5.bigpond.com (mailin5.bigpond.com [139.134.6.78] (may be forged))
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9F03YD19943
	for <linux-mips@oss.sgi.com>; Sun, 14 Oct 2001 17:03:34 -0700
Received: from bubble.local ([144.135.24.75]) by
          mailin5.bigpond.com (Netscape Messaging Server 4.15) with SMTP
          id GL80GF00.9KO for <linux-mips@oss.sgi.com>; Mon, 15 Oct 2001
          10:09:51 +1000 
Received: from 144.136.192.57 ([144.136.192.57]) by bwmam03.mailsvc.email.bigpond.com(MailRouter V2.9k 8323/2994302); 15 Oct 2001 10:09:45
Received: (qmail 11758 invoked by uid 179); 15 Oct 2001 00:03:17 -0000
Date: Mon, 15 Oct 2001 09:33:17 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: "H . J . Lu" <hjl@lucon.org>
Cc: "Leonard N. Zubkoff" <lnz@dandelion.com>, binutils@sourceware.cygnus.com,
   gcc@gcc.gnu.org, GNU C Library <libc-alpha@sourceware.cygnus.com>,
   Kenneth Albanowski <kjahds@kjahds.com>, Mat Hostetter <mat@lcs.mit.edu>,
   Andy Dougherty <doughera@lafcol.lafayette.edu>,
   Warner Losh <imp@village.org>, linux-mips@oss.sgi.com,
   Ron Guilmette <rfg@monkeys.com>,
   "Polstra; John" <linux-binutils-in@polstra.com>,
   "Hazelwood; Galen" <galenh@micron.net>,
   Ralf Baechle <ralf@mailhost.uni-koblenz.de>,
   Linas Vepstas <linas@linas.org>, Feher Janos <aries@hal2000.terra.vein.hu>,
   "Steven J. Hill" <sjhill@cotw.com>, linux-gcc@vger.kernel.org
Subject: Re: binutils 2.11.92.0.6 (Re: binutils 2.11.92.0.5 is broken)
Message-ID: <20011015093317.B1015@bubble.sa.bigpond.net.au>
Mail-Followup-To: "H . J . Lu" <hjl@lucon.org>,
	"Leonard N. Zubkoff" <lnz@dandelion.com>,
	binutils@sourceware.cygnus.com, gcc@gcc.gnu.org,
	GNU C Library <libc-alpha@sourceware.cygnus.com>,
	Kenneth Albanowski <kjahds@kjahds.com>,
	Mat Hostetter <mat@lcs.mit.edu>,
	Andy Dougherty <doughera@lafcol.lafayette.edu>,
	Warner Losh <imp@village.org>, linux-mips@oss.sgi.com,
	Ron Guilmette <rfg@monkeys.com>,
	"Polstra; John" <linux-binutils-in@polstra.com>,
	"Hazelwood; Galen" <galenh@micron.net>,
	Ralf Baechle <ralf@informatik.uni-koblenz.de>,
	Linas Vepstas <linas@linas.org>,
	Feher Janos <aries@hal2000.terra.vein.hu>,
	"Steven J. Hill" <sjhill@cotw.com>, linux-gcc@vger.kernel.org
References: <200110131452.f9DEq7Q0032358@dandelion.com> <20011013190034.A27019@lucon.org> <20011013235621.A15807@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20011013235621.A15807@lucon.org>; from hjl@lucon.org on Sat, Oct 13, 2001 at 11:56:21PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Oct 13, 2001 at 11:56:21PM -0700, H . J . Lu wrote:
> > Hi Alan,
> > 
> > This patch
> > 
> > http://sources.redhat.com/ml/binutils/2001-10/msg00035.html
> > 
> > is incomplete. You cannot do any backend processing when

Err, yes.  Thanks for looking into it, HJ.  I've been away this weekend,
which is why it appears that I've been ignoring the problem.


> Index: elf32-hppa.c
> ===================================================================
> RCS file: /work/cvs/gnu/binutils/bfd/elf32-hppa.c,v
> retrieving revision 1.41
> diff -u -p -r1.41 elf32-hppa.c
> --- elf32-hppa.c	2001/10/03 15:55:57	1.41
> +++ elf32-hppa.c	2001/10/14 06:43:23
> @@ -1147,7 +1147,7 @@ elf32_hppa_copy_indirect_symbol (dir, in
>        edir->dyn_relocs = eind->dyn_relocs;
>        eind->dyn_relocs = NULL;
>      }
> -  else if (eind->dyn_relocs != NULL)
> +  else if (dir != ind->weakdef && eind->dyn_relocs != NULL)

I suspect this is not the correct fix.  dyn_relocs is being used to count
relocs, and probably what should happen is something like

  else if (eind->dyn_relocs != NULL)
    {
      struct elf32_hppa_dyn_reloc_entry *p;

      if (edir != eind->elf.weakdef)
	abort ();

      /* Add reloc counts against the weak sym to the strong sym list.
	 Entries on the eind list should have a different p->sec from
	 any on the dir list, so we don't need to merge entries.  */
      for (p = eind->dyn_relocs; p->next != NULL; p = p->next)
	;
      p->next = edir->dyn_relocs;
      edir->dyn_relocs = eind->dyn_relocs;
      eind->dyn_relocs = NULL;
    }

Untested as yet, because I don't have a testcase.  I'll see if I can
dream one up.

>      abort ();
>  
>    _bfd_elf_link_hash_copy_indirect (dir, ind);
> @@ -1843,6 +1843,11 @@ elf32_hppa_adjust_dynamic_symbol (info, 
>  	}
>  
>        return true;
> +    }
> +  else
> +    {
> +      h->plt.offset = (bfd_vma) -1;
> +      h->elf_link_hash_flags &= ~ELF_LINK_HASH_NEEDS_PLT;
>      }

This part is corrent, and similarly for the other architectures.

> --- elflink.h	2001/10/05 20:32:13	1.82
> +++ elflink.h	2001/10/11 18:15:44	1.83
> +     As above, we permit a non-weak definition in a shared object to
> +     override a weak definition in a regular object.  */

I don't disagree with this change, but has this been discussed sufficiently
here and on the glibc list?

Alan
