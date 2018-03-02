Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2018 22:57:38 +0100 (CET)
Received: from [198.145.29.99] ([198.145.29.99]:41662 "EHLO mail.kernel.org"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993004AbeCBV53wNrfP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Mar 2018 22:57:29 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2558B21725;
        Fri,  2 Mar 2018 21:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2558B21725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 2 Mar 2018 21:57:02 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     tglx@linutronix.de, john.stultz@linaro.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, acme@kernel.org, benh@kernel.crashing.org,
        borntraeger@de.ibm.com, catalin.marinas@arm.com,
        cmetcalf@mellanox.com, cohuck@redhat.com, davem@davemloft.net,
        deller@gmx.de, devel@driverdev.osuosl.org,
        gerald.schaefer@de.ibm.com, gregkh@linuxfoundation.org,
        heiko.carstens@de.ibm.com, hoeppner@linux.vnet.ibm.com,
        hpa@zytor.com, jejb@parisc-linux.org, jwi@linux.vnet.ibm.com,
        linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, mpe@ellerman.id.au,
        oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net,
        paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
        rostedt@goodmis.org, rric@kernel.org, schwidefsky@de.ibm.com,
        sebott@linux.vnet.ibm.com, sparclinux@vger.kernel.org,
        sth@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com,
        will.deacon@arm.com, x86@kernel.org
Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to
 compat_time.h
Message-ID: <20180302215702.GD4197@saruman>
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <20180116021818.24791-3-deepa.kernel@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62778
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


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 06:18:10PM -0800, Deepa Dinamani wrote:
> All the current architecture specific defines for these
> are the same. Refactor these common defines to a common
> header file.
>=20
> The new common linux/compat_time.h is also useful as it
> will eventually be used to hold all the defines that
> are needed for compat time types that support non y2038
> safe types. New architectures need not have to define these
> new types as they will only use new y2038 safe syscalls.
> This file can be deleted after y2038 when we stop supporting
> non y2038 safe syscalls.

=2E..

>  arch/mips/include/asm/compat.h    | 11 -----------
>  arch/mips/kernel/signal32.c       |  2 +-

For MIPS:
Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqZyK0ACgkQbAtpk944
dnriXA//fiy/M44auOl6H3L/Sttb1xadP44YPlJKIkOi6RRm+XDNJWeIyb2dB28g
vkHkEqeW5OX0Yz+YmbMULh8EAl6TV42LSMUcRcDNmI3GjkArQIEQ7T1E7BiwukFd
lclSwy3Fe9HwtZdLeKQuO+C8W4pZ0rUXZeQW+8A0TvNM1zAKInEKaAGXgxS7PcMs
7pZBbOcIGBg9sTWFPhU4N63bfMn095wDXupegwflrlB1JSTvFktFxc2E6c0JmIwm
ij9jNw3J/lUtGaMq2ynmbJQWr+/I1EFVe740bkdKYP2Q1ZdTybWR2FnnoP+cC6kF
hS49c68Enp1mSirYIqRidTc8YLALwUFpdheUUky1VUPSjBWee2BqZ83VrshoMvkx
DQTuUfxvlFdnCLF6xHl0Ock5g7QTzrne9rpvqGBge3sGp25RZ1RcJYAruNJ36u+C
9VP1Y284Sz40x76q77yLxC5rT3inAHQYO2c+ob/BnrKoSrMxfDrWYea1X1yh+x80
6qyZomlmDEu7OREVX2dnpkIG/0j2GvhQBtjYHAHjvTkmHho80Fe/GBZhObkQjnoW
xgm1BLteveq/IEGK1tY2MEqjNFgUjQn1/r72KrP1b7PMtmwHjkyaXljB/dEv5TI3
tEttVw3wzqGUWmbvyj7KZcpv/BQUx/Otrqh/zGMnC30U53Lzrzw=
=PkCk
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
