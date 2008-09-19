Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 07:31:43 +0100 (BST)
Received: from mail-gx0-f10.google.com ([209.85.217.10]:50922 "EHLO
	mail-gx0-f10.google.com") by ftp.linux-mips.org with ESMTP
	id S28786612AbYISGbh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Sep 2008 07:31:37 +0100
Received: by gxk3 with SMTP id 3so357439gxk.0
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2008 23:31:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type;
        bh=IVAbf6lZiuQ8gIWqC461w8CMq1CV4O1SD+ULzQEKmJ8=;
        b=RGzUqQ42TJBGdyevdgWxBlEHuqH/GlG8+BI8OimIYSEM1rqS0cEEGUnAwha9PmQjd2
         Dusup7LoiU61/jW4KiXkdIGtYMzuBxUYRl+ZxLM/HBHeL9rAWhNjLu5af8FD4TyxzBX1
         lT0HYpqSQ0f94K2jH/FoA8n5wn4s4uF6VUFeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=DrH9M+E9WG7H4cYPFwxVuOGdudSM6gEA/boszXjxjSfyUIlgkXNrVAkphL+Ju2dXqT
         TbUBrcj1rYVeXWCT12kNIjigfjdGgqLE8Sa+lPoAvjCPwDKaXgFy20FSRnGq1F4cRXpB
         xlTXWuXDoxrawxlOjRE9UuRz00tR01v55qMkA=
Received: by 10.90.106.6 with SMTP id e6mr6366018agc.31.1221805890000;
        Thu, 18 Sep 2008 23:31:30 -0700 (PDT)
Received: by 10.90.63.18 with HTTP; Thu, 18 Sep 2008 23:31:29 -0700 (PDT)
Message-ID: <a664af430809182331i41c9e344w83ecb2830ac24@mail.gmail.com>
Date:	Fri, 19 Sep 2008 10:31:29 +0400
From:	"Dinar Temirbulatov" <dtemirbulatov@gmail.com>
To:	linux-mips@linux-mips.org
Subject: mmap is broken for MIPS64 n32 and o32 abis
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1151_31304525.1221805889992"
Return-Path: <dtemirbulatov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20541
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dtemirbulatov@gmail.com
Precedence: bulk
X-list: linux-mips

------=_Part_1151_31304525.1221805889992
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I noticed that mmap is not working properly under n32, o32 abis in
MIPS64, for example if we want to map 0xb6000000 address to the
userland under those abis we call  mmap and because the last argument
in old_mmap is off_t and this type is 64-bits wide for MIPS64, we end
up having for example 0xffffffffb6000000 address value. I am sure that
this is not a glibc issue. Following patch adds 32-bit version of mmap
and also it adds mmap64 support for n32 abi since mmap64 was
implemented correctly for n32 too.
                                          thanks, Dinar.

------=_Part_1151_31304525.1221805889992
Content-Type: text/x-patch; name=mmap.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_flafe7v30
Content-Disposition: attachment; filename=mmap.patch

ZGlmZiAtcnVOcCBsaW51eC0yLjYuMjctcmM2L2FyY2gvbWlwcy9rZXJuZWwvc2NhbGw2NC1uMzIu
UyBsaW51eC0yLjYuMjctcmM2LWZpeC9hcmNoL21pcHMva2VybmVsL3NjYWxsNjQtbjMyLlMKLS0t
IGxpbnV4LTIuNi4yNy1yYzYvYXJjaC9taXBzL2tlcm5lbC9zY2FsbDY0LW4zMi5TCTIwMDgtMDkt
MTkgMDk6MzQ6NDIuMDAwMDAwMDAwICswNDAwCisrKyBsaW51eC0yLjYuMjctcmM2LWZpeC9hcmNo
L21pcHMva2VybmVsL3NjYWxsNjQtbjMyLlMJMjAwOC0wOS0xOSAwOTo0NzoxMy4wMDAwMDAwMDAg
KzA0MDAKQEAgLTEyOSw3ICsxMjksNyBAQCBFWFBPUlQoc3lzbjMyX2NhbGxfdGFibGUpCiAJUFRS
CXN5c19uZXdsc3RhdAogCVBUUglzeXNfcG9sbAogCVBUUglzeXNfbHNlZWsKLQlQVFIJb2xkX21t
YXAKKwlQVFIJc3lzMzJfbW1hcAogCVBUUglzeXNfbXByb3RlY3QJCQkvKiA2MDEwICovCiAJUFRS
CXN5c19tdW5tYXAKIAlQVFIJc3lzX2JyawpAQCAtNDEzLDQgKzQxMyw1IEBAIEVYUE9SVChzeXNu
MzJfY2FsbF90YWJsZSkKIAlQVFIJc3lzX2R1cDMJCQkvKiA1MjkwICovCiAJUFRSCXN5c19waXBl
MgogCVBUUglzeXNfaW5vdGlmeV9pbml0MQorICAgICAgICBQVFIJc3lzMzJfbW1hcDIKIAkuc2l6
ZQlzeXNuMzJfY2FsbF90YWJsZSwuLXN5c24zMl9jYWxsX3RhYmxlCmRpZmYgLXJ1TnAgbGludXgt
Mi42LjI3LXJjNi9hcmNoL21pcHMva2VybmVsL3NjYWxsNjQtbzMyLlMgbGludXgtMi42LjI3LXJj
Ni1maXgvYXJjaC9taXBzL2tlcm5lbC9zY2FsbDY0LW8zMi5TCi0tLSBsaW51eC0yLjYuMjctcmM2
L2FyY2gvbWlwcy9rZXJuZWwvc2NhbGw2NC1vMzIuUwkyMDA4LTA5LTE5IDA5OjM0OjQyLjAwMDAw
MDAwMCArMDQwMAorKysgbGludXgtMi42LjI3LXJjNi1maXgvYXJjaC9taXBzL2tlcm5lbC9zY2Fs
bDY0LW8zMi5TCTIwMDgtMDktMTkgMDk6NDc6MjIuMDAwMDAwMDAwICswNDAwCkBAIC0yOTUsNyAr
Mjk1LDcgQEAgc3lzX2NhbGxfdGFibGU6CiAJUFRSCXN5c19zd2Fwb24KIAlQVFIJc3lzX3JlYm9v
dAogCVBUUgljb21wYXRfc3lzX29sZF9yZWFkZGlyCi0JUFRSCW9sZF9tbWFwCQkJLyogNDA5MCAq
LworCVBUUglzeXMzMl9tbWFwCQkJLyogNDA5MCAqLwogCVBUUglzeXNfbXVubWFwCiAJUFRSCXN5
c190cnVuY2F0ZQogCVBUUglzeXNfZnRydW5jYXRlCmRpZmYgLXJ1TnAgbGludXgtMi42LjI3LXJj
Ni9hcmNoL21pcHMva2VybmVsL3N5c2NhbGwuYyBsaW51eC0yLjYuMjctcmM2LWZpeC9hcmNoL21p
cHMva2VybmVsL3N5c2NhbGwuYwotLS0gbGludXgtMi42LjI3LXJjNi9hcmNoL21pcHMva2VybmVs
L3N5c2NhbGwuYwkyMDA4LTA5LTE5IDA5OjM0OjQyLjAwMDAwMDAwMCArMDQwMAorKysgbGludXgt
Mi42LjI3LXJjNi1maXgvYXJjaC9taXBzL2tlcm5lbC9zeXNjYWxsLmMJMjAwOC0wOS0xOSAwOTo0
Njo1Mi4wMDAwMDAwMDAgKzA0MDAKQEAgLTE3MCw2ICsxNzAsMjIgQEAgb3V0OgogfQogCiBhc21s
aW5rYWdlIHVuc2lnbmVkIGxvbmcKK3N5czMyX21tYXAodW5zaWduZWQgbG9uZyBhZGRyLCB1bnNp
Z25lZCBsb25nIGxlbiwgaW50IHByb3QsCisgICAgICAgIGludCBmbGFncywgaW50IGZkLCB1bnNp
Z25lZCBpbnQgb2Zmc2V0IG9mZnNldCkKK3sKKyAgICAgICAgdW5zaWduZWQgbG9uZyByZXN1bHQ7
CisKKyAgICAgICAgcmVzdWx0ID0gLUVJTlZBTDsKKyAgICAgICAgaWYgKG9mZnNldCAmIH5QQUdF
X01BU0spCisgICAgICAgICAgICAgICAgZ290byBvdXQ7CisKKyAgICAgICAgcmVzdWx0ID0gZG9f
bW1hcDIoYWRkciwgbGVuLCBwcm90LCBmbGFncywgZmQsICh1bnNpZ25lZCBsb25nKSBvZmZzZXQg
Pj4gUEFHRV9TSElGVCk7CisKK291dDoKKyAgICAgICAgcmV0dXJuIHJlc3VsdDsKK30KKworYXNt
bGlua2FnZSB1bnNpZ25lZCBsb25nCiBzeXNfbW1hcDIodW5zaWduZWQgbG9uZyBhZGRyLCB1bnNp
Z25lZCBsb25nIGxlbiwgdW5zaWduZWQgbG9uZyBwcm90LAogICAgICAgICAgIHVuc2lnbmVkIGxv
bmcgZmxhZ3MsIHVuc2lnbmVkIGxvbmcgZmQsIHVuc2lnbmVkIGxvbmcgcGdvZmYpCiB7CmRpZmYg
LXJ1TnAgbGludXgtMi42LjI3LXJjNi9pbmNsdWRlL2FzbS1taXBzL3VuaXN0ZC5oIGxpbnV4LTIu
Ni4yNy1yYzYtZml4L2luY2x1ZGUvYXNtLW1pcHMvdW5pc3RkLmgKLS0tIGxpbnV4LTIuNi4yNy1y
YzYvaW5jbHVkZS9hc20tbWlwcy91bmlzdGQuaAkyMDA4LTA5LTE5IDA5OjM0OjQzLjAwMDAwMDAw
MCArMDQwMAorKysgbGludXgtMi42LjI3LXJjNi1maXgvaW5jbHVkZS9hc20tbWlwcy91bmlzdGQu
aAkyMDA4LTA5LTE5IDA5OjUwOjI2LjAwMDAwMDAwMCArMDQwMApAQCAtOTY2LDExICs5NjYsMTIg
QEAKICNkZWZpbmUgX19OUl9kdXAzCQkJKF9fTlJfTGludXggKyAyOTApCiAjZGVmaW5lIF9fTlJf
cGlwZTIJCQkoX19OUl9MaW51eCArIDI5MSkKICNkZWZpbmUgX19OUl9pbm90aWZ5X2luaXQxCQko
X19OUl9MaW51eCArIDI5MikKKyNkZWZpbmUgX19OUl9tbWFwMgkJCShfX05SX0xpbnV4ICsgMjkz
KQogCiAvKgogICogT2Zmc2V0IG9mIHRoZSBsYXN0IE4zMiBmbGF2b3VyZWQgc3lzY2FsbAogICov
Ci0jZGVmaW5lIF9fTlJfTGludXhfc3lzY2FsbHMJCTI5MgorI2RlZmluZSBfX05SX0xpbnV4X3N5
c2NhbGxzCQkyOTMKIAogI2VuZGlmIC8qIF9NSVBTX1NJTSA9PSBfTUlQU19TSU1fTkFCSTMyICov
CiAK
------=_Part_1151_31304525.1221805889992--
