Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6MMqkV16384
	for linux-mips-outgoing; Sun, 22 Jul 2001 15:52:46 -0700
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6MMqhV16377
	for <linux-mips@oss.sgi.com>; Sun, 22 Jul 2001 15:52:44 -0700
Received: from scotty.mgnet.de (pD957B5B4.dip.t-dialin.net [217.87.181.180])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id AAA09969
	for <linux-mips@oss.sgi.com>; Mon, 23 Jul 2001 00:52:37 +0200 (MET DST)
Received: (qmail 28833 invoked from network); 22 Jul 2001 22:52:32 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 22 Jul 2001 22:52:32 -0000
Date: Mon, 23 Jul 2001 00:52:26 +0200 (CEST)
From: Klaus Naumann <spock@mgnet.de>
To: Linux/MIPS list <linux-mips@oss.sgi.com>
Subject: Workaround for Multiple Disk Problem
Message-ID: <Pine.LNX.4.21.0107230045510.15244-200000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811071-1968279449-995842346=:15244"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811071-1968279449-995842346=:15244
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hi all,

the attached patch is a _WORK-AROUND_ for the Multiple Disk Problem which
is one of the biggest show stoppers on Indy/Indigo2 systems.
It disables DMA transfers to the SCSI bus. I'm not sure if this
is much slower. Please consider this a work around for machines
which have small disks and need them all to make up a decent build
machine or so ...
The patch implements a new config option right below SGI WD33C93 SCSI
Support in the SCSI Devices Configuration. Activate it and recompile
your kernel (you may have to do make distclean to recompile).
The driver will display a warning at boot time that this kernel has
DMA disabled.
I also know that this C code is the kind of C code which is really bad.
It's somewhat like the stuff your mother has warned you before when
you were young ...
But well it's a hack so I don't care.

		Enjoy, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt

---1463811071-1968279449-995842346=:15244
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sgiwd93_nodma.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0107230052260.15244@spock.mgnet.de>
Content-Description: 
Content-Disposition: attachment; filename="sgiwd93_nodma.patch"

LS0tIGN2cy9saW51eC9kcml2ZXJzL3Njc2kvQ29uZmlnLmluCVN1biBBcHIg
MTUgMTc6MTY6MDcgMjAwMQ0KKysrIGxpbnV4LmJ1aWxkL2RyaXZlcnMvc2Nz
aS9Db25maWcuaW4JU3VuIEp1bCAyMiAyMzo1MToxOSAyMDAxDQpAQCAtMzQs
NiArMzQsOSBAQA0KIA0KIGlmIFsgIiRDT05GSUdfU0dJX0lQMjIiID0gInki
IF07IHRoZW4NCiAgICBkZXBfdHJpc3RhdGUgJ1NHSSBXRDkzQzkzIFNDU0kg
RHJpdmVyJyBDT05GSUdfU0dJV0Q5M19TQ1NJICRDT05GSUdfU0NTSQ0KKyAg
IGlmIFsgIiRDT05GSUdfU0dJV0Q5M19TQ1NJIiAhPSAibiIgXTsgdGhlbg0K
KyAgICAgIGJvb2wgJyAgRGlzYWJsZSBETUEgZm9yIFNHSSBXRDMzQzkzIFND
U0kgRHJpdmVyJyBDT05GSUdfU0dJV0Q5M19TQ1NJX05PRE1BDQorICAgZmkN
CiBmaQ0KIGlmIFsgIiRDT05GSUdfREVDU1RBVElPTiIgPSAieSIgXTsgdGhl
bg0KICAgIGlmIFsgIiRDT05GSUdfVEMiID0gInkiIF07IHRoZW4NCi0tLSBj
dnMvbGludXgvZHJpdmVycy9zY3NpL3NnaXdkOTMuYwlUdWUgTWFyIDI3IDAw
OjExOjQ5IDIwMDENCisrKyBsaW51eC5idWlsZC9kcml2ZXJzL3Njc2kvc2dp
d2Q5My5jCVN1biBKdWwgMjIgMjM6NTk6NTYgMjAwMQ0KQEAgLTEwMiw2ICsx
MDIsMjEgQEANCiAJd2QzM2M5M19yZWdzICpyZWdwID0gaGRhdGEtPnJlZ3A7
DQogCXN0cnVjdCBocGMzX3Njc2lyZWdzICpocmVncyA9IChzdHJ1Y3QgaHBj
M19zY3NpcmVncyAqKSBjbWQtPmhvc3QtPmJhc2U7DQogCXN0cnVjdCBocGNf
Y2h1bmsgKmhjcCA9IChzdHJ1Y3QgaHBjX2NodW5rICopIGhkYXRhLT5kbWFf
Ym91bmNlX2J1ZmZlcjsNCisjaWZkZWYgQ09ORklHX1NHSVdEOTNfU0NTSV9O
T0RNQQ0KKwlzdGF0aWMgaW50IHByaW50d2FybmluZyA9IDA7DQorI2VuZGlm
DQorDQorLyogS2xhdXMgTmF1bWFubiAtIHRoaXMgaXMgYSB0ZW1wb3Jhcnkg
d29ya2Fyb3VuZCB1bnRpbA0KK3dlIHNvcnRlZCBvdXQgdGhlIERNQSBidWcg
d2hpY2ggb2Njb3VycyBpZiB0d28gZGlza3MgYXJlDQorY29ubmVjdGVkIHRv
IHRoZSBzYW1lIFNDU0kgYnVzLg0KKyovDQorI2lmZGVmIENPTkZJR19TR0lX
RDkzX1NDU0lfTk9ETUENCisJaWYocHJpbnR3YXJuaW5nID09IDApIHsNCisJ
CXByaW50aygiXG5cbiAtLS0gV0FSTklORyAtLS0gRE1BIGlzIGRpc2FibGVk
IC0tLSBXQVJOSU5HIC0tLVxuXG5cbiIpOw0KKwkJcHJpbnR3YXJuaW5nID0g
MTsNCisJfQ0KKwlyZXR1cm4gVFJVRTsNCisjZW5kaWYNCiANCiAjaWZkZWYg
REVCVUdfRE1BDQogCXByaW50aygiZG1hX3NldHVwOiBkYXRhaW5wPCVkPiBo
Y3A8JXA+ICIsDQo=
---1463811071-1968279449-995842346=:15244--
