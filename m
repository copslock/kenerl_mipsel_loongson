Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Aug 2017 19:19:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63148 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994928AbdHRRS6kB1Gq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Aug 2017 19:18:58 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 63AE55005552A;
        Fri, 18 Aug 2017 18:18:48 +0100 (IST)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 18 Aug 2017 18:18:52 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL-X.hh.imgtec.org
 (10.100.10.113) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 18 Aug
 2017 18:18:51 +0100
Received: from np-p-burton.localnet (10.20.1.88) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Fri, 18 Aug
 2017 10:18:49 -0700
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Set ISA bit in entry-y for microMIPS kernels
Date:   Fri, 18 Aug 2017 10:18:49 -0700
Message-ID: <8259872.Nrvp2QXiRE@np-p-burton>
Organization: Imagination Technologies
In-Reply-To: <alpine.DEB.2.00.1708181731080.17596@tp.orcam.me.uk>
References: <20170807231647.19551-1-paul.burton@imgtec.com> <alpine.DEB.2.00.1708181302480.17596@tp.orcam.me.uk> <alpine.DEB.2.00.1708181731080.17596@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5028221.36bJTdk8DF";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59683
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

--nextPart5028221.36bJTdk8DF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Maciej,

On Friday, 18 August 2017 09:46:30 PDT Maciej W. Rozycki wrote:
> On Fri, 18 Aug 2017, Maciej W. Rozycki wrote:
> > > When building a kernel for the microMIPS ISA, ensure that the ISA bit
> > > (ie. bit 0) in the entry address is set. Otherwise we may include an
> > > entry address in images which bootloaders will jump to as MIPS32 code.
> >  
> >  Hmm, what's going on here?  The ISA bit is set by the linker according to
> > 
> > the mode the code at the entry symbol has been assembled for, e.g.:
> > 
> > $ readelf -h vmlinux | grep Entry
> > 
> >   Entry point address:               0x804355e1
> > 
> > $ readelf -s vmlinux | grep kernel_entry
> > 156535: 80100400     0 FUNC    GLOBAL DEFAULT [MICROMIPS]     1
> > __kernel_entry 156742: 804355e0   146 FUNC    GLOBAL DEFAULT [MICROMIPS] 
> >    1 kernel_entry $
> > 
> > or no microMIPS (or MIPS16) executable could work.  Is your build process
> > or toolchain used broken by any chance?
> 
>  It is indeed the build process.  You've come up with a valid, however a
> complicated solution.  How about the change below, on top of yours -- does
> it work for you?  If so, then I'll wrap it up and submit as an update.
> 
>   Maciej
> 
> ---
>  arch/mips/Makefile |   17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> linux-mips-start-address.diff
> Index: linux-sfr-usead/arch/mips/Makefile
> ===================================================================
> --- linux-sfr-usead.orig/arch/mips/Makefile	2017-08-18 15:25:58.196676000
> +0100 +++ linux-sfr-usead/arch/mips/Makefile	2017-08-18 15:27:55.309653000
> +0100 @@ -242,21 +242,8 @@ include arch/mips/Kbuild.platforms
>  ifdef CONFIG_PHYSICAL_START
>  load-y					= $(CONFIG_PHYSICAL_START)
>  endif
> -
> -entry-noisa-y				= 0x$(shell $(NM) vmlinux 2>/dev/null \
> -					| grep "\bkernel_entry\b" | cut -f1 -d \ )
> -ifdef CONFIG_CPU_MICROMIPS
> -  #
> -  # Set the ISA bit, since the kernel_entry symbol in the ELF will have it
> -  # clear which would lead to images containing addresses which bootloaders
> may -  # jump to as MIPS32 code.
> -  #
> -  entry-y = $(patsubst %0,%1,$(patsubst %2,%3,$(patsubst %4,%5, \
> -              $(patsubst %6,%7,$(patsubst %8,%9,$(patsubst %a,%b, \
> -              $(patsubst %c,%d,$(patsubst %e,%f,$(entry-noisa-y)))))))))
> -else
> -  entry-y = $(entry-noisa-y)
> -endif
> +entry-y				= $(shell $(OBJDUMP) -f vmlinux 2>/dev/null \
> +					| sed -n 's/start address //p')
> 
>  cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
>  drivers-$(CONFIG_PCI)		+= arch/mips/pci/

I originally did this [1], and wrote about it in the post-three-dashes notes 
for this patch. To quote myself:

> I originally tried using "objdump -f" to obtain the entry address, which
> works for microMIPS but it always outputs a 32 bit address for a 32 bit
> ELF whilst nm will sign extend to 64 bit. That matters for systems where
> we might want to run a MIPS32 kernel on a MIPS64 CPU & load it with a
> MIPS64 bootloader, which would then jump to a non-canonical
> (non-sign-extended) address.
> 
> This works in all cases as it only changes the behaviour for microMIPS
> kernels, but isn't the prettiest solution. A possible alternative would
> be to write a custom tool to just extract, sign extend & print the entry
> point of an ELF executable. I'm open to feedback if that would be
> preferred.

So if we were to use objdump we'd need to handle sign extending 32 bit 
addresses to form a canonical address. Perhaps that'd be cleaner though.

Thanks,
    Paul

[1] https://patchwork.linux-mips.org/patch/14020/
--nextPart5028221.36bJTdk8DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlmXIXkACgkQgiDZ+mk8
HGX5WBAAlAqrRzF0glt7f1xh734kOJvqloE2pUVXjf7Zh6ffbujXmZmr8uXu7mca
VWZ4noW3FaxqoR0ZS/AWWc0Fuv77DIJkKa2hlUwkolfdEeoJnFvqc7HsHhnutvfh
INrs9p8fXJJSiHjtTrivxbPGTHNTXMVoo9C0pVTQr2LM3FFJ/QNqHJW+Q2GQyDzD
qvMRvNASVFreWEtPbCO0arf5uWwrthn7MTbjIftfe29HAFvyQ/JthspbEmoasTaF
yGiCnwN6GPVCMZCYcH973rtwH3H7Bf37mMUbv/NKcKS6VZctobOXoE4qwxn780Uo
RgSWDBfGE9GBCEBh1e2N8fpfgPEKZatCCwXzm09ldJSHay1SGV+stgz+2lEMKcUk
qDK5WRT/zYRIgPNVsr/HOpG8XsuH116nS0zj5q3Pv1QBzbRzMmJb6vCvHkEYB3LK
ZaP1b1MIjzmix5jt0k5CHUj+TMTBxbfrEW7U4w/tK9//V/cr5Y687sWkcRhNEbux
PrMSjoZpHnPQQEr4Hp057zq/BvssK7lapr4imVIcko9+iTxBp0Jscf6jbuxh0/Oc
lAiN03wzCcdAeIiJyZQaCQcGYJZgS3IBtVdjs2h0UlonSMUuNd0Z4Iso3rP/oahY
EJNhkMcX4B2AjQMQs0RKFOdaaBkvzL2wZM7OsB4IPptgg+Rkj88=
=VM4i
-----END PGP SIGNATURE-----

--nextPart5028221.36bJTdk8DF--
