Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Mar 2015 23:12:56 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:43250 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014051AbbCRWMy7LFMt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Mar 2015 23:12:54 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id EF9F241F8E19;
        Wed, 18 Mar 2015 22:12:49 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 18 Mar 2015 22:12:49 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 18 Mar 2015 22:12:49 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A30C8769EC648;
        Wed, 18 Mar 2015 22:12:45 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 18 Mar 2015 22:12:49 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Wed, 18 Mar
 2015 22:12:48 +0000
Date:   Wed, 18 Mar 2015 22:12:48 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "wangr@lemote.com" <wangr@lemote.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Qais Yousef <Qais.Yousef@imgtec.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "davidlohr@hp.com" <davidlohr@hp.com>,
        "chenhc@lemote.com" <chenhc@lemote.com>,
        "manuel.lauss@gmail.com" <manuel.lauss@gmail.com>,
        "mingo@kernel.org" <mingo@kernel.org>
Subject: Re: [PATCH] MIPS: MSA: misaligned support
Message-ID: <20150318221248.GB1116@jhogan-linux.le.imgtec.org>
References: <20150318011630.2702.28882.stgit@ubuntu-yegoshin>
 <5509611D.80404@imgtec.com>
 <5509D62B.7030507@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <5509D62B.7030507@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46450
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

--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Leonid,

On Wed, Mar 18, 2015 at 12:46:51PM -0700, Leonid Yegoshin wrote:
> On 03/18/2015 04:27 AM, James Hogan wrote:
> >
> >> +		break;
> >> +
> >> +	case 3: /* doubleword, no conversion */
> >> +		break;
> > don't you still need to copy the value though?
>=20
> Good point! Never test this subroutine yet, HW team still should produce=
=20
> BIG ENDIAN CPU+MSA variant.

P5600 big endian should be usable on Malta (I've ran it before).

Failing that, it should be pretty easy to force qemu to trigger an AdE
exception on all unaligned ld/st in order to test this.

> I will issue V2.
>=20
> >
> >> +	}
> >> +}
> >> +#endif
> >> +#endif
> >> +
> >>   static void emulate_load_store_insn(struct pt_regs *regs,
> >>   	void __user *addr, unsigned int __user *pc)
> >>   {
> >> @@ -434,6 +497,10 @@ static void emulate_load_store_insn(struct pt_reg=
s *regs,
> >>   #ifdef	CONFIG_EVA
> >>   	mm_segment_t seg;
> >>   #endif
> >> +#ifdef CONFIG_CPU_HAS_MSA
> >> +	union fpureg msadatabase[2], *msadata;
> >> +	unsigned int func, df, rs, wd;
> >> +#endif
> >>   	origpc =3D (unsigned long)pc;
> >>   	orig31 =3D regs->regs[31];
> >>  =20
> >> @@ -703,6 +770,82 @@ static void emulate_load_store_insn(struct pt_reg=
s *regs,
> >>   			break;
> >>   		return;
> >>  =20
> >> +#ifdef CONFIG_CPU_HAS_MSA
> >> +	case msa_op:
> >> +		if (cpu_has_mdmx)
> >> +			goto sigill;
> >> +
> >> +		func =3D insn.msa_mi10_format.func;
> >> +		switch (func) {
> >> +		default:
> >> +			goto sigbus;
> >> +
> >> +		case msa_ld_op:
> >> +		case msa_st_op:
> >> +			;
> >> +		}
> >> +
> >> +		if (!thread_msa_context_live())
> >> +			goto sigbus;
> > Will this ever happen? (I can't see AdE handler enabling interrupts).
> >
> > If the MSA context genuinely isn't live (i.e. it can be considered
> > UNPREDICTABLE), then surely a load operation should still succeed?
>=20
> thread_msa_context_live() =3D=3D check of TIF_MSA_CTX_LIVE =3D=3D existen=
ce of=20
> MSA context for thread.
> It differs from MSA is owned by thread, it just says that thread has=20
> already initialized MSA.
>=20
> Unfortunate choice of function name, I believe.

Right (I mis-read when its cleared when i grepped). Still, that would
make it even harder to hit since lose_fpu wouldn't clear it, and you
already would've taken an MSA disabled exception first.

Anyway, my point was that there's nothing invalid about an unaligned
load being the first MSA instruction. You might use it to load the
initial vector state.

>=20
> This is a guard against bad selection of exception priorities in HW...=20
> sometime it happens.
>=20
> >
> >> +
> >> +		df =3D insn.msa_mi10_format.df;
> >> +		rs =3D insn.msa_mi10_format.rs;
> >> +		wd =3D insn.msa_mi10_format.wd;
> >> +		addr =3D (unsigned long *)(regs->regs[rs] + (insn.msa_mi10_format.s=
10 * (1 << df)));
> > "* (1 << df)"?
> > why not just "<< df"?
> >
> >> +		/* align a working space in stack... */
> >> +		msadata =3D (union fpureg *)(((unsigned long)msadatabase + 15) & ~(=
unsigned long)0xf);
> > Maybe you could just use __aligned(16) on a single local union fpureg.
>=20
> I am not sure that it works in stack. I don't trust toolchain here -=20
> they even are not able to align a frame in stack to 16bytes.

I did wonder that, but found the following bug report which seems to
indicate that it was fixed generically in 4.6:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D16660

Unfortunately Linux supports MSA built with a toolchain that doesn't, so
that may not be good enough, I don't know :-(.

Cheers
James

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVCfhgAAoJEGwLaZPeOHZ6neUQALnlbSuVDkjxy1Q16IRulmjl
YKlg8UnTlcd0CSUJKaHh4WV/k3znVwW9SxvzjUILjnOJYLci76yzPiNslG/M8zMA
T8cLRLcpQI8M1H2CMe150kv1xbJU9UDzm+OkF5xKrRb3ohyy/Ro42Vx5VIs+3vlx
UF5Gc18uDHkMwFDS0ab1ZUCXy0KF2IQOb3kzKmAD4MEhdqDqIQCk9RNV+2REBnFt
x6UWej6CroD6ZCcj7VkKI6Wpi2IlGCZn0zMgoMfOrNC4zjts628oHFBJeNOeMdt6
h9I6tEZiAJ643+ogJZlANeTlgHuW/7Tu5LaesNvZTMFO5zZXWpP+pJmDyZ5KAQhJ
vpEWoO9nlwlLCoTuVsZmQacH5agiSwr0HJXpPmoqUzWQ5rLjcwmjAtx9dYIHsbjl
pAUmpo/PsYpJqZRdOjnJnh+AoD//dMe5YLpUj+xex65hm09d69KTpKTcAuIcaQNo
G2jAHpKX9av/+3d7lrdSgy2/d+yYEag7YMbaIluBChYAfgFMPg6HcmG++jIdhekQ
kNmzWWtiD8xMu6/pARcfhl7qe1yMvpV7iYhpxDozrdtaPVn0TpW1K2RLaDKtIS93
MO7SRiBwjNnbyiqYAoLKg0Et7dtEAauO7vKHB7J+ELVnd3CIlUhBGFHBRFchhzF2
au1nE2ofOvXlX77oj2y6
=LXWG
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
