Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jul 2015 13:29:43 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18860 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009891AbbGIL3l4432w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jul 2015 13:29:41 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 947E641F8E36
        for <linux-mips@linux-mips.org>; Thu,  9 Jul 2015 12:29:36 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Thu, 09 Jul 2015 12:29:36 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Thu, 09 Jul 2015 12:29:36 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4A791A7EA5617
        for <linux-mips@linux-mips.org>; Thu,  9 Jul 2015 12:29:34 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 9 Jul 2015 12:29:36 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 9 Jul
 2015 12:29:35 +0100
Message-ID: <559E5B21.3030407@imgtec.com>
Date:   Thu, 9 Jul 2015 12:29:37 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 05/19] MIPS: asm: mips-cm: Implement mips_cm_revision
References: <1436434853-30001-1-git-send-email-markos.chandras@imgtec.com> <1436434853-30001-6-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1436434853-30001-6-git-send-email-markos.chandras@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="QwGVNX6I1IhV7dLn2i0IcuT4fW9npwtWC"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: f107b6f
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48161
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

--QwGVNX6I1IhV7dLn2i0IcuT4fW9npwtWC
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Markos,

On 09/07/15 10:40, Markos Chandras wrote:
> From: Paul Burton <paul.burton@imgtec.com>
>=20
> Provide a function to trivially return the version of the CM present in=

> the system, or 0 if no CM is present. The mips_cm_revision() will be
> used later on to determine the CM register width, so it must not use
> the regular CM accessors to read the revision register since that will
> lead to build failures due to recursive inlines.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/include/asm/mips-cm.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mi=
ps-cm.h
> index edc7ee95269e..29ff74a629f6 100644
> --- a/arch/mips/include/asm/mips-cm.h
> +++ b/arch/mips/include/asm/mips-cm.h
> @@ -189,6 +189,13 @@ BUILD_CM_Cx_R_(tcid_8_priority,	0x80)
>  #define CM_GCR_REV_MINOR_SHF			0
>  #define CM_GCR_REV_MINOR_MSK			(_ULCAST_(0xff) << 0)
> =20
> +#define CM_ENCODE_REV(major, minor) \
> +		((major << CM_GCR_REV_MAJOR_SHF) | \
> +		 ((minor) << CM_GCR_REV_MINOR_SHF))
> +
> +#define CM_REV_CM2				CM_ENCODE_REV(6, 0)
> +#define CM_REV_CM3				CM_ENCODE_REV(8, 0)
> +
>  /* GCR_ERROR_CAUSE register fields */
>  #define CM_GCR_ERROR_CAUSE_ERRTYPE_SHF		27
>  #define CM_GCR_ERROR_CAUSE_ERRTYPE_MSK		(_ULCAST_(0x1f) << 27)
> @@ -324,4 +331,26 @@ static inline int mips_cm_l2sync(void)
>  	return 0;
>  }
> =20
> +/**
> + * mips_cm_revision - return CM revision

don't forget brackets: "mips_cm_revision()"

> + *
> + * Returns the revision of the CM, from GCR_REV, or 0 if no CM is pres=
ent.
> + * The return value should be checked against the CM_REV_* macros.

Use "Return: bla bla bla." so it lands in a nice return section.

see Documentation/kernel-doc-nano-HOWTO.txt for an example.

Cheers
James

> + */
> +static inline int mips_cm_revision(void)
> +{
> +	static int mips_cm_revision_nr =3D -1;
> +
> +	/* No need to read that register over and over */
> +	if (mips_cm_revision_nr >=3D 0)
> +		return mips_cm_revision_nr;
> +
> +	if (!mips_cm_present())
> +		return 0;
> +
> +	mips_cm_revision_nr =3D read_gcr_rev();
> +
> +	return mips_cm_revision_nr;
> +}
> +
>  #endif /* __MIPS_ASM_MIPS_CM_H__ */
>=20


--QwGVNX6I1IhV7dLn2i0IcuT4fW9npwtWC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVnlshAAoJEGwLaZPeOHZ6EQIP/jZnWBcbWpfbmD/ujeuZ4+Nu
A7X4SGAuZfx12RQf13l99z44rME4AcHT/ii97W7xOca7vdq92yZluNsOPSZpj5Ts
aSBdiZBW4pOCL8NuxXe5ifcibnvxUNuBk8KeXU/dz6z0PYQW4SPM4Vit1SKBOhda
R3qtbBChp0uAkz02d0SCDJflanmo1FuUpmX00xAiFtjLM7gZZZHkCLYIh/A66kTL
ChMUkKRLK0QI8d4yrHtemcfEXNH6nDLL3QFfiE+J3elvB5DM2wuhATlAk9y/xbz5
GofCEr0WzSsVWBcamBNhsS8iw8/htfHJ6bm860K4tJBaV0rZhHMXUpBfdOehOSdh
BRcdGqWFM4NNjzYvkFLsOgskB8D4yh+5w2FgYWmiRNC3/jXtuSru3/cM8dDriVBJ
Sg5ORQbGcbSK9QZRL/n50GURxodxwMB7KE5VtNxQ9AkV7p8WeAkGWbQpsVxSO0/Q
+Sf59HauKc7XbAD5d5bXUWdlJReVyB3zWvVp1h0KpErC81ktmF3is5rrfqBp+1rc
t5eFOfmfQwDIEXWR/Oe1Xj47Yr8pXLkPbyDj2KpSHryprAmJngWesabFGP3MSaYo
YaRX8CYBRAChICz4ucfJV9NShTaVUb+x34p0l6TeV4SnbxWJko0qB4CXtd9LNvvN
GyP2rWpkribLhWlN0rgl
=7RfA
-----END PGP SIGNATURE-----

--QwGVNX6I1IhV7dLn2i0IcuT4fW9npwtWC--
