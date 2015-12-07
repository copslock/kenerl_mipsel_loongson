Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2015 09:43:54 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19691 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27006898AbbLGInwiqUE6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2015 09:43:52 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 2D42141F8E55;
        Mon,  7 Dec 2015 08:43:47 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 07 Dec 2015 08:43:47 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 07 Dec 2015 08:43:47 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id C2B7E7C40C7B2;
        Mon,  7 Dec 2015 08:43:44 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Mon, 7 Dec 2015 08:43:46 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 7 Dec
 2015 08:43:46 +0000
Date:   Mon, 7 Dec 2015 08:43:46 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] MIPS: Don't unwind to user mode with EVA
Message-ID: <20151207084345.GB874@jhogan-linux.le.imgtec.org>
References: <1449267902-28674-1-git-send-email-james.hogan@imgtec.com>
 <1449267902-28674-2-git-send-email-james.hogan@imgtec.com>
 <56622DF5.30005@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <56622DF5.30005@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: c13f36af
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Dec 04, 2015 at 04:21:09PM -0800, Leonid Yegoshin wrote:
> OK.

Thanks Leonid. Can that be taken as a Reviewed-by?

Cheers
James

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWZUbBAAoJEGwLaZPeOHZ6SKwP/i0PfNI1qeOpYUuFbkYaqPSw
CyR4utT8xp9yJhFl7H/186J09oYOtreFwrncO4apUBwkaEjZUFE4aRp5VNpdFBgy
KHLnTgwvRSEmnayVwRQnZhfSnP0nf0oDysZ7ZgorX9Lux2pe3o9/lBarYvSqQnto
dDXu9XW7+is1B/eVUm255eEXOLf525SzHTrR8bCjRKomeaZXJJQddvvDSq3kPImR
3ei7006JX6iYtftzf2g1lzsH70ssouNOOSl0iqQNXfEKi2E4Xu/MEd2PZuPl4KMS
bAfYvG2xjTh/CxhXoH/53iJQKe1ecCNM0+yAzqtNTIswnMJEBAfik22CTBDuNgXZ
DYuP7ONfSVArt5n+ZDE5kvTi7SgRFjgXhqZ76nH6gzP5OH3Z4nmevBTDAAVyQ6dY
VpFjFFwoJDLcwnF8Q3zHP6in8DE/GM63L2kD2ogi3mBFlOP+m60YTmmt0QNhSHph
R4bjNxFUguNAHFVOyLSErVbXi5IFZNP3OYzLB62wXYKOgiLpdGWgbrzgHB5oFJSv
DbqFBiZJjrCpKKnP755UMOrJotNFKUpR4GEF+hMkzUX8p6YwHX8YPkMOE/S6Aqd6
fdQ9xqJjQzUKt/BnbaAPFE1+1OTwlTmAnwDRtFvfpNiNWOcMAFlKCcJLLcd99MyC
3mKxS3IzGrHdoLVcV3zC
=WguQ
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
