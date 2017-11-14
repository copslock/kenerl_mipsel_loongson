Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 21:31:33 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:60033 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990901AbdKNUb0pcktl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 21:31:26 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 14 Nov 2017 20:30:53 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 14 Nov
 2017 12:30:48 -0800
Date:   Tue, 14 Nov 2017 20:30:47 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Steven J. Hill" <steven.hill@cavium.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3 04/11] MIPS: Octeon: Remove usage of cvmx_wait()
 everywhere.
Message-ID: <20171114203046.GC5823@jhogan-linux.mipstec.com>
References: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
 <1510633827-23548-5-git-send-email-steven.hill@cavium.com>
 <20171114190828.GD16044@linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
Content-Disposition: inline
In-Reply-To: <20171114190828.GD16044@linux-mips.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510691450-452059-8520-539232-1
X-BESS-VER: 2017.14.1-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186928
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
X-archive-position: 60935
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

--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2017 at 08:08:28PM +0100, Ralf Baechle wrote:
> On Mon, Nov 13, 2017 at 10:30:20PM -0600, Steven J. Hill wrote:
> > From: "Steven J. Hill" <Steven.Hill@cavium.com>
>=20
> At this place and many others cvmx_wait() was used to wait for a number
> of miliseconds, so I think it should better be replaced with something
> like mdelay(10).

Note that this patch, along with the nudges one and the lastpfn one, is
already queued for 4.15:

git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git
branch: mips-next

so any fixes to it will have to be made on top.

Cheers
James

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloLUm0ACgkQbAtpk944
dnrKIg//Ro41TrHMcJP+MTkUf4cB8aBl9NWNBAD4Fr1vCxgCy3Z6z+CbgzsAdyTk
pvulNHzcv40vEJTU/KXd1CePn+4JBNGgZ87KI1E1KLlmOuUDBPePiF7gouHU0f5j
YJD4IIFvJWeF8Sr1sj5MXFVPF83da2LplgqVcseeXCQIdrESrh4txzJvDTXbOrPx
LD+hV0fATpvC6ynWeabIVGHxwcJsw+nM2PUpbbQPc6gSHuUqRm16jMrRa8N65XgY
s44MXBVV/Q/oa4AgxuFfqaAB+S6AgUbD4SQg8xPmvBOcKHeu784x46Nd3yrLrMrZ
YehboQObF565/YYffEp9NAsbIEe2uyxzTvnau+Ix7o2GjAraVZJBnlMgCEafQt7q
d5aDIq58aAGiwplgTw437+aMMTtDuGms7SsSZeuFJN3n2ZTKSC2f2db37DqTvYYk
x5MyGgIVzaVSqBLYCtTs+mZV1WNdS3N8qjEFC+e7xGCwyivz8RSC5M1tvfRFasIh
zHarjVDrO4vVm7JBJwkq1YoDrVLBco6UOp2qpEnrIOuf+W4Pjri3ssIx4KWHtm7B
Tt5LBubS5aKFW/5uwtmitg7r9DcT+SNB1qFFi/LFlTWN4xChLQPWMDnj8MN2HSU7
4Yx+FgYZm5+pJyn+ByKhIbCU+1iflDqkIwD1eZschiIkjfqvwpc=
=MJyA
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--
