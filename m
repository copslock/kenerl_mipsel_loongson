Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2007 04:56:16 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.180]:12266 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20021794AbXHBD4M (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Aug 2007 04:56:12 +0100
Received: by wa-out-1112.google.com with SMTP id m16so400611waf
        for <linux-mips@linux-mips.org>; Wed, 01 Aug 2007 20:55:53 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ud7qtqygjYT12dxYt72qHtwfDM4+K+MVoKRd+7Hy9wLtIZc9BXTf9XfqCP14rw0vECAfFqRZ6TQQdfrWW1YdX3w03V0IvTnlYcUtXijcv/bOVFX7lE3OW/FXVz8Mq0AGVr4DqbQ/ns735/kj5U/6yqwDjRBlCcQgHMMmPATdw2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PPb7U+TzksNQtB3pwPSoRr2aSeydt8R5iXNtF7mNZTfuWZmR+rHGzUaiKX1TqGAFeKmVHpe4D5oI3pKUNv1EjVD2WXEcRHXr8VldlqM5ZDxz2VYnbsDk7n+Pgdgt/d2CRb7v2JFFNYQvPWqdQRuX8IQz++aMjN+lvLyyHPfLO8Q=
Received: by 10.114.36.1 with SMTP id j1mr1410871waj.1186026953476;
        Wed, 01 Aug 2007 20:55:53 -0700 (PDT)
Received: by 10.115.111.14 with HTTP; Wed, 1 Aug 2007 20:55:48 -0700 (PDT)
Message-ID: <5861a7880708012055g5350b09akc610dd84cf63c5a2@mail.gmail.com>
Date:	Thu, 2 Aug 2007 07:55:48 +0400
From:	"Dajie Tan" <jiankemeng@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>, Ralf <ralf@linux-mips.org>
Subject: Fwd: [RFC] Calculate exactly how many ptr is needed for pgd
In-Reply-To: <5861a7880708012054u404c9b02s7141d1811d4a7fdf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline
References: <46AF4981.1090601@lemote.com>
	 <5861a7880708012054u404c9b02s7141d1811d4a7fdf@mail.gmail.com>
Return-Path: <jiankemeng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiankemeng@gmail.com
Precedence: bulk
X-list: linux-mips

SXQgd29ya3Mgd2VsbC4gSWYgSSBzdGFydCB4b3JnK3hmY2UsIGl0IGNhbiBzYXZlIDIuNU1CIG1l
bW9yeSBpbiBteSBzeXN0ZW0uCgpUaGFua3MsIHNvbmdtYW8uCgoyMDA3LzcvMzEsIFNvbmdtYW8g
VGlhbiA8dGlhbnNtQGxlbW90ZS5jb20+Ogo+IFVuZGVyIDMyLWJpdCBrZXJuZWwgd2l0aCA0ayBw
YWdlLCBhIHBhZ2UgaXMgbmVlZGVkIGZvciBhIHBnZCwKPiBidXQgd2hlbiBwYWdlIHNpemUgPiA0
aywgYSBwYWdlIHdpbGwgYmUgdG9vIG11Y2guCj4KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20t
bWlwcy9wZ3RhYmxlLTMyLmggYi9pbmNsdWRlL2FzbS1taXBzL3BndGFibGUtMzIuaAo+IGluZGV4
IDJmYmQ0N2UuLjJhMTYyNDAgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9hc20tbWlwcy9wZ3RhYmxl
LTMyLmgKPiArKysgYi9pbmNsdWRlL2FzbS1taXBzL3BndGFibGUtMzIuaAo+IEBAIC02Nyw3ICs2
Nyw4IEBAIGV4dGVybiBpbnQgYWRkX3RlbXBvcmFyeV9lbnRyeSh1bnNpZ25lZCBsb25nIGVudHJ5
bG8wLAo+IHVuc2lnbmVkIGxvbmcgZW50cnlsbzEsCj4gICNkZWZpbmUgUFRFX09SREVSICAgIDAK
PiAgI2VuZGlmCj4KPiAtI2RlZmluZSBQVFJTX1BFUl9QR0QgICAgKChQQUdFX1NJWkUgPDwgUEdE
X09SREVSKSAvIHNpemVvZihwZ2RfdCkpCj4gKy8qIFVzaW5nIGEgcGFnZSBmb3IgcGdkIHdpbGwg
YmUgYSB3YXN0ZSB3aGVuIHBhZ2Ugc2l6ZSA+IDRrICovCj4gKyNkZWZpbmUgUFRSU19QRVJfUEdE
ICAgICgxIDw8ICgzMiAtIFBHRElSX1NISUZUKSkKPiAgI2RlZmluZSBQVFJTX1BFUl9QVEUgICAg
KChQQUdFX1NJWkUgPDwgUFRFX09SREVSKSAvIHNpemVvZihwdGVfdCkpCj4KPiAgI2RlZmluZSBV
U0VSX1BUUlNfUEVSX1BHRCAgICAoMHg4MDAwMDAwMFVML1BHRElSX1NJWkUpCj4KPgoKCi0tIArk
uLrlpKnlnLDnq4vlv4MK5Li655Sf5rCR56uL5ZG9CuS4uuW+gOWco+e7p+e7neWtpgrkuLrkuIfk
uJblvIDlpKrlubMK
