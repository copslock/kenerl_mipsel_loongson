Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 18:48:03 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30421 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994922AbdHRQr5AFg4q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 18:47:57 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id E4409654AA2D6;
        Fri, 18 Aug 2017 17:47:46 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 18 Aug
 2017 17:47:50 +0100
Received: from np-p-burton.localnet (10.20.1.88) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 18 Aug
 2017 09:47:48 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     <linux-mips@linux-mips.org>, Jason Cooper <jason@lakedaemon.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 22/38] MIPS: VDSO: Drop gic_get_usm_range() usage
Date:   Fri, 18 Aug 2017 09:47:48 -0700
Message-ID: <5466935.iyMmjgKhHK@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <7dd8db6f-90b3-84ec-c266-88daaccccbe1@arm.com>
References: <20170813043646.25821-1-paul.burton@imgtec.com> <20170813043646.25821-23-paul.burton@imgtec.com> <7dd8db6f-90b3-84ec-c266-88daaccccbe1@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10088959.vsj7z2tTFC";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart10088959.vsj7z2tTFC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Marc,

On Friday, 18 August 2017 04:38:50 PDT Marc Zyngier wrote:
> On 13/08/17 05:36, Paul Burton wrote:
> > We don't really need gic_get_usm_range() to abstract discovery of the
> > address of the GIC user-visible section now that we have access to its
> > base address globally.
> > 
> > Switch to calculating it ourselves, which will allow us to stop
> > requiring the irqchip driver to care about a counter exposed to userland
> > for use via the VDSO.
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-mips@linux-mips.org
> > ---
> > 
> >  arch/mips/kernel/vdso.c | 15 +++++----------
> >  1 file changed, 5 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
> > index 093517e85a6c..019035d7225c 100644
> > --- a/arch/mips/kernel/vdso.c
> > +++ b/arch/mips/kernel/vdso.c
> > @@ -13,13 +13,13 @@
> > 
> >  #include <linux/err.h>
> >  #include <linux/init.h>
> >  #include <linux/ioport.h>
> > 
> > -#include <linux/irqchip/mips-gic.h>
> > 
> >  #include <linux/mm.h>
> >  #include <linux/sched.h>
> >  #include <linux/slab.h>
> >  #include <linux/timekeeper_internal.h>
> >  
> >  #include <asm/abi.h>
> > 
> > +#include <asm/mips-cps.h>
> > 
> >  #include <asm/vdso.h>
> >  
> >  /* Kernel-provided data used by the VDSO. */
> > 
> > @@ -99,9 +99,8 @@ int arch_setup_additional_pages(struct linux_binprm
> > *bprm, int uses_interp)> 
> >  {
> >  
> >  	struct mips_vdso_image *image = current->thread.abi->vdso;
> >  	struct mm_struct *mm = current->mm;
> > 
> > -	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr;
> > +	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr,
> > gic_pfn;> 
> >  	struct vm_area_struct *vma;
> > 
> > -	struct resource gic_res;
> > 
> >  	int ret;
> >  	
> >  	if (down_write_killable(&mm->mmap_sem))
> > 
> > @@ -125,7 +124,7 @@ int arch_setup_additional_pages(struct linux_binprm
> > *bprm, int uses_interp)> 
> >  	 * only map a page even though the total area is 64K, as we only need
> >  	 * the counter registers at the start.
> >  	 */
> > 
> > -	gic_size = gic_present ? PAGE_SIZE : 0;
> > +	gic_size = mips_gic_present() ? PAGE_SIZE : 0;
> > 
> >  	vvar_size = gic_size + PAGE_SIZE;
> >  	size = vvar_size + image->size;
> > 
> > @@ -148,13 +147,9 @@ int arch_setup_additional_pages(struct linux_binprm
> > *bprm, int uses_interp)> 
> >  	/* Map GIC user page. */
> >  	if (gic_size) {
> > 
> > -		ret = gic_get_usm_range(&gic_res);
> > -		if (ret)
> > -			goto out;
> > +		gic_pfn = virt_to_phys(mips_gic_base + MIPS_GIC_USER_OFS) >>
> > PAGE_SHIFT;
> 
> virt_to_pfn() instead?

We don't seem to have virt_to_pfn() on MIPS, but I'd be happy to add it & tidy 
up a few places that could use it. Would you mind if that cleanup came 
separately though?

> 
> > -		ret = io_remap_pfn_range(vma, base,
> > -					 gic_res.start >> PAGE_SHIFT,
> > -					 gic_size,
> > +		ret = io_remap_pfn_range(vma, base, gic_pfn, gic_size,
> > 
> >  					 pgprot_noncached(PAGE_READONLY));
> >  		
> >  		if (ret)
> >  		
> >  			goto out;
> 
> Thanks,
> 
> 	M.

Thanks,
    Paul
--nextPart10088959.vsj7z2tTFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlmXGjQACgkQgiDZ+mk8
HGW+FhAAgOjmAPAnkYLgmckYL845n7kNyKltvK5RmnLE/eKRqRJQ5PjSnIyEEZJA
/5MBuFxwO/K5VCg5Aq9blnDwmjpJDFfhOUFOGZImxeM8iIvePWy7K2ZwhOeRaKeW
LGMoRipplwRrG8nyRtsGMyp7RcbtKiA66nEJOHd1aCM1rfAWldzyVUum8eaNp2y8
eHGU65XLMDUQ+hNY3zS8LSzwgqObKrDHxaP7CcvK3217i9rE7aUUB9ecra1IGDaD
wSf1cdYU3JghYcC5YIRoC7x7M5MtKn/9RgnrEiWxaXYgQ5xesKhr/3MfHO2sTEjC
DAWu2s45PKt9T6wbaspAvgusJxXXhqctA2khwLvq4Uk/dbgnZdpG12ksOxZYY2TB
gmalra0GOjzsMvbhiX2hD0daRleQ6z2xgPBrVr/uy7M7teZJdHFGpyvaY6vRF2yP
Q5P5oikRQiStHKI+qZ2f6FKJ0Isd014mBqKwq+bsv2gJDXhaSQEizEIhOh7wd5GW
0+8NJ6RlsSsoK8WvFv+rbTTSzZklkqn3kCxbVMgo36P0dhSvTseZGXqD9+Kow2GR
5DtWRXWk6Vq/vIDv88/1QQ7/5XprIuU8T25IntDi1ttasByyzhv8uFyx/8nU8ZV2
oY7APN3Cq0A4ZW42YyjiqjLLAQ4bQIUSL0G20Pp86fCaTMKmOWc=
=q1yG
-----END PGP SIGNATURE-----

--nextPart10088959.vsj7z2tTFC--
