Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Feb 2005 00:42:40 +0000 (GMT)
Received: from mail-relay.infostations.net ([IPv6:::ffff:69.19.152.5]:40425
	"EHLO mail-relay.infostations.net") by linux-mips.org with ESMTP
	id <S8225323AbVBWAmY>; Wed, 23 Feb 2005 00:42:24 +0000
Received: from seriyu.infostations.net (seriyu.infostations.net [71.4.40.35])
	by mail-relay.infostations.net (Postfix) with ESMTP id 3AFF79F822
	for <linux-mips@linux-mips.org>; Tue, 22 Feb 2005 16:42:24 -0800 (PST)
Received: from host-69-19-148-86.rev.o1.com ([69.19.148.86])
	by seriyu.infostations.net with esmtp (Exim 4.41 #1)
	id 1D3kbb-0000Uz-VF
	for <linux-mips@linux-mips.org>; Tue, 22 Feb 2005 16:42:21 -0800
From:	Josh Green <jgreen@users.sourceforge.net>
To:	mips-linux@mips-linux.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-lmo4fQnamer33EKbJefb"
Message-Id: <1109119128.27702.12.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
Subject: Memory allocation problem with iptables and NAT
Resent-From: Josh Green <jgreen@users.sourceforge.net>
Resent-To: linux-mips@linux-mips.org
Date:	Tue, 22 Feb 2005 16:43:56 -0800
X-Mailer: Evolution 2.0.2 
Resent-Message-Id: <20050223004224.3AFF79F822@mail-relay.infostations.net>
Resent-Date: Tue, 22 Feb 2005 16:42:24 -0800 (PST)
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips


--=-lmo4fQnamer33EKbJefb
Content-Type: multipart/mixed; boundary="=-556lHh5vBz+RX6GxOpWX"


--=-556lHh5vBz+RX6GxOpWX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm not yet sure if this is a problem with the Linux MIPS platform in
particular, but I thought I would probe to see if anyone else has
experienced this.  I'm using an AMD Alchemy db1100 board with a CVS
checkout from a few weeks back of the mips-linux kernel (2.6.11 rc2).

I can insert the ip_tables and iptable_nat modules fine.  But the
following iptables command fails:

# iptables -t nat -F
iptables v1.3.0: can't initialize iptables table `nat': Memory
allocation problem
Perhaps iptables or your kernel needs to be upgraded.


I did an strace and came up with the attached output. Of particular
interest is this call:

old_mmap(NULL, 1651212288, PROT_READ|PROT_WRITE, MAP_PRIVATE|
MAP_ANONYMOUS, 0, 0) =3D -1 ENOMEM (Cannot allocate memory)

Wow, seems something is trying to mmap over 1.6GB of data.  If anyone
has any tips on why this is happening I would appreciate the input.
	Best regards,
	Josh Green


--=-556lHh5vBz+RX6GxOpWX
Content-Disposition: attachment; filename=iptables_strace.txt
Content-Type: text/plain; name=iptables_strace.txt; charset=ISO-8859-1
Content-Transfer-Encoding: base64

IyBzdHJhY2UgaXB0YWJsZXMgLXQgbmF0IC1GDQpleGVjdmUoIi91c3Ivc2Jpbi9pcHRhYmxlcyIs
IFsiaXB0YWJsZXMiLCAiLXQiLCAibmF0IiwgIi1GIl0sIFsvKiAxNiB2YXJzICovXSkgPSAwDQpp
b2N0bCgwLCBUSU9DTlhDTCwge0IxMTUyMDAgb3Bvc3QgaXNpZyBpY2Fub24gLWVjaG8gLi4ufSkg
PSAwDQppb2N0bCgxLCBUSU9DTlhDTCwge0IxMTUyMDAgb3Bvc3QgaXNpZyBpY2Fub24gLWVjaG8g
Li4ufSkgPSAwDQpzb2NrZXQoUEZfSU5FVCwgU09DS19SQVcsIElQUFJPVE9fUkFXKSAgPSA0DQpn
ZXRzb2Nrb3B0KDQsIFNPTF9JUCwgMHg0MCAvKiBJUF8/Pz8gKi8sICJuYXRcMFwwXDBcMFwwXDBc
MFwwXDBcMFwwXDBcMFwwXDBcMFwwXDBcMFwwXDBcMFwwXDBcMFwwIi4uLiwgWzg0XSkgPSAwDQpi
cmsoMCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDEwMDA3MDAwDQpicmso
MHgxMDAwODAwMCkgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDEwMDA4MDAwDQpvbGRfbW1h
cChOVUxMLCAxNjUxMjEyMjg4LCBQUk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8TUFQ
X0FOT05ZTU9VUywgMCwgMCkgPSAtMSBFTk9NRU0gKENhbm5vdCBhbGxvY2F0ZSBtZW1vcnkpDQpi
cmsoMHg3MjZiZjAwMCkgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDEwMDA4MDAwDQpvbGRf
bW1hcChOVUxMLCAxNjUxMjEyMjg4LCBQUk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8
TUFQX0FOT05ZTU9VUywgMCwgMCkgPSAtMSBFTk9NRU0gKENhbm5vdCBhbGxvY2F0ZSBtZW1vcnkp
DQpjbG9zZSg0KSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwDQpvcGVuKCIvcHJv
Yy9zeXMva2VybmVsL21vZHByb2JlIiwgT19SRE9OTFkpID0gNA0KcmVhZCg0LCAiL3NiaW4vbW9k
cHJvYmVcbiIsIDEwMjQpICAgICAgID0gMTUNCmNsb3NlKDQpICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICA9IDANCmZvcmsoKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9
IDEwNDENCndhaXQ0KC0xLCBbV0lGRVhJVEVEKHMpICYmIFdFWElUU1RBVFVTKHMpID09IDBdLCAw
LCBOVUxMKSA9IDEwNDENCi0tLSBTSUdDSExEIChDaGlsZCBleGl0ZWQpIEAgMCAoMCkgLS0tDQpz
b2NrZXQoUEZfSU5FVCwgU09DS19SQVcsIElQUFJPVE9fUkFXKSAgPSA0DQpnZXRzb2Nrb3B0KDQs
IFNPTF9JUCwgMHg0MCAvKiBJUF8/Pz8gKi8sICJuYXRcMFwwXDBcMFwwXDBcMFwwXDBcMFwwXDBc
MFwzNDBcMjU2XDBcMjBcMFwwXDBcMFwzMFw0Ii4uLiwgWzg0XSkgPSAwDQpvbGRfbW1hcChOVUxM
LCAxNjUxMjEyMjg4LCBQUk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0FOT05Z
TU9VUywgMCwgMCkgPSAtMSBFTk9NRU0gKENhbm5vdCBhbGxvY2F0ZSBtZW1vcnkpDQpicmsoMHg3
MjZiZjAwMCkgICAgICAgICAgICAgICAgICAgICAgICAgPSAweDEwMDA4MDAwDQpvbGRfbW1hcChO
VUxMLCAxNjUxMjEyMjg4LCBQUk9UX1JFQUR8UFJPVF9XUklURSwgTUFQX1BSSVZBVEV8TUFQX0FO
T05ZTU9VUywgMCwgMCkgPSAtMSBFTk9NRU0gKENhbm5vdCBhbGxvY2F0ZSBtZW1vcnkpDQpjbG9z
ZSg0KSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPSAwDQp3cml0ZSgyLCAiaXB0YWJs
ZXMiLCA4aXB0YWJsZXMpICAgICAgICAgICAgICAgICA9IDgNCndyaXRlKDIsICIgdiIsIDIgdikg
ICAgICAgICAgICAgICAgICAgICAgID0gMg0Kd3JpdGUoMiwgIjEuMy4wIiwgNTEuMy4wKSAgICAg
ICAgICAgICAgICAgICAgPSA1DQp3cml0ZSgyLCAiOiAiLCAyOiApICAgICAgICAgICAgICAgICAg
ICAgICA9IDINCndyaXRlKDIsICJjYW5cJ3QgaW5pdGlhbGl6ZSBpcHRhYmxlcyB0YWJsZSAiLi4u
LCAzM2Nhbid0IGluaXRpYWxpemUgaXB0YWJsZXMgdGFibGUgYCkgPSAzMw0Kd3JpdGUoMiwgIm5h
dCIsIDNuYXQpICAgICAgICAgICAgICAgICAgICAgID0gMw0Kd3JpdGUoMiwgIlwnOiAiLCAzJzog
KSAgICAgICAgICAgICAgICAgICAgID0gMw0Kd3JpdGUoMiwgIk1lbW9yeSBhbGxvY2F0aW9uIHBy
b2JsZW0iLCAyNU1lbW9yeSBhbGxvY2F0aW9uIHByb2JsZW0pID0gMjUNCndyaXRlKDIsICJcbiIs
IDENCikgICAgICAgICAgICAgICAgICAgICAgID0gMQ0Kd3JpdGUoMiwgIlBlcmhhcHMgaXB0YWJs
ZXMgb3IgeW91ciBrZXJuZWwgIi4uLiwgNTRQZXJoYXBzIGlwdGFibGVzIG9yIHlvdXIga2VybmVs
IG5lZWRzIHRvIGJlIHVwZ3JhZGVkLg0KKSA9IDU0DQpleGl0KDMpICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgPSA/DQo=


--=-556lHh5vBz+RX6GxOpWX--

--=-lmo4fQnamer33EKbJefb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCG9CXRoMuWKCcbgQRAuIEAJsEbq3+Uw+XfX4s8t75i2ZiwC7t8gCfbAUW
ErKfR8aDZAk2YL9a7K1UVbQ=
=bqul
-----END PGP SIGNATURE-----

--=-lmo4fQnamer33EKbJefb--
