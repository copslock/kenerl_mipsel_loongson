Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Sep 2015 21:03:06 +0200 (CEST)
Received: from smtp.gentoo.org ([140.211.166.183]:43804 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008773AbbIYTDEanxcJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 25 Sep 2015 21:03:04 +0200
Received: from vapier.lan (localhost [127.0.0.1])
        by smtp.gentoo.org (Postfix) with SMTP id 0255D33BF44;
        Fri, 25 Sep 2015 19:02:55 +0000 (UTC)
Date:   Fri, 25 Sep 2015 15:02:56 -0400
From:   Mike Frysinger <vapier@gentoo.org>
To:     linux-mips@linux-mips.org, macro@linux-mips.org,
        ralf@linux-mips.org
Cc:     Steven.Hill@imgtec.com, stable@kernel.org
Subject: Re: >=linux-4.1: build fails w/_PAGE_GLOBAL_SHIFT redefined errors
 in pgtable-bits.h
Message-ID: <20150925190256.GA32577@vapier.lan>
References: <20150911192553.GF640@vapier>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20150911192553.GF640@vapier>
Return-Path: <vapier@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vapier@gentoo.org
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


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11 Sep 2015 15:25, Mike Frysinger wrote:
> this works in linux-4.0, but starting with 4.1, i'm seeing:
>   CC      arch/mips/kernel/cpu-probe.o
> In file included from ./arch/mips/include/asm/io.h:27:0,
>                  from ./arch/mips/include/asm/page.h:176,
>                  from include/linux/mm_types.h:15,
>                  from include/linux/sched.h:27,
>                  from include/linux/ptrace.h:5,
>                  from arch/mips/kernel/cpu-probe.c:16:
> ./arch/mips/include/asm/pgtable-bits.h:164:0: error: "_PAGE_GLOBAL_SHIFT"=
 redefined [-Werror]
> ./arch/mips/include/asm/pgtable-bits.h:141:0: note: this is the location =
of the previous definition
> cc1: all warnings being treated as errors
> make[2]: *** [arch/mips/kernel/cpu-probe.o] Error 1
> make[1]: *** [arch/mips/kernel] Error 2
> make: *** [arch/mips] Error 2
>=20
> this warning hits many times, but this one is actually fatal
>=20
> looks like it's due to:
> 	be0c37c985eddc46d0d67543898c086f60460e2e MIPS: Rearrange PTE bits into f=
ixed positions.
>=20
> my config is attached

looks like this is fixed for linux-4.3 with:

commit 1cfa8de2880e5512f9037c7804ea47a79cc8232c
Author:     Maciej W. Rozycki <macro@linux-mips.org>
AuthorDate: Sun May 3 10:36:19 2015 +0100
Commit:     Ralf Baechle <ralf@linux-mips.org>
CommitDate: Sun Aug 30 13:16:40 2015 +0200

    MIPS: pgtable-bits.h: Correct _PAGE_GLOBAL_SHIFT build failure

can that get included in linux-4.1 and linux-4.2 stable ?
-mike

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWBZpgAAoJEEFjO5/oN/WBLK0QAKE5pTNBttr5HUABeRncQ34z
HvbImcuYkDfcMWgh1Q+nFAUgT+tVvyGdptNU6L2X99lM02+e5nwff/kVUcCa06ao
oP+8Z0G5rMvS1LOSO/PlJTeug68RcMdXcwB+y8P0oI7UDYnunTdh84dLkDZVduAh
/i2uQxVIJB0LH8oOpf9IF4JYbd5Kt2V8LUpVeJ+yj2zvcGBGHUnO6dYQET9I402V
nSIVqXOGS5MRYAocNQdx+dflYxou6kXXmuS9N6DnP4BAqNbQ/8bMkV3JJpniSgb8
WZNsCayIOqecUNUYrbjpEHOiCPhLM/T3K70/dtH06ErvXHqCUnvgvzmdtmC7YxQt
6nRr8GiexhqEIa8VOGyLkOFLE50mBHtgGG2dqfAwymfbVPRkxyfTS3V6C6DLWx3A
7rPTFl8CubUUv8p7LjERLaECv38odOQnc8CcHuZaobPd6Zn/mK8VKUd1KHDZoSp/
Z5l4/y4V6Gsozk2H+3E1T7PcnLMz+XEdE5j8qEFmxbjZAle+E1ICqnYK9xm3zdni
+o3wOoZTZRfzhLXHIieamIQ38LmA8isGevga3lcE3BnoSbdzUvkjSKIl3MHr2Lne
2hkZHX1Sm516dELepq+cpa21VDTXpmmgYt88YZLfJgrWHjE+7d0msTa0QII2lDAo
0no0gQ3z11ce5qO2+m3t
=3Owv
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
