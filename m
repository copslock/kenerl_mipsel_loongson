Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Mar 2018 05:01:20 +0100 (CET)
Received: from mx2.suse.de ([195.135.220.15]:57266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992615AbeCTEBKi1KvL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Mar 2018 05:01:10 +0100
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 378D2AF48;
        Tue, 20 Mar 2018 04:01:04 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Date:   Tue, 20 Mar 2018 15:00:55 +1100
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: ralink: fix booting on mt7621
Message-ID: <87efkf9z0o.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-Path: <neil@brown.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63069
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


Since commit 3af5a67c86a3 ("MIPS: Fix early CM probing") the MT7621
has not been able to boot.

This patched caused mips_cm_probe() to be called before
mt7621.c::proc_soc_init().

prom_soc_init() has a comment explaining that mips_cm_probe()
"wipes out the bootloader config" and means that configuration
registers are no longer available.  It has some code to re-enable
this config.

Before this re-enable code is run, the sysc register cannot be
read, so when SYSC_REG_CHIP_NAME0 is read, a garbage value
is returned and panic() is called.

If we move the config-repair code to the top of prom_soc_init(),
the registers can be read and boot can proceed.

Fixes: 3af5a67c86a3 ("MIPS: Fix early CM probing")
Signed-off-by: NeilBrown <neil@brown.name>
=2D--
 arch/mips/ralink/mt7621.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index 1b274742077d..5a1b19bebd5b 100644
=2D-- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -170,6 +170,27 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 	u32 n1;
 	u32 rev;
=20
+	/* Early detection of CMP support */
+	mips_cm_probe();
+	mips_cpc_probe();
+
+	if (mips_cps_numiocu(0)) {
+		/*
+		 * mips_cm_probe() wipes out bootloader
+		 * config for CM regions and we have to configure them
+		 * again. This SoC cannot talk to pamlbus devices
+		 * witout proper iocu region set up.
+		 *
+		 * FIXME: it would be better to do this with values
+		 * from DT, but we need this very early because
+		 * without this we cannot talk to pretty much anything
+		 * including serial.
+		 */
+		write_gcr_reg0_base(MT7621_PALMBUS_BASE);
+		write_gcr_reg0_mask(~MT7621_PALMBUS_SIZE |
+				    CM_GCR_REGn_MASK_CMTGT_IOCU0);
+	}
+
 	n0 =3D __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
 	n1 =3D __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
=20
@@ -194,26 +215,6 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
=20
 	rt2880_pinmux_data =3D mt7621_pinmux_data;
=20
=2D	/* Early detection of CMP support */
=2D	mips_cm_probe();
=2D	mips_cpc_probe();
=2D
=2D	if (mips_cps_numiocu(0)) {
=2D		/*
=2D		 * mips_cm_probe() wipes out bootloader
=2D		 * config for CM regions and we have to configure them
=2D		 * again. This SoC cannot talk to pamlbus devices
=2D		 * witout proper iocu region set up.
=2D		 *
=2D		 * FIXME: it would be better to do this with values
=2D		 * from DT, but we need this very early because
=2D		 * without this we cannot talk to pretty much anything
=2D		 * including serial.
=2D		 */
=2D		write_gcr_reg0_base(MT7621_PALMBUS_BASE);
=2D		write_gcr_reg0_mask(~MT7621_PALMBUS_SIZE |
=2D				    CM_GCR_REGn_MASK_CMTGT_IOCU0);
=2D	}
=20
 	if (!register_cps_smp_ops())
 		return;
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqwh3gACgkQOeye3VZi
gbmKRg/4tZZnDqQU5XUQfWHRUnBhbjYUrXEibv6EiQr/qsxbKVxamZFMf6aWSZvM
YyOQvCFIkpH5ImnP8bk26CUxbn9EapuncuK46Yw4PITVWEZ3Z3RTLsp3rSruGNsz
tKdn/Pvx+otRk3Or7dNZEW6uJUrtPHk74Pu6DKAlCIAaWh0WUY2JkQsrovSy0xvW
ZhmzHwHL9ztbrc37GaJvIL4ZwN/945pmsebEXywDaOiV7K23qe8NRQQ2RFvX47WC
qmMnIQipC7af1p7xXhrFUr0siSigdr3PwuFApfCsZ0bcFWPD1vjaHYnFNdDBLCQI
9LRF7huoadCpKGE7elHHowTN8ZUHnPBiDgnQMY0Uxmxl13X6K2uGaqWyuEsj1Sn9
jneFqmS3NfDEK9P9qLo8WfDVz9WFODbI+aoAm7TipKLVNwBRsmUVRnLr4nZPOGCI
iq7AI3OU9qiVdNyxgsfFiu1mlwsA6J9lFA+2PDGk8pS3i7KkUXFEQaK2D0so3yZZ
YbwH6PLraI85Ea5lpLbaUtj979iPv4ZMH6/BM9A1jB+DyAp29aY1UV/l4UmYL85i
Mda9f59u3lDzUIrTVZjY7gzo4YRgnYthcVpByJU13bwh6joAKsUDyKRKv/nfRlI0
cwUEAQoKsrFm1uWpBi33vuDFKq6FO9/FduoiPdSHegg4N/E55A==
=8fUY
-----END PGP SIGNATURE-----
--=-=-=--
