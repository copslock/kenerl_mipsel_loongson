Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Jan 2005 09:45:07 +0000 (GMT)
Received: from host51-186.pool80204.interbusiness.it ([IPv6:::ffff:80.204.186.51]:421
	"EHLO gate.exadron.com") by linux-mips.org with ESMTP
	id <S8225216AbVALJpC>; Wed, 12 Jan 2005 09:45:02 +0000
Received: from 10.0.10.57 ([10.0.10.57])
	by gate.exadron.com (8.12.7/8.12.7) with ESMTP id j0CA7pMM018499
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linux-mips@linux-mips.org>; Wed, 12 Jan 2005 11:07:52 +0100
Subject: [PATCH] au1x00 pm
From: Christian <c.pellegrin@exadron.com>
To: linux-mips@linux-mips.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-t+Exg8cnrip8AsVkFe11"
Date: Wed, 12 Jan 2005 10:40:39 +0100
Message-Id: <1105522839.5654.16.camel@absolute.ascensit.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Return-Path: <c.pellegrin@exadron.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: c.pellegrin@exadron.com
Precedence: bulk
X-list: linux-mips


--=-t+Exg8cnrip8AsVkFe11
Content-Type: multipart/mixed; boundary="=-yIwcPyenP3TuQxz4PcNi"


--=-yIwcPyenP3TuQxz4PcNi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

I'm working on a custom embedded board with the Alchemy au1100. I saw
that some code in the thunk is not up-to-date so I'm sending the patches
that I needed to make the kernel compile and work. Since this is my
first contribution please tell me if there's something wrong.=20

This patch fixes some compilation problems and reenables PM. Frequency
change and sleep is ok, need to work on bootloader to make suspend
work. =20

--=20
Christian <c.pellegrin@exadron.com>

--=-yIwcPyenP3TuQxz4PcNi
Content-Disposition: attachment; filename=pm1
Content-Type: text/x-patch; name=pm1; charset=UTF-8
Content-Transfer-Encoding: base64

SW5kZXg6IGFyY2gvbWlwcy9LY29uZmlnDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2hvbWUvY3Zz
L2xpbnV4L2FyY2gvbWlwcy9LY29uZmlnLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4xMjcNCmRp
ZmYgLXUgLXIxLjEyNyBLY29uZmlnDQotLS0gYXJjaC9taXBzL0tjb25maWcJMTIgSmFuIDIwMDUg
MDA6MTA6NDIgLTAwMDAJMS4xMjcNCisrKyBhcmNoL21pcHMvS2NvbmZpZwkxMiBKYW4gMjAwNSAw
OTowNDowMiAtMDAwMA0KQEAgLTk3MCw2ICs5NzAsOSBAQA0KIGNvbmZpZyBNSVBTX0RJU0FCTEVf
T0JTT0xFVEVfSURFDQogCWJvb2wNCiANCitjb25maWcgV1dQQw0KKwlib29sICJTdXBwb3J0IGZv
ciBXV1BDIg0KKw0KIGNvbmZpZyBDUFVfTElUVExFX0VORElBTg0KIAlib29sICJHZW5lcmF0ZSBs
aXR0bGUgZW5kaWFuIGNvZGUiDQogCWRlZmF1bHQgeSBpZiBBQ0VSX1BJQ0FfNjEgfHwgQ0FTSU9f
RTU1IHx8IEREQjUwNzQgfHwgRERCNTQ3NiB8fCBEREI1NDc3IHx8IE1BQ0hfREVDU1RBVElPTiB8
fCBJQk1fV09SS1BBRCB8fCBMQVNBVCB8fCBNSVBTX0NPQkFMVCB8fCBNSVBTX0lURTgxNzIgfHwg
TUlQU19JVlIgfHwgU09DX0FVMVgwMCB8fCBORUNfT1NQUkVZIHx8IE9MSVZFVFRJX003MDAgfHwg
U05JX1JNMjAwX1BDSSB8fCBWSUNUT1JfTVBDMzBYIHx8IFpBT19DQVBDRUxMQQ0KQEAgLTE1ODMs
NyArMTU4Niw3IEBADQogDQogY29uZmlnIFBNDQogCWJvb2wgIlBvd2VyIE1hbmFnZW1lbnQgc3Vw
cG9ydCAoRVhQRVJJTUVOVEFMKSINCi0JZGVwZW5kcyBvbiBFWFBFUklNRU5UQUwgJiYgTUFDSF9B
VTFYMDANCisJZGVwZW5kcyBvbiBFWFBFUklNRU5UQUwgJiYgU09DX0FVMVgwMA0KIA0KIGVuZG1l
bnUNCiANCkluZGV4OiBhcmNoL21pcHMvYXUxMDAwL2NvbW1vbi9wb3dlci5jDQo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
DQpSQ1MgZmlsZTogL2hvbWUvY3ZzL2xpbnV4L2FyY2gvbWlwcy9hdTEwMDAvY29tbW9uL3Bvd2Vy
LmMsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjE1DQpkaWZmIC11IC1yMS4xNSBwb3dlci5jDQot
LS0gYXJjaC9taXBzL2F1MTAwMC9jb21tb24vcG93ZXIuYwkyMCBBcHIgMjAwNCAxNTo1Mjo1MSAt
MDAwMAkxLjE1DQorKysgYXJjaC9taXBzL2F1MTAwMC9jb21tb24vcG93ZXIuYwkxMiBKYW4gMjAw
NSAwOTowNDo0OCAtMDAwMA0KQEAgLTM0LDYgKzM0LDcgQEANCiAjaW5jbHVkZSA8bGludXgvcG0u
aD4NCiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KICNpbmNsdWRlIDxsaW51eC9zeXNjdGwuaD4N
CisjaW5jbHVkZSA8bGludXgvamlmZmllcy5oPg0KIA0KICNpbmNsdWRlIDxhc20vc3RyaW5nLmg+
DQogI2luY2x1ZGUgPGFzbS91YWNjZXNzLmg+DQpJbmRleDogYXJjaC9taXBzL2F1MTAwMC9jb21t
b24vdGltZS5jDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2hvbWUvY3ZzL2xpbnV4L2FyY2gvbWlw
cy9hdTEwMDAvY29tbW9uL3RpbWUuYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMzENCmRpZmYg
LXUgLXIxLjMxIHRpbWUuYw0KLS0tIGFyY2gvbWlwcy9hdTEwMDAvY29tbW9uL3RpbWUuYwkxMCBK
YW4gMjAwNSAxMDoyMzozNiAtMDAwMAkxLjMxDQorKysgYXJjaC9taXBzL2F1MTAwMC9jb21tb24v
dGltZS5jCTEyIEphbiAyMDA1IDA5OjA0OjU0IC0wMDAwDQpAQCAtMTIzLDcgKzEyMyw3IEBADQog
CWludCB0aW1lX2VsYXBzZWQ7DQogCXN0YXRpYyBpbnQgamlmZmllX2RyaWZ0ID0gMDsNCiANCi0J
a3N0YXQuaXJxc1swXVtpcnFdKys7DQorCWtzdGF0X3RoaXNfY3B1LmlycXNbaXJxXSsrOw0KIAlp
ZiAoYXVfcmVhZGwoU1lTX0NPVU5URVJfQ05UUkwpICYgU1lTX0NOVFJMX00yMCkgew0KIAkJLyog
c2hvdWxkIG5ldmVyIGhhcHBlbiEgKi8NCiAJCXByaW50ayhLRVJOX1dBUk5JTkcgImNvdW50ZXIg
MCB3IHN0YXR1cyBlcm9yXG4iKTsNCg==


--=-yIwcPyenP3TuQxz4PcNi--

--=-t+Exg8cnrip8AsVkFe11
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB5PCXq26xP1xKlLcRAlZ7AKCLvl8XdK+f7RjsSHQHdks7xnZAYACgk1dA
xE53k9MCK/mv1H+z+wfLL9s=
=Aywb
-----END PGP SIGNATURE-----

--=-t+Exg8cnrip8AsVkFe11--
