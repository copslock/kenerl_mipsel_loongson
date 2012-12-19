Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Dec 2012 06:18:53 +0100 (CET)
Received: from dns1.mips.com ([12.201.5.69]:39397 "EHLO dns1.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822664Ab2LSFSs5Amzg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Dec 2012 06:18:48 +0100
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
        by dns1.mips.com (8.13.8/8.13.8) with ESMTP id qBJ5Id3q023289;
        Tue, 18 Dec 2012 21:18:39 -0800
X-WSS-ID: 0MF9IR0-01-0GB-02
X-M-MSG: 
Received: from exchdb01.mips.com (unknown [192.168.36.67])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mailgate1.mips.com (Postfix) with ESMTP id 2ED2D36465A;
        Tue, 18 Dec 2012 21:18:36 -0800 (PST)
Received: from EXCHDB03.MIPS.com ([fe80::6df1:ae84:797e:9076]) by
 exchdb01.mips.com ([fe80::2897:a30d:a923:303%16]) with mapi id
 14.01.0270.001; Tue, 18 Dec 2012 21:18:35 -0800
From:   "Hill, Steven" <sjhill@mips.com>
To:     Jayachandran C <jchandra@broadcom.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH] Revert "MIPS: Optimise TLB handlers for MIPS32/64 R2
 cores."
Thread-Topic: [PATCH] Revert "MIPS: Optimise TLB handlers for MIPS32/64 R2
 cores."
Thread-Index: AQHN3QUIS1qOm5BxXUKcek/ScPwLU5gflgVP
Date:   Wed, 19 Dec 2012 05:18:35 +0000
Message-ID: <31E06A9FC96CEC488B43B19E2957C1B801146AB865@exchdb03.mips.com>
References: <1355824203-18912-1-git-send-email-jchandra@broadcom.com>
In-Reply-To: <1355824203-18912-1-git-send-email-jchandra@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.36.79]
x-ems-proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
x-ems-stamp: Ch8NKIBZiKAadUBu4WQ7jw==
Content-Type: multipart/mixed;
        boundary="_002_31E06A9FC96CEC488B43B19E2957C1B801146AB865exchdb03mipsc_"
MIME-Version: 1.0
X-archive-position: 35310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

--_002_31E06A9FC96CEC488B43B19E2957C1B801146AB865exchdb03mipsc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

JC,=0A=
=0A=
Can you try to apply this patch on top of the "MIPS: Optimise TLB handlers =
for MIPS32/64 R2 cores." patch and let me know of the results. Thanks.=0A=
=0A=
-Steve=

--_002_31E06A9FC96CEC488B43B19E2957C1B801146AB865exchdb03mipsc_
Content-Type: text/x-patch; name="fix-optimise-tlb-for-mips64r2.patch"
Content-Description: fix-optimise-tlb-for-mips64r2.patch
Content-Disposition: attachment;
	filename="fix-optimise-tlb-for-mips64r2.patch"; size=4333;
	creation-date="Wed, 19 Dec 2012 05:16:58 GMT";
	modification-date="Wed, 19 Dec 2012 05:16:58 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9pbnN0LmggYi9hcmNoL21pcHMvaW5j
bHVkZS9hc20vaW5zdC5oCmluZGV4IDUzNTQyZTNjLi43NjFmYTE4IDEwMDY0NAotLS0gYS9hcmNo
L21pcHMvaW5jbHVkZS9hc20vaW5zdC5oCisrKyBiL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS9pbnN0
LmgKQEAgLTg5Myw3ICs4OTMsNyBAQCBlbnVtIG1tX21ham9yX29wIHsKIAltbV9wb29sMzJiX29w
LCBtbV9wb29sMTZiX29wLCBtbV9saHUxNl9vcCwgbW1fYW5kaTE2X29wLAogCW1tX2FkZGl1MzJf
b3AsIG1tX2xodTMyX29wLCBtbV9zaDMyX29wLCBtbV9saDMyX29wLAogCW1tX3Bvb2wzMmlfb3As
IG1tX3Bvb2wxNmNfb3AsIG1tX2x3c3AxNl9vcCwgbW1fcG9vbDE2ZF9vcCwKLQltbV9vcmkzMl9v
cCwgbW1fcG9vbDMyZl9vcCwgbW1fcmVzZXJ2ZWQxX29wLCBtbV9yZXNlcnZlZDJfb3AsCisJbW1f
b3JpMzJfb3AsIG1tX3Bvb2wzMmZfb3AsIG1tX3Bvb2xzMzJzX29wLCBtbV9yZXNlcnZlZDJfb3As
CiAJbW1fcG9vbDMyY19vcCwgbW1fbHdncDE2X29wLCBtbV9sdzE2X29wLCBtbV9wb29sMTZlX29w
LAogCW1tX3hvcmkzMl9vcCwgbW1famFsczMyX29wLCBtbV9hZGRpdXBjX29wLCBtbV9yZXNlcnZl
ZDNfb3AsCiAJbW1fcmVzZXJ2ZWQ0X29wLCBtbV9wb29sMTZmX29wLCBtbV9zYjE2X29wLCBtbV9i
ZXF6MTZfb3AsCkBAIC0xMDk1LDYgKzEwOTUsMTggQEAgZW51bSBtbV8zMmZfNzNfbWlub3Jfb3Ag
ewogfTsKIAogLyoKKyAqIFBPT0wzMlMgbWlub3Igb3Bjb2Rlcy4KKyAqLworZW51bSBtbV8zMnNf
bWlub3Jfb3AgeworCW1tX2RpbnNtX29wID0gMHgwNCwKKwltbV9kaW5zX29wID0gMHgwYywKKwlt
bV9kZXh0dV9vcCA9IDB4MTQsCisJbW1fZGV4dG1fb3AgPSAweDI0LAorCW1tX2RleHRfb3AgPSAw
eDJjLAorCW1tX2RpbnN1X29wID0gMHgzNCwKK307CisKKy8qCiAgKiBQT09MMTZDIG1pbm9yIG9w
Y29kZXMuCiAgKi8KIGVudW0gbW1fMTZjX21pbm9yX29wIHsKZGlmZiAtLWdpdCBhL2FyY2gvbWlw
cy9pbmNsdWRlL2FzbS91YXNtLmggYi9hcmNoL21pcHMvaW5jbHVkZS9hc20vdWFzbS5oCmluZGV4
IDJhNmM2NWEuLjcwYmY4ZjEgMTAwNjQ0Ci0tLSBhL2FyY2gvbWlwcy9pbmNsdWRlL2FzbS91YXNt
LmgKKysrIGIvYXJjaC9taXBzL2luY2x1ZGUvYXNtL3Vhc20uaApAQCAtNzcsNiArNzcsNyBAQCBJ
cF91MXUyczMoX2JuZSk7CiBJcF91MnMzdTEoX2NhY2hlKTsKIElwX3UydTFzMyhfZGFkZGl1KTsK
IElwX3UzdTF1MihfZGFkZHUpOworSXBfdTJ1MW1zYnUzKF9kZXh0KTsKIElwX3UydTFtc2J1Myhf
ZGlucyk7CiBJcF91MnUxbXNidTMoX2RpbnNtKTsKIElwX3UxdTJ1MyhfZG1mYzApOwpkaWZmIC0t
Z2l0IGEvYXJjaC9taXBzL21tL3RsYmV4LmMgYi9hcmNoL21pcHMvbW0vdGxiZXguYwppbmRleCBk
NTBlNmQxLi42OTllMzUyIDEwMDY0NAotLS0gYS9hcmNoL21pcHMvbW0vdGxiZXguYworKysgYi9h
cmNoL21pcHMvbW0vdGxiZXguYwpAQCAtMTA4OCw4ICsxMDg4LDEzIEBAIHN0YXRpYyB2b2lkIF9f
Y3B1aW5pdCBidWlsZF9nZXRfcHRlcCh1MzIgKipwLCB1bnNpZ25lZCBpbnQgdG1wLCB1bnNpZ25l
ZCBpbnQgcHRyCiAJCS8qIFBURSBwdHIgb2Zmc2V0IGlzIG9idGFpbmVkIGZyb20gQmFkVkFkZHIg
Ki8KIAkJVUFTTV9pX01GQzAocCwgdG1wLCBDMF9CQURWQUREUik7CiAJCVVBU01faV9MVyhwLCBw
dHIsIDAsIHB0cik7CisjaWZkZWYgQ09ORklHX0NQVV9NSVBTNjQKKwkJdWFzbV9pX2RleHQocCwg
dG1wLCB0bXAsIFBBR0VfU0hJRlQrMSwgUEdESVJfU0hJRlQtUEFHRV9TSElGVC0xKTsKKwkJdWFz
bV9pX2RpbnMocCwgcHRyLCB0bXAsIFBURV9UX0xPRzIrMSwgUEdESVJfU0hJRlQtUEFHRV9TSElG
VC0xKTsKKyNlbHNlCiAJCXVhc21faV9leHQocCwgdG1wLCB0bXAsIFBBR0VfU0hJRlQrMSwgUEdE
SVJfU0hJRlQtUEFHRV9TSElGVC0xKTsKIAkJdWFzbV9pX2lucyhwLCBwdHIsIHRtcCwgUFRFX1Rf
TE9HMisxLCBQR0RJUl9TSElGVC1QQUdFX1NISUZULTEpOworI2VuZGlmCiAJCXJldHVybjsKIAl9
CiAKZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9tbS91YXNtLW1pY3JvbWlwcy5jIGIvYXJjaC9taXBz
L21tL3Vhc20tbWljcm9taXBzLmMKaW5kZXggZjJiODM0YS4uMWQzMDY3ZSAxMDA2NDQKLS0tIGEv
YXJjaC9taXBzL21tL3Vhc20tbWljcm9taXBzLmMKKysrIGIvYXJjaC9taXBzL21tL3Vhc20tbWlj
cm9taXBzLmMKQEAgLTM3LDYgKzM3LDkgQEAgc3RhdGljIHN0cnVjdCBpbnNuIGluc25fdGFibGVb
XSBfX3Vhc21pbml0ZGF0YSA9IHsKIAl7IGluc25fY2FjaGUsIE0obW1fcG9vbDMyYl9vcCwgMCwg
MCwgbW1fY2FjaGVfZnVuYywgMCwgMCksIFJUIHwgUlMgfCBTSU1NIH0sCiAJeyBpbnNuX2RhZGR1
LCAwLCAwIH0sCiAJeyBpbnNuX2RhZGRpdSwgMCwgMCB9LAorCXsgaW5zbl9kZXh0LCBNKG1tX3Bv
b2xzMzJzX29wLCAwLCAwLCAwLCAwLCBtbV9kZXh0X29wKSwgUlMgfCBSVCB8IFJEIHwgUkV9LAor
CXsgaW5zbl9kaW5zLCBNKG1tX3Bvb2xzMzJzX29wLCAwLCAwLCAwLCAwLCBtbV9kaW5zX29wKSwg
UlMgfCBSVCB8IFJEIHwgUkV9LAorCXsgaW5zbl9kaW5zbSwgTShtbV9wb29sczMyc19vcCwgMCwg
MCwgMCwgMCwgbW1fZGluc21fb3ApLCBSUyB8IFJUIHwgUkQgfCBSRX0sCiAJeyBpbnNuX2RtZmMw
LCAwLCAwIH0sCiAJeyBpbnNuX2RtdGMwLCAwLCAwIH0sCiAJeyBpbnNuX2RzbGwsIDAsIDAgfSwK
ZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9tbS91YXNtLW1pcHMuYyBiL2FyY2gvbWlwcy9tbS91YXNt
LW1pcHMuYwppbmRleCBlODYzMzRiLi4yNjk1MDc2IDEwMDY0NAotLS0gYS9hcmNoL21pcHMvbW0v
dWFzbS1taXBzLmMKKysrIGIvYXJjaC9taXBzL21tL3Vhc20tbWlwcy5jCkBAIC0zNyw2ICszNyw4
IEBAIHN0YXRpYyBzdHJ1Y3QgaW5zbiBpbnNuX3RhYmxlW10gX191YXNtaW5pdGRhdGEgPSB7CiAJ
eyBpbnNuX2NhY2hlLCAgTShjYWNoZV9vcCwgMCwgMCwgMCwgMCwgMCksICBSUyB8IFJUIHwgU0lN
TSB9LAogCXsgaW5zbl9kYWRkdSwgTShzcGVjX29wLCAwLCAwLCAwLCAwLCBkYWRkdV9vcCksIFJT
IHwgUlQgfCBSRCB9LAogCXsgaW5zbl9kYWRkaXUsIE0oZGFkZGl1X29wLCAwLCAwLCAwLCAwLCAw
KSwgUlMgfCBSVCB8IFNJTU0gfSwKKwl7IGluc25fZGV4dCwgTShzcGVjM19vcCwgMCwgMCwgMCwg
MCwgZGV4dF9vcCksIFJTIHwgUlQgfCBSRCB8IFJFfSwKKwl7IGluc25fZGlucywgTShzcGVjM19v
cCwgMCwgMCwgMCwgMCwgZGluc19vcCksIFJTIHwgUlQgfCBSRCB8IFJFfSwKIAl7IGluc25fZG1m
YzAsIE0oY29wMF9vcCwgZG1mY19vcCwgMCwgMCwgMCwgMCksIFJUIHwgUkQgfCBTRVR9LAogCXsg
aW5zbl9kbXRjMCwgTShjb3AwX29wLCBkbXRjX29wLCAwLCAwLCAwLCAwKSwgUlQgfCBSRCB8IFNF
VH0sCiAJeyBpbnNuX2RzbGwsIE0oc3BlY19vcCwgMCwgMCwgMCwgMCwgZHNsbF9vcCksIFJUIHwg
UkQgfCBSRSB9LApkaWZmIC0tZ2l0IGEvYXJjaC9taXBzL21tL3Vhc20uYyBiL2FyY2gvbWlwcy9t
bS91YXNtLmMKaW5kZXggZDNiMDFiOTAuLjY1NzI1YmUgMTAwNjQ0Ci0tLSBhL2FyY2gvbWlwcy9t
bS91YXNtLmMKKysrIGIvYXJjaC9taXBzL21tL3Vhc20uYwpAQCAtNjgsNyArNjgsNyBAQCBlbnVt
IG9wY29kZSB7CiAJaW5zbl9pbnZhbGlkLAogCWluc25fYWRkaXUsIGluc25fYWRkdSwgaW5zbl9h
bmQsIGluc25fYW5kaSwgaW5zbl9iYml0MCwgaW5zbl9iYml0MSwKIAlpbnNuX2JlcSwgaW5zbl9i
ZXFsLCBpbnNuX2JnZXosIGluc25fYmdlemwsIGluc25fYmx0eiwgaW5zbl9ibHR6bCwKLQlpbnNu
X2JuZSwgaW5zbl9jYWNoZSwgaW5zbl9kYWRkaXUsIGluc25fZGFkZHUsIGluc25fZGlucywgaW5z
bl9kaW5zbSwKKwlpbnNuX2JuZSwgaW5zbl9jYWNoZSwgaW5zbl9kYWRkaXUsIGluc25fZGFkZHUs
IGluc25fZGV4dCwgaW5zbl9kaW5zLCBpbnNuX2RpbnNtLAogCWluc25fZG1mYzAsIGluc25fZG10
YzAsIGluc25fZHJvdHIsIGluc25fZHJvdHIzMiwgaW5zbl9kc2xsLAogCWluc25fZHNsbDMyLCBp
bnNuX2RzcmEsIGluc25fZHNybCwgaW5zbl9kc3JsMzIsIGluc25fZHN1YnUsIGluc25fZXJldCwK
IAlpbnNuX2V4dCwgaW5zbl9pbnMsIGluc25faiwgaW5zbl9qYWwsIGluc25fanIsIGluc25fbGQs
IGluc25fbGR4LApAQCAtMzA5LDYgKzMwOSw3IEBAIElfMChfdGxid2kpCiBJXzAoX3RsYndyKQog
SV91M3UxdTIoX3hvcikKIElfdTJ1MXUzKF94b3JpKQorSV91MnUxbXNiZHUzKF9kZXh0KQogSV91
MnUxbXNidTMoX2RpbnMpOwogSV91MnUxbXNiMzJ1MyhfZGluc20pOwogSV91MShfc3lzY2FsbCk7
Cg==

--_002_31E06A9FC96CEC488B43B19E2957C1B801146AB865exchdb03mipsc_--
