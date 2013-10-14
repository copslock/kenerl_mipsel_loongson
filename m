Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Oct 2013 10:41:35 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:48426 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816642Ab3JNIlbpjwzL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Oct 2013 10:41:31 +0200
Message-ID: <525BADFB.4070601@imgtec.com>
Date:   Mon, 14 Oct 2013 09:40:27 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        <linux-mips@linux-mips.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: stack protector: Fix per-task canary switch
References: <1381144466-19736-1-git-send-email-james.hogan@imgtec.com> <20131007124859.GF3098@linux-mips.org> <20131010231617.GI4301@kroah.com>
In-Reply-To: <20131010231617.GI4301@kroah.com>
X-Enigmail-Version: 1.5.2
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="f4cWQ6IOHFSdwW7FDOpeEuVlXW5wMM18L"
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2013_10_14_09_41_26
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38318
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

--f4cWQ6IOHFSdwW7FDOpeEuVlXW5wMM18L
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On 11/10/13 00:16, Greg KH wrote:
> On Mon, Oct 07, 2013 at 02:48:59PM +0200, Ralf Baechle wrote:
>> On Mon, Oct 07, 2013 at 12:14:26PM +0100, James Hogan wrote:
>>
>>> Ralf: This is a regression in v3.11, so please consider for v3.12.
>>
>> Applied, will send to Linus with the next pull request.
>=20
> Which would be in time for 3.12-final, right?

Yes, it's included in v3.12-rc5 as:
8b3c569a3999a8fd5a819f892525ab5520777c92

>> stable folks - please apply to 3.12-stable.
>=20
> There is no 3.12-stable yet, as 3.12-final isn't out yet.
>=20
> Confused,

I think Ralf meant v3.11-stable. It's only needed there as the
regression was introduced in v3.11-rc1.

Thanks
James


--f4cWQ6IOHFSdwW7FDOpeEuVlXW5wMM18L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBAgAGBQJSW64BAAoJEKHZs+irPybf6ZMP/RCQSAsOIOTSL8Wqdl3RjyRG
hzmWQZws8Dl7gpc93jwNd3nKyqkm2UPmQJgfKY2xDvD8+3y94TEUU/JXYE1Djkmr
Om4tXngwFQ0g0Xpy5wQ4KoSaBeAM6172voRBzzD5z+hg10RMPEAoixrW4hl4SU6I
rZj4ZHI/G9rI4XrznYRcSKkEaYzW1pgOzlojs9Dd0xGurPbm8cE70usVQ1Dhel8c
DV+40Ku63gEDDUyCX0cI4DzLOMAHt1+giSIsFysekuhb+9CjliPQLivPLdZpwSuL
b3rqhWhx2XHOaQ7qJdfPiYK3P6fb5I25YCj2cKh9klZ/I+ksN+cuxHOwqGwG3oAl
Otlg0NhS8xPj7derzCkovNoJeSvsfAAZWlQgDLfkw+iuS/KCd1KlABzO4AgKW6yg
EWRwvIKIrQt9qGGWno4IhRisJ6lT3V+fxI7qJclxUrrq1Yd3H1q/YmMmnvcr3LMM
Y1Bz2g8CL6DimwbOsoR+/m3z0DgAY69zUcMGwjinZjbRVYeBOGV5rQ54BkywKU2N
AjJoD+qXDy3tbjshH6kA9vmmmSQFWHvPKk9wqeCmCs/FeFaxPKd5A0gbUebyigCa
wxj2zY5pgIaX1h4QOj69eomoM6yguw4kUQ0ROddgJWwFEXXBUHHGBEpVsr9Y4BQ9
PNI/2vA2PrTQAljmS8jp
=lqpH
-----END PGP SIGNATURE-----

--f4cWQ6IOHFSdwW7FDOpeEuVlXW5wMM18L--
