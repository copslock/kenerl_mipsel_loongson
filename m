Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id NAA01143 for <linux-archive@neteng.engr.sgi.com>; Fri, 25 Jun 1999 13:33:08 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA90285
	for linux-list;
	Fri, 25 Jun 1999 13:31:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA11386
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 25 Jun 1999 13:31:14 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA07148
	for <linux@cthulhu.engr.sgi.com>; Fri, 25 Jun 1999 13:31:12 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id PAA07790
	for <linux@cthulhu.engr.sgi.com>; Fri, 25 Jun 1999 15:31:10 -0500
Date: Fri, 25 Jun 1999 15:41:11 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Here's another patch
In-Reply-To: <Pine.LNX.3.96.990625153832.14516B-100000@mdk187.tucc.uab.edu>
Message-ID: <Pine.LNX.3.96.990625154025.14516D-200000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="445303055-1059967903-930343271=:14516"
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--445303055-1059967903-930343271=:14516
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Fri, 25 Jun 1999, Andrew R. Baker wrote:
> 
> Could some of y'all try it out and make sure it doesn't break things?
> It is needed before we can support the second SCSI controller on the
> Indigo2.

And here is the message again, this time with the patch attached :)

-Andrew

--445303055-1059967903-930343271=:14516
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.96.990625154111.14516E@mdk187.tucc.uab.edu>
Content-Description: 

LS0tIHNnaXdkOTMuYy5vcmlnCUZyaSBKdW4gMjUgMTU6MzE6NTUgMTk5OQ0K
KysrIHNnaXdkOTMuYwlGcmkgSnVuIDI1IDE1OjMzOjQzIDE5OTkNCkBAIC03
MCw3ICs3MCw3IEBADQogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQogDQogCXNw
aW5fbG9ja19pcnFzYXZlKCZpb19yZXF1ZXN0X2xvY2ssIGZsYWdzKTsNCi0J
d2QzM2M5M19pbnRyKHNnaXdkOTNfaG9zdCk7DQorCXdkMzNjOTNfaW50cigo
c3RydWN0IFNjc2lfSG9zdCAqKSBkZXZfaWQpOw0KIAlzcGluX3VubG9ja19p
cnFyZXN0b3JlKCZpb19yZXF1ZXN0X2xvY2ssIGZsYWdzKTsNCiB9DQogDQpA
QCAtMjM2LDkgKzIzNiw5IEBADQogI2VuZGlmDQogfQ0KIA0KLXZvaWQgc2dp
d2Q5M19yZXNldCh2b2lkKQ0KK3ZvaWQgc2dpd2Q5M19yZXNldCh1Y2hhciAq
YmFzZSkNCiB7DQotCXN0cnVjdCBocGMzX3Njc2lyZWdzICpocmVncyA9ICZo
cGMzYzAtPnNjc2lfY2hhbjA7DQorCXN0cnVjdCBocGMzX3Njc2lyZWdzICpo
cmVncyA9IChzdHJ1Y3QgaHBjM19zY3NpcmVncyAqKSBiYXNlOw0KIA0KIAlo
cmVncy0+Y3RybCA9IEhQQzNfU0NUUkxfQ1JFU0VUOw0KIAl1ZGVsYXkgKDUw
KTsNCi0tLSB3ZDMzYzkzLmMub3JpZwlGcmkgSnVuIDI1IDE1OjI5OjI1IDE5
OTkNCisrKyB3ZDMzYzkzLmMJRnJpIEp1biAyNSAxNTozMDoyMiAxOTk5DQpA
QCAtMTM2Miw3ICsxMzYyLDcgQEANCiAjaWZkZWYgQ09ORklHX1NHSQ0KIHsN
CiBpbnQgYnVzeWNvdW50ID0gMDsNCi1leHRlcm4gdm9pZCBzZ2l3ZDkzX3Jl
c2V0KHZvaWQpOw0KK2V4dGVybiB2b2lkIHNnaXdkOTNfcmVzZXQodWNoYXIp
Ow0KIA0KICAgIC8qIHdhaXQgJ3RpbCB0aGUgY2hpcCBnZXRzIHNvbWUgdGlt
ZSBmb3IgdXMgKi8NCiAgICB3aGlsZSAoUkVBRF9BVVhfU1RBVCgpICYgQVNS
X0JTWSAmJiBidXN5Y291bnQrKyA8IDEwMCkNCkBAIC0xMzc2LDcgKzEzNzYs
NyBAQA0KICAgICAqLw0KICAgIC8qIHN0aWxsIGJ1c3kgPyAqLw0KICAgIGlm
IChSRUFEX0FVWF9TVEFUKCkgJiBBU1JfQlNZKQ0KLQlzZ2l3ZDkzX3Jlc2V0
KCk7IC8qIHllYWgsIGdpdmUgaXQgdGhlIGhhcmQgb25lICovDQorCXNnaXdk
OTNfcmVzZXQoaW5zdGFuY2UtPmJhc2UpOyAvKiB5ZWFoLCBnaXZlIGl0IHRo
ZSBoYXJkIG9uZSAqLw0KIH0NCiAjZW5kaWYNCiANCg==
--445303055-1059967903-930343271=:14516--
