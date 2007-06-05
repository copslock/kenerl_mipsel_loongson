Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jun 2007 10:43:04 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.168]:29996 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021765AbXFEJnB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 5 Jun 2007 10:43:01 +0100
Received: by ug-out-1314.google.com with SMTP id m3so127159ugc
        for <linux-mips@linux-mips.org>; Tue, 05 Jun 2007 02:42:00 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:x-mailer:reply-to:x-priority:message-id:to:subject:mime-version:content-type;
        b=XC7CMK5pd6IYW7lHPvaj/rTOG+Rj5RkCR0hGJuc1qYkm9BTaGsSaDzPTA7ecg7OQwGi2M8r+AiiDi7LOJto1ncAEim4S7ohTHZxTsSKwBPSmX8koIE+kbsB2qngeBkUXBj+gQa1D7eMpGGNravsQk5IU8EB/FhAFtALjfwB4yK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:x-mailer:reply-to:x-priority:message-id:to:subject:mime-version:content-type;
        b=UPNrzo9qArqP7mjgRIzZ4P3/qXZh6Jn/qgy9rQdPuDFLmrK1OHeL4ZpQrdES0R7HBmimgAqF+KMicTLQi3QU8psizA4lZkUWcMR9knbznvQLXGPn+eAylwdZGYbESjkfkJbfniWIJT0RxdTiZpD7DUKX6NoYT4gELUlyINPYVOU=
Received: by 10.78.170.6 with SMTP id s6mr2338779hue.1181036520671;
        Tue, 05 Jun 2007 02:42:00 -0700 (PDT)
Received: from PAVEL-57E50373D ( [85.141.175.237])
        by mx.google.com with ESMTP id 34sm515066nfu.2007.06.05.02.41.58;
        Tue, 05 Jun 2007 02:41:59 -0700 (PDT)
Date:	Tue, 5 Jun 2007 13:42:20 +0400
From:	Pavel Kiryukhin <vksavl@gmail.com>
X-Mailer: The Bat! (v3.80.06) Professional
Reply-To: Pavel Kiryukhin <vksavl@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <97136920.20070605134220@gmail.com>
To:	linux-mips@linux-mips.org
Subject: use compat_siginfo in rt_sigframe_n32
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----------671721163521A93E"
Return-Path: <vksavl@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vksavl@gmail.com
Precedence: bulk
X-list: linux-mips

------------671721163521A93E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

There was an old patch
<http://www.linux-mips.org/archives/linux-mips/2006-07/msg00216.html>
that suggested (also) to use compat_siginfo in rt_sigframe_n32.
It seems that it is still an issue.
-- 
Regards,
 Pavel                          mailto:vksavl@gmail.com
------------671721163521A93E
Content-Type: application/octet-stream; name="compat_siginfo-in-copy_siginfo_to_user32.patch"
Content-transfer-encoding: base64
Content-Disposition: attachment; filename="compat_siginfo-in-copy_siginfo_to_user32.patch"

RnJvbTogUGF2ZWwgS2lyeXVraGluIDx2a3NhdmxAZ21haWwuY29tPgpEYXRlOiBUdWUsIDUg
SnVuIDIwMDcgMTE6NTE6MTkgKzA0MDAKU3ViamVjdDogW1BBVENIXSBVc2UgY29tcGF0X3Np
Z2luZm8gYW5kIGNvcHlfc2lnaW5mb190b191c2VyMzIgaW4gc2V0dXBfcnRfZnJhbWVfbjMy
KCkuClNpZ25lZC1vZmYtYnk6IFBhdmVsIEtpcnl1a2hpbiA8dmtzYXZsQGdtYWlsLmNvbT4K
CmRpZmYgLS1naXQgYS9hcmNoL21pcHMva2VybmVsL3NpZ25hbC1jb21tb24uaCBiL2FyY2gv
bWlwcy9rZXJuZWwvc2lnbmFsLWNvbW1vbi5oCmluZGV4IGMwZmFhYmQuLjhjYzhhODggMTAw
NjQ0Ci0tLSBhL2FyY2gvbWlwcy9rZXJuZWwvc2lnbmFsLWNvbW1vbi5oCisrKyBiL2FyY2gv
bWlwcy9rZXJuZWwvc2lnbmFsLWNvbW1vbi5oCkBAIC00Myw0ICs0Myw2OCBAQCBleHRlcm4g
aW50IGZwY3NyX3BlbmRpbmcodW5zaWduZWQgaW50IF9fdXNlciAqZnBjc3IpOwogI2RlZmlu
ZSB1bmxvY2tfZnB1X293bmVyKCkJcGFnZWZhdWx0X2VuYWJsZSgpCiAjZW5kaWYKIAorI2lu
Y2x1ZGUgPGxpbnV4L2NvbXBhdC5oPgorCisjZGVmaW5lIFNJX1BBRF9TSVpFMzIgICAoKFNJ
X01BWF9TSVpFL3NpemVvZihpbnQpKSAtIDMpCisKK3R5cGVkZWYgc3RydWN0IGNvbXBhdF9z
aWdpbmZvIHsKKyAgICAgICAgaW50IHNpX3NpZ25vOworICAgICAgICBpbnQgc2lfY29kZTsK
KyAgICAgICAgaW50IHNpX2Vycm5vOworCisgICAgICAgIHVuaW9uIHsKKyAgICAgICAgICAg
ICAgICBpbnQgX3BhZFtTSV9QQURfU0laRTMyXTsKKworICAgICAgICAgICAgICAgIC8qIGtp
bGwoKSAqLworICAgICAgICAgICAgICAgIHN0cnVjdCB7CisgICAgICAgICAgICAgICAgICAg
ICAgICBjb21wYXRfcGlkX3QgX3BpZDsgICAgICAvKiBzZW5kZXIncyBwaWQgKi8KKyAgICAg
ICAgICAgICAgICAgICAgICAgIGNvbXBhdF91aWRfdCBfdWlkOyAgICAgIC8qIHNlbmRlcidz
IHVpZCAqLworICAgICAgICAgICAgICAgIH0gX2tpbGw7CisKKyAgICAgICAgICAgICAgICAv
KiBTSUdDSExEICovCisgICAgICAgICAgICAgICAgc3RydWN0IHsKKyAgICAgICAgICAgICAg
ICAgICAgICAgIGNvbXBhdF9waWRfdCBfcGlkOyAgICAgIC8qIHdoaWNoIGNoaWxkICovCisg
ICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRfdWlkX3QgX3VpZDsgICAgICAvKiBzZW5k
ZXIncyB1aWQgKi8KKyAgICAgICAgICAgICAgICAgICAgICAgIGludCBfc3RhdHVzOyAgICAg
ICAgICAgIC8qIGV4aXQgY29kZSAqLworICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0
X2Nsb2NrX3QgX3V0aW1lOworICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0X2Nsb2Nr
X3QgX3N0aW1lOworICAgICAgICAgICAgICAgIH0gX3NpZ2NobGQ7CisKKyAgICAgICAgICAg
ICAgICAvKiBJUklYIFNJR0NITEQgKi8KKyAgICAgICAgICAgICAgICBzdHJ1Y3QgeworICAg
ICAgICAgICAgICAgICAgICAgICAgY29tcGF0X3BpZF90IF9waWQ7ICAgICAgLyogd2hpY2gg
Y2hpbGQgKi8KKyAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdF9jbG9ja190IF91dGlt
ZTsKKyAgICAgICAgICAgICAgICAgICAgICAgIGludCBfc3RhdHVzOyAgICAgICAgICAgIC8q
IGV4aXQgY29kZSAqLworICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0X2Nsb2NrX3Qg
X3N0aW1lOworICAgICAgICAgICAgICAgIH0gX2lyaXhfc2lnY2hsZDsKKworICAgICAgICAg
ICAgICAgIC8qIFNJR0lMTCwgU0lHRlBFLCBTSUdTRUdWLCBTSUdCVVMgKi8KKyAgICAgICAg
ICAgICAgICBzdHJ1Y3QgeworICAgICAgICAgICAgICAgICAgICAgICAgczMyIF9hZGRyOyAv
KiBmYXVsdGluZyBpbnNuL21lbW9yeSByZWYuICovCisgICAgICAgICAgICAgICAgfSBfc2ln
ZmF1bHQ7CisKKyAgICAgICAgICAgICAgICAvKiBTSUdQT0xMLCBTSUdYRlNaIChUbyBkbyAu
Li4pICAqLworICAgICAgICAgICAgICAgIHN0cnVjdCB7CisgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQgX2JhbmQ7ICAgICAgLyogUE9MTF9JTiwgUE9MTF9PVVQsIFBPTExfTVNHICov
CisgICAgICAgICAgICAgICAgICAgICAgICBpbnQgX2ZkOworICAgICAgICAgICAgICAgIH0g
X3NpZ3BvbGw7CisKKyAgICAgICAgICAgICAgICAvKiBQT1NJWC4xYiB0aW1lcnMgKi8KKyAg
ICAgICAgICAgICAgICBzdHJ1Y3QgeworICAgICAgICAgICAgICAgICAgICAgICAgdGltZXJf
dCBfdGlkOyAgICAgICAgICAgLyogdGltZXIgaWQgKi8KKyAgICAgICAgICAgICAgICAgICAg
ICAgIGludCBfb3ZlcnJ1bjsgICAgICAgICAgIC8qIG92ZXJydW4gY291bnQgKi8KKyAgICAg
ICAgICAgICAgICAgICAgICAgIGNvbXBhdF9zaWd2YWxfdCBfc2lndmFsOy8qIHNhbWUgYXMg
YmVsb3cgKi8KKyAgICAgICAgICAgICAgICAgICAgICAgIGludCBfc3lzX3ByaXZhdGU7ICAg
ICAgIC8qIG5vdCB0byBiZSBwYXNzZWQgdG8gdXNlciAqLworICAgICAgICAgICAgICAgIH0g
X3RpbWVyOworCisgICAgICAgICAgICAgICAgLyogUE9TSVguMWIgc2lnbmFscyAqLworICAg
ICAgICAgICAgICAgIHN0cnVjdCB7CisgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRf
cGlkX3QgX3BpZDsgICAgICAvKiBzZW5kZXIncyBwaWQgKi8KKyAgICAgICAgICAgICAgICAg
ICAgICAgIGNvbXBhdF91aWRfdCBfdWlkOyAgICAgIC8qIHNlbmRlcidzIHVpZCAqLworICAg
ICAgICAgICAgICAgICAgICAgICAgY29tcGF0X3NpZ3ZhbF90IF9zaWd2YWw7CisgICAgICAg
ICAgICAgICAgfSBfcnQ7CisKKyAgICAgICAgfSBfc2lmaWVsZHM7Cit9IGNvbXBhdF9zaWdp
bmZvX3Q7CisKICNlbmRpZgkvKiBfX1NJR05BTF9DT01NT05fSCAqLwpkaWZmIC0tZ2l0IGEv
YXJjaC9taXBzL2tlcm5lbC9zaWduYWwzMi5jIGIvYXJjaC9taXBzL2tlcm5lbC9zaWduYWwz
Mi5jCmluZGV4IDAwM2Y4MTUuLjQ4NmI4ZTUgMTAwNjQ0Ci0tLSBhL2FyY2gvbWlwcy9rZXJu
ZWwvc2lnbmFsMzIuYworKysgYi9hcmNoL21pcHMva2VybmVsL3NpZ25hbDMyLmMKQEAgLTM2
LDY4ICszNiw2IEBACiAKICNpbmNsdWRlICJzaWduYWwtY29tbW9uLmgiCiAKLSNkZWZpbmUg
U0lfUEFEX1NJWkUzMiAgICgoU0lfTUFYX1NJWkUvc2l6ZW9mKGludCkpIC0gMykKLQotdHlw
ZWRlZiBzdHJ1Y3QgY29tcGF0X3NpZ2luZm8gewotCWludCBzaV9zaWdubzsKLQlpbnQgc2lf
Y29kZTsKLQlpbnQgc2lfZXJybm87Ci0KLQl1bmlvbiB7Ci0JCWludCBfcGFkW1NJX1BBRF9T
SVpFMzJdOwotCi0JCS8qIGtpbGwoKSAqLwotCQlzdHJ1Y3QgewotCQkJY29tcGF0X3BpZF90
IF9waWQ7CS8qIHNlbmRlcidzIHBpZCAqLwotCQkJY29tcGF0X3VpZF90IF91aWQ7CS8qIHNl
bmRlcidzIHVpZCAqLwotCQl9IF9raWxsOwotCi0JCS8qIFNJR0NITEQgKi8KLQkJc3RydWN0
IHsKLQkJCWNvbXBhdF9waWRfdCBfcGlkOwkvKiB3aGljaCBjaGlsZCAqLwotCQkJY29tcGF0
X3VpZF90IF91aWQ7CS8qIHNlbmRlcidzIHVpZCAqLwotCQkJaW50IF9zdGF0dXM7CQkvKiBl
eGl0IGNvZGUgKi8KLQkJCWNvbXBhdF9jbG9ja190IF91dGltZTsKLQkJCWNvbXBhdF9jbG9j
a190IF9zdGltZTsKLQkJfSBfc2lnY2hsZDsKLQotCQkvKiBJUklYIFNJR0NITEQgKi8KLQkJ
c3RydWN0IHsKLQkJCWNvbXBhdF9waWRfdCBfcGlkOwkvKiB3aGljaCBjaGlsZCAqLwotCQkJ
Y29tcGF0X2Nsb2NrX3QgX3V0aW1lOwotCQkJaW50IF9zdGF0dXM7CQkvKiBleGl0IGNvZGUg
Ki8KLQkJCWNvbXBhdF9jbG9ja190IF9zdGltZTsKLQkJfSBfaXJpeF9zaWdjaGxkOwotCi0J
CS8qIFNJR0lMTCwgU0lHRlBFLCBTSUdTRUdWLCBTSUdCVVMgKi8KLQkJc3RydWN0IHsKLQkJ
CXMzMiBfYWRkcjsgLyogZmF1bHRpbmcgaW5zbi9tZW1vcnkgcmVmLiAqLwotCQl9IF9zaWdm
YXVsdDsKLQotCQkvKiBTSUdQT0xMLCBTSUdYRlNaIChUbyBkbyAuLi4pICAqLwotCQlzdHJ1
Y3QgewotCQkJaW50IF9iYW5kOwkvKiBQT0xMX0lOLCBQT0xMX09VVCwgUE9MTF9NU0cgKi8K
LQkJCWludCBfZmQ7Ci0JCX0gX3NpZ3BvbGw7Ci0KLQkJLyogUE9TSVguMWIgdGltZXJzICov
Ci0JCXN0cnVjdCB7Ci0JCQl0aW1lcl90IF90aWQ7CQkvKiB0aW1lciBpZCAqLwotCQkJaW50
IF9vdmVycnVuOwkJLyogb3ZlcnJ1biBjb3VudCAqLwotCQkJY29tcGF0X3NpZ3ZhbF90IF9z
aWd2YWw7Lyogc2FtZSBhcyBiZWxvdyAqLwotCQkJaW50IF9zeXNfcHJpdmF0ZTsgICAgICAg
Lyogbm90IHRvIGJlIHBhc3NlZCB0byB1c2VyICovCi0JCX0gX3RpbWVyOwotCi0JCS8qIFBP
U0lYLjFiIHNpZ25hbHMgKi8KLQkJc3RydWN0IHsKLQkJCWNvbXBhdF9waWRfdCBfcGlkOwkv
KiBzZW5kZXIncyBwaWQgKi8KLQkJCWNvbXBhdF91aWRfdCBfdWlkOwkvKiBzZW5kZXIncyB1
aWQgKi8KLQkJCWNvbXBhdF9zaWd2YWxfdCBfc2lndmFsOwotCQl9IF9ydDsKLQotCX0gX3Np
ZmllbGRzOwotfSBjb21wYXRfc2lnaW5mb190OwotCiAvKgogICogSW5jbHVkaW5nIDxhc20v
dW5pc3RkLmg+IHdvdWxkIGdpdmUgdXNlIHRoZSA2NC1iaXQgc3lzY2FsbCBudW1iZXJzIC4u
LgogICovCmRpZmYgLS1naXQgYS9hcmNoL21pcHMva2VybmVsL3NpZ25hbF9uMzIuYyBiL2Fy
Y2gvbWlwcy9rZXJuZWwvc2lnbmFsX24zMi5jCmluZGV4IDRjZjlmZjIuLmViN2UwNTkgMTAw
NjQ0Ci0tLSBhL2FyY2gvbWlwcy9rZXJuZWwvc2lnbmFsX24zMi5jCisrKyBiL2FyY2gvbWlw
cy9rZXJuZWwvc2lnbmFsX24zMi5jCkBAIC03Miw3ICs3Miw3IEBAIHN0cnVjdCB1Y29udGV4
dG4zMiB7CiBzdHJ1Y3QgcnRfc2lnZnJhbWVfbjMyIHsKIAl1MzIgcnNfYXNzWzRdOwkJCS8q
IGFyZ3VtZW50IHNhdmUgc3BhY2UgZm9yIG8zMiAqLwogCXUzMiByc19jb2RlWzJdOwkJCS8q
IHNpZ25hbCB0cmFtcG9saW5lICovCi0Jc3RydWN0IHNpZ2luZm8gcnNfaW5mbzsKKwlzdHJ1
Y3QgY29tcGF0X3NpZ2luZm8gcnNfaW5mbzsKIAlzdHJ1Y3QgdWNvbnRleHRuMzIgcnNfdWM7
CiB9OwogCkBAIC04MSw3ICs4MSw3IEBAIHN0cnVjdCBydF9zaWdmcmFtZV9uMzIgewogc3Ry
dWN0IHJ0X3NpZ2ZyYW1lX24zMiB7CiAJdTMyIHJzX2Fzc1s0XTsJCQkvKiBhcmd1bWVudCBz
YXZlIHNwYWNlIGZvciBvMzIgKi8KIAl1MzIgcnNfcGFkWzJdOwotCXN0cnVjdCBzaWdpbmZv
IHJzX2luZm87CisJc3RydWN0IGNvbXBhdF9zaWdpbmZvIHJzX2luZm87CiAJc3RydWN0IHVj
b250ZXh0bjMyIHJzX3VjOwogCXUzMiByc19jb2RlWzhdIF9fX19jYWNoZWxpbmVfYWxpZ25l
ZDsJCS8qIHNpZ25hbCB0cmFtcG9saW5lICovCiB9OwpAQCAtMTg3LDcgKzE4Nyw3IEBAIHN0
YXRpYyBpbnQgc2V0dXBfcnRfZnJhbWVfbjMyKHN0cnVjdCBrX3NpZ2FjdGlvbiAqIGthLAog
CWluc3RhbGxfc2lndHJhbXAoZnJhbWUtPnJzX2NvZGUsIF9fTlJfTjMyX3J0X3NpZ3JldHVy
bik7CiAKIAkvKiBDcmVhdGUgc2lnaW5mby4gICovCi0JZXJyIHw9IGNvcHlfc2lnaW5mb190
b191c2VyKCZmcmFtZS0+cnNfaW5mbywgaW5mbyk7CisJZXJyIHw9IGNvcHlfc2lnaW5mb190
b191c2VyMzIoJmZyYW1lLT5yc19pbmZvLCBpbmZvKTsKIAogCS8qIENyZWF0ZSB0aGUgdWNv
bnRleHQuICAqLwogCWVyciB8PSBfX3B1dF91c2VyKDAsICZmcmFtZS0+cnNfdWMudWNfZmxh
Z3MpOwotLSAKMS41LjIuMQoK
------------671721163521A93E--
