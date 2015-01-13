Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2015 10:44:12 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:38318 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010645AbbAMJoKYnywN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 13 Jan 2015 10:44:10 +0100
Received: from p4fe24f9a.dip0.t-ipconnect.de ([79.226.79.154]:53063 helo=localhost)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YAy1B-0005UZ-Gj; Tue, 13 Jan 2015 10:44:09 +0100
Date:   Tue, 13 Jan 2015 10:44:08 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     linux-i2c@vger.kernel.org
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] i2c: pmcmsp: remove dead code
Message-ID: <20150113094336.GA1059@katana>
References: <1420744740-26468-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <1420744740-26468-1-git-send-email-wsa@the-dreams.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45097
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2015 at 08:19:00PM +0100, Wolfram Sang wrote:
> CPPCHECK rightfully says:
>=20
> drivers/i2c/busses/i2c-pmcmsp.c:151: style: The function 'pmcmsptwi_reg_t=
o_clock' is never used.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Applied to for-next, thanks!


--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtOjoAAoJEBQN5MwUoCm2EIkP/RdYsRpy/YENBTaTLFILCMki
9IPu3ss4I1Dw1PopRIcGLgR/xK/CVevHE6pYLDxHlZp3F5mqJwaYTLXWcmsetLoH
7+OecBh7xEd3F7zGRAizroNhDu5DlP4b9QYyKYU99puTB+ItbPHTXWB1/ZQGifrS
IVJTkvJNaLHkhu9LE0hiHMMU8I7alLRU9J/iFrVV2CJxXeEhLD7ukUliPgLoiLof
cUTEoWDtETS/bzNKz4Axh6WzRFXNyW3H4YvIRgsWhoD4LNpxT4IwvSufIea1BiZp
UfqL7xursv3sWQOgWehmwOHb3f9f3GrTmF1mvhWc8jJKFX/yCA1bcqiugnfRkhhQ
7WWBN/wSmLLlIVlWoCHw04EuqPz2HkJityv/I6KyMw1d3PIhC499DLZYX4qCQV6k
UnAyUCmnJVqfqPDrTciQB8FUOGqOFhq2mpe7hidKcAL48BId6k5DZ5ZfrjONDLVL
Lpt37N8Aah4r1OfyXvMPBMfhiF/ygQ+018sKCZwpI0uMpFlx+rhFALXQFaulnHlQ
2NigVMXiWo1ZCk9HSCF5ghV9drQAu/IAmRnnGurlAIPFuBOJ+bfWvjVxfBsz+T4w
AsyBAR2zafae0lvGPg73oNlI43KaR3gaOkwvT21297D7Deu6ur/fCtJJyFRcUqW2
cLr9dRRDT5pLCM0dbGpb
=dtU8
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
