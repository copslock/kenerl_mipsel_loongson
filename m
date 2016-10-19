Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2016 04:52:58 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.136]:33518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990519AbcJSCwvTdkp0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Oct 2016 04:52:51 +0200
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id ED0A020211;
        Wed, 19 Oct 2016 02:52:47 +0000 (UTC)
Received: from mail.kernel.org (host-091-097-042-010.ewe-ip-backbone.de [91.97.42.10])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80866202EB;
        Wed, 19 Oct 2016 02:52:46 +0000 (UTC)
Date:   Wed, 19 Oct 2016 04:52:44 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 13/14] power: reset: Add Intel PIIX4 poweroff driver
Message-ID: <20161019025244.agynpetclhimk3tr@earth>
References: <20160919234242.23xyy2y3zjvuhate@earth>
 <20160928153056.28719-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3eu5fzwnauerbpg6"
Content-Disposition: inline
In-Reply-To: <20160928153056.28719-1-paul.burton@imgtec.com>
User-Agent: NeoMutt/20160916 (1.7.0)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sre@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55494
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sre@kernel.org
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


--3eu5fzwnauerbpg6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 28, 2016 at 04:30:56PM +0100, Paul Burton wrote:
> Add a driver which allows powering off the system via an Intel PIIX4
> southbridge, by entering the PIIX4 SOff state. This is useful on the
> MIPS Malta development board, where it will power down the FPGA based
> board until its ON/NMI button is pressed, or the QEMU implementation of
> the MIPS Malta board where it will cause QEMU to exit.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: linux-pm@vger.kernel.org

Thanks, queued.

-- Sebastian

--3eu5fzwnauerbpg6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBt/8AAoJENju1/PIO/qaKngQAISzQ5ysV+Sm8/0fFDv4/ICC
f69gYtzf3wJvBoP12/3CcbibuxlkQfVl4ADYqEyCSiTbJFUXmw1j4ELeqNcjfjX6
vNo4lj0qDMZUeOwsQCOJysCsRW0G6qxBd8HBkH3gdT/5UFYYyI8DmhsBtWJw/wgI
EJ1EJzhv2ZN+BUlBPPrrpPIJMNdhvJmPTZTIUOnZbxHV9ybiR3pHZinzIPIAvnpc
ijEVqgjKMu8jjeoOzSIQXGzOubCWkyl5hUD9B3LBz4KvUGL4uZa7P6j9oeQBxO2Y
66Pac+SMWR6VOxcM/qBB37J4nQdyAIdw5+YthtBzy5ShBtE+pwVTIH2ty2pApUy9
T3uCS2GlSH5CvNH5mvSrAKUk3XKzcnBQREg6BNXD20Wki7vxrUZAE7eZ8ymap2SI
7tbq7WSz4JtXqWFp+b64TjMGlb6J+lv/RVUkkJ7OMwHdgWlDg9mlCJ7DQpi+JQ8s
4bJOBno7Wik/yxdMtdnDIJ6nmlmJ3aYt3pfHhvrsgHcLEu/SyHBHTZnrpgSynkbm
eRCVuHcl4Yij8K/0PRIPELlgZE2EA1H/puFBCbiL5AIMHWnCJQsicVvcc5gxFkFZ
kO3BDipXGWvSRL9kv9+SgLJEmkZ0tXw2RR/kYQfBPFAWLv+rEJX2SwR2tflAXofx
80lXFgykTW3LxHhUXwFS
=5I6j
-----END PGP SIGNATURE-----

--3eu5fzwnauerbpg6--
