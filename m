Received: from dns1.rz.fh-heilbronn.de (dns1.rz.fh-heilbronn.de [141.7.1.18])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id TAA23874
	for <pstadt@stud.fh-heilbronn.de>; Thu, 1 Jul 1999 19:02:59 +0200
Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by dns1.rz.fh-heilbronn.de (8.8.8/8.8.5) with ESMTP id SAA16129
	for <pstadt@stud.fh-heilbronn.de>; Thu, 1 Jul 1999 18:03:34 +0200 (MET DST)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id IAA23762; Thu, 1 Jul 1999 08:59:21 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA85961
	for linux-list;
	Thu, 1 Jul 1999 08:55:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA74698
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 1 Jul 1999 08:55:19 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id IAA04480
	for <linux@cthulhu.engr.sgi.com>; Thu, 1 Jul 1999 08:55:15 -0700 (PDT)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id KAA00478
	for <linux@cthulhu.engr.sgi.com>; Thu, 1 Jul 1999 10:33:55 -0500
Date: Thu, 1 Jul 1999 11:05:19 -0500 (CDT)
From: "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To: Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Latest Indigo2 SCSI patch
In-Reply-To: <Pine.LNX.3.96.990701094704.3088B-100000@mdk187.tucc.uab.edu>
Message-ID: <Pine.LNX.3.96.990701103639.3088C-200000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="445303055-1189053499-930845119=:3088"
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--445303055-1189053499-930845119=:3088
Content-Type: TEXT/PLAIN; charset=US-ASCII


OK, eventually I will remember to attach the patch with my announcements.

On Thu, 1 Jul 1999, Andrew R. Baker wrote:
> 
> Could Indigo2 and Indy users try this patch out?  It gets the second SCSI
> controller up and running on the Indigo2.  If there are no complaints, I
> am going to put it into the CVS tree.
> 
> -Andrew
> 

--445303055-1189053499-930845119=:3088
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=patch
Content-ID: <Pine.LNX.3.96.990701110519.3088D@mdk187.tucc.uab.edu>
Content-Description: 
Content-Transfer-Encoding: BASE64

LS0tIHNnaXdkOTMuYy5vcmlnCUZyaSBKdW4gMjUgMTU6MzE6NTUgMTk5OQ0K
KysrIHNnaXdkOTMuYwlUdWUgSnVuIDI5IDEzOjIxOjU4IDE5OTkNCkBAIC00
Myw2ICs0Myw3IEBADQogfTsNCiANCiBzdHJ1Y3QgU2NzaV9Ib3N0ICpzZ2l3
ZDkzX2hvc3QgPSBOVUxMOw0KK3N0cnVjdCBTY3NpX0hvc3QgKnNnaXdkOTNf
aG9zdDEgPSBOVUxMOw0KIA0KIC8qIFd1ZmYgd3VmZiwgd3VmZiwgd2QzM2M5
My5jLCB3dWZmIHd1ZmYsIG9iamVjdCBvcmllbnRlZCwgYm93IHdvdy4gKi8N
CiBzdGF0aWMgaW5saW5lIHZvaWQgd3JpdGVfd2QzM2M5M19jb3VudCh3ZDMz
YzkzX3JlZ3MgKnJlZ3AsIHVuc2lnbmVkIGxvbmcgdmFsdWUpDQpAQCAtNzAs
NyArNzEsNyBAQA0KIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KIA0KIAlzcGlu
X2xvY2tfaXJxc2F2ZSgmaW9fcmVxdWVzdF9sb2NrLCBmbGFncyk7DQotCXdk
MzNjOTNfaW50cihzZ2l3ZDkzX2hvc3QpOw0KKwl3ZDMzYzkzX2ludHIoKHN0
cnVjdCBTY3NpX0hvc3QgKikgZGV2X2lkKTsNCiAJc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmaW9fcmVxdWVzdF9sb2NrLCBmbGFncyk7DQogfQ0KIA0KQEAg
LTIzNiw5ICsyMzcsOSBAQA0KICNlbmRpZg0KIH0NCiANCi12b2lkIHNnaXdk
OTNfcmVzZXQodm9pZCkNCit2b2lkIHNnaXdkOTNfcmVzZXQodWNoYXIgKmJh
c2UpDQogew0KLQlzdHJ1Y3QgaHBjM19zY3NpcmVncyAqaHJlZ3MgPSAmaHBj
M2MwLT5zY3NpX2NoYW4wOw0KKwlzdHJ1Y3QgaHBjM19zY3NpcmVncyAqaHJl
Z3MgPSAoc3RydWN0IGhwYzNfc2NzaXJlZ3MgKikgYmFzZTsNCiANCiAJaHJl
Z3MtPmN0cmwgPSBIUEMzX1NDVFJMX0NSRVNFVDsNCiAJdWRlbGF5ICg1MCk7
DQpAQCAtMjY2LDkgKzI2NywxMSBAQA0KIHsNCiAJc3RhdGljIHVuc2lnbmVk
IGNoYXIgY2FsbGVkID0gMDsNCiAJc3RydWN0IGhwYzNfc2NzaXJlZ3MgKmhy
ZWdzID0gJmhwYzNjMC0+c2NzaV9jaGFuMDsNCisJc3RydWN0IGhwYzNfc2Nz
aXJlZ3MgKmhyZWdzMSA9ICZocGMzYzAtPnNjc2lfY2hhbjE7DQogCXN0cnVj
dCBXRDMzQzkzX2hvc3RkYXRhICpoZGF0YTsNCisJc3RydWN0IFdEMzNDOTNf
aG9zdGRhdGEgKmhkYXRhMTsNCiAJdWNoYXIgKmJ1ZjsNCi0NCisJDQogCWlm
KGNhbGxlZCkNCiAJCXJldHVybiAwOyAvKiBTaG91bGQgYml0Y2ggb24gdGhl
IGNvbnNvbGUgYWJvdXQgdGhpcy4uLiAqLw0KIA0KQEAgLTI4MSw3ICsyODQs
NyBAQA0KIAlidWYgPSAodWNoYXIgKikgZ2V0X2ZyZWVfcGFnZShHRlBfS0VS
TkVMKTsNCiAJaW5pdF9ocGNfY2hhaW4oYnVmKTsNCiAJZG1hX2NhY2hlX3di
YWNrX2ludigodW5zaWduZWQgbG9uZykgYnVmLCBQQUdFX1NJWkUpOw0KLQ0K
KwkvKiBIUENfU0NTSV9SRUcwIHwgMHgwMyB8IEtTRUcxICovDQogCXdkMzNj
OTNfaW5pdChzZ2l3ZDkzX2hvc3QsICh3ZDMzYzkzX3JlZ3MgKikgMHhiZmJj
MDAwMywNCiAJCSAgICAgZG1hX3NldHVwLCBkbWFfc3RvcCwgV0QzM0M5M19G
U18xNl8yMCk7DQogDQpAQCAtMjkxLDYgKzI5NCwyNyBAQA0KIAlkbWFfY2Fj
aGVfd2JhY2tfaW52KCh1bnNpZ25lZCBsb25nKSBidWYsIFBBR0VfU0laRSk7
DQogDQogCXJlcXVlc3RfaXJxKDEsIHNnaXdkOTNfaW50ciwgMCwgIlNHSSBX
RDkzIiwgKHZvaWQgKikgc2dpd2Q5M19ob3N0KTsNCisgICAgICAgIC8qIHNl
dCB1cCBzZWNvbmQgY29udHJvbGxlciBvbiB0aGUgSW5kaWdvMiAqLw0KKwlp
Zighc2dpX2d1aW5lc3MpIHsNCisJCXNnaXdkOTNfaG9zdDEgPSBzY3NpX3Jl
Z2lzdGVyKEhQc1VYLCBzaXplb2Yoc3RydWN0IFdEMzNDOTNfaG9zdGRhdGEp
KTsNCisJCXNnaXdkOTNfaG9zdDEtPmJhc2UgPSAodW5zaWduZWQgY2hhciAq
KSBocmVnczE7DQorCQlzZ2l3ZDkzX2hvc3QxLT5pcnEgPSAyOw0KKw0KKwkJ
YnVmID0gKHVjaGFyICopIGdldF9mcmVlX3BhZ2UoR0ZQX0tFUk5FTCk7DQor
CQlpbml0X2hwY19jaGFpbihidWYpOw0KKwkJZG1hX2NhY2hlX3diYWNrX2lu
digodW5zaWduZWQgbG9uZykgYnVmLCBQQUdFX1NJWkUpOw0KKwkJLyogSFBD
X1NDU0lfUkVHMSB8IDB4MDMgfCBLU0VHMSAqLw0KKwkJd2QzM2M5M19pbml0
KHNnaXdkOTNfaG9zdDEsICh3ZDMzYzkzX3JlZ3MgKikgMHhiZmJjODAwMywN
CisJCQkgICAgIGRtYV9zZXR1cCwgZG1hX3N0b3AsIFdEMzNDOTNfRlNfMTZf
MjApOw0KKw0KKwkJaGRhdGExID0gKHN0cnVjdCBXRDMzQzkzX2hvc3RkYXRh
ICopc2dpd2Q5M19ob3N0MS0+aG9zdGRhdGE7DQorCQloZGF0YTEtPm5vX3N5
bmMgPSAwOw0KKwkJaGRhdGExLT5kbWFfYm91bmNlX2J1ZmZlciA9ICh1Y2hh
ciAqKSAoS1NFRzFBRERSKGJ1ZikpOw0KKwkJZG1hX2NhY2hlX3diYWNrX2lu
digodW5zaWduZWQgbG9uZykgYnVmLCBQQUdFX1NJWkUpOw0KKw0KKwkJcmVx
dWVzdF9pcnEoMiwgc2dpd2Q5M19pbnRyLCAwLCAiU0dJIFdEOTMiLCAodm9p
ZCAqKSBzZ2l3ZDkzX2hvc3QxKTsNCisJfQ0KKwkNCiAJY2FsbGVkID0gMTsN
CiANCiAJcmV0dXJuIDE7IC8qIEZvdW5kIG9uZS4gKi8NCi0tLSB3ZDMzYzkz
LmMub3JpZwlGcmkgSnVuIDI1IDE1OjI5OjI1IDE5OTkNCisrKyB3ZDMzYzkz
LmMJVHVlIEp1biAyOSAxMzoxNTo0NiAxOTk5DQpAQCAtMTAyOCw3ICsxMDI4
LDcgQEANCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBob3N0ZGF0YS0+
c3luY194ZmVyW2NtZC0+dGFyZ2V0XSA9IGlkOw0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIH0NCiAjaWZkZWYgU1lOQ19ERUJVRw0KLXByaW50aygi
c3luY194ZmVyPSUwMngiLGhvc3RkYXRhLT5zeW5jX3hmZXJbY21kLT50YXJn
ZXRdKTsNCitwcmludGsoIiBzeW5jX3hmZXI9JTAyeFxuIixob3N0ZGF0YS0+
c3luY194ZmVyW2NtZC0+dGFyZ2V0XSk7DQogI2VuZGlmDQogICAgICAgICAg
ICAgICAgICAgICAgICAgaG9zdGRhdGEtPnN5bmNfc3RhdFtjbWQtPnRhcmdl
dF0gPSBTU19TRVQ7DQogICAgICAgICAgICAgICAgICAgICAgICAgd3JpdGVf
d2QzM2M5M19jbWQocmVncCxXRF9DTURfTkVHQVRFX0FDSyk7DQpAQCAtMTM2
Miw3ICsxMzYyLDcgQEANCiAjaWZkZWYgQ09ORklHX1NHSQ0KIHsNCiBpbnQg
YnVzeWNvdW50ID0gMDsNCi1leHRlcm4gdm9pZCBzZ2l3ZDkzX3Jlc2V0KHZv
aWQpOw0KK2V4dGVybiB2b2lkIHNnaXdkOTNfcmVzZXQodWNoYXIqKTsNCiAN
CiAgICAvKiB3YWl0ICd0aWwgdGhlIGNoaXAgZ2V0cyBzb21lIHRpbWUgZm9y
IHVzICovDQogICAgd2hpbGUgKFJFQURfQVVYX1NUQVQoKSAmIEFTUl9CU1kg
JiYgYnVzeWNvdW50KysgPCAxMDApDQpAQCAtMTM3Niw3ICsxMzc2LDcgQEAN
CiAgICAgKi8NCiAgICAvKiBzdGlsbCBidXN5ID8gKi8NCiAgICBpZiAoUkVB
RF9BVVhfU1RBVCgpICYgQVNSX0JTWSkNCi0Jc2dpd2Q5M19yZXNldCgpOyAv
KiB5ZWFoLCBnaXZlIGl0IHRoZSBoYXJkIG9uZSAqLw0KKwlzZ2l3ZDkzX3Jl
c2V0KGluc3RhbmNlLT5iYXNlKTsgLyogeWVhaCwgZ2l2ZSBpdCB0aGUgaGFy
ZCBvbmUgKi8NCiB9DQogI2VuZGlmDQogDQo=
--445303055-1189053499-930845119=:3088--
