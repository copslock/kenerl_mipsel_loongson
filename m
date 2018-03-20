Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2018 09:30:17 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:47785 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992678AbeCTIaEJYEms (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Mar 2018 09:30:04 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4B31EAC57;
        Tue, 20 Mar 2018 08:29:58 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Date:   Tue, 20 Mar 2018 19:29:51 +1100
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ralink: remove ralink_halt()
Message-ID: <87370v9mkg.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-Path: <neil@brown.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63072
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: neil@brown.name
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

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


ralink_halt() does nothing that machine_halt()
doesn't already do, so it adds no value.

It actually causes incorrect behaviour due to the
"unreachable()" at the end.  This tell the compiler that the
end of the function will never be reached, which isn't true.
The compiler responds by not adding a 'return' instruction,
so control simply moves on to whatever bytes come afterwards
in memory.  In my tested, that was the ralink_restart()
function.  This means that an attempt to 'halt' the machine
would actually cause a reboot.

So remove ralink_halt() so that a 'halt' really does halt.

Signed-off-by: NeilBrown <neil@brown.name>
=2D--
 arch/mips/ralink/reset.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/ralink/reset.c b/arch/mips/ralink/reset.c
index 64543d66e76b..e9531fea23a2 100644
=2D-- a/arch/mips/ralink/reset.c
+++ b/arch/mips/ralink/reset.c
@@ -96,16 +96,9 @@ static void ralink_restart(char *command)
 	unreachable();
 }
=20
=2Dstatic void ralink_halt(void)
=2D{
=2D	local_irq_disable();
=2D	unreachable();
=2D}
=2D
 static int __init mips_reboot_setup(void)
 {
 	_machine_restart =3D ralink_restart;
=2D	_machine_halt =3D ralink_halt;
=20
 	return 0;
 }
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqwxn8ACgkQOeye3VZi
gblkLRAAvwG8WkRAE1caLZ1sbk1UVbj6WvbgJ0g0F6mxky+8sWif0kKsTyOqBSzM
HeR1bw2n4N+IAqgX8EilcO6L2h0tFT60kgZeMFabR9z2S9i1rX7cv7xvF/cmQOiz
84LejiQHNxpFZ8QRrOaRSI+H5D4qxac2hiwrzO60XinEjPKCGoavmXtiWld9Tn7O
3C8OI+t1pEwH3PHSZcD57l5z7HURGnGP9evrl0xvzm523YJiK+HGOnhE/TdHTKLN
mggnBSNKV0hgmIIuMXkv4zu+TbLq8WR/hs8nNLsOSATLayjXDTrwzn63E0tVjjUE
HZy3t6ZjU+Dud9fFoRkhqMm0kfC9/tCW+oW0EwXM6rJLWRD3wZqNRhfxdlN6Xh8X
bXBsAP0LcbrSNj3jlXxhWbMeYTaVtu2R/ZkDkSq4e6JASp1Ly+5AfEpemMJzCyiR
6i4EAh2PdRdYNteKfMMXb3/s6IBmbYQjE9D2ZVptiDi8o0blW+EejKcXsbLqMsmc
gVV3Pa4m0dEF96+TV6lWv8ypr/wGf92kDMum7/A6odcBnKtPRv+gsVIOggf3F9RU
sqvL2GBUEth+G/IYyVh0/o1P33kcJjjbRLXjOAi0c6BKGARkNwP1EpTmbUiwAnY7
jK4jJbsVbPMvG6d2cCxOe1uMGSh/ngO+Kd+lKvP1JPXloxuU11o=
=Rhh6
-----END PGP SIGNATURE-----
--=-=-=--
