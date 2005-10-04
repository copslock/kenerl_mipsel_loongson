Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2005 09:50:13 +0100 (BST)
Received: from zproxy.gmail.com ([64.233.162.193]:26540 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133458AbVJDItz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 4 Oct 2005 09:49:55 +0100
Received: by zproxy.gmail.com with SMTP id j2so136222nzf
        for <linux-mips@linux-mips.org>; Tue, 04 Oct 2005 01:49:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type;
        b=bLUshBcCyd0By1bKl40tGMD8JKyJnw85xGvdc4kUCH+0VehghgjquPFLUuNbyqNgixnSuXPtAxG3/rTfbglA8EuZgpUYtIJpCa5gyT8hXLNJF/eEyecj980kwiDHpKzmkdSSOGy5kevNm3Qc6j3I1dWB83IxHelaGoVDKhCDPzQ=
Received: by 10.36.224.78 with SMTP id w78mr48850nzg;
        Tue, 04 Oct 2005 01:49:44 -0700 (PDT)
Received: by 10.36.49.3 with HTTP; Tue, 4 Oct 2005 01:49:44 -0700 (PDT)
Message-ID: <cda58cb80510040149p690397afo@mail.gmail.com>
Date:	Tue, 4 Oct 2005 10:49:44 +0200
From:	Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] Add support for 4KS cpu.
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3451_12254408.1128415784694"
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_3451_12254408.1128415784694
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch adds support for both 4ksc and 4ksd cpus. These cpu are
mainly used in embedded system such as smartcard or point of sell
devices as they provide some extra security features.

Signed-off-by: Franck <vagabon.xyz@gmail.com>

------=_Part_3451_12254408.1128415784694
Content-Type: text/x-patch; name="4ksx-support.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="4ksx-support.patch"

ZGlmZiAtTnVycCBsaW51eC0yLjYuMTQtcmMyLW1pcHNjdnMvYXJjaC9taXBzL0tjb25maWcgbGlu
dXgtMi42LjE0LXJjMi1taXBzY3ZzLTRLU3gvYXJjaC9taXBzL0tjb25maWcKLS0tIGxpbnV4LTIu
Ni4xNC1yYzItbWlwc2N2cy9hcmNoL21pcHMvS2NvbmZpZwkyMDA1LTA5LTIzIDIyOjAyOjQ0LjAw
MDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjE0LXJjMi1taXBzY3ZzLTRLU3gvYXJjaC9taXBz
L0tjb25maWcJMjAwNS0xMC0wNCAwOTo1Mjo0My4wMDAwMDAwMDAgKzAyMDAKQEAgLTExMjMsNiAr
MTEyMywyMCBAQCBjb25maWcgQ1BVX1NCMQogCXNlbGVjdCBDUFVfU1VQUE9SVFNfNjRCSVRfS0VS
TkVMCiAJc2VsZWN0IENQVV9TVVBQT1JUU19ISUdITUVNCiAKK2NvbmZpZyBDUFVfNEtTQworCWJv
b2wgIjRLU0MiCisJc2VsZWN0IENQVV9TVVBQT1JUU18zMkJJVF9LRVJORUwKKwlzZWxlY3QgQ1BV
X0hBU19QUkVGRVRDSAorCWhlbHAKKwkgIE1JUFMgVGVjaG5vbG9naWVzIDRLU2Mtc2VyaWVzIHBy
b2Nlc3NvcnMuCisKK2NvbmZpZyBDUFVfNEtTRAorCWJvb2wgIjRLU0QiCisJc2VsZWN0IENQVV9T
VVBQT1JUU18zMkJJVF9LRVJORUwKKwlzZWxlY3QgQ1BVX0hBU19QUkVGRVRDSAorCWhlbHAKKwkg
IE1JUFMgVGVjaG5vbG9naWVzIDRLU2Qtc2VyaWVzIHByb2Nlc3NvcnMuCisKIGVuZGNob2ljZQog
CiBlbmRtZW51CmRpZmYgLU51cnAgbGludXgtMi42LjE0LXJjMi1taXBzY3ZzL2FyY2gvbWlwcy9r
ZXJuZWwvY3B1LXByb2JlLmMgbGludXgtMi42LjE0LXJjMi1taXBzY3ZzLTRLU3gvYXJjaC9taXBz
L2tlcm5lbC9jcHUtcHJvYmUuYwotLS0gbGludXgtMi42LjE0LXJjMi1taXBzY3ZzL2FyY2gvbWlw
cy9rZXJuZWwvY3B1LXByb2JlLmMJMjAwNS0wOC0xNiAxOTo1MDo0My4wMDAwMDAwMDAgKzAyMDAK
KysrIGxpbnV4LTIuNi4xNC1yYzItbWlwc2N2cy00S1N4L2FyY2gvbWlwcy9rZXJuZWwvY3B1LXBy
b2JlLmMJMjAwNS0xMC0wNCAwOTo0MTo0Mi4wMDAwMDAwMDAgKzAyMDAKQEAgLTU1Miw2ICs1NTIs
NyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgY3B1X3Byb2JlX21pcHMoc3RydWN0CiAJCWMtPmNwdXR5
cGUgPSBDUFVfNEtFQzsKIAkJYnJlYWs7CiAJY2FzZSBQUklEX0lNUF80S1NDOgorCWNhc2UgUFJJ
RF9JTVBfNEtTRDoKIAkJYy0+Y3B1dHlwZSA9IENQVV80S1NDOwogCQlicmVhazsKIAljYXNlIFBS
SURfSU1QXzVLQzoKZGlmZiAtTnVycCBsaW51eC0yLjYuMTQtcmMyLW1pcHNjdnMvYXJjaC9taXBz
L2tlcm5lbC9NYWtlZmlsZSBsaW51eC0yLjYuMTQtcmMyLW1pcHNjdnMtNEtTeC9hcmNoL21pcHMv
a2VybmVsL01ha2VmaWxlCi0tLSBsaW51eC0yLjYuMTQtcmMyLW1pcHNjdnMvYXJjaC9taXBzL2tl
cm5lbC9NYWtlZmlsZQkyMDA1LTA5LTAxIDIyOjQyOjQ2LjAwMDAwMDAwMCArMDIwMAorKysgbGlu
dXgtMi42LjE0LXJjMi1taXBzY3ZzLTRLU3gvYXJjaC9taXBzL2tlcm5lbC9NYWtlZmlsZQkyMDA1
LTEwLTA0IDA5OjMwOjI5LjAwMDAwMDAwMCArMDIwMApAQCAtMzEsNiArMzEsOCBAQCBvYmotJChD
T05GSUdfQ1BVX1NCMSkJCSs9IHI0a19mcHUubyByNGtfCiBvYmotJChDT05GSUdfQ1BVX01JUFMz
Ml9SMSkJKz0gcjRrX2ZwdS5vIHI0a19zd2l0Y2gubwogb2JqLSQoQ09ORklHX0NQVV9NSVBTNjRf
UjEpCSs9IHI0a19mcHUubyByNGtfc3dpdGNoLm8KIG9iai0kKENPTkZJR19DUFVfUjYwMDApCQkr
PSByNjAwMF9mcHUubyByNGtfc3dpdGNoLm8KK29iai0kKENPTkZJR19DUFVfNEtTQykJCSs9IHI0
a19zd2l0Y2gubworb2JqLSQoQ09ORklHX0NQVV80S1NEKQkJKz0gcjRrX3N3aXRjaC5vCiAKIG9i
ai0kKENPTkZJR19TTVApCQkrPSBzbXAubwogCmRpZmYgLU51cnAgbGludXgtMi42LjE0LXJjMi1t
aXBzY3ZzL2FyY2gvbWlwcy9saWItMzIvTWFrZWZpbGUgbGludXgtMi42LjE0LXJjMi1taXBzY3Zz
LTRLU3gvYXJjaC9taXBzL2xpYi0zMi9NYWtlZmlsZQotLS0gbGludXgtMi42LjE0LXJjMi1taXBz
Y3ZzL2FyY2gvbWlwcy9saWItMzIvTWFrZWZpbGUJMjAwNS0wNy0xMSAxMjowMzoyNy4wMDAwMDAw
MDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xNC1yYzItbWlwc2N2cy00S1N4L2FyY2gvbWlwcy9saWIt
MzIvTWFrZWZpbGUJMjAwNS0xMC0wNCAwOTo0NDowOS4wMDAwMDAwMDAgKzAyMDAKQEAgLTIxLDUg
KzIxLDcgQEAgb2JqLSQoQ09ORklHX0NQVV9TQjEpCQkrPSBkdW1wX3RsYi5vCiBvYmotJChDT05G
SUdfQ1BVX1RYMzlYWCkJKz0gcjNrX2R1bXBfdGxiLm8KIG9iai0kKENPTkZJR19DUFVfVFg0OVhY
KQkrPSBkdW1wX3RsYi5vCiBvYmotJChDT05GSUdfQ1BVX1ZSNDFYWCkJKz0gZHVtcF90bGIubwor
b2JqLSQoQ09ORklHX0NQVV80S1NDKQkJKz0gZHVtcF90bGIubworb2JqLSQoQ09ORklHX0NQVV80
S1NEKQkJKz0gZHVtcF90bGIubwogCiBFWFRSQV9BRkxBR1MgOj0gJChDRkxBR1MpCmRpZmYgLU51
cnAgbGludXgtMi42LjE0LXJjMi1taXBzY3ZzL2FyY2gvbWlwcy9NYWtlZmlsZSBsaW51eC0yLjYu
MTQtcmMyLW1pcHNjdnMtNEtTeC9hcmNoL21pcHMvTWFrZWZpbGUKLS0tIGxpbnV4LTIuNi4xNC1y
YzItbWlwc2N2cy9hcmNoL21pcHMvTWFrZWZpbGUJMjAwNS0wOS0xNSAxMDo1MzoxMC4wMDAwMDAw
MDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xNC1yYzItbWlwc2N2cy00S1N4L2FyY2gvbWlwcy9NYWtl
ZmlsZQkyMDA1LTEwLTA0IDA5OjI1OjIxLjAwMDAwMDAwMCArMDIwMApAQCAtMjM3LDYgKzIzNywx
NCBAQCBjZmxhZ3MtJChDT05GSUdfQ1BVX1IxMDAwMCkJKz0gXAogCQkJJChjYWxsIHNldF9nY2Nm
bGFncyxyMTAwMDAsbWlwczQscjgwMDAsbWlwczQsbWlwczIpIFwKIAkJCS1XYSwtLXRyYXAKIAor
Y2ZsYWdzLSQoQ09ORklHX0NQVV80S1NDKQkrPSBcCisJCQkkKGNhbGwgc2V0X2djY2ZsYWdzLDRr
ZWMsbWlwczMycjIscjQ2MDAsbWlwczMsbWlwczIpIFwKKwkJCS1tc21hcnRtaXBzIC1XYSwtLXRy
YXAKKworY2ZsYWdzLSQoQ09ORklHX0NQVV80S1NEKQkrPSBcCisJCQkkKGNhbGwgc2V0X2djY2Zs
YWdzLDRrZWMsbWlwczMycjIscjQ2MDAsbWlwczMsbWlwczIpIFwKKwkJCS1tc21hcnRtaXBzIC1X
YSwtLXRyYXAKKwogaWZkZWYgQ09ORklHX0NQVV9TQjEKIGlmZGVmIENPTkZJR19TQjFfUEFTU18x
X1dPUktBUk9VTkRTCiBNT0RGTEFHUwkrPSAtbXNiMS1wYXNzMS13b3JrYXJvdW5kcwpkaWZmIC1O
dXJwIGxpbnV4LTIuNi4xNC1yYzItbWlwc2N2cy9hcmNoL21pcHMvbW0vY2FjaGUuYyBsaW51eC0y
LjYuMTQtcmMyLW1pcHNjdnMtNEtTeC9hcmNoL21pcHMvbW0vY2FjaGUuYwotLS0gbGludXgtMi42
LjE0LXJjMi1taXBzY3ZzL2FyY2gvbWlwcy9tbS9jYWNoZS5jCTIwMDUtMDctMDYgMTQ6MDg6MTQu
MDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMTQtcmMyLW1pcHNjdnMtNEtTeC9hcmNoL21p
cHMvbW0vY2FjaGUuYwkyMDA1LTEwLTA0IDA5OjQ2OjU2LjAwMDAwMDAwMCArMDIwMApAQCAtMTIw
LDcgKzEyMCw4IEBAIHZvaWQgX19pbml0IGNwdV9jYWNoZV9pbml0KHZvaWQpCiAgICAgZGVmaW5l
ZChDT05GSUdfQ1BVX05FVkFEQSkgfHwgZGVmaW5lZChDT05GSUdfQ1BVX1I1NDMyKSAgfHwgXAog
ICAgIGRlZmluZWQoQ09ORklHX0NQVV9SNTUwMCkgIHx8IGRlZmluZWQoQ09ORklHX0NQVV9NSVBT
MzJfUjEpIHx8IFwKICAgICBkZWZpbmVkKENPTkZJR19DUFVfTUlQUzY0X1IxKSB8fCBkZWZpbmVk
KENPTkZJR19DUFVfVFg0OVhYKSB8fCBcCi0gICAgZGVmaW5lZChDT05GSUdfQ1BVX1JNNzAwMCkg
fHwgZGVmaW5lZChDT05GSUdfQ1BVX1JNOTAwMCkKKyAgICBkZWZpbmVkKENPTkZJR19DUFVfUk03
MDAwKSB8fCBkZWZpbmVkKENPTkZJR19DUFVfUk05MDAwKSB8fCBcCisgICAgZGVmaW5lZChDT05G
SUdfQ1BVXzRLU0MpICAgfHwgZGVmaW5lZChDT05GSUdfQ1BVXzRLU0QpCiAJCWxkX21tdV9yNHh4
MCgpOwogI2VuZGlmCiAJfSBlbHNlIHN3aXRjaCAoY3VycmVudF9jcHVfZGF0YS5jcHV0eXBlKSB7
CmRpZmYgLU51cnAgbGludXgtMi42LjE0LXJjMi1taXBzY3ZzL2FyY2gvbWlwcy9tbS9NYWtlZmls
ZSBsaW51eC0yLjYuMTQtcmMyLW1pcHNjdnMtNEtTeC9hcmNoL21pcHMvbW0vTWFrZWZpbGUKLS0t
IGxpbnV4LTIuNi4xNC1yYzItbWlwc2N2cy9hcmNoL21pcHMvbW0vTWFrZWZpbGUJMjAwNS0wNy0x
NCAxNDowNTowNi4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xNC1yYzItbWlwc2N2cy00
S1N4L2FyY2gvbWlwcy9tbS9NYWtlZmlsZQkyMDA1LTEwLTA0IDA5OjQ1OjE3LjAwMDAwMDAwMCAr
MDIwMApAQCAtMjYsNiArMjYsOCBAQCBvYmotJChDT05GSUdfQ1BVX1NCMSkJCSs9IGMtc2IxLm8g
Y2Vyci1zCiBvYmotJChDT05GSUdfQ1BVX1RYMzlYWCkJKz0gYy10eDM5Lm8gcGctcjRrLm8gdGxi
LXIzay5vCiBvYmotJChDT05GSUdfQ1BVX1RYNDlYWCkJKz0gYy1yNGsubyBjZXgtZ2VuLm8gcGct
cjRrLm8gdGxiLXI0ay5vCiBvYmotJChDT05GSUdfQ1BVX1ZSNDFYWCkJKz0gYy1yNGsubyBjZXgt
Z2VuLm8gcGctcjRrLm8gdGxiLXI0ay5vCitvYmotJChDT05GSUdfQ1BVXzRLU0MpCQkrPSBjLXI0
ay5vIGNleC1nZW4ubyBwZy1yNGsubyB0bGItcjRrLm8KK29iai0kKENPTkZJR19DUFVfNEtTRCkJ
CSs9IGMtcjRrLm8gY2V4LWdlbi5vIHBnLXI0ay5vIHRsYi1yNGsubwogCiBvYmotJChDT05GSUdf
SVAyMl9DUFVfU0NBQ0hFKQkrPSBzYy1pcDIyLm8KIG9iai0kKENPTkZJR19SNTAwMF9DUFVfU0NB
Q0hFKSAgKz0gc2MtcjVrLm8KZGlmZiAtTnVycCBsaW51eC0yLjYuMTQtcmMyLW1pcHNjdnMvaW5j
bHVkZS9hc20tbWlwcy9tb2R1bGUuaCBsaW51eC0yLjYuMTQtcmMyLW1pcHNjdnMtNEtTeC9pbmNs
dWRlL2FzbS1taXBzL21vZHVsZS5oCi0tLSBsaW51eC0yLjYuMTQtcmMyLW1pcHNjdnMvaW5jbHVk
ZS9hc20tbWlwcy9tb2R1bGUuaAkyMDA1LTA5LTE0IDEyOjM1OjM3LjAwMDAwMDAwMCArMDIwMAor
KysgbGludXgtMi42LjE0LXJjMi1taXBzY3ZzLTRLU3gvaW5jbHVkZS9hc20tbWlwcy9tb2R1bGUu
aAkyMDA1LTEwLTA0IDA5OjU1OjM0LjAwMDAwMDAwMCArMDIwMApAQCAtMTEzLDcgKzExMywxMSBA
QCBzZWFyY2hfbW9kdWxlX2RiZXRhYmxlcyh1bnNpZ25lZCBsb25nIGFkCiAjZGVmaW5lIE1PRFVM
RV9QUk9DX0ZBTUlMWSAiUk05MDAwIgogI2VsaWYgZGVmaW5lZCBDT05GSUdfQ1BVX1NCMQogI2Rl
ZmluZSBNT0RVTEVfUFJPQ19GQU1JTFkgIlNCMSIKLSNlbGlmCisjZWxpZiBkZWZpbmVkIENPTkZJ
R19DUFVfNEtTQworI2RlZmluZSBNT0RVTEVfUFJPQ19GQU1JTFkgIjRLU0MiCisjZWxpZiBkZWZp
bmVkIENPTkZJR19DUFVfNEtTRAorI2RlZmluZSBNT0RVTEVfUFJPQ19GQU1JTFkgIjRLU0QiCisj
ZWxzZQogI2Vycm9yIE1PRFVMRV9QUk9DX0ZBTUlMWSB1bmRlZmluZWQgZm9yIHlvdXIgcHJvY2Vz
c29yIGNvbmZpZ3VyYXRpb24KICNlbmRpZgogCg==
------=_Part_3451_12254408.1128415784694--
