Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1PI6eI24875
	for linux-mips-outgoing; Mon, 25 Feb 2002 10:06:40 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1PI63924869
	for <linux-mips@oss.sgi.com>; Mon, 25 Feb 2002 10:06:04 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id SAA20371;
	Mon, 25 Feb 2002 18:04:56 +0100 (MET)
Date: Mon, 25 Feb 2002 18:04:55 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: R3k and swap: Still no go?
In-Reply-To: <20020223001122.F15503@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1020225173650.12500L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 23 Feb 2002, Jan-Benedict Glaw wrote:

> A year or two ago we've had a thread about r3k and swap. Currently,
> the box will oops... There's a patch changing some magic numbers
> in include/asm-mips/pgtable.h (attached against current CVS), but
> it is not really acceptable: some numbers are changed but nobody
> seems to know *what* this does mean. Ralf even mentioned that there
> might be some bug in the whole paging mechanism hiding behind this.

 Indeed, for good code you need to inspect why things work after an
uncertain fix (for commercial one, you probably don't). 

> Flo looked into this and his resume was that even the current
> (oopsing) values *should* do the job IIRC. Maciej, do you have
> a hint on this? I'm now using this patch, because it does make
> the kernel useable, but I don't understand why...

 I browsed through the kernel and it seems the fix is twiddling in the
right area, although a minor clean up seems to be needed.

> +#else /* CONFIG_CPU_R3000 */
> +#	define SWP_TYPE(x)			(((x).val >> 8) & 0x7f)
> +#	define SWP_OFFSET(x)			((x).val >> 15)
> +#	define define SWP_ENTRY(type,offset)	((swp_entry_t) { ((type) << 8) | ((offset) << 15) })
> +#endif

 This is an overkill -- you limit yourself to 128kB of swap per
device/file. ;-)  Except that there is a typo in the SWP_ENTRY definition,
so it can't work anyway. 

>   [ Part 1.3: "Flo's statement" ]
[...]
> -#define SWP_OFFSET(x)		((x).val >> 8)
> -#define SWP_ENTRY(type,offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 8) })
> +#define SWP_OFFSET(x)		((x).val >> 10)
> +#define SWP_ENTRY(type,offset)	((swp_entry_t) { ((type) << 1) | ((offset) << 10) })

 This is a move in the right direction.  I'd shift bits and mask them a
bit differently, though.  The point is to have _PAGE_VALID cleared for
paged-out entries. 

> The R3k machine (Decstation 5000/120) does survive swapping. The 
> idea is that the bits 9 & 10 on the R3k are
> 
> #define _PAGE_VALID                 (1<<9)
> #define _PAGE_SILENT_READ           (1<<9)  /* synonym                 */
> #define _PAGE_DIRTY                 (1<<10) /* The MIPS dirty bit      */
> #define _PAGE_SILENT_WRITE          (1<<10)

 Yep, that's the culprit.

> Whereas this on R4k is 
> 
> #define _PAGE_VALID                 (1<<7)
> #define _PAGE_SILENT_READ           (1<<7)  /* synonym                 */
> #define _PAGE_DIRTY                 (1<<8)  /* The MIPS dirty bit      */
> #define _PAGE_SILENT_WRITE          (1<<8)

 Remember these are shifted left by six.

> OTOH when following the code paths the pte gets completely replaced
> with the swap entry and not bitmasked/and/ored with the original 
> pte or the ptes flags. So i find no dependencie to the SWP_ macros.

 Well, when loaded into the TLB paged-out entries absolutely must have
their _PAGE_VALID bit cleared.  Otherwise you don't get a TLBL/TLBS
exception upon an address dereference and a random (not quite, but still
irrelevant to the page map) page address is used instead.  And as I see
SWP_ENTRY is used to make swap PTE entries which are to fault upon a
dereference. 

> When adding debug code there i can see the flags getting restored
> correctly on swapping in.

 Unless _PAGE_VALID is set and you don't reach the code at all.

 Actually the R4k variant seems to be broken as well -- it's only
MAX_SWAPFILES that protects _PAGE_VALID from being set here as well.
Anyone knows why we don't use _PAGE_VALID as a presence mark and have
separate software-maintained _PAGE_PRESENT for this purpose?  Other archs
don't seem to need such a mess... 

 I should have a patch ready soon.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
