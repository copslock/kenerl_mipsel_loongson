Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jul 2017 16:27:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65046 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23994818AbdGQO1Ql320g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Jul 2017 16:27:16 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 05B6741F8E6A;
        Mon, 17 Jul 2017 16:38:06 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 17 Jul 2017 16:38:06 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 17 Jul 2017 16:38:06 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C37B652D94CC;
        Mon, 17 Jul 2017 15:27:07 +0100 (IST)
Received: from [10.150.130.85] (10.150.130.85) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 17 Jul
 2017 15:27:10 +0100
Subject: Re: [PATCH 2/2] MIPS: Remove pt_regs adjustments in indirect syscall
 handler
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
References: <20170331160959.3192-1-James.Cowgill@imgtec.com>
 <20170331160959.3192-3-James.Cowgill@imgtec.com>
From:   James Cowgill <James.Cowgill@imgtec.com>
Message-ID: <86263466-443d-475b-a927-9df38af9f732@imgtec.com>
Date:   Mon, 17 Jul 2017 15:27:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170331160959.3192-3-James.Cowgill@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature";
        boundary="Dr26jnaMAfDE6edD3jUJiLpfTVJLsGflD"
X-Originating-IP: [10.150.130.85]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Cowgill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Cowgill@imgtec.com
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

--Dr26jnaMAfDE6edD3jUJiLpfTVJLsGflD
Content-Type: multipart/mixed; boundary="Uthsh9AUbBdIr47VfJQ5wvsE8cf8oeiF9";
 protected-headers="v1"
From: James Cowgill <James.Cowgill@imgtec.com>
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Message-ID: <86263466-443d-475b-a927-9df38af9f732@imgtec.com>
Subject: Re: [PATCH 2/2] MIPS: Remove pt_regs adjustments in indirect syscall
 handler
References: <20170331160959.3192-1-James.Cowgill@imgtec.com>
 <20170331160959.3192-3-James.Cowgill@imgtec.com>
In-Reply-To: <20170331160959.3192-3-James.Cowgill@imgtec.com>

--Uthsh9AUbBdIr47VfJQ5wvsE8cf8oeiF9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 31/03/17 17:09, James Cowgill wrote:
> If a restartable syscall is called using the indirect o32 syscall
> handler - eg: syscall(__NR_waitid, ...), then it is possible for the
> incorrect arguments to be passed to the syscall after it has been
> restarted. This is because the syscall handler tries to shift all the
> registers down one place in pt_regs so that when the syscall is restart=
ed,
> the "real" syscall is called instead. Unfortunately it only shifts the
> arguments passed in registers, not the arguments on the user stack. Thi=
s
> causes the 4th argument to be duplicated when the syscall is restarted.=

>=20
> Fix by removing all the pt_regs shifting so that the indirect syscall
> handler is called again when the syscall is restarted. The comment "som=
e
> syscalls like execve get their arguments from struct pt_regs" is long
> out of date so this should now be safe.
>=20
> Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>

Ping? The first patch in this series has been applied, but this patch
has not been.

Thanks,
James


--Uthsh9AUbBdIr47VfJQ5wvsE8cf8oeiF9--

--Dr26jnaMAfDE6edD3jUJiLpfTVJLsGflD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+Ixt5DaZ6POztUwQx/FnbeotAe8FAllsyTUACgkQx/Fnbeot
Ae9Ddw//VXSXc9COkm80IVmEUV2eyqdzezKKgcu/5Jzsyoaf2EM+5N9NDInvkT9s
P0z9HSHcm7j8BqjGrmcvSo00SoRVRnxKW/9Pw7KAIBAIt6Unofu5sYAMBkyI4IdF
/vbkj5gffZ4nrjQd0eBuN13bSIUwj9uc4MqJRKDm/b0nvGmyZOiBGZTyD8RMjG3r
XYtsvvvJWuvWCj7XRwvdGy2uCL/coK9wjQicLXLXEula9R7nDHPH0gSjZRTcq/LQ
Vii15Ma3YvwKxaVP+hdR9cfZ1WFRsTXw0+RX+klG/1xDzs/RRZe8Sb7TVOaUzSNz
rcG0PdVCdo1n8y3+obo8lu41tTUXWdhknW11dCXkTn8gzfuFtrh8C17BfYFEWffW
23L1LyO9UD6uOVVK/buCG/K1TI+9BZsM11VqJt6dfzSEkIhzQD3R2+ct6qT70jgG
vh57QiY7qR6vOGxrF5jnXCCPp3Rzg30xZk8/4RXuh8RXtj3LPgsMrD4qZqJdShjj
se3487yYvV+mwfOycJFGHgEJ+PGdCPkqgG4kmDNCb9jTEcU9CHavJwk0se6eSj3N
CQsbPkLlIYdKsuLT8mNey0FhoAjPDtGpJ7zTHmO27Efe8vTrjEemgfNBqbf01w2p
RhnKtJCGZOrvEanWddPTCOi5hO+N0muXa8V39jzI9tbLHWFxDso=
=9Yg5
-----END PGP SIGNATURE-----

--Dr26jnaMAfDE6edD3jUJiLpfTVJLsGflD--
