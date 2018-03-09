Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 01:20:54 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:50540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994765AbeCIAUpQbkCR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Mar 2018 01:20:45 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B196206B2;
        Fri,  9 Mar 2018 00:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B196206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 9 Mar 2018 00:20:33 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: Hang more efficiently on halt/powerdown/restart
Message-ID: <20180309002032.GD24558@saruman>
References: <20170823205317.4828-1-paul.burton@imgtec.com>
 <20170823205317.4828-2-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline
In-Reply-To: <20170823205317.4828-2-paul.burton@imgtec.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62862
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


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 01:53:16PM -0700, Paul Burton wrote:
> The generic MIPS implementations of halting, powering down or restarting
> the system all hang using a busy loop as a last resort. We have many
> platforms which avoid this loop by implementing their own, many using
> some variation upon executing a wait instruction to lower CPU power
> usage if we reach this point.
>=20
> In order to prepare for cleaning up these various custom implementations
> of the same thing, this patch makes the generic machine_halt(),
> machine_power_off() & machine_restart() functions each make use of the
> wait instruction to lower CPU power usage in cases where we know that
> the wait instruction is available. If wait isn't known to be supported
> then we fall back to calling cpu_wait(), and if we don't have a
> cpu_wait() callback then we effectively continue using a busy loop.
>=20
> In effect the new machine_hang() function provides a superset of the
> functionality that the various platforms currently provide differing
> subsets of.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org

I've applied this patch (but not patch 2) for 4.17.

Thanks
James

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqh01AACgkQbAtpk944
dnppEw/+OaZnuzfJyssPuT2nbd46P9+muHXEXwrNs1aVU8tYGY8Mw1Yyc7AeF12f
K7qWsXo+rBpujgICXD8/cjGZeQDzBl3QBi2oL3rlguVJKm71WtbCgrUeoFVCPOBC
bk31zeEBV3oA0lqW7PzUsjl7muht74C64v6Rvo/kohyAyfGjrVyxV859Q+gjusKR
+fnOykLOqy5RNtj80g8hwBZ42o71CqSaCNQJuAm1cHMMD2Cr/FPMbb8jGoKNayo8
55FnJxzIJ2fRUt/hLYG+cWIOLHcw1mOrvlo5R2eSDaFPDYLYoJmuesrgMqVgvsYJ
1WlcyoXglkU7oreC1mIwnAdpVD+SeWfp7oHIIwWQ5QVKFVE0Sand/AtHKZlqv7yP
wPJ6EelLHI5U1i6N/YACMVBuj7ipM5bs0bFzBktcFPO4TKPO1H7LMA0LO1nMmro6
dixlPFFOW4eG0YsKFxZ2qR8VSWwJ6yT77Lxr+MnRuae1FBUXzfedlFBcPiJyNofS
FGrqg91aQ9QhYLPtlmaanvMfBmwJ8hiZb3gn/n6+RTMU+hzxHAEEHwK7awxZv4+Q
CSh5R/zDsKvAi3MnuFYqBRPr5St3WCmq/6E/Z8T5drv+VullB4EqZXKAbLyyr10Z
qkWYHCX7LRuBT0m/egfjGCpctYXVEGljRsHwOG2ItzNQSemeMvA=
=QtNL
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--
