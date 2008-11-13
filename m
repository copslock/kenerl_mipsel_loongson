Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2008 19:50:37 +0000 (GMT)
Received: from mail.zeugmasystems.com ([192.139.122.66]:50248 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S23661971AbYKMTuf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Nov 2008 19:50:35 +0000
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C945C9.141FDD8B"
Subject: [PATCH] ptrace syscall cleanups for mips compat archs
Date:	Thu, 13 Nov 2008 11:50:12 -0800
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C50144BC0F@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ptrace syscall cleanups for mips compat archs
Thread-Index: AclFyQZMlMwnGZlJQ4ORamqDWC1rqQ==
From:	"Anirban Sinha" <ASinha@zeugmasystems.com>
To:	<ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Cc:	"Kaz Kylheku" <KKylheku@zeugmasystems.com>
Return-Path: <ASinha@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ASinha@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01C945C9.141FDD8B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Ralf:

I have been looking into some of the very recent cleanups that has been
done to compat_sys_ptrace() after 2.6.26. I believe we can clean up the
system call further. I am proposing the attached patch to this end. Let
me know what you feel.

Cheers,

Ani


------_=_NextPart_001_01C945C9.141FDD8B
Content-Type: application/octet-stream;
	name="ptrace-cleanup-patch"
Content-Transfer-Encoding: base64
Content-Description: ptrace-cleanup-patch
Content-Disposition: attachment;
	filename="ptrace-cleanup-patch"

SW5kZXg6IG1pcHMtZ2l0L2FyY2gvbWlwcy9rZXJuZWwvcHRyYWNlMzIuYwo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0t
LSBtaXBzLWdpdC5vcmlnL2FyY2gvbWlwcy9rZXJuZWwvcHRyYWNlMzIuYworKysgbWlwcy1naXQv
YXJjaC9taXBzL2tlcm5lbC9wdHJhY2UzMi5jCkBAIC00OSwxOSArNDksNiBAQCBsb25nIGNvbXBh
dF9hcmNoX3B0cmFjZShzdHJ1Y3QgdGFza19zdHJ1CiAJaW50IHJldDsKIAogCXN3aXRjaCAocmVx
dWVzdCkgewotCS8qIHdoZW4gSSBhbmQgRCBzcGFjZSBhcmUgc2VwYXJhdGUsIHRoZXNlIHdpbGwg
bmVlZCB0byBiZSBmaXhlZC4gKi8KLQljYXNlIFBUUkFDRV9QRUVLVEVYVDogLyogcmVhZCB3b3Jk
IGF0IGxvY2F0aW9uIGFkZHIuICovCi0JY2FzZSBQVFJBQ0VfUEVFS0RBVEE6IHsKLQkJdW5zaWdu
ZWQgaW50IHRtcDsKLQkJaW50IGNvcGllZDsKLQotCQljb3BpZWQgPSBhY2Nlc3NfcHJvY2Vzc192
bShjaGlsZCwgYWRkciwgJnRtcCwgc2l6ZW9mKHRtcCksIDApOwotCQlyZXQgPSAtRUlPOwotCQlp
ZiAoY29waWVkICE9IHNpemVvZih0bXApKQotCQkJYnJlYWs7Ci0JCXJldCA9IHB1dF91c2VyKHRt
cCwgKHVuc2lnbmVkIGludCBfX3VzZXIgKikgKHVuc2lnbmVkIGxvbmcpIGRhdGEpOwotCQlicmVh
azsKLQl9CiAKIAkvKgogCSAqIFJlYWQgNCBieXRlcyBvZiB0aGUgb3RoZXIgcHJvY2Vzcycgc3Rv
cmFnZQpAQCAtMjA4LDE2ICsxOTUsNiBAQCBsb25nIGNvbXBhdF9hcmNoX3B0cmFjZShzdHJ1Y3Qg
dGFza19zdHJ1CiAJCWJyZWFrOwogCX0KIAotCS8qIHdoZW4gSSBhbmQgRCBzcGFjZSBhcmUgc2Vw
YXJhdGUsIHRoaXMgd2lsbCBoYXZlIHRvIGJlIGZpeGVkLiAqLwotCWNhc2UgUFRSQUNFX1BPS0VU
RVhUOiAvKiB3cml0ZSB0aGUgd29yZCBhdCBsb2NhdGlvbiBhZGRyLiAqLwotCWNhc2UgUFRSQUNF
X1BPS0VEQVRBOgotCQlyZXQgPSAwOwotCQlpZiAoYWNjZXNzX3Byb2Nlc3Nfdm0oY2hpbGQsIGFk
ZHIsICZkYXRhLCBzaXplb2YoZGF0YSksIDEpCi0JCSAgICA9PSBzaXplb2YoZGF0YSkpCi0JCQli
cmVhazsKLQkJcmV0ID0gLUVJTzsKLQkJYnJlYWs7Ci0KIAkvKgogCSAqIFdyaXRlIDQgYnl0ZXMg
aW50byB0aGUgb3RoZXIgcHJvY2Vzcycgc3RvcmFnZQogCSAqICBkYXRhIGlzIHRoZSA0IGJ5dGVz
IHRoYXQgdGhlIHVzZXIgd2FudHMgd3JpdHRlbgpAQCAtMzMyLDUwICszMDksMTEgQEAgbG9uZyBj
b21wYXRfYXJjaF9wdHJhY2Uoc3RydWN0IHRhc2tfc3RydQogCQlyZXQgPSBwdHJhY2Vfc2V0ZnBy
ZWdzKGNoaWxkLCAoX191MzIgX191c2VyICopIChfX3U2NCkgZGF0YSk7CiAJCWJyZWFrOwogCi0J
Y2FzZSBQVFJBQ0VfU1lTQ0FMTDogLyogY29udGludWUgYW5kIHN0b3AgYXQgbmV4dCAocmV0dXJu
IGZyb20pIHN5c2NhbGwgKi8KLQljYXNlIFBUUkFDRV9DT05UOiB7IC8qIHJlc3RhcnQgYWZ0ZXIg
c2lnbmFsLiAqLwotCQlyZXQgPSAtRUlPOwotCQlpZiAoIXZhbGlkX3NpZ25hbChkYXRhKSkKLQkJ
CWJyZWFrOwotCQlpZiAocmVxdWVzdCA9PSBQVFJBQ0VfU1lTQ0FMTCkgewotCQkJc2V0X3Rza190
aHJlYWRfZmxhZyhjaGlsZCwgVElGX1NZU0NBTExfVFJBQ0UpOwotCQl9Ci0JCWVsc2UgewotCQkJ
Y2xlYXJfdHNrX3RocmVhZF9mbGFnKGNoaWxkLCBUSUZfU1lTQ0FMTF9UUkFDRSk7Ci0JCX0KLQkJ
Y2hpbGQtPmV4aXRfY29kZSA9IGRhdGE7Ci0JCXdha2VfdXBfcHJvY2VzcyhjaGlsZCk7Ci0JCXJl
dCA9IDA7Ci0JCWJyZWFrOwotCX0KLQotCS8qCi0JICogbWFrZSB0aGUgY2hpbGQgZXhpdC4gIEJl
c3QgSSBjYW4gZG8gaXMgc2VuZCBpdCBhIHNpZ2tpbGwuCi0JICogcGVyaGFwcyBpdCBzaG91bGQg
YmUgcHV0IGluIHRoZSBzdGF0dXMgdGhhdCBpdCB3YW50cyB0bwotCSAqIGV4aXQuCi0JICovCi0J
Y2FzZSBQVFJBQ0VfS0lMTDoKLQkJcmV0ID0gMDsKLQkJaWYgKGNoaWxkLT5leGl0X3N0YXRlID09
IEVYSVRfWk9NQklFKQkvKiBhbHJlYWR5IGRlYWQgKi8KLQkJCWJyZWFrOwotCQljaGlsZC0+ZXhp
dF9jb2RlID0gU0lHS0lMTDsKLQkJd2FrZV91cF9wcm9jZXNzKGNoaWxkKTsKLQkJYnJlYWs7Ci0K
IAljYXNlIFBUUkFDRV9HRVRfVEhSRUFEX0FSRUE6CiAJCXJldCA9IHB1dF91c2VyKHRhc2tfdGhy
ZWFkX2luZm8oY2hpbGQpLT50cF92YWx1ZSwKIAkJCQkodW5zaWduZWQgaW50IF9fdXNlciAqKSAo
dW5zaWduZWQgbG9uZykgZGF0YSk7CiAJCWJyZWFrOwogCi0JY2FzZSBQVFJBQ0VfREVUQUNIOiAv
KiBkZXRhY2ggYSBwcm9jZXNzIHRoYXQgd2FzIGF0dGFjaGVkLiAqLwotCQlyZXQgPSBwdHJhY2Vf
ZGV0YWNoKGNoaWxkLCBkYXRhKTsKLQkJYnJlYWs7Ci0KLQljYXNlIFBUUkFDRV9HRVRFVkVOVE1T
RzoKLQkJcmV0ID0gcHV0X3VzZXIoY2hpbGQtPnB0cmFjZV9tZXNzYWdlLAotCQkJICAgICAgICh1
bnNpZ25lZCBpbnQgX191c2VyICopICh1bnNpZ25lZCBsb25nKSBkYXRhKTsKLQkJYnJlYWs7Ci0K
IAljYXNlIFBUUkFDRV9HRVRfVEhSRUFEX0FSRUFfMzI2NDoKIAkJcmV0ID0gcHV0X3VzZXIodGFz
a190aHJlYWRfaW5mbyhjaGlsZCktPnRwX3ZhbHVlLAogCQkJCSh1bnNpZ25lZCBsb25nIF9fdXNl
ciAqKSAodW5zaWduZWQgbG9uZykgZGF0YSk7CkBAIC0zOTIsNyArMzMwLDcgQEAgbG9uZyBjb21w
YXRfYXJjaF9wdHJhY2Uoc3RydWN0IHRhc2tfc3RydQogCQlicmVhazsKIAogCWRlZmF1bHQ6Ci0J
CXJldCA9IHB0cmFjZV9yZXF1ZXN0KGNoaWxkLCByZXF1ZXN0LCBhZGRyLCBkYXRhKTsKKwkJcmV0
ID0gY29tcGF0X3B0cmFjZV9yZXF1ZXN0KGNoaWxkLCByZXF1ZXN0LCBhZGRyLCBkYXRhKTsKIAkJ
YnJlYWs7CiAJfQogb3V0Ogo=

------_=_NextPart_001_01C945C9.141FDD8B--
