Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Dec 2004 02:55:35 +0000 (GMT)
Received: from mail-relay.infostations.net ([IPv6:::ffff:69.19.152.5]:32670
	"EHLO mail-relay.infostations.net") by linux-mips.org with ESMTP
	id <S8225229AbULTCz2>; Mon, 20 Dec 2004 02:55:28 +0000
Received: from seriyu.infostations.net (seriyu.infostations.net [71.4.40.35])
	by mail-relay.infostations.net (Postfix) with ESMTP id 631D1F70BC
	for <linux-mips@linux-mips.org>; Mon, 20 Dec 2004 02:54:39 +0000 (Local time zone must be set--see zic manual page)
Received: from host-66-81-138-241.rev.o1.com ([66.81.138.241])
	by seriyu.infostations.net with esmtp (Exim 4.41 #1 (Gentoo))
	id 1CgDhY-0006Qq-UL
	for <linux-mips@linux-mips.org>; Sun, 19 Dec 2004 18:55:14 -0800
Subject: Fixes to drivers/net/au1000_eth.c
From: Josh Green <jgreen@users.sourceforge.net>
To: linux-mips@linux-mips.org
In-Reply-To: <1103412993.9129.8.camel@SillyPuddy.localdomain>
References: <1103412993.9129.8.camel@SillyPuddy.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6LjiaEgGP55s2qTToT6/"
Date: Sun, 19 Dec 2004 18:54:28 -0800
Message-Id: <1103511268.15414.15.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips


--=-6LjiaEgGP55s2qTToT6/
Content-Type: multipart/mixed; boundary="=-SQvlWiq0lT4r9NBZ6h/n"


--=-SQvlWiq0lT4r9NBZ6h/n
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-12-18 at 15:36 -0800, Josh Green wrote:
> I'm using latest linux-mips CVS kernel (2.6.10rc3) and GCC 3.4.2 on a
> AMD Alchemy DBau1100 development board (mipsel/MIPS32).  I wasn't able
> to find any other location to post bugs, so please let me know if there
> is a bug system or more appropriate place to post this.

I'm replying to my own post, since I discovered what was causing the
kernel oops with the au1000_eth.c driver.  The attached patch fixes 3
problems:

- The build problem with extern inline str2eaddr.  I just made it
non-inline, although I'm not sure if this is the best way to resolve the
issue.

- At the end of mii_probe(): aup->mii is checked to indicate whether an
ethernet device was found or not, this variable will actually always be
set, which leads to a crash when aup->mii->chip_info->name is accessed
in code following it (in the case where no device is detected).
aup->mii->chip_info seems like a better test, although I'm not positive
on that one.

- In au1000_probe() 'sizeof(dev->dev_addr)' was being used in memcpy
when copying ethernet MAC addresses.  This size is currently 32 which is
larger than the 6 byte buffers being used in the copies, leading to
kernel oopses.

If I should be sending this to the author of the driver or some other
location, please let me know. Best regards,
	Josh Green


--=-SQvlWiq0lT4r9NBZ6h/n
Content-Disposition: attachment; filename=au1000_eth_fixes.patch
Content-Type: text/x-patch; name=au1000_eth_fixes.patch; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SW5kZXg6IGFyY2gvbWlwcy9hdTEwMDAvY29tbW9uL3Byb20uYw0KPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNTIGZp
bGU6IC9ob21lL2N2cy9saW51eC9hcmNoL21pcHMvYXUxMDAwL2NvbW1vbi9wcm9tLmMsdg0KcmV0
cmlldmluZyByZXZpc2lvbiAxLjEyDQpkaWZmIC1yMS4xMiBwcm9tLmMNCjExNWMxMTUNCjwgaW5s
aW5lIHZvaWQgc3RyMmVhZGRyKHVuc2lnbmVkIGNoYXIgKmVhLCB1bnNpZ25lZCBjaGFyICpzdHIp
DQotLS0NCj4gdm9pZCBzdHIyZWFkZHIodW5zaWduZWQgY2hhciAqZWEsIHVuc2lnbmVkIGNoYXIg
KnN0cikNCkluZGV4OiBkcml2ZXJzL25ldC9hdTEwMDBfZXRoLmMNCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClJDUyBm
aWxlOiAvaG9tZS9jdnMvbGludXgvZHJpdmVycy9uZXQvYXUxMDAwX2V0aC5jLHYNCnJldHJpZXZp
bmcgcmV2aXNpb24gMS4zOQ0KZGlmZiAtcjEuMzkgYXUxMDAwX2V0aC5jDQoxMDAsMTAxYzEwMA0K
PCBleHRlcm4gaW5saW5lIHZvaWQgc3RyMmVhZGRyKHVuc2lnbmVkIGNoYXIgKmVhLCB1bnNpZ25l
ZCBjaGFyICpzdHIpOw0KPCBleHRlcm4gaW5saW5lIHVuc2lnbmVkIGNoYXIgc3RyMmhleG51bSh1
bnNpZ25lZCBjaGFyIGMpOw0KLS0tDQo+IGV4dGVybiB2b2lkIHN0cjJlYWRkcih1bnNpZ25lZCBj
aGFyICplYSwgdW5zaWduZWQgY2hhciAqc3RyKTsNCjEwNDVjMTA0NA0KPCAJaWYgKGF1cC0+bWlp
ID09IE5VTEwpIHsNCi0tLQ0KPiAJaWYgKGF1cC0+bWlpLT5jaGlwX2luZm8gPT0gTlVMTCkgew0K
MTQ5N2MxNDk2DQo8IAkJCW1lbWNweShhdTEwMDBfbWFjX2FkZHIsIGV0aGFkZHIsIHNpemVvZihk
ZXYtPmRldl9hZGRyKSk7DQotLS0NCj4gCQkJbWVtY3B5KGF1MTAwMF9tYWNfYWRkciwgZXRoYWRk
ciwgc2l6ZW9mKGF1MTAwMF9tYWNfYWRkcikpOw0KMTUwOGMxNTA3DQo8IAkJCQkJCXNpemVvZihk
ZXYtPmRldl9hZGRyKSk7DQotLS0NCj4gCQkJCQkJc2l6ZW9mKGF1MTAwMF9tYWNfYWRkcikpOw0K
MTUxM2MxNTEyDQo8IAkJbWVtY3B5KGRldi0+ZGV2X2FkZHIsIGF1MTAwMF9tYWNfYWRkciwgc2l6
ZW9mKGRldi0+ZGV2X2FkZHIpKTsNCi0tLQ0KPiAJCW1lbWNweShkZXYtPmRldl9hZGRyLCBhdTEw
MDBfbWFjX2FkZHIsIHNpemVvZihhdTEwMDBfbWFjX2FkZHIpKTsNCjE1MjNjMTUyMg0KPCAJCW1l
bWNweShkZXYtPmRldl9hZGRyLCBhdTEwMDBfbWFjX2FkZHIsIHNpemVvZihkZXYtPmRldl9hZGRy
KSk7DQotLS0NCj4gCQltZW1jcHkoZGV2LT5kZXZfYWRkciwgYXUxMDAwX21hY19hZGRyLCBzaXpl
b2YoYXUxMDAwX21hY19hZGRyKSk7DQo=


--=-SQvlWiq0lT4r9NBZ6h/n--

--=-6LjiaEgGP55s2qTToT6/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBxj7jRoMuWKCcbgQRAlmAAJ9HFwYFOXooHpMwByXpE5PoMpc0VwCfRK/K
1ZtCKN+beVQh+iHcVSlCroA=
=xbyA
-----END PGP SIGNATURE-----

--=-6LjiaEgGP55s2qTToT6/--
