Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jan 2010 16:13:03 +0100 (CET)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:12145 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493130Ab0AYPM6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 25 Jan 2010 16:12:58 +0100
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
        by demumfd002.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id o0PFCSYN029357
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Mon, 25 Jan 2010 16:12:29 +0100
Received: from demuexc022.nsn-intra.net (demuexc022.nsn-intra.net [10.150.128.35])
        by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id o0PFCOlE028960;
        Mon, 25 Jan 2010 16:12:24 +0100
Received: from DEMUEXC027.nsn-intra.net ([10.150.128.19]) by demuexc022.nsn-intra.net with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 25 Jan 2010 16:12:24 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----_=_NextPart_001_01CA9DD0.C0722236"
Subject: RE: [PATCH 2/3] I2C: Add driver for Cavium OCTEON I2C ports.
Date:   Mon, 25 Jan 2010 16:12:04 +0100
Message-ID: <B9D8E77D89A5D44DBBB9A296E95DCE130BA499@DEMUEXC027.nsn-intra.net>
In-Reply-To: <20100124160017.GF28675@fluff.org.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/3] I2C: Add driver for Cavium OCTEON I2C ports.
Thread-Index: AcqdDmu9HO5caq3OSSWke/Hm5eI6ZgAvvEMw
References: <4B463B1F.6000404@caviumnetworks.com> <1262894061-32613-2-git-send-email-ddaney@caviumnetworks.com> <20100124160017.GF28675@fluff.org.uk>
From:   "Bozic, Rade (EXT-Other - DE/Ulm)" <rade.bozic.ext@nsn.com>
To:     "David Daney" <ddaney@caviumnetworks.com>,
        "ext Ben Dooks" <ben-linux@fluff.org>
Cc:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <linux-i2c@vger.kernel.org>, <khali@linux-fr.org>
X-OriginalArrivalTime: 25 Jan 2010 15:12:24.0096 (UTC) FILETIME=[CC5E2200:01CA9DD0]
X-archive-position: 25650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rade.bozic.ext@nsn.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16019

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA9DD0.C0722236
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello David,

Yesterday Ben Dooks wrote a email with some new issues ( Message-ID: =
<20100124160017.GF28675@fluff.org.uk>).

New changes:

1. Some return values was Changed
2. Changed __exit_p to __devexit_p and __exit into __devexit
3. New handling of NO_IRQ


In the appendix is a new I2C patch.
Maybe we can put the patch also in the Kernel.



Regards
Rade

------_=_NextPart_001_01CA9DD0.C0722236
Content-Type: application/octet-stream;
	name="i2c-octeon_25.12.2010.patch"
Content-Transfer-Encoding: base64
Content-Description: i2c-octeon_25.12.2010.patch
Content-Disposition: attachment;
	filename="i2c-octeon_25.12.2010.patch"

U2lnbmVkLW9mZi1ieTogUmFkZSBCb3ppYyA8cmFkZS5ib3ppYy5leHRAbnNuLmNvbT4KU2lnbmVk
LW9mZi1ieTogRGF2aWQgRGFuZXkgPGRkYW5leUBjYXZpdW1uZXR3b3Jrcy5jb20+CgotLS0+IApk
aWZmIC1wdXJOIGxpbnV4LTIuNl9vcmcvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1vY3Rlb24uYyBs
aW51eC0yLjZfaTJjL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtb2N0ZW9uLmMKLS0tIGxpbnV4LTIu
Nl9vcmcvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1vY3Rlb24uYwkyMDEwLTAxLTIyIDE2OjMzOjIz
LjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtMi42X2kyYy9kcml2ZXJzL2kyYy9idXNzZXMvaTJj
LW9jdGVvbi5jCTIwMTAtMDEtMjUgMTU6MzM6MjMuMDAwMDAwMDAwICswMTAwCkBAIC0xMCw3ICsx
MCw2IEBACiAgKiBMaWNlbnNlIHZlcnNpb24gMi4gVGhpcyBwcm9ncmFtIGlzIGxpY2Vuc2VkICJh
cyBpcyIgd2l0aG91dCBhbnkKICAqIHdhcnJhbnR5IG9mIGFueSBraW5kLCB3aGV0aGVyIGV4cHJl
c3Mgb3IgaW1wbGllZC4KICAqLwotCiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+CiAjaW5jbHVk
ZSA8bGludXgvbW9kdWxlLmg+CiAjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4KQEAgLTM1Miw3ICsz
NTEsNyBAQCBzdGF0aWMgaW50IG9jdGVvbl9pMmNfeGZlcihzdHJ1Y3QgaTJjX2FkCiAJfQogCW9j
dGVvbl9pMmNfc3RvcChpMmMpOwogCi0JcmV0dXJuIChyZXQgPCAwKSA/IHJldCA6IG51bTsKKwly
ZXR1cm4gKHJldCA8IDApID8gRUlPIDogbnVtOwogfQogCiBzdGF0aWMgdTMyIG9jdGVvbl9pMmNf
ZnVuY3Rpb25hbGl0eShzdHJ1Y3QgaTJjX2FkYXB0ZXIgKmFkYXApCkBAIC00NTcsMTMgKzQ1Niwx
MyBAQCBzdGF0aWMgaW50IF9faW5pdCBvY3Rlb25faTJjX3Byb2JlKHN0cnVjCiAJaWYgKHJlc19t
ZW0gPT0gTlVMTCkgewogCQlkZXZfZGJnKGkyYy0+ZGV2LCAiJXM6IGZvdW5kIG5vIG1lbW9yeSBy
ZXNvdXJjZVxuIiwgX19mdW5jX18pOwogCQlrZnJlZShpMmMpOwotCQlyZXR1cm4gLUVOT0RFVjsK
KwkJcmV0dXJuIC1FSU5WQUw7CiAJfQogCiAJaWYgKGkyY19kYXRhID09IE5VTEwpIHsKIAkJZGV2
X2RiZyhpMmMtPmRldiwgIiVzOiBubyBJMkMgZnJlcXVlbmNlIGRhdGFcbiIsIF9fZnVuY19fKTsK
IAkJa2ZyZWUoaTJjKTsKLQkJcmV0dXJuIC1FTk9ERVY7CisJCXJldHVybiAtRUlOVkFMOwogCX0K
IAogCWkyYy0+dHdzaV9waHlzID0gcmVzX21lbS0+c3RhcnQ7CkBAIC00NzUsNiArNDc0LDcgQEAg
c3RhdGljIGludCBfX2luaXQgb2N0ZW9uX2kyY19wcm9iZShzdHJ1YwogCQlkZXZfZGJnKGkyYy0+
ZGV2LAogCQkJIiVzIGkyYy1jYXZpdW0gLSByZXF1ZXN0X21lbV9yZWdpb24gZmFpbGVkXG4iLAog
CQkJX19mdW5jX18pOworCQlyZXN1bHQgPSAtRU5PTUVNOwogCQlnb3RvIGZhaWxfcmVnaW9uOwog
CX0KIAlpMmMtPnR3c2lfYmFzZSA9IGlvcmVtYXAoaTJjLT50d3NpX3BoeXMsIGkyYy0+cmVnc2l6
ZSk7CkBAIC00ODIsMjcgKzQ4MiwzNyBAQCBzdGF0aWMgaW50IF9faW5pdCBvY3Rlb25faTJjX3By
b2JlKHN0cnVjCiAJaW5pdF93YWl0cXVldWVfaGVhZCgmaTJjLT5xdWV1ZSk7CiAKIAlpMmMtPmly
cSA9IGlycTsKKworCS8qIGkyYy0+aXJxID09IE5PX0lSUSBpbXBsaWVzIHBvbGxpbmcgKi8KIAlp
ZiAoaTJjLT5pcnEgIT0gTk9fSVJRKSB7Ci0JCS8qIGkyYy0+aXJxID0gTk9fSVJRIGltcGxpZXMg
cG9sbGluZyAqLwotCQlyZXN1bHQgPSByZXF1ZXN0X2lycShpMmMtPmlycSwgb2N0ZW9uX2kyY19p
c3IsIDAsIERSVl9OQU1FLCBpMmMpOwotCQlpZiAocmVzdWx0IDwgMCkgeworCQlpZiAoaTJjLT5p
cnEgPCAwKSB7CiAJCQlkZXZfZGJnKGkyYy0+ZGV2LAotCQkJCSIlczogLSBmYWlsZWQgdG8gYXR0
YWNoIGludGVycnVwdFxuIiwKKwkJCQkiJXM6IC0gYmFkIGludGVycnVwdCBudW1iZXJcbiIsCiAJ
CQkJX19mdW5jX18pOworCQkJcmVzdWx0ID0gLUVJTlZBTDsKIAkJCWdvdG8gZmFpbF9pcnE7CisJ
CX0gZWxzZSB7CisJCQlyZXN1bHQgPSByZXF1ZXN0X2lycShpMmMtPmlycSwgb2N0ZW9uX2kyY19p
c3IsIDAsCisJCQkJCQkJCURSVl9OQU1FLCBpMmMpOworCQkJaWYgKHJlc3VsdCA8IDApIHsKKwkJ
CQlkZXZfZGJnKGkyYy0+ZGV2LAorCQkJCQkiJXM6IC0gZmFpbGVkIHRvIGF0dGFjaCBpbnRlcnJ1
cHRcbiIsCisJCQkJCV9fZnVuY19fKTsKKwkJCQlnb3RvIGZhaWxfaXJxOworCQkJfQogCQl9CiAJ
fQogCiAJcmVzdWx0ID0gb2N0ZW9uX2kyY19pbml0bG93bGV2ZWwoaTJjKTsKIAlpZiAocmVzdWx0
KSB7CiAJCWRldl9kYmcoaTJjLT5kZXYsICIlczogaW5pdCBsb3cgbGV2ZWwgZmFpbGVkXG4iLCBf
X2Z1bmNfXyk7Ci0JCWdvdG8gIGZhaWxfYWRkOworCQlnb3RvIGZhaWxfYWRkOwogCX0KIAogCXJl
c3VsdCA9IG9jdGVvbl9pMmNfc2V0Y2xvY2soaTJjKTsKIAlpZiAocmVzdWx0KSB7CiAJCWRldl9k
YmcoaTJjLT5kZXYsICIlczogY2xvY2sgaW5pdCBmYWlsZWRcbiIsIF9fZnVuY19fKTsKLQkJZ290
byAgZmFpbF9hZGQ7CisJCWdvdG8gZmFpbF9hZGQ7CiAJfQogCiAJaTJjLT5hZGFwID0gb2N0ZW9u
X2kyY19vcHM7CkBAIC01MzAsNyArNTQwLDcgQEAgZmFpbF9yZWdpb246CiAJcmV0dXJuIHJlc3Vs
dDsKIH07CiAKLXN0YXRpYyBpbnQgX19leGl0IG9jdGVvbl9pMmNfcmVtb3ZlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpCitzdGF0aWMgaW50IF9fZGV2ZXhpdCBvY3Rlb25faTJjX3JlbW92
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogewogCXN0cnVjdCBvY3Rlb25faTJjICpp
MmMgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsKIApAQCAtNTQ2LDcgKzU1Niw3IEBAIHN0
YXRpYyBpbnQgX19leGl0IG9jdGVvbl9pMmNfcmVtb3ZlKHN0cnUKIAogc3RhdGljIHN0cnVjdCBw
bGF0Zm9ybV9kcml2ZXIgb2N0ZW9uX2kyY19kcml2ZXIgPSB7CiAJLnByb2JlCQk9IG9jdGVvbl9p
MmNfcHJvYmUsCi0JLnJlbW92ZQkJPSBfX2V4aXRfcChvY3Rlb25faTJjX3JlbW92ZSksCisJLnJl
bW92ZQkJPSBfX2RldmV4aXRfcChvY3Rlb25faTJjX3JlbW92ZSksCiAJLmRyaXZlcgkJPSB7CiAJ
CS5vd25lcgk9IFRISVNfTU9EVUxFLAogCQkubmFtZQk9IERSVl9OQU1FLApAQCAtNTc2LDQgKzU4
NiwzIEBAIE1PRFVMRV9BTElBUygicGxhdGZvcm06IiBEUlZfTkFNRSk7CiAKIG1vZHVsZV9pbml0
KG9jdGVvbl9pMmNfaW5pdCk7CiBtb2R1bGVfZXhpdChvY3Rlb25faTJjX2V4aXQpOwotCg==

------_=_NextPart_001_01CA9DD0.C0722236--
