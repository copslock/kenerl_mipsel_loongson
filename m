Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Feb 2018 14:39:14 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:60480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994554AbeBMNjFfVf8V (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Feb 2018 14:39:05 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59A0021777;
        Tue, 13 Feb 2018 13:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A0021777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 13 Feb 2018 13:38:33 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        linux-mips@linux-mips.org, "# v4 . 11" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] MIPS: fix incorrect mem=X@Y handling
Message-ID: <20180213133832.GD4290@saruman>
References: <20180201113721.24776-1-marcin.nowakowski@mips.com>
 <CA+7wUswiOdqunZfnL-6YFJ6gPfj7bXAdHYbetbW_PdQaN28GzQ@mail.gmail.com>
 <CA+7wUszerm6VQsboY9hhgzEZejFOyKZtoh+eCpAESho-xdmQXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
In-Reply-To: <CA+7wUszerm6VQsboY9hhgzEZejFOyKZtoh+eCpAESho-xdmQXw@mail.gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 01:14:29PM +0100, Mathieu Malaterre wrote:
> On Thu, Feb 1, 2018 at 1:12 PM, Mathieu Malaterre <malat@debian.org> wrot=
e:
> > On Thu, Feb 1, 2018 at 12:37 PM, Marcin Nowakowski
> > <marcin.nowakowski@mips.com> wrote:
> >> Commit 73fbc1eba7ff ("MIPS: fix mem=3DX@Y commandline processing") add=
ed a
> >> fix to ensure that the memory range between PHYS_OFFSET and low memory
> >> address specified by mem=3D cmdline argument is not later processed by
> >> free_all_bootmem.  This change was incorrect for systems where the
> >> commandline specifies more than 1 mem argument, as it will cause all
> >> memory between PHYS_OFFSET and each of the memory offsets to be marked
> >> as reserved, which results in parts of the RAM marked as reserved
> >> (Creator CI20's u-boot has a default commandline argument 'mem=3D256M@=
0x0
> >> mem=3D768M@0x30000000').
> >>
> >> Change the behaviour to ensure that only the range between PHYS_OFFSET
> >> and the lowest start address of the memories is marked as protected.
> >>
> >> This change also ensures that the range is marked protected even if it=
's
> >> only defined through the devicetree and not only via commandline
> >> arguments.
> >>
> >> Reported-by: Mathieu Malaterre <mathieu.malaterre@gmail.com>
> >> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@mips.com>
> >> Fixes: 73fbc1eba7ff ("MIPS: fix mem=3DX@Y commandline processing")
> >> Cc: <stable@vger.kernel.org> # v4.11+
> >> ---
> >> v3: Update stable version, code cleanup as suggested by James Hogan
> >> v2: Use updated email adress, add tag for stable.
> >> ---
> >>  arch/mips/kernel/setup.c | 16 ++++++++++++----
> >>  1 file changed, 12 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> >> index 702c678de116..e4a1581ce822 100644
> >> --- a/arch/mips/kernel/setup.c
> >> +++ b/arch/mips/kernel/setup.c
> >> @@ -375,6 +375,7 @@ static void __init bootmem_init(void)
> >>         unsigned long reserved_end;
> >>         unsigned long mapstart =3D ~0UL;
> >>         unsigned long bootmap_size;
> >> +       phys_addr_t ramstart =3D (phys_addr_t)ULLONG_MAX;
> >>         bool bootmap_valid =3D false;
> >>         int i;
> >>
> >> @@ -395,7 +396,8 @@ static void __init bootmem_init(void)
> >>         max_low_pfn =3D 0;
> >>
> >>         /*
> >> -        * Find the highest page frame number we have available.
> >> +        * Find the highest page frame number we have available
> >> +        * and the lowest used RAM address
> >>          */
> >>         for (i =3D 0; i < boot_mem_map.nr_map; i++) {
> >>                 unsigned long start, end;
> >> @@ -407,6 +409,8 @@ static void __init bootmem_init(void)
> >>                 end =3D PFN_DOWN(boot_mem_map.map[i].addr
> >>                                 + boot_mem_map.map[i].size);
> >>
> >> +               ramstart =3D min(ramstart, boot_mem_map.map[i].addr);
> >> +
> >>  #ifndef CONFIG_HIGHMEM
> >>                 /*
> >>                  * Skip highmem here so we get an accurate max_low_pfn=
 if low
> >> @@ -436,6 +440,13 @@ static void __init bootmem_init(void)
> >>                 mapstart =3D max(reserved_end, start);
> >>         }
> >>
> >> +       /*
> >> +        * Reserve any memory between the start of RAM and PHYS_OFFSET
> >> +        */
> >> +       if (ramstart > PHYS_OFFSET)
> >> +               add_memory_region(PHYS_OFFSET, ramstart - PHYS_OFFSET,
> >> +                                 BOOT_MEM_RESERVED);
> >> +
> >>         if (min_low_pfn >=3D max_low_pfn)
> >>                 panic("Incorrect memory mapping !!!");
> >>         if (min_low_pfn > ARCH_PFN_OFFSET) {
> >> @@ -664,9 +675,6 @@ static int __init early_parse_mem(char *p)
> >>
> >>         add_memory_region(start, size, BOOT_MEM_RAM);
> >>
> >> -       if (start && start > PHYS_OFFSET)
> >> -               add_memory_region(PHYS_OFFSET, start - PHYS_OFFSET,
> >> -                               BOOT_MEM_RESERVED);
> >>         return 0;
> >>  }
> >>  early_param("mem", early_parse_mem);
> >> --
> >> 2.14.1
> >>
> >
> > Looks good to me:
> >
> > $ cat /proc/cpuinfo
> > system type : JZ4780
> > machine : Creator CI20
> > processor : 0
> > cpu model : Ingenic JZRISC V4.15  FPU V0.0
> > BogoMIPS : 956.00
> > wait instruction : yes
> > microsecond timers : no
> > tlb_entries : 32
> > extra interrupt vector : yes
> > hardware watchpoint : yes, count: 1, address/irw mask: [0x0fff]
> > isa : mips1 mips2 mips32r1 mips32r2
> > ASEs implemented :
> > shadow register sets : 1
> > kscratch registers : 0
> > package : 0
> > core : 0
> > VCED exceptions : not available
> > VCEI exceptions : not available
> > $ uname -a
> > Linux ci20 4.15.0+ #323 PREEMPT Thu Feb 1 13:08:11 CET 2018 mips GNU/Li=
nux
> >
> > Tested-by: Mathieu Malaterre <malat@debian.org>
> >
> > Thanks
>=20
> Could you please review the patch v3 ?

Yes, looks good to me, and Ralf had applied to his test branch so I
presume he's happy with it too. I'll apply for 4.16.

Commit 73fbc1eba7ff ("MIPS: fix mem=3DX@Y commandline processing") which
this fixes was evidently requested to be backported to stable (unsure
who by) and added to the 4.9 queue, but then this arose and it was
removed until this fix is merged (see
https://patchwork.linux-mips.org/patch/17268/).

Anybody know how far back before 4.11 both of these patches should be
applied to stable? If not I'll just leave it at 4.11 and if its
important before then for kexec or whatever they can be requested again.

Thanks
James

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqC6lgACgkQbAtpk944
dno45xAAt+faWRXen0r+6bLIFo1ZVOvnMVlRmWplqg2Oo3kvHTPVJYchZYjY+Dz4
AKtJSlT4KXcEvaRMBQTaPHyfiw51KHXaL6qqaXNLK+xY5Cl9YrwUA6HtZDW+0xV4
9fwuCo+fOrFzFnK7G6DNGSUsBLwGeFNbYIcWEjmKH61FEWzjXDkNv5xzpZebXZI/
OAWTa1Tu23e4hGHScN3Gh1nHzsM1+RKWJLPIJeFBF3LkIjJpRg8YeC3RBDosFUJN
4OFLIlHnhqLTzL9hAmES9VXmbiyfmKBAMciYNydXbL3Cv7MHJ+ZZaf6j3uMZ4lpv
nNVOhOz3tecr2unYmMiwwqOz0zEX7Y28eTTDMoJX8TpNEajFBN7W8P2Gf6Qc996o
96VYYNIKOatc9AlwAW7zjXIVw8V2F8BDEIeQg/2dP/ZjoMvT9Gqp9S491jdb9PUK
ePT2SQ5MKbC4bEN7SqlGd9CX/JMZpUC0hkwmFXeONGPnYmRzwwV4RiXXQWjDmrH/
v124hIpmY4cNx9LAJ+YFJGt4yQmI2xxlyLo0q1lWdG7YgVEkOFs7LCtpaDK4AlpR
oRyGv3tXVt6KPCeLG/eejELfMVsFjl+mrSNfzLIXtSxjevUFGBjLou2iju0BiYea
5Zjf9UFSrRqewnucd/XdWBbnb1tj4dSijo6xc3ij74S0oFVMcQA=
=Hg1b
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
