Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2016 15:10:25 +0200 (CEST)
Received: from smtp5-g21.free.fr ([212.27.42.5]:46791 "EHLO smtp5-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27031676AbcETNKWdWaLY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 May 2016 15:10:22 +0200
Received: from tock (unknown [78.54.180.121])
        (Authenticated sender: albeu)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id E50E95FF20;
        Fri, 20 May 2016 15:11:26 +0200 (CEST)
Date:   Fri, 20 May 2016 15:10:10 +0200
From:   Alban <albeu@free.fr>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Aban Bedel <albeu@free.fr>, linux-mips@linux-mips.org,
        sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH v2 2/2] MIPS: ath79: fix regression in PCI window
 initialization
Message-ID: <20160520151010.2f7e5773@tock>
In-Reply-To: <1463421115-19048-2-git-send-email-nbd@nbd.name>
References: <1463421115-19048-1-git-send-email-nbd@nbd.name>
        <1463421115-19048-2-git-send-email-nbd@nbd.name>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/5262r2j.undY5dyrINuumaM"; protocol="application/pgp-signature"
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53557
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

--Sig_/5262r2j.undY5dyrINuumaM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 16 May 2016 19:51:55 +0200
Felix Fietkau <nbd@nbd.name> wrote:

> ath79_ddr_pci_win_base has the type void __iomem *, so register offsets
> need to be a multiple of 4.
>=20
> Cc: Alban Bedel <albeu@free.fr>
> Fixes: 24b0e3e84fbf ("MIPS: ath79: Improve the DDR controller interface")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Acked-by: Aban Bedel <albeu@free.fr>

Alban

--Sig_/5262r2j.undY5dyrINuumaM
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXPwyyAAoJEHSUmkuduC28dvwQAOJP9Fwwd3VPWcv6KIwm/0u2
HigwLSR9LVlIJ0FZMSyoUTvUMVRLtp4DNjFQ4di0tlrc0ho6MNltO7HK8+GbOMGi
kji/wyrHfJBHvUh82iUmkTtIlNQsJyXBxcP5bGSVFbKrEzctOBhtzlrtUA0+kPnr
6dmgkQXcklEeq3wYkKm1d/FKZ6geZ8WIjv/HDyBD8JMSLtradNNQzrPdc/bwtmWq
qPZ2kjuC1sETVsNRGc8xJw5ixcH4MY5GviReExziP237AReekwFLYXAD3rk5sxIJ
KNUFi6mA/IAjx6dbhR9GGnM4VVm1lyNC3zZs+RWNep8h93oImhhPGf4SihtvVqc1
6E/DPEb+GCwi+NSZA1vI010vjFLswUDnj2e90v17uxjCAhzwtOZY76GGQTL+PEzH
MVAv59tsXbhTFVY9STFXQIwMi7KCnUkbKO3ei+t54XOm/qouJg0uteK80P2TRYQD
LWCJOGay5ihnF7jrwjjVR8Sm9X4357kv+ONeUcR1wMDoHviV1rGjv0EoXP9/qou3
gXBWKmQ1VY5r2PtO7NN2PEybEmpGzGScWw4TL4eSCYTL+p/dsOiSL6SgKmj8nBsm
hsbWfZlIynImqwG8Dxt3oWaPjXWTzPoyEHWo48ENS051y6K5WAe+nJIMohOvmIiq
c+DRfeiVVHTQnA78klOb
=wdLw
-----END PGP SIGNATURE-----

--Sig_/5262r2j.undY5dyrINuumaM--
