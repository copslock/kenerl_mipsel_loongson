Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Dec 2016 14:02:50 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25037 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992166AbcLSNCnJ3sTc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Dec 2016 14:02:43 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 0522B41F8DFC;
        Mon, 19 Dec 2016 14:03:59 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 19 Dec 2016 14:03:59 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 19 Dec 2016 14:03:59 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0E1281EF9654B;
        Mon, 19 Dec 2016 13:02:34 +0000 (GMT)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 19 Dec
 2016 13:02:37 +0000
Date:   Mon, 19 Dec 2016 13:02:37 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Serge Semin <fancer.lancer@gmail.com>, <ralf@linux-mips.org>,
        <paul.burton@imgtec.com>, <rabinv@axis.com>,
        <alexander.sverdlin@nokia.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <Sergey.Semin@t-platforms.ru>,
        <linux-mips@linux-mips.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 19/21] MIPS memblock: Add print out method of kernel
 virtual memory layout
Message-ID: <20161219130236.GJ27950@jhogan-linux.le.imgtec.org>
References: <1482113266-13207-1-git-send-email-fancer.lancer@gmail.com>
 <1482113266-13207-20-git-send-email-fancer.lancer@gmail.com>
 <db27f41e-4121-bb83-6533-6727c26b9c5b@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0Ed1hDcWxc3B7cn"
Content-Disposition: inline
In-Reply-To: <db27f41e-4121-bb83-6533-6727c26b9c5b@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56093
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--y0Ed1hDcWxc3B7cn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Mon, Dec 19, 2016 at 12:04:54PM +0000, Matt Redfearn wrote:
> On 19/12/16 02:07, Serge Semin wrote:
> > It's useful to have some printed map of the kernel virtual memory,
> > at least for debugging purpose.
> >
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > ---

> > @@ -106,6 +107,49 @@ static void __init zone_sizes_init(void)
> >   }
> >  =20
> >   /*
> > + * Print out kernel memory layout
> > + */
> > +#define MLK(b, t) b, t, ((t) - (b)) >> 10
> > +#define MLM(b, t) b, t, ((t) - (b)) >> 20
> > +#define MLK_ROUNDUP(b, t) b, t, DIV_ROUND_UP(((t) - (b)), SZ_1K)
> > +static void __init mem_print_kmap_info(void)
> > +{
> > +	pr_notice("Virtual kernel memory layout:\n"
> > +		  "    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> > +		  "    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> > +#ifdef CONFIG_HIGHMEM
> > +		  "    pkmap   : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> > +#endif
> > +		  "    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> > +		  "      .text : 0x%p" " - 0x%p" "   (%4td kB)\n"
> > +		  "      .data : 0x%p" " - 0x%p" "   (%4td kB)\n"
> > +		  "      .init : 0x%p" " - 0x%p" "   (%4td kB)\n",
> > +		MLM(PAGE_OFFSET, (unsigned long)high_memory),
> > +		MLM(VMALLOC_START, VMALLOC_END),
> > +#ifdef CONFIG_HIGHMEM
> > +		MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP)*(PAGE_SIZE)),
> > +#endif
> > +		MLK(FIXADDR_START, FIXADDR_TOP),
> > +		MLK_ROUNDUP(_text, _etext),
> > +		MLK_ROUNDUP(_sdata, _edata),
> > +		MLK_ROUNDUP(__init_begin, __init_end));
>=20
> Please drop printing the kernel addresses, or at least only do it if=20
> KASLR is not turned on, otherwise you're removing the advantage of=20
> KASLR, that critical kernel addresses cannot be determined easily from=20
> userspace.

According to Documentation/printk-formats.txt, this is what %pK is for.
Better to use that instead?

Cheers
James

>=20
> It may be better to merge the functionality of show_kernel_relocation
> http://lxr.free-electrons.com/source/arch/mips/kernel/relocate.c#L354
> into this function, but only print it under the same conditions as=20
> currently, i.e.
> #if defined(CONFIG_DEBUG_KERNEL) && defined(CONFIG_DEBUG_INFO)
> http://lxr.free-electrons.com/source/arch/mips/kernel/setup.c#L530
>=20
> Thanks,
> Matt

--y0Ed1hDcWxc3B7cn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYV9psAAoJEGwLaZPeOHZ6AOcQAIg5aU60b73zBLz7whKWI2Oc
O5KfLoRmtNPb8rAJLTV1pFIamjhmNWKulnmFywPclWfWKrl59OLjf86QJiw93iXM
SuWb1FHkJ6AswvaR+vgW+poHhH9rpzcQQ0pOEJvimt5pLQBKuI9FF78K9xl0lHc8
LArFZC8/+pHnu8xH7Eqj4OG8Ju9P1b02GdMZgCKsT3Tegn5m3uWRKgGoTfHUN9nS
bKePLKoqeNDWAEd3ifXzsctJNPBdcuJjutrJzQEJEOP/2HQW2OhncAqhfKuNi3As
cXD5mP6Rqg0DPFPOSvmCr1ED/jmWhWfjiNan2D0Ds3UVu42wVqgTfeqZ1mHHperV
ubV29vU/gmjlzAieLGWYZ02S4Q5s3C9KfdCP90KLt16wS7Lnqa13bmau1jn3nF1h
0dQa5Ucxam+2z99EtW+r9DfqlIXdgUwrXIT8mVsSIS9y1mABvONDx+rct2tNEKLL
PYxTFCWFn3vA8SgUxmxgsvi9NSx+YW4iFZLt5DaBj79K5weNkiHIk1P5eOdef0wN
2erB0Vkcy04K/hyzUKk5W7dR9bKBWI/4zGznS8aoKH48oq+Un75PQ90sf60pKmdF
fJbmvFfhIqFZom2dqbksuhWYH1escVsZuZyvMPNkbiwfVraPCHW9aNwpQyEztaBv
hJTu8+aXxZsMQAGgThNC
=RD0L
-----END PGP SIGNATURE-----

--y0Ed1hDcWxc3B7cn--
