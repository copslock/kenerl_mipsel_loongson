Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Nov 2013 16:39:54 +0100 (CET)
Received: from mail-ee0-f51.google.com ([74.125.83.51]:46436 "EHLO
        mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6866963Ab3KLPjsSBymg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Nov 2013 16:39:48 +0100
Received: by mail-ee0-f51.google.com with SMTP id t10so3255048eei.10
        for <linux-mips@linux-mips.org>; Tue, 12 Nov 2013 07:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type;
        bh=RL7z9m9ElJu5UxglVaM/CpYpEPw5Lo/EyFzvAp21oJY=;
        b=beidTutOKqpcSn71jeHRD/ryEd6Lf0obWxP0AixgceUHxc0uqhykvrTSA8hhDIGh4J
         TksjEiuPJQXtOPNiLxzHap8Yt2WxtCumQNN47LdW65UDFZN4BKDSFwEd84U/qjWn4eMU
         2U6NOt4wcUAezGmV2nfCiXB/iRH8aJqckByfgh/yWajvcpIybdHQVnbS08bTgZH7C8WK
         0B6Xuat4CYz+5gpX3cR8tbJTpnyC+AVU/GtOr9NL4mAsjuw9NvSqvpIrC9KOSNqR2FiR
         o5Oeez9npxLgWxb7rScnIHGu672cv/XA/9WgJBlWSkZitv/oQC2r1TI/aL9Z8KXdju61
         1e2g==
X-Gm-Message-State: ALoCoQnLOWmh/5yjXCzwELTS9vKpqO6amGmBlVrlTuV6HLIQfh+DUaPbb/H5SIfpT+bLGVNnewZ9
X-Received: by 10.15.53.193 with SMTP id r41mr1506919eew.93.1384270782844;
        Tue, 12 Nov 2013 07:39:42 -0800 (PST)
Received: from [192.168.0.100] (nat-63.starnet.cz. [178.255.168.63])
        by mx.google.com with ESMTPSA id z2sm77205559eee.7.2013.11.12.07.39.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Nov 2013 07:39:42 -0800 (PST)
Message-ID: <52824BBC.9020401@monstr.eu>
Date:   Tue, 12 Nov 2013 16:39:40 +0100
From:   Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130330 Thunderbird/17.0.5
MIME-Version: 1.0
To:     Mark Salter <msalter@redhat.com>
CC:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Richard Kuo <rkuo@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>,
        linux-metag@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/11] Consolidate asm/fixmap.h files
References: <1384262545-20875-1-git-send-email-msalter@redhat.com>
In-Reply-To: <1384262545-20875-1-git-send-email-msalter@redhat.com>
X-Enigmail-Version: 1.6
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="wakS2gO08XuamRTkaApEoSt4HdIMUTtMO"
Return-Path: <monstr@monstr.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: monstr@monstr.eu
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wakS2gO08XuamRTkaApEoSt4HdIMUTtMO
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/12/2013 02:22 PM, Mark Salter wrote:
> Many architectures provide an asm/fixmap.h which defines support for
> compile-time 'special' virtual mappings which need to be made before
> paging_init() has run. This suport is also used for early ioremap
> on x86. Much of this support is identical across the architectures.
> This patch consolidates all of the common bits into asm-generic/fixmap.=
h
> which is intended to be included from arch/*/include/asm/fixmap.h.
>=20
> This has been compiled on x86, arm, powerpc, and sh, but tested
> on x86 only.
>=20
> Mark Salter (11):
>   Add generic fixmap.h
>   x86: use generic fixmap.h
>   arm: use generic fixmap.h
>   hexagon: use generic fixmap.h
>   metag: use generic fixmap.h
>   microblaze: use generic fixmap.h
>   mips: use generic fixmap.h
>   powerpc: use generic fixmap.h
>   sh: use generic fixmap.h
>   tile: use generic fixmap.h
>   um: use generic fixmap.h
>=20
>  arch/arm/include/asm/fixmap.h        |  25 ++------
>  arch/hexagon/include/asm/fixmap.h    |  40 +------------
>  arch/metag/include/asm/fixmap.h      |  32 +----------
>  arch/microblaze/include/asm/fixmap.h |  44 +-------------
>  arch/mips/include/asm/fixmap.h       |  33 +----------
>  arch/powerpc/include/asm/fixmap.h    |  44 +-------------
>  arch/sh/include/asm/fixmap.h         |  39 +------------
>  arch/tile/include/asm/fixmap.h       |  33 +----------
>  arch/um/include/asm/fixmap.h         |  40 +------------
>  arch/x86/include/asm/fixmap.h        |  59 +------------------
>  include/asm-generic/fixmap.h         | 107 +++++++++++++++++++++++++++=
++++++++
>  11 files changed, 125 insertions(+), 371 deletions(-)
>  create mode 100644 include/asm-generic/fixmap.h

Any repo/branch with all these patches will be helpful.

Thanks,
Michal



--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--wakS2gO08XuamRTkaApEoSt4HdIMUTtMO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKCS7wACgkQykllyylKDCEq9QCffe3d/+9UQGGG/rdCAxD81tq3
sRQAmwaBtQ/8lmwDm9Eo3vmovL9WeRiE
=R0bw
-----END PGP SIGNATURE-----

--wakS2gO08XuamRTkaApEoSt4HdIMUTtMO--
