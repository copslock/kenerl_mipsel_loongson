Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Feb 2003 14:14:47 +0000 (GMT)
Received: from [IPv6:::ffff:133.36.48.43] ([IPv6:::ffff:133.36.48.43]:26529
	"EHLO cat.os-omicron.org") by linux-mips.org with ESMTP
	id <S8225209AbTBQOO1>; Mon, 17 Feb 2003 14:14:27 +0000
Received: from wl04.sys.cs.tuat.ac.jp (pisces.sys.cs.tuat.ac.jp [165.93.162.82])
	by cat.os-omicron.org (Postfix) with SMTP id 74BFCA4E4
	for <linux-mips@linux-mips.org>; Mon, 17 Feb 2003 23:16:10 +0900 (JST)
Date: Mon, 17 Feb 2003 23:13:47 +0900
From: TAKANO Ryousei <takano@os-omicron.org>
To: linux-mips@linux-mips.org
Subject: Re: [PATCH][2/2] TANBAC TB0193 (L-Card+)
Message-Id: <20030217231347.719be6fc.takano@os-omicron.org>
In-Reply-To: <86r8a79s9w.fsf@trasno.mitica>
References: <20030217133222.13f9adf8.takano@os-omicron.org>
	<86r8a79s9w.fsf@trasno.mitica>
Organization: OS/omicron Project
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-vine-linux)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Mon__17_Feb_2003_23:13:47_+0900_08260b60"
Return-Path: <takano@os-omicron.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1450
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: takano@os-omicron.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Multipart_Mon__17_Feb_2003_23:13:47_+0900_08260b60
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi, Juan

On Mon, 17 Feb 2003 10:21:31 +0100
Juan Quintela <quintela@mandrakesoft.com> wrote:

> plain uXX instead of __uXX should work on kernel land.
 (snip) 
> Please, use C99 initializers.
> 

I fixed __uXX staffs adn C99 initializers.

Thanks,
TAKANO Ryousei

--Multipart_Mon__17_Feb_2003_23:13:47_+0900_08260b60
Content-Type: application/octet-stream;
 name="tanbac-tb0193-drivers2.patch"
Content-Disposition: attachment;
 filename="tanbac-tb0193-drivers2.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtTnJ1IC0tZXhjbHVkZT1DVlMgLS1leGNsdWRlPS5jdnNpZ25vcmUgbGludXgub3JpZy9h
cmNoL21pcHMvdnI0MTgxL3RhbmJhYy10YjAxOTMvaWRlLXRiMDE5My5jIGxpbnV4L2FyY2gvbWlw
cy92cjQxODEvdGFuYmFjLXRiMDE5My9pZGUtdGIwMTkzLmMKLS0tIGxpbnV4Lm9yaWcvZHJpdmVy
cy9tdGQvbWFwcy90YjAxOTMtZmxhc2guYwlNb24gRmViIDE3IDIyOjQxOjUzIDIwMDMKKysrIGxp
bnV4L2RyaXZlcnMvbXRkL21hcHMvdGIwMTkzLWZsYXNoLmMJTW9uIEZlYiAxNyAxOTowOTowMSAy
MDAzCkBAIC00Niw3ICs0Niw3IEBACiAJcmV0dXJuICh2b2lkICopKGFkZHJ8QTIzX0JJVCk7CiB9
CiAKLXN0YXRpYyBfX3U4IHRiMDE5M19yZWFkOChzdHJ1Y3QgbWFwX2luZm8gKm1hcCwgdW5zaWdu
ZWQgbG9uZyBvZnMpCitzdGF0aWMgdTggdGIwMTkzX3JlYWQ4KHN0cnVjdCBtYXBfaW5mbyAqbWFw
LCB1bnNpZ25lZCBsb25nIG9mcykKIHsKIAl1bnNpZ25lZCBsb25nIGFkZHIgPSBtYXAtPm1hcF9w
cml2XzEgKyBvZnM7CiAKQEAgLTU0LDcgKzU0LDcgQEAKIAlyZXR1cm4gcmVhZGIgKCBhZGRyMmJ1
cyhhZGRyKSApOwogfQogCi1zdGF0aWMgX191MTYgdGIwMTkzX3JlYWQxNihzdHJ1Y3QgbWFwX2lu
Zm8gKm1hcCwgdW5zaWduZWQgbG9uZyBvZnMpCitzdGF0aWMgdTE2IHRiMDE5M19yZWFkMTYoc3Ry
dWN0IG1hcF9pbmZvICptYXAsIHVuc2lnbmVkIGxvbmcgb2ZzKQogewogCXVuc2lnbmVkIGxvbmcg
YWRkciA9IG1hcC0+bWFwX3ByaXZfMSArIG9mczsKIApAQCAtNjIsNyArNjIsNyBAQAogCXJldHVy
biByZWFkdyAoIGFkZHIyYnVzKGFkZHIpICk7CiB9CiAKLXN0YXRpYyBfX3UzMiB0YjAxOTNfcmVh
ZDMyKHN0cnVjdCBtYXBfaW5mbyAqbWFwLCB1bnNpZ25lZCBsb25nIG9mcykKK3N0YXRpYyB1MzIg
dGIwMTkzX3JlYWQzMihzdHJ1Y3QgbWFwX2luZm8gKm1hcCwgdW5zaWduZWQgbG9uZyBvZnMpCiB7
CiAJdW5zaWduZWQgbG9uZyBhZGRyID0gbWFwLT5tYXBfcHJpdl8xICsgb2ZzOwogCkBAIC05MCw3
ICs5MCw3IEBACiAJfQogfQogCi1zdGF0aWMgdm9pZCB0YjAxOTNfd3JpdGU4KHN0cnVjdCBtYXBf
aW5mbyAqbWFwLCBfX3U4IGQsIHVuc2lnbmVkIGxvbmcgYWRyKQorc3RhdGljIHZvaWQgdGIwMTkz
X3dyaXRlOChzdHJ1Y3QgbWFwX2luZm8gKm1hcCwgdTggZCwgdW5zaWduZWQgbG9uZyBhZHIpCiB7
CiAJdW5zaWduZWQgbG9uZyBhZGRyID0gbWFwLT5tYXBfcHJpdl8xICsgYWRyOwogCkBAIC05OCw3
ICs5OCw3IEBACiAJd3JpdGViKGQsIGFkZHIyYnVzKGFkZHIpICk7CiB9CiAKLXN0YXRpYyB2b2lk
IHRiMDE5M193cml0ZTE2KHN0cnVjdCBtYXBfaW5mbyAqbWFwLCBfX3UxNiBkLCB1bnNpZ25lZCBs
b25nIGFkcikKK3N0YXRpYyB2b2lkIHRiMDE5M193cml0ZTE2KHN0cnVjdCBtYXBfaW5mbyAqbWFw
LCB1MTYgZCwgdW5zaWduZWQgbG9uZyBhZHIpCiB7CiAJdW5zaWduZWQgbG9uZyBhZGRyID0gbWFw
LT5tYXBfcHJpdl8xICsgYWRyOwogCkBAIC0xMDYsNyArMTA2LDcgQEAKIAl3cml0ZXcoZCwgYWRk
cjJidXMoYWRkcikgKTsKIH0KIAotc3RhdGljIHZvaWQgdGIwMTkzX3dyaXRlMzIoc3RydWN0IG1h
cF9pbmZvICptYXAsIF9fdTMyIGQsIHVuc2lnbmVkIGxvbmcgYWRyKQorc3RhdGljIHZvaWQgdGIw
MTkzX3dyaXRlMzIoc3RydWN0IG1hcF9pbmZvICptYXAsIHUzMiBkLCB1bnNpZ25lZCBsb25nIGFk
cikKIHsKIAl1bnNpZ25lZCBsb25nIGFkZHIgPSBtYXAtPm1hcF9wcml2XzEgKyBhZHI7CiAKQEAg
LTEzNSwxNyArMTM1LDE3IEBACiB9CiAKIHN0YXRpYyBzdHJ1Y3QgbWFwX2luZm8gdGIwMTkzX21h
cCA9IHsKLQluYW1lOgkJIlRBTkJBQyBUQjAxOTMgZmxhc2giLAotCXJlYWQ4OgkJdGIwMTkzX3Jl
YWQ4LAotCXJlYWQxNjoJCXRiMDE5M19yZWFkMTYsCi0JcmVhZDMyOgkJdGIwMTkzX3JlYWQzMiwK
LQljb3B5X2Zyb206CXRiMDE5M19jb3B5X2Zyb20sCi0Jd3JpdGU4OgkJdGIwMTkzX3dyaXRlOCwK
LQl3cml0ZTE2Ogl0YjAxOTNfd3JpdGUxNiwKLQl3cml0ZTMyOgl0YjAxOTNfd3JpdGUzMiwKLQlj
b3B5X3RvOgl0YjAxOTNfY29weV90bywKKwkubmFtZSA9CQkiVEFOQkFDIFRCMDE5MyBmbGFzaCIs
CisJLnJlYWQ4ID0JdGIwMTkzX3JlYWQ4LAorCS5yZWFkMTYgPQl0YjAxOTNfcmVhZDE2LAorCS5y
ZWFkMzIgPQl0YjAxOTNfcmVhZDMyLAorCS5jb3B5X2Zyb20gPQl0YjAxOTNfY29weV9mcm9tLAor
CS53cml0ZTggPQl0YjAxOTNfd3JpdGU4LAorCS53cml0ZTE2ID0JdGIwMTkzX3dyaXRlMTYsCisJ
LndyaXRlMzIgPQl0YjAxOTNfd3JpdGUzMiwKKwkuY29weV90byA9CXRiMDE5M19jb3B5X3RvLAog
Ci0JbWFwX3ByaXZfMToJV0lORE9XX0FERFIsCisJLm1hcF9wcml2XzEgPQlXSU5ET1dfQUREUiwK
IH07CiAKIApAQCAtMTYwLDI1ICsxNjAsMjUgQEAKICAqICJzdHJ1Y3QgbWFwX2Rlc2MgKl9pb19k
ZXNjIiBmb3IgdGhlIGNvcnJlc3BvbmRpbmcgbWFjaGluZS4KICAqLwogCi1zdGF0aWMgdW5zaWdu
ZWQgbG9uZyBsY2FyZF9tYXhfZmxhc2hfc2l6ZSA9IDB4MDEwMDAwMDA7Ci1zdGF0aWMgc3RydWN0
IG10ZF9wYXJ0aXRpb24gbGNhcmRfcGFydGl0aW9uc1tdID0geworc3RhdGljIHVuc2lnbmVkIGxv
bmcgdGIwMTkzX21heF9mbGFzaF9zaXplID0gMHgwMTAwMDAwMDsKK3N0YXRpYyBzdHJ1Y3QgbXRk
X3BhcnRpdGlvbiB0YjAxOTNfcGFydGl0aW9uc1tdID0gewogCXsgCi0JCW5hbWU6CQkicm9vdCBm
aWxlIHN5c3RlbSIsCi0JCW9mZnNldDoJCTB4MDAwMDAwMDAsCi0JCXNpemU6CQkweDAwYzAwMDAw
LAorCQkubmFtZSA9CQkicm9vdCBmaWxlIHN5c3RlbSIsCisJCS5vZmZzZXQgPQkweDAwMDAwMDAw
LAorCQkuc2l6ZSA9CQkweDAwYzAwMDAwLAogCX0sewotCQluYW1lOgkJIm1vbml0b3IiLAotCQlv
ZmZzZXQ6CQkweDAwYzAwMDAwLAotCQlzaXplOgkJMHgwMDAyMDAwMCwKLSAgICAgICAgICAgICAg
ICBtYXNrX2ZsYWdzOglNVERfV1JJVEVBQkxFLAorCQkubmFtZSA9CQkibW9uaXRvciIsCisJCS5v
ZmZzZXQgPQkweDAwYzAwMDAwLAorCQkuc2l6ZSA9CQkweDAwMDIwMDAwLAorICAgICAgICAgICAg
ICAgIC5tYXNrX2ZsYWdzID0JTVREX1dSSVRFQUJMRSwKIAl9LHsKLQkJbmFtZToJCSJyZXNlcnZl
ZCIsCi0JCW9mZnNldDoJCTB4MDBjMjAwMDAsCi0JCXNpemU6CQkweDAwMGUwMDAwLAorCQkubmFt
ZSA9CQkicmVzZXJ2ZWQiLAorCQkub2Zmc2V0ID0JMHgwMGMyMDAwMCwKKwkJLnNpemUgPQkJMHgw
MDBlMDAwMCwKIAl9LHsKLQkJbmFtZToJCSJrZXJuZWwiLAotCQlvZmZzZXQ6CQkweDAwZDAwMDAw
LAotCQlzaXplOgkJMHgwMDMwMDAwMCwKKwkJLm5hbWUgPQkJImtlcm5lbCIsCisJCS5vZmZzZXQg
PQkweDAwZDAwMDAwLAorCQkuc2l6ZSA9CQkweDAwMzAwMDAwLAogCX0sCiB9OwogCkBAIC0yMTEs
OSArMjExLDkgQEAKIAkgKiBTdGF0aWMgcGFydGl0aW9uIGRlZmluaXRpb24gc2VsZWN0aW9uCiAJ
ICovCiAJcGFydF90eXBlID0gInN0YXRpYyI7Ci0JcGFydHMgPSBsY2FyZF9wYXJ0aXRpb25zOwot
CW5iX3BhcnRzID0gTkJfT0YobGNhcmRfcGFydGl0aW9ucyk7Ci0JdGIwMTkzX21hcC5zaXplID0g
bGNhcmRfbWF4X2ZsYXNoX3NpemU7CisJcGFydHMgPSB0YjAxOTNfcGFydGl0aW9uczsKKwluYl9w
YXJ0cyA9IE5CX09GKHRiMDE5M19wYXJ0aXRpb25zKTsKKwl0YjAxOTNfbWFwLnNpemUgPSB0YjAx
OTNfbWF4X2ZsYXNoX3NpemU7CiAKIAkvKgogCSAqIE5vdyBsZXQncyBwcm9iZSBmb3IgdGhlIGFj
dHVhbCBmbGFzaC4gIERvIGl0IGhlcmUgc2luY2UK

--Multipart_Mon__17_Feb_2003_23:13:47_+0900_08260b60--
