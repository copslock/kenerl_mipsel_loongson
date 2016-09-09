Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Sep 2016 14:37:05 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46501 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992991AbcIIMg67AZ8Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Sep 2016 14:36:58 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 9EF8C41F8E3C;
        Fri,  9 Sep 2016 13:36:53 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 09 Sep 2016 13:36:53 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 09 Sep 2016 13:36:53 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 346D5139D2013;
        Fri,  9 Sep 2016 13:36:50 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 9 Sep
 2016 13:36:52 +0100
Date:   Fri, 9 Sep 2016 13:36:52 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Sagar Borikar <sagar.borikar@gmail.com>
CC:     <linux-mips@linux-mips.org>
Subject: Re: highmem issues with 3.14.10 (LST)
Message-ID: <20160909123652.GA1846@jhogan-linux.le.imgtec.org>
References: <CAFwMWxtUHa_Av34RrzFp3Dar0y-ghQRJNeXeUqYeUo3149zOsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <CAFwMWxtUHa_Av34RrzFp3Dar0y-ghQRJNeXeUqYeUo3149zOsw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 5de3adfe
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55080
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

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sagar,

On Thu, Sep 08, 2016 at 08:33:57PM -0700, Sagar Borikar wrote:
> Hello,
>=20
> I am upgrading kernel for a MIPS Interaptive CPU from 3.10.60 to
> 3.14.10 (stable) from:
> https://www.linux-mips.org/wiki/Malta_Linux_Repository

Unfortunately that wiki page needs updating.

If you're upgrading anyway, I think we'd recommend switching all the way
to a recent mainline kernel release / stable branch, e.g. 4.4 (LTS) or
4.7 (and maybe update to 4.9 (LTS) when it is released or when 4.7 goes
EOL). I think all the stuff you'll need for interAptiv should be in
mainline now anyway.

>=20
>  The platform has non-contiguous low memory and high memory. After the
> upgrade, highmem is not getting enabled due to max_low_pfn and
> highend_pfn not being the same.
>=20
> The commit cce335ae47e231398269fb05fa48e0e9cbf289e0 introduced the
> change apparently for sibyte platform. That change doesn't hold good
> for all platforms where the high memory and low memory is sparsed.
>=20
> If I comment out only following change in arch/mips/mm/init.c, highmem
> gets initialized properly.
>=20
> 296     if (cpu_has_dc_aliases && max_low_pfn !=3D highend_pfn) {
> 297         printk(KERN_WARNING "This processor doesn't support highmem."
> 298                " %ldk highmem ignored\n",
> 299                (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
> 300         max_zone_pfns[ZONE_HIGHMEM] =3D max_low_pfn;
> 301         lastpfn =3D max_low_pfn;
> 302     }

I don't think we ever supported DCache aliasing + highmem in
combination.

If you want to use that memory your options are probably:
- increase the page size to avoid dcache aliasing.
- OR use EVA to increase the size of lowmem, which at the moment is a
  bit more involved. How much RAM do you have, and what does your
  physical memory map look like?

Cheers
James

>=20
> So wanted to know whether there is additional change required in
> platform to work with above codebase.
> Secondly, when the system proceeds (with commented code above), it
> seems execve causes panic in copy_strings:
>=20
> Kernel bug detected[#1]:
> CPU: 0 PID: 177 Comm: mcp Not tainted 3.14.10 #19
> task: 82c99070 ti: 829b0000 task.ti: 829b0000
> $ 0   : 00000000 81a40018 00000001 00000528
> $ 4   : 806805b0 00000294 00000000 81c76000
> $ 8   : 82c99070 fe001ffc 00000000 805d0000
> $12   : 00000000 00000000 00000000 00000001
> $16   : 8214a760 00000000 81a40010 82c2c580
> $20   : ffffffff 7fff7000 00000000 00000008
> $24   : 00000000 801182a0
> $28   : 829b0000 829b1e78 8214a760 801bb0bc
> Hi    : 000000e1
> Lo    : 00077c44
> epc   : 801bb014 copy_strings+0x304/0x394
>     Not tainted
> ra    : 801bb0bc copy_strings_kernel+0x18/0x2c
> Status: 1100fc03        KERNEL EXL IE
> Cause : 10800034
> PrId  : 0001a020 (MIPS interAptiv)
> Modules linked in:
> Process mcp (pid: 177, threadinfo=3D829b0000, task=3D82c99070, tls=3D770b=
82f0)
> Stack : 00000080 00000000 00000000 00000000 00000017 829b1e98 00000000 00=
000000
>           8214a760 82bba0b0 fe001000 00000ff4 80000000 00000080
> 82bba0b0 81a40000
>           80b12b00 00000001 80b12b00 7fe5e66c 81c40000 801bb0bc
> 80b12b00 82c2c630
>           82c2c580 00000080 82c2c580 801bc4d4 00000003 8013452c
> 7649e000 7648fa08
>           82c99234 00000000 00000601 80b12b34 7649e000 7648fa08
> 7649e000 7fe5dc50
>          ...
> Call Trace:
> [<801bb014>] copy_strings+0x304/0x394
> [<801bb0bc>] copy_strings_kernel+0x18/0x2c
> [<801bc4d4>] do_execve+0x2fc/0x4c4
> [<8010d37c>] handle_sys+0x11c/0x140
> Code: 0806ec05  00000000  24020001 <00020336> 0c045e64  02002021
> 0c0651dd  02002021  0806ec1d
> ---[ end trace ed487c3c490d886b ]---
> BUG: Bad rss-counter state mm:828bd6a0 idx:1 val:2
>=20
> This panic occurs only when I spawn nested fork/execve. If I spawn the
> process directly without nesting, I don't see this panic.
>=20
> Looks like there are several reports about "Bad rss-counter state"
> panic with 3.14-stable. But I couldn't find any concrete solution to
> the panic.
>=20
> Any pointers?
>=20
> Thanks
>=20
> Sagar
>=20

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX0qzkAAoJEGwLaZPeOHZ6kU8P/RHG22Wtb8DI81toCWy/22SR
+ayXrek2rtrlsZbur4uY3awxcqBNcJHb4lGTiS9ufOKw258JQmN6cJJp9dZwPBex
j/iuT603Wk1ctg5gACx2u3UEUrGpPdLpqpa3U0L78nMVPGAO5DgKxJmfJdsgiDzL
yTwV1WpEbL8T8uj3nEisMLQgKq1mJwdw8JeIn6wtRAv8Q5iWCsmonRmFmm0F5H1K
/2U9hZZOcXSuN+FcypILElryDNxACioWo/6/pqgImwMnCPqsS7jLaOPEBhYnmars
Jjp/ndcAmCIBC8mQHFcsKuj92hyJgYz932kDE4/5yZU9c4x8nl2BDqZE7g5Gb2kl
VT3kf6p2fiocAWjTfRHsz/sWmmT/BKff+Y7bb/9CqEqBjluyh+w5NvnAXsvygXJE
Agu1IDEZUu5L2QWFbUtU/KosYOLt1S3MygTL32JbAS9ZlMIelBifQ4aE0rKUBZvq
fKlFhrJyMKIUj0UeaJgaH1ZYvJaa44PI+Y56n38G4Ljhw4o823w0VfUNKnL4sCuo
SMGTW34AgrIinGlv12mFNvJJEeWqR1yV0oC+5KG9WlEQFoIzOWMOxagDzh731MX9
FKwUk0Oj1hIB/bExDxS6uZdNlJiSaKMGBh/xFBSP9lf37H+zXZdscm3O8CKNKDHm
SoCSMCcViQnKEcQ+YJEo
=Z26n
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
