Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Dec 2011 05:51:03 +0100 (CET)
Received: from calzone.tip.net.au ([203.10.76.15]:51004 "EHLO
        calzone.tip.net.au" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903679Ab1LQEu4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Dec 2011 05:50:56 +0100
Received: from canb.auug.org.au (ash.rothwell.emu.id.au [IPv6:2402:b800:7003:7010:223:14ff:fe30:c8e4])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by calzone.tip.net.au (Postfix) with ESMTPSA id 48B6A128494;
        Sat, 17 Dec 2011 15:50:50 +1100 (EST)
Date:   Sat, 17 Dec 2011 15:50:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hillf Danton <dhillf@gmail.com>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org,
        "Jayachandran C." <jayachandranc@netlogicmicro.com>
Subject: linux-next: build failure after merge of the final tree (mips tree
 related)
Message-Id: <20111217155044.094c4c2b51af7c66e8ec90a3@canb.auug.org.au>
X-Mailer: Sylpheed 3.2.0beta4 (GTK+ 2.24.8; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Sat__17_Dec_2011_15_50_44_+1100_uI2PGSWnWbhegEUC"
X-archive-position: 32113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13998

--Signature=_Sat__17_Dec_2011_15_50_44_+1100_uI2PGSWnWbhegEUC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the final tree, today's linux-next build (mips almost all
configs) failed like this:

arch/mips/mm/tlb-r4k.c: In function 'local_flush_tlb_range':
arch/mips/mm/tlb-r4k.c:128: error: 'HPAGE_SIZE' undeclared (first use in th=
is function)
arch/mips/mm/tlb-r4k.c:130: error: 'HPAGE_SHIFT' undeclared (first use in t=
his function)

Probably caused by commit 0b07e859f87b ("MIPS: Flush huge TLB").
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__17_Dec_2011_15_50_44_+1100_uI2PGSWnWbhegEUC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJO7B+kAAoJEECxmPOUX5FEw8oP/RDiFMJrX/roVS+VcSQcYgO4
x8XAHxkIwOvlDOIdqZb2xmvDZRnGtxLoE87gWKBhHHYW0M2UpXBk7b+ltT+L4EbY
HeHBjybDq8un4lee240kHmZCBb/jrj8ZiO5JOwJsqx/Di9PsBikRqkTsebR7Ds9n
HFnZEWy5iEcJqzuxxhsOCh+UJdJjUtGjSwFsdU33JY2UCTsHWT8mvc/Qza7YIYaJ
ZTwdPFyj/S6wVo8HdyQImppWg1rpfAAaOJifDH9QHbfzGrnnGue9G4TKsWCgnuJz
rI+RpAl9e8xqePF/cUGd4Tey5+uLZbWduLgmO9JWqX3NJBw9EKZOHRzFEsOtk94R
AUyo8FISRyQ7IwJ7qgOmr770wlfEmJbB4LpFzwd3QiyVaivWBDnyvggVYVXkHZ5U
u5gmD4ewx4/I5iIrz863zejVeU9iFKWt0cjYkm1sTVhfOvK1t8HCVS4JYBmKUijY
VexfWjBLMAqYLYX/DTCV0s2D/Ty02rl+xl8djCBnOKxixFyD0t8nWEC1TYFVh86D
wDHFzaRJgPQUPM9Lh7Z/6VFueLB8DHPQ5XMAtujXP4vAqEAAX+dP4HtNQMU64Q1K
AQwiLl5p4Tf69HHa1mT1JkdidVZQpd/mtUYVydZ3NTiJioJO7pMM8689ryVwrTFz
p7xOru4oUWGHhAo22+m+
=xFzP
-----END PGP SIGNATURE-----

--Signature=_Sat__17_Dec_2011_15_50_44_+1100_uI2PGSWnWbhegEUC--
