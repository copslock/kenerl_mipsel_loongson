Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Mar 2017 11:31:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14676 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23991172AbdCGKbmwMz22 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Mar 2017 11:31:42 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 66E0C41F8E09;
        Tue,  7 Mar 2017 11:36:31 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 07 Mar 2017 11:36:31 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 07 Mar 2017 11:36:31 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id BCE3579A8A543;
        Tue,  7 Mar 2017 10:31:34 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 7 Mar
 2017 10:31:36 +0000
Date:   Tue, 7 Mar 2017 10:31:36 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3] MIPS: Fix build breakage caused by header file changes
Message-ID: <20170307103136.GH2878@jhogan-linux.le.imgtec.org>
References: <1488827635-7708-1-git-send-email-linux@roeck-us.net>
 <20170306232019.GG2878@jhogan-linux.le.imgtec.org>
 <146eef7a-44dd-48ff-3f09-0b342d844bd6@roeck-us.net>
 <20170307093339.GC996@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U3BNvdZEnlJXqmh+"
Content-Disposition: inline
In-Reply-To: <20170307093339.GC996@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57069
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

--U3BNvdZEnlJXqmh+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Tue, Mar 07, 2017 at 09:33:40AM +0000, James Hogan wrote:
> On Mon, Mar 06, 2017 at 07:30:05PM -0800, Guenter Roeck wrote:
> > On 03/06/2017 03:20 PM, James Hogan wrote:
> > > On Mon, Mar 06, 2017 at 11:13:55AM -0800, Guenter Roeck wrote:
> > >> Since commit f3ac60671954 ("sched/headers: Move task-stack related
> > >> APIs from <linux/sched.h> to <linux/sched/task_stack.h>") and commit
> > >> f780d89a0e82 ("sched/headers: Remove <asm/ptrace.h> from
> > >> <linux/sched.h>"), various mips builds fail as follows.
> > >>
> > >> arch/mips/kernel/smp-mt.c: In function =E2=80=98vsmp_boot_secondary=
=E2=80=99:
> > >> arch/mips/include/asm/processor.h:384:41: error:
> > >> 	implicit declaration of function =E2=80=98task_stack_page=E2=80=99
> > >>
> > >> In file included from
> > >> 	/opt/buildbot/slave/hwmon-testing/build/arch/mips/kernel/pm.c:
> > >> arch/mips/include/asm/fpu.h: In function '__own_fpu':
> > >> arch/mips/include/asm/processor.h:385:31: error:
> > >> 	invalid application of 'sizeof' to incomplete type 'struct pt_regs'
> > >
> > > This one is in an inline function, so I think it'd affect multiple
> > > includes of <asm/fpu.h> even if __own_fpu isn't used, so I think the
> > > following patch which adds the include ptrace.h in fpu.h is more robu=
st
> > > than adding to the individual c files affected:
> > > https://patchwork.linux-mips.org/patch/15386/
> > >
> > Agreed.
> >=20
> > > Admitedly it could probably have a more specific subject line since
> > > there are more similar errors.
> >=20
> > Does that fix all compile problems ? Seems to me that we'll still need
> >=20
> > -#include <linux/sched.h>
> > +#include <linux/sched/task_stack.h>
> >=20
> > or did you prepare a patch for this as well ?
>=20
> It fixed the config I was using at the time. I didn't do a full build
> test of all configs at the time so didn't fix the above.

More specifically your changes to the following files:
arch/mips/kernel/pm.c
arch/mips/power/cpu.c

Don't appear to be necessary with my patch above, but the rest look good
to me. With those changes removed:

Reviewed-by: James Hogan <james.hogan@imgtec.com>

Build testing of that in progress...

Thanks
James

--U3BNvdZEnlJXqmh+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYvowIAAoJEGwLaZPeOHZ6ku8P/jF6F7+FHFE37m/nQNmA3lPe
sKWXy2WtyJJFiwYD4xwl0eXH1ymAH2s7pDd+3/kcS3z1Q4jLpRnwNPavSoLPaW9Z
yRIpJPzH/qpcRVZU0IeqiLDUkNu60BJmGELpQhAIgsTNbph51wF5AdsQpxwd/4/0
FSYS6BJ7UUATv9ypqZcMA/c0kFcJAxa0rW8aPdYaCZ8VE5ALl4BOToD33AYkWgGE
it+YwtJz6Ho1J7I8TY9FPuvbf86ct8Fr/19r3SRPxhDieQZiO49AdZbwkzORF4rO
mOy030yM4HXrT5uflPtu25CKFZiT2hFvWXYXGQlk2ViSNy/4mn8D+e8HcBUOW+h8
D6Mx//zyRH66H+KF0sm8Q0xN/VtI3ce9wq3zycRP9UBJI/K6O0ZEOFPnvoPFqsmT
wdr1+UwN83DQr3q+qEYKl9fAiXNuoVxc6jgwEME3iUYt4yUa7pCWxD5CWjKYKBCf
Zd3IYlGA17Y6JyutZ93UXs/VPcPqXz3v3Fi5fCCMijVN/nMra6/lWHxoeCdwSxVM
Y9/SbkRdJ1AdBSsSeIuHasRe7/1Gp58OxsCT7P+0DhxSZVB/+EjblhhCAcVmIyT0
jQQGFspQFYLaDml7xyWJBLJuqFPoVtCML8pFgqnHPnhVOG+9ibXTnY9a22gRSX53
kpZEkcGapwSlBMLSyHjp
=ul4T
-----END PGP SIGNATURE-----

--U3BNvdZEnlJXqmh+--
