Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Nov 2017 17:47:37 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:33728 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992309AbdKJQraYblpU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Nov 2017 17:47:30 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx30.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 10 Nov 2017 16:47:07 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Fri, 10 Nov
 2017 08:47:00 -0800
Date:   Fri, 10 Nov 2017 16:46:58 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [GIT PULL] Final MIPS fixes for 4.14
Message-ID: <20171110164657.GW15235@jhogan-linux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pP8l8ytKVQui4K7o"
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510332426-637140-28708-42884-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186794
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

--pP8l8ytKVQui4K7o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

I've gathered a few final short & sweet MIPS bug fixes for v4.14. Please
consider pulling.

Thanks
James

The following changes since commit 39dae59d66acd86d1de24294bd2f343fd5e7a625:

  Linux 4.14-rc8 (2017-11-05 13:05:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git tags/mips_fixes_4.14_2

for you to fetch changes up to b084116f8587b222a2c5ef6dcd846f40f24b9420:

  MIPS: AR7: Ensure that serial ports are properly set up (2017-11-08 14:57:55 +0000)

----------------------------------------------------------------
Final MIPS fixes for 4.14

A final few MIPS fixes for 4.14:

- Fix BMIPS NULL pointer dereference (4.7)
- Fix AR7 early GPIO init allocation failure (3.19)
- Fix dead serial output on certain AR7 platforms (2.6.35)

----------------------------------------------------------------
Jaedon Shin (1):
      MIPS: BMIPS: Fix missing cbr address

Jonas Gorski (1):
      MIPS: AR7: Defer registration of GPIO

Oswald Buddenhagen (1):
      MIPS: AR7: Ensure that serial ports are properly set up

 arch/mips/ar7/platform.c     | 5 +++++
 arch/mips/ar7/prom.c         | 2 --
 arch/mips/kernel/smp-bmips.c | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

--pP8l8ytKVQui4K7o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloF2AEACgkQbAtpk944
dnqGLg/+MNUKkiKFdZgy/V018TKEq/wCw0eBoa0hA8z6bpdL0N9+U3zFniJ9YGLd
sRvZQz9O93bmQGKU7fdRw/huxN37Jv7oMIRuQa9BRuPSaWk14hfKPn+lMvi4C/Sg
5vI1T0UpO8mD5IA70Y9GpUWk3V/VSvmv8WdbupvVrbBfuy6F/toZDVc5K3c1DbO/
pwOk5jVyaxJuM2ZnXQuPT2BhS90micfRAXNvAMQXHLiA8DcWybEpN3Pn2Dolg1Wq
KWcY4z1qKTDM9Z9QEtXWg1NeN3zj3d9CB0Raq0SU8iHsnDlN+Z3a+wwWxaohFYcN
3JThT9IP3nwcl/9cJkrMJtJs0tIuqzAs3Qj2gEBgS7xCJhXy2R7ZFDLh3zeSuC5r
fCv6p1cySMbfz9WKbaJWpc/wHFQ0TLKb9hENUT8hywOe6Rv3NXDH7GDqKeoKaHQm
e2wRzug6fK/tf1ukskJdRzD3xD0wMoeSkvqyZ1mfTYhjOvNSCAhfV2A7Uuxd4BuV
MhVm1Dw/jzfJ8U2ChtxRMfMgzXm9e1dI/nhkS+HVps2mpS0/Ynn6R5HYm1kX8A2s
UAa9A2Y/y15dIRD2jZ6N9kQsvJX7oNts8DX6aJVRHklabF7hlP4+gKYgaT/MsRUn
6Pytz5TZ+475pAsaVkg9t2e9C1Gwl2gmoDWYQYuNhzNS/8ePQiU=
=yn9c
-----END PGP SIGNATURE-----

--pP8l8ytKVQui4K7o--
