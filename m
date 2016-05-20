Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2016 14:49:31 +0200 (CEST)
Received: from smtp5-g21.free.fr ([212.27.42.5]:10296 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27031658AbcETMt3PK-SY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 May 2016 14:49:29 +0200
Received: from tock (unknown [78.54.180.121])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id 4BB535FFC5;
        Fri, 20 May 2016 14:50:33 +0200 (CEST)
Date:   Fri, 20 May 2016 14:49:18 +0200
From:   Alban <albeu@free.fr>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH v2 1/2] MIPS: ath79: make ath79_ddr_ctrl_init()
 compatible for newer SoCs
Message-ID: <20160520144918.792b4795@tock>
In-Reply-To: <1463421115-19048-1-git-send-email-nbd@nbd.name>
References: <1463421115-19048-1-git-send-email-nbd@nbd.name>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/_Le./NmerUZUOI03wsCUbzZ"; protocol="application/pgp-signature"
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53556
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

--Sig_/_Le./NmerUZUOI03wsCUbzZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 16 May 2016 19:51:54 +0200
Felix Fietkau <nbd@nbd.name> wrote:

> AR913x, AR724x and AR933x are the only SoCs where the
> ath79_ddr_wb_flush_base starts at 0x7c, all newer SoCs use 0x9c
> Invert the logic to make the code compatible with AR95xx
>=20
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: Aban Bedel <albeu@free.fr>

Alban

--Sig_/_Le./NmerUZUOI03wsCUbzZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXPwfPAAoJEHSUmkuduC28aiQQAKKRHvJUsC3Po/RSz5XdMuJS
iDxgqdzrT0LvKAglvgxW9kRXeTASXHW1SpKD7E76RhwO+W/1Kp+uwxSDHrlOF9rB
5YuwUtGgAj/GTbTGRZ75JuV4+A7NVYy9x5ess6vOpykOlXX9wBRBklua7AQwH/Ve
oS9fe5/0W/6c6Hk0ioRKcJT1Uj5ZhUYqr8MiM6GDJ4ZMYGeqqR0QYFn+dk6BKZUm
hRBU9ImlwbnnR4CNo6mjhxBJe5Pj9IYQ7zHeaFLyMPyTgAlX0VrGruTdMl+xOY1P
J8prY+d8NUF2GcJUUefM5UuhXfSqGNPdcGfJji+qJ5/KppDd6tiw38Tb6YwLyTBZ
5Mf/asjBOsJfLLJMFlLJvpdQDr2p0/IT5rYlsGAumDxbGKlH1z+PG6BuDKy1yi34
FfMZen+s+uj3bfqV7G68Ii9eWMnPuwZJIp/akkx2kJhiinLw2Vh5spBiQd6MdqKo
ojp9FHmLejZAP5LQD1OZvTVIoSY0qvSjkH1K74Job0DOIgvK9z1sI8cyE6TZIhoN
nHMkoIrN+9mlj0bGID8Y/6nBIDDP/OeqM9tDq232YrtvwzSxcOCHDq/k8BpDECci
UU2gPdePupHT8GGFfOxwfF3tYiNoQ1sp42o2JgPI/T4NO/d/oWWoBBL/ynfGQ1yS
/yzox2PSkaAaZCGooB0J
=5Hva
-----END PGP SIGNATURE-----

--Sig_/_Le./NmerUZUOI03wsCUbzZ--
