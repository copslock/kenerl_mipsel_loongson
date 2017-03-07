Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2017 10:33:56 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2421 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990720AbdCGJdtikMbH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2017 10:33:49 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 99E0741F8E09;
        Tue,  7 Mar 2017 10:38:35 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 07 Mar 2017 10:38:35 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 07 Mar 2017 10:38:35 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 326F9F73EB441;
        Tue,  7 Mar 2017 09:33:39 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 7 Mar
 2017 09:33:40 +0000
Date:   Tue, 7 Mar 2017 09:33:40 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3] MIPS: Fix build breakage caused by header file changes
Message-ID: <20170307093339.GC996@jhogan-linux.le.imgtec.org>
References: <1488827635-7708-1-git-send-email-linux@roeck-us.net>
 <20170306232019.GG2878@jhogan-linux.le.imgtec.org>
 <146eef7a-44dd-48ff-3f09-0b342d844bd6@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ITEy4z2kE7rjCDPK"
Content-Disposition: inline
In-Reply-To: <146eef7a-44dd-48ff-3f09-0b342d844bd6@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57067
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

--ITEy4z2kE7rjCDPK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2017 at 07:30:05PM -0800, Guenter Roeck wrote:
> On 03/06/2017 03:20 PM, James Hogan wrote:
> > On Mon, Mar 06, 2017 at 11:13:55AM -0800, Guenter Roeck wrote:
> >> Since commit f3ac60671954 ("sched/headers: Move task-stack related
> >> APIs from <linux/sched.h> to <linux/sched/task_stack.h>") and commit
> >> f780d89a0e82 ("sched/headers: Remove <asm/ptrace.h> from
> >> <linux/sched.h>"), various mips builds fail as follows.
> >>
> >> arch/mips/kernel/smp-mt.c: In function =E2=80=98vsmp_boot_secondary=E2=
=80=99:
> >> arch/mips/include/asm/processor.h:384:41: error:
> >> 	implicit declaration of function =E2=80=98task_stack_page=E2=80=99
> >>
> >> In file included from
> >> 	/opt/buildbot/slave/hwmon-testing/build/arch/mips/kernel/pm.c:
> >> arch/mips/include/asm/fpu.h: In function '__own_fpu':
> >> arch/mips/include/asm/processor.h:385:31: error:
> >> 	invalid application of 'sizeof' to incomplete type 'struct pt_regs'
> >
> > This one is in an inline function, so I think it'd affect multiple
> > includes of <asm/fpu.h> even if __own_fpu isn't used, so I think the
> > following patch which adds the include ptrace.h in fpu.h is more robust
> > than adding to the individual c files affected:
> > https://patchwork.linux-mips.org/patch/15386/
> >
> Agreed.
>=20
> > Admitedly it could probably have a more specific subject line since
> > there are more similar errors.
>=20
> Does that fix all compile problems ? Seems to me that we'll still need
>=20
> -#include <linux/sched.h>
> +#include <linux/sched/task_stack.h>
>=20
> or did you prepare a patch for this as well ?

It fixed the config I was using at the time. I didn't do a full build
test of all configs at the time so didn't fix the above.

Cheers
James

--ITEy4z2kE7rjCDPK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYvn5zAAoJEGwLaZPeOHZ6OIYQAIjfncWCgMZcVUAwzUhZRsRe
BTDF2GVodln+VQ/bTNgA/vOarAHbJ0rYiPrlVWCgXmqpuKHSNkKN6vd+lgtxCAE8
K36XMfhaS+4dCB1Vzec0CVZVAEXNbkz33oQXi1F9+5crKZ+KTbjEqQdedVCXUOiK
D3bjvQ/dY1KRMwgvoZdjY2auS1cZYhiHb0Ojskbc3/H7xXAS0IXRMT9d3FHsq9TU
y214UFld//wgrqpcWjUxlN1FbxvHTFYcPN77DE9LfY/dTxlYpwJX9XFip5Dxi3EJ
uLx4raQmk55g7/bhpnYQusoN4xk1bUhl//FOQ0zo1Yd83UASAplwSTvhTcreJFSI
1XcxVwWoZnHxxPBwlNdK0jTdv8phwaaJVnHCY5zOQ/cuf3ocsmdiQ+hRiJxKo+PH
L8XdP5z7XnwvIucKrKV7iURCM6qoVl6qe7LmJtmBwhsMW2u15hgFDUdrE8GLRxng
DEkjQuKygLssZNIovoszVVKImjCs5jokmGHz1tFAJSdM+8zanhJfU8L0Elv/BsWi
iMayyB2k1SHtgk/LdT2Ahxwlace8reNjbBZgC5CfWjZ3HSZIO1OIydBwPQ4QTs9F
ibQFsJPmGRtft7M3rXNLS5VYCrosM6kP1NBsq0X5vt3LtnJxxmmTFDlwIR8TXWJU
DpEcmpoBs9OU6D8kxWF4
=mM3q
-----END PGP SIGNATURE-----

--ITEy4z2kE7rjCDPK--
