Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Nov 2017 11:11:41 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:34595 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990592AbdK3KLcwV5-A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Nov 2017 11:11:32 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx27.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 30 Nov 2017 10:10:00 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 30 Nov
 2017 02:09:59 -0800
Date:   Thu, 30 Nov 2017 10:09:57 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Miodrag Dinic <Miodrag.Dinic@mips.com>
CC:     David Daney <ddaney@caviumnetworks.com>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Aleksandar Markovic <Aleksandar.Markovic@mips.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        DengCheng Zhu <DengCheng.Zhu@mips.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Douglas Leung <Douglas.Leung@mips.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Goran Ferenc <Goran.Ferenc@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        James Cowgill <James.Cowgill@imgtec.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matt Redfearn <Matt.Redfearn@mips.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Paul Burton <Paul.Burton@mips.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Petar Jovanovic <Petar.Jovanovic@mips.com>,
        Raghu Gandham <Raghu.Gandham@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Saeger <tom.saeger@oracle.com>
Subject: Re: [PATCH v2] MIPS: Add nonxstack=on|off kernel parameter
Message-ID: <20171130100957.GG5027@jhogan-linux.mipstec.com>
References: <1511272574-10509-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <dda5572e-0617-3427-7a90-07b3cf43d808@caviumnetworks.com>
 <48924BBB91ABDE4D9335632A6B179DD6A8CFEA@MIPSMAIL01.mipstec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Rmm1Stw9KgbdL9/H"
Content-Disposition: inline
In-Reply-To: <48924BBB91ABDE4D9335632A6B179DD6A8CFEA@MIPSMAIL01.mipstec.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1512036600-637137-17628-163817-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.21
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187457
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        0.01 BSF_SC0_SA_TO_FROM_DOMAIN_MATCH META: Sender 
        Domain Matches Recipient Domain 
        0.20 PR0N_SUBJECT           META: Subject has letters around special characters (pr0n) 
X-BESS-Outbound-Spam-Status: SCORE=0.21 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_SA_TO_FROM_DOMAIN_MATCH, PR0N_SUBJECT
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--Rmm1Stw9KgbdL9/H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2017 at 09:34:15AM +0000, Miodrag Dinic wrote:
> Hi David,
>=20
> Sorry for a late response, please find answers in-lined:
>=20
> > > If this parameter is omitted, kernel behavior remains the same as it
> > > was before this patch is applied.
> >=20
> > Do other architectures have a similar hack?
> >=20
> > If arm{,64} and x86 don't need this, what would make MIPS so special
> > that we have to carry this around?
>=20
> Yes, there are similar workarounds. Just a couple lines above
> nonxstack description in the documentation there are :
> 	noexec		[IA-64]
>=20
> 	noexec		[X86]
> 			On X86-32 available only on PAE configured kernels.
> 			noexec=3Don: enable non-executable mappings (default)
> 			noexec=3Doff: disable non-executable mappings
> ...
>=20
> 	noexec32	[X86-64]
> 			This affects only 32-bit executables.
> 			noexec32=3Don: enable non-executable mappings (default)
> 				read doesn't imply executable mappings
> 			noexec32=3Doff: disable non-executable mappings
> 				read implies executable mappings
>=20
> > >=20
> > > This functionality is convenient during debugging and is especially
> > > useful for Android development where non-exec stack is required.
> >=20
> > Why not just set the PT_GNU_STACK flags correctly in the first place?
>=20
> We do have PT_GNU_STACK flags set correctly, this feature is required to
> workaround CPU revisions which do not have RIXI support.

RIXI support can be discovered programatically from CP0_Config3.RXI
(cpu_has_rixi in asm/cpu-features.h), so I don't follow why CPUs without
RIXI would require a kernel parameter.

Cheers
James

>=20
> Kind regards,
> Miodrag
> ________________________________________
> From: David Daney [ddaney@caviumnetworks.com]
> Sent: Tuesday, November 21, 2017 9:53 PM
> To: Aleksandar Markovic; linux-mips@linux-mips.org
> Cc: Miodrag Dinic; Aleksandar Markovic; Andrew Morton; DengCheng Zhu; Din=
g Tianhong; Douglas Leung; Frederic Weisbecker; Goran Ferenc; Ingo Molnar; =
James Cowgill; James Hogan; Jonathan Corbet; linux-doc@vger.kernel.org; lin=
ux-kernel@vger.kernel.org; Marc Zyngier; Matt Redfearn; Mimi Zohar; Paul Bu=
rton; Paul E. McKenney; Petar Jovanovic; Raghu Gandham; Ralf Baechle; Thoma=
s Gleixner; Tom Saeger
> Subject: Re: [PATCH v2] MIPS: Add nonxstack=3Don|off kernel parameter
>=20
> On 11/21/2017 05:56 AM, Aleksandar Markovic wrote:
> > From: Miodrag Dinic <miodrag.dinic@mips.com>
> >
> > Add a new kernel parameter to override the default behavior related
> > to the decision whether to set up stack as non-executable in function
> > mips_elf_read_implies_exec().
> >
> > The new parameter is used to control non executable stack and heap,
> > regardless of PT_GNU_STACK entry. This does apply to both stack and
> > heap, despite the name.
> >
> > Allowed values:
> >
> > nonxstack=3Don  Force non-exec stack & heap
> > nonxstack=3Doff Force executable stack & heap
> >
> > If this parameter is omitted, kernel behavior remains the same as it
> > was before this patch is applied.
>=20
> Do other architectures have a similar hack?
>=20
> If arm{,64} and x86 don't need this, what would make MIPS so special
> that we have to carry this around?
>=20
>=20
> >
> > This functionality is convenient during debugging and is especially
> > useful for Android development where non-exec stack is required.
>=20
> Why not just set the PT_GNU_STACK flags correctly in the first place?
>=20
> >
> > Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
> > Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
> > ---
> >   Documentation/admin-guide/kernel-parameters.txt | 11 +++++++
> >   arch/mips/kernel/elf.c                          | 39 ++++++++++++++++=
+++++++++
> >   2 files changed, 50 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index b74e133..99464ee 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2614,6 +2614,17 @@
> >                       noexec32=3Doff: disable non-executable mappings
> >                               read implies executable mappings
> >
> > +     nonxstack       [MIPS]
> > +                     Force setting up stack and heap as non-executable=
 or
> > +                     executable regardless of PT_GNU_STACK entry. Both
> > +                     stack and heap are affected, despite the name. Va=
lid
> > +                     arguments: on, off.
> > +                     nonxstack=3Don:   Force non-executable stack and =
heap
> > +                     nonxstack=3Doff:  Force executable stack and heap
> > +                     If ommited, stack and heap will or will not be set
> > +                     up as non-executable depending on PT_GNU_STACK
> > +                     entry and possibly other factors.
> > +
> >       nofpu           [MIPS,SH] Disable hardware FPU at boot time.
> >
> >       nofxsr          [BUGS=3DX86-32] Disables x86 floating point exten=
ded
> > diff --git a/arch/mips/kernel/elf.c b/arch/mips/kernel/elf.c
> > index 731325a..28ef7f3 100644
> > --- a/arch/mips/kernel/elf.c
> > +++ b/arch/mips/kernel/elf.c
> > @@ -326,8 +326,47 @@ void mips_set_personality_nan(struct arch_elf_stat=
e *state)
> >       }
> >   }
> >
> > +static int nonxstack =3D EXSTACK_DEFAULT;
> > +
> > +/*
> > + * kernel parameter: nonxstack=3Don|off
> > + *
> > + *   Force setting up stack and heap as non-executable or
> > + *   executable regardless of PT_GNU_STACK entry. Both
> > + *   stack and heap are affected, despite the name. Valid
> > + *   arguments: on, off.
> > + *
> > + *     nonxstack=3Don:   Force non-executable stack and heap
> > + *     nonxstack=3Doff:  Force executable stack and heap
> > + *
> > + *   If ommited, stack and heap will or will not be set
> > + *   up as non-executable depending on PT_GNU_STACK
> > + *   entry and possibly other factors.
> > + */
> > +static int __init nonxstack_setup(char *str)
> > +{
> > +     if (!strcmp(str, "on"))
> > +             nonxstack =3D EXSTACK_DISABLE_X;
> > +     else if (!strcmp(str, "off"))
> > +             nonxstack =3D EXSTACK_ENABLE_X;
> > +     else
> > +             pr_err("Malformed nonxstack format! nonxstack=3Don|off\n"=
);
> > +
> > +     return 1;
> > +}
> > +__setup("nonxstack=3D", nonxstack_setup);
> > +
> >   int mips_elf_read_implies_exec(void *elf_ex, int exstack)
> >   {
> > +     switch (nonxstack) {
> > +     case EXSTACK_DISABLE_X:
> > +             return 0;
> > +     case EXSTACK_ENABLE_X:
> > +             return 1;
> > +     default:
> > +             break;
> > +     }
> > +
> >       if (exstack !=3D EXSTACK_DISABLE_X) {
> >               /* The binary doesn't request a non-executable stack */
> >               return 1;
> >
>=20
>=20

--Rmm1Stw9KgbdL9/H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlof2NoACgkQbAtpk944
dnq8uQ/9H0M9dDhdqhxZDLZLhSS/jByMQGEiIbwRDF5iwpnTZ92B83hKkPxT5B4j
Lk1XA2EL9L1fyBswsj8ULmQJFLftKyenKT+MnZC5YJaJ1aXW48iRlcsVA4gohhe3
NXrps5ZP69te7BZvouxHMQ8uKrKR/1lnWK5AWS+/H0oVc+KvQcVmFFhdpRrpyxv5
Z/gALi6dK80RpqdABZD1gk+yRDhr+SVh9GZOr5AfrNzLyYIAgkqHncl5w7dd67+k
whTei8Rc3UAhxm+XTep8pY0cLLw5erwimCvzjfJE2v88VKW3zsyoOWvQiUeyaSFF
310GkyPzBhPYE9N7pvMQUPEdw4Bm2g6XlazuLQ+Qu448LrVUVSCDpPZ5Q3Pt2HqL
ZBYO9YvlQkvPHZoQR34v5wJrdyg2k9TUP2oAilxcCsRwzyJSCchCPbdQ7lGR6RLo
CWXu7dqVdzu7Ilcixss2raE8PMYEdL8+S9cCk1fF/tZgfNdNiMUe6HMKy5QBGv71
6XOzSvX4n4pIwHK7Lxjn7f3EnT14v4tzfVvtyRjuzij4OCXSVgGj3bvXE0dMxVC8
Y+flyX2DLGx/zwYNd5Lc4a8QsydEs+x+7XNMRxmp9qh+wY9A1/dbFamOGBxA+A32
P66WqECFSpw0J+AsDJd6bKCkjQtIbgopKgoOP0D5nTUFf/vANB4=
=n2zl
-----END PGP SIGNATURE-----

--Rmm1Stw9KgbdL9/H--
