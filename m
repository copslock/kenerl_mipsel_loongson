Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Sep 2002 22:45:06 +0200 (CEST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:51253 "EHLO
	ubik.localnet") by linux-mips.org with ESMTP id <S1122962AbSIKUpF>;
	Wed, 11 Sep 2002 22:45:05 +0200
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by ubik.localnet (8.12.3/8.12.3/Debian -4) with ESMTP id g8BKiw6m014253
	for <linux-mips@linux-mips.org>; Wed, 11 Sep 2002 22:44:58 +0200
Message-ID: <3D7FAB4A.4010802@murphy.dk>
Date: Wed, 11 Sep 2002 22:44:58 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips <linux-mips@linux-mips.org>
Subject: ide-dma bug
Content-Type: multipart/mixed;
 boundary="------------060003010506000001030300"
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060003010506000001030300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

If I use the ide-dma.c from the current cvs (2.4 branch) then I get an 
error from
ext2 when it tries to mount the root filesystem along the lines of

ext2_check_page: bad entry in directory #2

By applying the attached patch I can continue (it reverses part of the 
change
from the yesterday to today), i.e. I can boot the system. I may have time
at some point to look at this problem, but it should not be isolated to 
mips(el)
as far as I can see, so some experts are probably working at it as I write.

/Brian

--------------060003010506000001030300
Content-Type: application/x-java-vm;
 name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch"

SW5kZXg6IGlkZS1kbWEuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3ZzL2xpbnV4LW1p
cHMvZHJpdmVycy9pZGUvaWRlLWRtYS5jLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjEuMS4y
CnJldHJpZXZpbmcgcmV2aXNpb24gMS4xLjEuMQpkaWZmIC11IC1yMS4xLjEuMiAtcjEuMS4x
LjEKLS0tIGlkZS1kbWEuYwkxMSBTZXAgMjAwMiAxNzo1NzoxNCAtMDAwMAkxLjEuMS4yCisr
KyBpZGUtZG1hLmMJMTggSnVsIDIwMDIgMTc6MzQ6NDggLTAwMDAJMS4xLjEuMQpAQCAtMjUy
LDUzICsyNTIsMzMgQEAKIHsKIAlzdHJ1Y3QgYnVmZmVyX2hlYWQgKmJoOwogCXN0cnVjdCBz
Y2F0dGVybGlzdCAqc2cgPSBod2lmLT5zZ190YWJsZTsKLQl1bnNpZ25lZCBsb25nIGxhc3Rk
YXRhZW5kID0gfjBVTDsKIAlpbnQgbmVudHMgPSAwOwogCiAJaWYgKGh3aWYtPnNnX2RtYV9h
Y3RpdmUpCiAJCUJVRygpOwotCisJCQogCWlmIChycS0+Y21kID09IFJFQUQpCiAJCWh3aWYt
PnNnX2RtYV9kaXJlY3Rpb24gPSBQQ0lfRE1BX0ZST01ERVZJQ0U7CiAJZWxzZQogCQlod2lm
LT5zZ19kbWFfZGlyZWN0aW9uID0gUENJX0RNQV9UT0RFVklDRTsKLQogCWJoID0gcnEtPmJo
OwogCWRvIHsKLQkJc3RydWN0IHNjYXR0ZXJsaXN0ICpzZ2U7Ci0KLQkJLyoKLQkJICogY29u
dGludWUgc2VnbWVudCBmcm9tIGJlZm9yZT8KLQkJICovCi0JCWlmIChiaF9waHlzKGJoKSA9
PSBsYXN0ZGF0YWVuZCkgewotCQkJc2dbbmVudHMgLSAxXS5sZW5ndGggKz0gYmgtPmJfc2l6
ZTsKLQkJCWxhc3RkYXRhZW5kICs9IGJoLT5iX3NpemU7Ci0JCQljb250aW51ZTsKLQkJfQor
CQl1bnNpZ25lZCBjaGFyICp2aXJ0X2FkZHIgPSBiaC0+Yl9kYXRhOworCQl1bnNpZ25lZCBp
bnQgc2l6ZSA9IGJoLT5iX3NpemU7CiAKLQkJLyoKLQkJICogc3RhcnQgbmV3IHNlZ21lbnQK
LQkJICovCiAJCWlmIChuZW50cyA+PSBQUkRfRU5UUklFUykKIAkJCXJldHVybiAwOwogCi0J
CXNnZSA9ICZzZ1tuZW50c107Ci0JCW1lbXNldChzZ2UsIDAsIHNpemVvZigqc2dlKSk7Ci0K
LQkJaWYgKGJoLT5iX3BhZ2UpIHsKLQkJCXNnZS0+cGFnZSA9IGJoLT5iX3BhZ2U7Ci0JCQlz
Z2UtPm9mZnNldCA9IGJoX29mZnNldChiaCk7Ci0JCX0gZWxzZSB7Ci0JCQlpZiAoKCh1bnNp
Z25lZCBsb25nKSBiaC0+Yl9kYXRhKSA8IFBBR0VfU0laRSkKLQkJCQlCVUcoKTsKLQotCQkJ
c2dlLT5hZGRyZXNzID0gYmgtPmJfZGF0YTsKKwkJd2hpbGUgKChiaCA9IGJoLT5iX3JlcW5l
eHQpICE9IE5VTEwpIHsKKwkJCWlmICgodmlydF9hZGRyICsgc2l6ZSkgIT0gKHVuc2lnbmVk
IGNoYXIgKikgYmgtPmJfZGF0YSkKKwkJCQlicmVhazsKKwkJCXNpemUgKz0gYmgtPmJfc2l6
ZTsKIAkJfQotCi0JCXNnZS0+bGVuZ3RoID0gYmgtPmJfc2l6ZTsKLQkJbGFzdGRhdGFlbmQg
PSBiaF9waHlzKGJoKSArIGJoLT5iX3NpemU7CisJCW1lbXNldCgmc2dbbmVudHNdLCAwLCBz
aXplb2YoKnNnKSk7CisJCXNnW25lbnRzXS5hZGRyZXNzID0gdmlydF9hZGRyOworCQlzZ1tu
ZW50c10ubGVuZ3RoID0gc2l6ZTsKIAkJbmVudHMrKzsKLQl9IHdoaWxlICgoYmggPSBiaC0+
Yl9yZXFuZXh0KSAhPSBOVUxMKTsKKwl9IHdoaWxlIChiaCAhPSBOVUxMKTsKIAogCXJldHVy
biBwY2lfbWFwX3NnKGh3aWYtPnBjaV9kZXYsIHNnLCBuZW50cywgaHdpZi0+c2dfZG1hX2Rp
cmVjdGlvbik7CiB9Cg==
--------------060003010506000001030300--
