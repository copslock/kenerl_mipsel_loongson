Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 18 Dec 2004 23:37:24 +0000 (GMT)
Received: from nccn1.nccn.net ([IPv6:::ffff:209.79.220.11]:10387 "EHLO
	nccn1.nccn.net") by linux-mips.org with ESMTP id <S8225215AbULRXhT>;
	Sat, 18 Dec 2004 23:37:19 +0000
Received: from 192.168.0.100 (office.nccn.net [209.79.220.38])
	by nccn1.nccn.net (8.12.8/8.12.8/*SLiM* NO UCE! [V13]) with ESMTP id iBINb5EX031265
	for <linux-mips@linux-mips.org>; Sat, 18 Dec 2004 15:37:06 -0800
Subject: Build problem with drivers/net/au1000_eth.c
From: Josh Green <jgreen@users.sourceforge.net>
To: linux-mips@linux-mips.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sxP1ytOyqXfKYedZzYEh"
Date: Sat, 18 Dec 2004 15:36:33 -0800
Message-Id: <1103412993.9129.8.camel@SillyPuddy.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
Return-Path: <jgreen@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jgreen@users.sourceforge.net
Precedence: bulk
X-list: linux-mips


--=-sxP1ytOyqXfKYedZzYEh
Content-Type: multipart/mixed; boundary="=-f1n7npLtdgN2AUUC2GE4"


--=-f1n7npLtdgN2AUUC2GE4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I'm using latest linux-mips CVS kernel (2.6.10rc3) and GCC 3.4.2 on a
AMD Alchemy DBau1100 development board (mipsel/MIPS32).  I wasn't able
to find any other location to post bugs, so please let me know if there
is a bug system or more appropriate place to post this.  The kernel
build dies with:

  CC      drivers/net/au1000_eth.o
drivers/net/au1000_eth.c: In function `au1000_init_module':
drivers/net/au1000_eth.c:100: sorry, unimplemented: inlining failed in
call to 'str2eaddr': function body not available
drivers/net/au1000_eth.c:1506: sorry, unimplemented: called from here
drivers/net/au1000_eth.c: At top level:
drivers/net/au1000_eth.c:152: warning: 'phy_link' defined but not used
make[2]: *** [drivers/net/au1000_eth.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2


I was able to get things to build with the following patch, although I'm
sure this is not the proper way to do things:
$ cvs diff drivers/net/au1000_eth.c

Index: drivers/net/au1000_eth.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/cvs/linux/drivers/net/au1000_eth.c,v
retrieving revision 1.39
diff -r1.39 au1000_eth.c
100c100
< extern inline void str2eaddr(unsigned char *ea, unsigned char *str);
---
> extern void str2eaddr(unsigned char *ea, unsigned char *str);



I'm noticing another problem now though (a kernel oops), which could be
related to my little patch above.  I changed the definition of str2eaddr
in arch/mips/au1000/common/prom.c to also not be inline just to make
sure they matched.  I now get this oops which seems to appear/disappear
after enabling/disabling kernel options (although I have not been able
to trace it down to one particular feature).  This leads me to believe
it is some sort of alignment bug, which is what the exception refers to.
I have yet been able to build a ksymoops that will work properly, but
I'm still working on that.  If any one has any tips on how I can resolve
this issue I could use the help.  Raw oops output (not ksymoops yet) is
attached.

Best regards,
	Josh Green


--=-f1n7npLtdgN2AUUC2GE4
Content-Disposition: attachment; filename=au1000_init_oops.txt
Content-Type: text/plain; name=au1000_init_oops.txt; charset=ISO-8859-1
Content-Transfer-Encoding: base64

VW5oYW5kbGVkIGtlcm5lbCB1bmFsaWduZWQgYWNjZXNzIGluIGFyY2gvbWlwcy9rZXJuZWwvdW5h
bGlnbmVkLmM6OmVtdWxhdGVfbG9hZF9zdG9yZV9pbnNuLCBsaW5lIDQ3NVsjMV06DQpDcHUgMA0K
JCAwICAgOiAwMDAwMDAwMCAxMDAwZmMwMCA2ZTJmNzM3MyAwMDAwMDAwMA0KJCA0ICAgOiA4MDMw
MDAwMCA4MTBmMTQwMCAwMDAwMDAwMyBiMDUwMDAxNA0KJCA4ICAgOiAwMDAwNTYxYiA4MTBmMTQw
MCBiMDUwMDAxOCAwMDAwMDAwMA0KJDEyICAgOiA4MDM2ZmNmOCBmZmZmZmZmYSBmZmZmZmZmZiAw
MDAwMDAwYQ0KJDE2ICAgOiAwMDAwMDAyMiAwMDAwMDAwMSAwMDAwMDAyMCA4MTBmMTQwMA0KJDIw
ICAgOiA4MTBmMTYyMCAwMDAwZmZmZiA4MDMyNmNjYyBiMDUwMDAwMA0KJDI0ICAgOiAwMDAwMDAw
MSA4MTBiOWUxYQ0KJDI4ICAgOiA4MTBiODAwMCA4MTBiOWY0MCA4MTBmMTYyMCA4MDM1YTJmOA0K
SGkgICAgOiAwMDAzMDFmZg0KTG8gICAgOiBmYzg1YjAwMA0KZXBjICAgOiA4MDM1YTRkNCBhdTEw
MDBfaW5pdF9tb2R1bGUrMHg0YjgvMHg4YmMgICAgIE5vdCB0YWludGVkDQpyYSAgICA6IDgwMzVh
MmY4IGF1MTAwMF9pbml0X21vZHVsZSsweDJkYy8weDhiYw0KU3RhdHVzOiAxMDAwZmMwMyAgICBL
RVJORUwgRVhMIElFDQpDYXVzZSA6IDAwODAwMDEwDQpCYWRWQSA6IDZlMmY3MzczDQpQcklkICA6
IDAyMDMwMjA0DQpNb2R1bGVzIGxpbmtlZCBpbjoNClByb2Nlc3Mgc3dhcHBlciAocGlkOiAxLCB0
aHJlYWRpbmZvPTgxMGI4MDAwLCB0YXNrPTgxMGFkYjQ4KQ0KU3RhY2sgOiAzNzY4NzQ2NSA4MTBm
MTQwMCBiMDUwMDAwMCAwMDAwMDAxYyAxODFhMDAwMCA4MDM1YzJkNCAwMDAwMDAwMCAwMDAwMDAw
MA0KICAgICAgICAwMDAwMDAxYyA4MDM2ZmNmOCA4MDM2MTU4YyAwMDAwMDAwMCA4MDJmMDAwMCA4
MDJmMDAwMCA4MDM2MDAwMCA4MDM2MTViYw0KICAgICAgICA4MDJmMDAwMCA4MDJmMDAwMCA4MDMw
MDAwMCA4MDEwMDZmYyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMA0KICAgICAg
ICAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMCAwMDAwMDAwMA0KICAgICAgICAwMDAwMDAwMCA4MDEwNGQ1NCAxMDAwZmMwMyAwMDAw
MDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCA4MDEwNGQ0NA0KICAgICAgICAuLi4NCkNh
bGwgVHJhY2U6DQogWzw4MDM1YzJkND5dIGRldmluZXRfaW5pdCsweDI0LzB4NjQNCiBbPDgwMTAw
NmZjPl0gaW5pdCsweGM0LzB4MjU0DQogWzw4MDEwNGQ1ND5dIGtlcm5lbF90aHJlYWRfaGVscGVy
KzB4MTAvMHgxOA0KIFs8ODAxMDRkNDQ+XSBrZXJuZWxfdGhyZWFkX2hlbHBlcisweDAvMHgxOA0K
DQoNCkNvZGU6IDAwMDAwMDAwICA4YzQyMDAwNCAgM2MwNDgwMzAgPDhjNDYwMDAwPiAyNDg0MDhh
MCAgMGMwNDk5MjAgIDAwMDA4ODIxICAwMDAwMTAyMSAgMjY4NTAwMDQNCktlcm5lbCBwYW5pYyAt
IG5vdCBzeW5jaW5nOiBBdHRlbXB0ZWQgdG8ga2lsbCBpbml0IQ0K


--=-f1n7npLtdgN2AUUC2GE4--

--=-sxP1ytOyqXfKYedZzYEh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBxL8BRoMuWKCcbgQRAifUAJ0bo0mkXYmCVhxKpP2EUMSgXx2aMwCcCsS3
Twv8UwSXqC9AeMTURFJAtrs=
=/L2R
-----END PGP SIGNATURE-----

--=-sxP1ytOyqXfKYedZzYEh--
