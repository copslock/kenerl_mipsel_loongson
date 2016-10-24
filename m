Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2016 15:43:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:12087 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992195AbcJXNm6tZAIf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Oct 2016 15:42:58 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id C58A441F8DB3;
        Mon, 24 Oct 2016 14:42:15 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 24 Oct 2016 14:42:15 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 24 Oct 2016 14:42:15 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C05CEA0D2ED28;
        Mon, 24 Oct 2016 14:42:49 +0100 (IST)
Received: from np-p-burton.localnet (10.100.200.204) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 24 Oct
 2016 14:42:52 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>, Stephan Linz <linz@li-pro.net>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 11/14] MIPS: Malta: Use syscon-reboot driver to reboot
Date:   Mon, 24 Oct 2016 14:42:47 +0100
Message-ID: <2861325.0K2k6plxiD@np-p-burton>
Organization: Imagination Technologies
User-Agent: KMail/5.3.2 (Linux/4.8.4-1-ARCH; KDE/5.27.0; x86_64; ; )
In-Reply-To: <alpine.DEB.2.00.1610220956020.31859@tp.orcam.me.uk>
References: <20160919212132.28893-1-paul.burton@imgtec.com> <20160919212132.28893-12-paul.burton@imgtec.com> <alpine.DEB.2.00.1610220956020.31859@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2122299.b1UfvaGdkL";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Originating-IP: [10.100.200.204]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

--nextPart2122299.b1UfvaGdkL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Maciej,

On Saturday, 22 October 2016 10:08:57 BST Maciej W. Rozycki wrote:
> On Mon, 19 Sep 2016, Paul Burton wrote:
> > Make use of the generic syscon-reboot driver to reboot the Malta board,
> > reducing the amount of platform code it requires.
> > 
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > ---
> 
>  This has broken reboot support, all I get now is:
> 
> reboot: Restarting system
> Unable to restart system
> Reboot failed -- System halted
> 
> at which point I need to issue a serial BREAK to regain control of the
> board and get back to YAMON; fortunately the board is wired for that.

This was already reported over here:

https://www.linux-mips.org/archives/linux-mips/2016-10/msg00120.html 

These 2 patches fix it:

https://patchwork.linux-mips.org/patch/14395/ 
https://patchwork.linux-mips.org/patch/14396/ 

I've asked Ralf if we can get those, along with a few others, in ASAP - 
preferrably for -rc3.

Thanks,
    Paul
--nextPart2122299.b1UfvaGdkL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYDg/XAAoJEIIg2fppPBxljywQAKU1k+r1rWK1SAEHi91zUbWP
Fqozc3hh3zpoD27/NMMgePhq5kykNfz22qCpJcn2vy2Tp7mUXyt2Ei2jbqcSN7QJ
AuEbgkz9HOzLeX6uApIM5LuDsH4elOjor9+nTF+RHUec6LPDG5GEDa+4IArWdRAy
3KeCA9NBHgoxESopcOI8QqeWx/qfVuhjNnN6cJ4TJIS7D4MAa1TbYbx8OFEKbrwm
7JUyQMAtFYtrPZcEpwqy9HhiB7iiQ4luThVOqo7WXwH219blMYl8k6MhEI/VdWuK
6sUX/gu8G62w8ZARDdUSQBVlma1kHMscRWVmbr7GeuwtJP7TiylxoksiaTJXKveu
1BrG3VOaaNyCCmk1o6K30lAbxUA6eZxpx9AQWloHOEKGCHn3jJtbcUXgsocCJhTL
oe0csnI2U4vX/k/Dx0ISnn/5cEQV0u3vFJr2AP3J0Qo1GVTbVg2cKDk8H//Kx5B0
WE6ubQVTZuADcpVb5OAFk7JJ4BNYFDp/5I0kup7N8cOvhxkM4w/u+VciyjWiT32K
PJctBry8VFYR2Nz3n6PomciJE2EDFH2bFk3Zsf8JQ01lnYWx4PnIdSA2hbZwf+Bf
MMN7OIo4NMfEZ8FayQUZY4Lyi/yX9DOB4c02WAozPT/QRSJTqricF2/J/6SXHyTP
sATNafTu7TsG8547sOxq
=Ck9L
-----END PGP SIGNATURE-----

--nextPart2122299.b1UfvaGdkL--
