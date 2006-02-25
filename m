Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Feb 2006 05:13:17 +0000 (GMT)
Received: from terminus.zytor.com ([192.83.249.54]:23759 "EHLO
	terminus.zytor.com") by ftp.linux-mips.org with ESMTP
	id S8126502AbWBYFNH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 25 Feb 2006 05:13:07 +0000
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k1P5KR2O008234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Feb 2006 21:20:28 -0800
Message-ID: <43FFE91D.7020905@zytor.com>
Date:	Fri, 24 Feb 2006 21:20:29 -0800
From:	"H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: [PATCH] sys_mmap2 offset argument should always be shifted 12, not
 PAGE_SHIFT
Content-Type: multipart/mixed;
 boundary="------------020906030804010508050306"
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status:	Clean
Return-Path: <hpa@zytor.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hpa@zytor.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------020906030804010508050306
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This patch adjusts the offset argument passed into sys_mmap2 to be 
always shifted 12, even when the native page size isn't 4K.  This is 
what all existing userspace libraries expect.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------020906030804010508050306
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="diff"

ZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9rZXJuZWwvbGludXgzMi5jIGIvYXJjaC9taXBzL2tl
cm5lbC9saW51eDMyLmMKaW5kZXggNWY2OGIyMi4uNzJlYTVkNSAxMDA2NDQKLS0tIGEvYXJj
aC9taXBzL2tlcm5lbC9saW51eDMyLmMKKysrIGIvYXJjaC9taXBzL2tlcm5lbC9saW51eDMy
LmMKQEAgLTEwNiw2ICsxMDYsMTAgQEAgc3lzMzJfbW1hcDIodW5zaWduZWQgbG9uZyBhZGRy
LCB1bnNpZ25lZAogCXVuc2lnbmVkIGxvbmcgZXJyb3I7CiAKIAllcnJvciA9IC1FSU5WQUw7
CisJaWYgKHBnb2ZmICYgKH5QQUdFX01BU0sgPj4gMTIpKQorCQlnb3RvIG91dDsKKwlwZ29m
ZiA+Pj0gUEFHRV9TSElGVC0xMjsKKwogCWlmICghKGZsYWdzICYgTUFQX0FOT05ZTU9VUykp
IHsKIAkJZXJyb3IgPSAtRUJBREY7CiAJCWZpbGUgPSBmZ2V0KGZkKTsKZGlmZiAtLWdpdCBh
L2FyY2gvbWlwcy9rZXJuZWwvc3lzY2FsbC5jIGIvYXJjaC9taXBzL2tlcm5lbC9zeXNjYWxs
LmMKaW5kZXggMWRhMmVlYi4uMWQyODRmYiAxMDA2NDQKLS0tIGEvYXJjaC9taXBzL2tlcm5l
bC9zeXNjYWxsLmMKKysrIGIvYXJjaC9taXBzL2tlcm5lbC9zeXNjYWxsLmMKQEAgLTE2Miw3
ICsxNjIsMTAgQEAgYXNtbGlua2FnZSB1bnNpZ25lZCBsb25nCiBzeXNfbW1hcDIodW5zaWdu
ZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIGxlbiwgdW5zaWduZWQgbG9uZyBwcm90LAog
ICAgICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3MsIHVuc2lnbmVkIGxvbmcgZmQsIHVuc2ln
bmVkIGxvbmcgcGdvZmYpCiB7Ci0JcmV0dXJuIGRvX21tYXAyKGFkZHIsIGxlbiwgcHJvdCwg
ZmxhZ3MsIGZkLCBwZ29mZik7CisJaWYgKHBnb2ZmICYgKH5QQUdFX01BU0sgPj4gMTIpKQor
CQlyZXR1cm4gLUVJTlZBTDsKKworCXJldHVybiBkb19tbWFwMihhZGRyLCBsZW4sIHByb3Qs
IGZsYWdzLCBmZCwgcGdvZmYgPj4gKFBBR0VfU0hJRlQtMTIpKTsKIH0KIAogc2F2ZV9zdGF0
aWNfZnVuY3Rpb24oc3lzX2ZvcmspOwo=
--------------020906030804010508050306--
