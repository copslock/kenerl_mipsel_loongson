Received:  by oss.sgi.com id <S305163AbQDQQyW>;
	Mon, 17 Apr 2000 09:54:22 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:60248 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305161AbQDQQx4>; Mon, 17 Apr 2000 09:53:56 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id JAA03841; Mon, 17 Apr 2000 09:57:55 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA23978
	for linux-list;
	Mon, 17 Apr 2000 09:35:07 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA28040
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 17 Apr 2000 09:35:03 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from mail.ivm.net (mail.ivm.net [62.204.1.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA06829
	for <linux@cthulhu.engr.sgi.com>; Mon, 17 Apr 2000 09:35:01 -0700 (PDT)
	mail_from (Harald.Koerfgen@home.ivm.de)
Received: from franz.no.dom (port184.duesseldorf.ivm.de [195.247.65.184])
	by mail.ivm.net (8.8.8/8.8.8) with ESMTP id SAA25110;
	Mon, 17 Apr 2000 18:34:32 +0200
X-To:   linux@cthulhu.engr.sgi.com
Message-ID: <XFMail.000417183334.Harald.Koerfgen@home.ivm.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="_=XFMail.1.4.0.Linux:000417182219:353=_"
In-Reply-To: <NDBBIDGAOKMNJNDAHDDMAEGGCJAA.mfklar@ponymail.com>
Date:   Mon, 17 Apr 2000 18:33:34 +0200 (CEST)
Reply-To: Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Organization: none
From:   Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
To:     Mike Klar <mfklar@ponymail.com>
Subject: RE: Unaligned address handling, and the cause of that login prob
Cc:     linux-mips@fnet.fr, linux@cthulhu.engr.sgi.com
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

This message is in MIME format
--_=XFMail.1.4.0.Linux:000417182219:353=_
Content-Type: text/plain; charset=us-ascii


On 16-Apr-00 Mike Klar wrote:
> While tracking down a random memory corruption bug, I stumbled across the
> cause of that telnet/ssh problem in recent kernels reported about a month
> ago:
> 
> The version of down_trylock() for CPUs with support LL/SC assumes that
> struct semaphore is 64-bit aligned, since it accesses count and waking as a
> single dualword (with lld/scd).

Good spotted. This is perfectly in line with my observation that telnet/ssh
worked perfectly well if you built a kernel without CONFIG_CPU_HAS_LLSC.

The attached patch seems to fix this, and another bug in
waking_non_zero_interruptible() as well.

Telnet is working again :)

-- 
Regards,
Harald

--_=XFMail.1.4.0.Linux:000417182219:353=_
Content-Disposition: attachment; filename="sema-fix-041700"
Content-Transfer-Encoding: base64
Content-Description: sema-fix-041700
Content-Type: application/octet-stream; name=sema-fix-041700; SizeOnDisk=1597

ZGlmZiAtcnVOIC9uZnMvY3ZzL2xpbnV4LTIuMy9saW51eC9pbmNsdWRlL2FzbS1taXBzL3NlbWFw
aG9yZS1oZWxwZXIuaCBsaW51eC9pbmNsdWRlL2FzbS1taXBzL3NlbWFwaG9yZS1oZWxwZXIuaAot
LS0gL25mcy9jdnMvbGludXgtMi4zL2xpbnV4L2luY2x1ZGUvYXNtLW1pcHMvc2VtYXBob3JlLWhl
bHBlci5oCVR1ZSBNYXIgMjggMTc6MjU6MTkgMjAwMAorKysgbGludXgvaW5jbHVkZS9hc20tbWlw
cy9zZW1hcGhvcmUtaGVscGVyLmgJTW9uIEFwciAxNyAxODoxMzoxNCAyMDAwCkBAIC0xMzQsOCAr
MTM0LDYgQEAKIHsKIAlsb25nIHJldCwgdG1wOwogCi0jaWZkZWYgX19NSVBTRUJfXwotCiAgICAg
ICAgIF9fYXNtX18gX192b2xhdGlsZV9fKCIKIAkuc2V0CXB1c2gKIAkuc2V0CW1pcHMzCkBAIC0x
NTksNDYgKzE1Nyw2IEBACiAJLnNldAlwb3AiCiAJOiAiPSZyIihyZXQpLCAiPSZyIih0bXApLCAi
PW0iKCpzZW0pCiAJOiAiciIoc2lnbmFsX3BlbmRpbmcodHNrKSksICJpIigtRUlOVFIpKTsKLQot
I2VsaWYgZGVmaW5lZChfX01JUFNFTF9fKQotCi0JX19hc21fXyBfX3ZvbGF0aWxlX18oIgotCS5z
ZXQJbWlwczMKLQkuc2V0CXB1c2gKLQkuc2V0CW5vYXQKLTA6Ci0JbGxkCSUxLCAlMgotCWxpCSUw
LCAwCi0JYmxlegklMSwgMWYKLQlkbGkJJDEsIDB4MDAwMDAwMDEwMDAwMDAwMAotCWRzdWJ1CSUx
LCAlMSwgJDEKLQlsaQklMCwgMQotCWIJMmYKLTE6Ci0JYmVxegklMywgMmYKLQlsaQklMCwgJTQK
LQkvKiAKLQkgKiBJdCB3b3VsZCBiZSBuaWNlIHRvIGFzc3VtZSB0aGF0IHNlbS0+Y291bnQKLQkg
KiBpcyAhPSAtMSwgYnV0IHdlIHdpbGwgZ3VhcmQgYWdhaW5zdCB0aGF0IGNhc2UKLQkgKi8KLQlk
YWRkaXUJJDEsICUxLCAxCi0JZHNsbDMyCSQxLCAkMSwgMAotCWRzcmwzMgkkMSwgJDEsIDAKLQlk
c3JsMzIJJTEsICUxLCAwCi0JZHNsbDMyCSUxLCAlMSwgMAotCW9yCSUxLCAlMSwgJDEKLTI6Ci0J
c2NkCSUxLCAlMgotCWJlcXoJJTEsIDBiCi0KLQkuc2V0CXBvcAotCS5zZXQJbWlwczAiCi0JOiAi
PSZyIihyZXQpLCAiPSZyIih0bXApLCAiPW0iKCpzZW0pCi0JOiAiciIoc2lnbmFsX3BlbmRpbmco
dHNrKSksICJpIigtRUlOVFIpKTsKLQotI2Vsc2UKLSNlcnJvciAiTUlQUyBidXQgbmVpdGhlciBf
X01JUFNFTF9fIG5vciBfX01JUFNFQl9fPyIKLSNlbmRpZgogCiAJcmV0dXJuIHJldDsKIH0KZGlm
ZiAtcnVOIC9uZnMvY3ZzL2xpbnV4LTIuMy9saW51eC9pbmNsdWRlL2FzbS1taXBzL3NlbWFwaG9y
ZS5oIGxpbnV4L2luY2x1ZGUvYXNtLW1pcHMvc2VtYXBob3JlLmgKLS0tIC9uZnMvY3ZzL2xpbnV4
LTIuMy9saW51eC9pbmNsdWRlL2FzbS1taXBzL3NlbWFwaG9yZS5oCVR1ZSBNYXIgMjggMTc6MjU6
MTkgMjAwMAorKysgbGludXgvaW5jbHVkZS9hc20tbWlwcy9zZW1hcGhvcmUuaAlNb24gQXByIDE3
IDE4OjExOjAxIDIwMDAKQEAgLTMxLDcgKzMxLDcgQEAKICNpZiBXQUlUUVVFVUVfREVCVUcKIAls
b25nIF9fbWFnaWM7CiAjZW5kaWYKLX07Cit9IF9fYXR0cmlidXRlX18oKGFsaWduZWQoOCkpKTsK
IAogI2lmIFdBSVRRVUVVRV9ERUJVRwogIyBkZWZpbmUgX19TRU1fREVCVUdfSU5JVChuYW1lKSBc
Cg==

--_=XFMail.1.4.0.Linux:000417182219:353=_--
End of MIME message
