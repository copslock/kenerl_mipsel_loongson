Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jun 2017 10:26:50 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23677 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993420AbdFZI0n1GiGV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jun 2017 10:26:43 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id EE5AD41F8EAF;
        Mon, 26 Jun 2017 10:36:34 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 26 Jun 2017 10:36:34 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 26 Jun 2017 10:36:34 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8D234ED9F50A0;
        Mon, 26 Jun 2017 09:26:35 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 26 Jun
 2017 09:26:37 +0100
Date:   Mon, 26 Jun 2017 09:26:37 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V7 9/9] MIPS: Loongson: Introduce and use
 LOONGSON_LLSC_WAR
Message-ID: <20170626082637.GE6973@jhogan-linux.le.imgtec.org>
References: <1498144016-9111-1-git-send-email-chenhc@lemote.com>
 <1498144016-9111-10-git-send-email-chenhc@lemote.com>
 <20170623145453.GB31455@jhogan-linux.le.imgtec.org>
 <CAAhV-H5NO1otR1YmyobZMk5Sw_GpgATVWMn5rNwmaMFOUFuctQ@mail.gmail.com>
 <1B97A9D2-5753-4143-AB56-389280FDBA64@imgtec.com>
 <CAAhV-H4=D0QqKA=M48e8r+3x2N3SXEDTYLawxU5+sYndJ1fZ9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vQ3nNXu39BMSLhj/"
Content-Disposition: inline
In-Reply-To: <CAAhV-H4=D0QqKA=M48e8r+3x2N3SXEDTYLawxU5+sYndJ1fZ9Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58797
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

--vQ3nNXu39BMSLhj/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Huacai,

On Sat, Jun 24, 2017 at 05:23:52PM +0800, Huacai Chen wrote:
> You are right, but it seems like __WEAK_LLSC_MB is already the best
> name for this case. Maybe I define a macro named __VERY_WEAK_LLSC_MB
> to expand a "sync" on Loongson?

I suppose so.

Can you clarify what very weak ordering means in this context? I.e. in
what case is it insufficient to have the sync before the label rather
than before every ll in the retry loop?

Cheers
James

>=20
> Huacai
>=20
> On Sat, Jun 24, 2017 at 5:02 PM, James Hogan <james.hogan@imgtec.com> wro=
te:
> > On 24 June 2017 09:55:14 BST, Huacai Chen <chenhc@lemote.com> wrote:
> >>Hi, James,
> >>
> >>smp_mb__before_llsc() can not be used in all cases, e.g., in
> >>arch/mips/include/asm/spinlock.h and other similar cases which has a
> >>label before ll/lld. So, I think it is better to keep it as is to keep
> >>consistency.
> >
> > I know. I didn't mean use smp_mb_before_llsc directly, i just meant use=
 something similar directly before the ll that would expand to nothing on n=
on loongson kernels and still avoid the mass duplication of inline asm whic=
h leads to divergence, bitrot, and maintenance problems.
> >
> > cheers
> > James
> >
> >>
> >>Huacai
> >>
> >>On Fri, Jun 23, 2017 at 10:54 PM, James Hogan <james.hogan@imgtec.com>
> >>wrote:
> >>> On Thu, Jun 22, 2017 at 11:06:56PM +0800, Huacai Chen wrote:
> >>>> diff --git a/arch/mips/include/asm/atomic.h
> >>b/arch/mips/include/asm/atomic.h
> >>>> index 0ab176b..e0002c58 100644
> >>>> --- a/arch/mips/include/asm/atomic.h
> >>>> +++ b/arch/mips/include/asm/atomic.h
> >>>> @@ -56,6 +56,22 @@ static __inline__ void atomic_##op(int i,
> >>atomic_t * v)                          \
> >>>>               "       .set    mips0
> >> \n"   \
> >>>>               : "=3D&r" (temp), "+" GCC_OFF_SMALL_ASM() (v->counter)
> >>       \
> >>>>               : "Ir" (i));
> >>       \
> >>>> +     } else if (kernel_uses_llsc && LOONGSON_LLSC_WAR) {
> >>       \
> >>>> +             int temp;
> >>       \
> >>>> +
> >>       \
> >>>> +             do {
> >>       \
> >>>> +                     __asm__ __volatile__(
> >>       \
> >>>> +                     "       .set    "MIPS_ISA_LEVEL"
> >> \n"   \
> >>>> +                     __WEAK_LLSC_MB
> >>       \
> >>>> +                     "       ll      %0, %1          # atomic_" #op
> >>"\n"   \
> >>>> +                     "       " #asm_op " %0, %2
> >> \n"   \
> >>>> +                     "       sc      %0, %1
> >> \n"   \
> >>>> +                     "       .set    mips0
> >> \n"   \
> >>>> +                     : "=3D&r" (temp), "+" GCC_OFF_SMALL_ASM()
> >>(v->counter)      \
> >>>> +                     : "Ir" (i));
> >>       \
> >>>> +             } while (unlikely(!temp));
> >>       \
> >>>
> >>> Can loongson use the common versions of all these bits of assembly by
> >>> adding a LOONGSON_LLSC_WAR dependent smp_mb__before_llsc()-like macro
> >>> before the asm?
> >>>
> >>> It would save a lot of duplication, avoid potential bitrot and
> >>> divergence, and make the patch much easier to review.
> >>>
> >>> Cheers
> >>> James
> >
> >
> > --
> > James Hogan
> >

--vQ3nNXu39BMSLhj/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllQxSgACgkQbAtpk944
dnqLTQ//bydNJPVeGP874073oVZMOaDCd0B6Ym2V0JiJqoSscANuiPj7+B42sVHY
HCXEWCXD9axOuhlJDn9yzLI6i3Sjp/s+SG6GlmoyeSDTXqfOivnUfCpKGmOQRnaY
T04W8CLB37T/p5cLR8J/4avhIIF2R5c9nJKS6R3NM3mg9gtFcQJy/WPqpAwrwiUq
0AyMUtsX1blh6OvvONA9zerc/fxei6LmXPrAfyOQEekX6IIMrHa94D7WAgu5XzS2
lENMv48YA8kNs/oRh840itma8UOiqC4wX+yTFjcGAjCXuE/yWf/o8rFCLfKsjxd9
sCj5SWu3wK6kwo00yWDQ2XiJcDhSEXusrAS2Gg5VE5qzQxxQRh+l/tyNRLRkkMhc
Xi/xCrBLIyjjDFSXFXSINtiMaEdF1OXA7IE2Jj/XNaONrwI86BPGW0fyKsTs0Vq9
2ZQAmf8OQzTCELJfrShXcxriVRXcBK/558ZA8ZWI+5GxJBLTwFGUx6ekONHoXg6y
zGtiYR6yLu0uCzEQ6ksCdtYCNqW7jB7HvlhP7httyX10OAl7HQ1DPuUss8J5Qhcw
YuC82bcvGqFplsetZ4n7C3elkbPR71snkGperTWl5EiHFgDTrmUCRm+dYhk6olNN
Fkwi3sb8oj4bvcorFYr/Zb4JgnBOaeRnbcPJhft1fGu94E+i9QM=
=XvBa
-----END PGP SIGNATURE-----

--vQ3nNXu39BMSLhj/--
