Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2017 23:08:45 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:33625 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993910AbdKHWIin3LIr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Nov 2017 23:08:38 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 08 Nov 2017 22:07:45 +0000
Received: from localhost (192.168.154.110) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 8 Nov 2017
 14:03:24 -0800
Date:   Wed, 8 Nov 2017 22:03:22 +0000
From:   James Hogan <james.hogan@mips.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     <linux-mips@linux-mips.org>, <linux-serial@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Schichan <nschichan@freebox.fr>
Subject: Re: [PATCH 0/3] MIPS: AR7: assorted fixes
Message-ID: <20171108220322.GO15260@jhogan-linux>
References: <20171029152721.6770-1-jonas.gorski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8CNmCRe8Sh4keFKJ"
Content-Disposition: inline
In-Reply-To: <20171029152721.6770-1-jonas.gorski@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510178858-637138-27161-936463-5
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186734
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
X-archive-position: 60777
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

--8CNmCRe8Sh4keFKJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2017 at 04:27:18PM +0100, Jonas Gorski wrote:
> This patchset fixes a few issues found in AR7 that accumulated in the
> past few years. One was fixed for ages in OpenWrt/LEDE and never made
> it upstream, the others weren't noticed until now.
>=20
> Jonas Gorski (2):
>   MIPS: AR7: defer registration of GPIO
>   MIPS: AR7: ensure the port type's FCR value is used
>=20
> Oswald Buddenhagen (1):
>   MIPS: AR7: ensure that serial ports are properly set up

Thanks. Patches 1 + 2 applied for 4.14.

Cheers
James

--8CNmCRe8Sh4keFKJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloDfyIACgkQbAtpk944
dnpRvg/8DkL56Q6m1iZzJwFPkCJlh0eWskY1Mi6b3msAGViiB8YrP+wSxoscSv91
MDD0LNPEuu3azN5UCR1FAfSALPml3Mc7mU0+l4mBtpQcIonrQLIHb7p06qMWPLul
BU6/Lii9B+TBvTv+45W4IrwtRPX8Jik+FI1kjbO9HtugNgfTrIBNHZNiC9pM2MhM
E6ZGRd+RsD3/O+hTMrtu9PbD8j8LT0wZJseT8ythEup53sFG/XTEts+DfxEHnvoM
ueqPYG05R36ufDsotqOOGZI1EAREsc/33+qR8H6YOmPx4zAj1wIl+ILtM9Nm9WbJ
CeIaA9OwTUej8hayMhmfH5i7bRFgZt2Nx5RYjvL14sn9KGLAEZJDh3v+IXi7zSpe
hqOnlL69u7bpoFnET5LYm3sRUDGofL/5lg4hRVtcou8tOhdQgxsRhC9FHDC5aKwd
1xS9fI5orU5dEvmKbcjeyZtn0u+TfY5oZdqRUI2qtHMqMf6SanipO+zcZvNwDmcS
KTxrGKf2VIzvm9rLFH/VY/4vIgKhSMFF1JGljbIW/sPJ6Qr4PHdAxStfJY8KiIOa
P2gGxHRawOrLhAmfpXoWxqZ+eFhmn19KH6Cl9154zQORsc9DxYw75Pvh+kpnOGzB
c8NPvJp/0g4ZJvdKfMGGz8j+5LG5tv/QBotyw0lk+3Aj8mDCO6M=
=p972
-----END PGP SIGNATURE-----

--8CNmCRe8Sh4keFKJ--
