Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Dec 2009 01:18:39 +0100 (CET)
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39786 "EHLO
        out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1494058AbZLEASg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Dec 2009 01:18:36 +0100
Received: from compute2.internal (compute2.internal [10.202.2.42])
        by gateway1.messagingengine.com (Postfix) with ESMTP id 3FA2AC5E27;
        Fri,  4 Dec 2009 19:18:29 -0500 (EST)
Received: from web8.messagingengine.com ([10.202.2.217])
  by compute2.internal (MEProxy); Fri, 04 Dec 2009 19:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:from:to:cc:mime-version:content-transfer-encoding:content-type:references:subject:in-reply-to:date; s=smtpout; bh=1AAkkxUWuwkBGwvzJVA+0drXT/I=; b=jENwqKROUpPXGe+PvLbzjso4uEApXbe/rUSd33z3clT5hAEPYBy2KZzwq19czVZCJfwEQpN0Yv+YqKw4j5SIq0/4azfe+BNUP7K4+yGp3w5A1z3hyizmMxs299IdvR9NZN9zCuUUI7z58oSL4Er/4DpnS9yo7SpObt6G4vi3mJo=
Received: by web8.messagingengine.com (Postfix, from userid 99)
        id 1B8D1F4D7A; Fri,  4 Dec 2009 19:18:29 -0500 (EST)
Message-Id: <1259972309.7597.1348536401@webmail.messagingengine.com>
X-Sasl-Enc: 5dB/xGLuUzDfrBYmGOLPPhW3EgyxoMPxet0AVroUuJFF 1259972309
From:   myuboot@fastmail.fm
To:     "Florian Fainelli" <florian@openwrt.org>
Cc:     "David VomLehn" <dvomlehn@cisco.com>,
        "Chris Dearman" <chris@mips.com>,
        "linux-mips" <linux-mips@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: multipart/mixed; boundary="_----------=_125997230975970"
X-Mailer: MessagingEngine.com Webmail Interface
References: <1255735395.30097.1340523469@webmail.messagingengine.com>
 <20091118010351.GA21728@dvomlehn-lnx2.corp.sa.net>
 <1259195053.31777.1347090923@webmail.messagingengine.com>
 <200911260945.59751.florian@openwrt.org>
Subject: Re: problem bring up initramfs and busybox
In-Reply-To: <200911260945.59751.florian@openwrt.org>
Date:   Fri, 04 Dec 2009 18:18:29 -0600
Return-Path: <myuboot@fastmail.fm>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: myuboot@fastmail.fm
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--_----------=_125997230975970
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
Date: Fri, 4 Dec 2009 19:18:29 -0500
X-Mailer: MessagingEngine.com Webmail Interface

Finally, I figured out the problem. The main issue is in file irq.c, in
which the register starting at CHNL_OFFSET() is not set correctly in big
endian mode. With that problem, even though the serial port 8250 is
generating interrupt,  the interrupt controller blocks it.

In  big endian mode, the value written at line=20
writel(i, REG(CHNL_OFFSET(i)));

should be=20
writel(i << 24, REG(CHNL_OFFSET(i)));

I suspect this problem is applicable to AR7 running in big endian mode
since my board is almost the same to AR7. I am attaching a patch for
anyone's reference. Thanks to Florian, Kevin, Chris and Ralf for your
advise.

Best regards, Andrew



On Thu, 26 Nov 2009 09:45 +0100, "Florian Fainelli"
<florian@openwrt.org> wrote:
> Hi Andrew.
>=20
> Le jeudi 26 novembre 2009 01:24:13, myuboot@fastmail.fm a =E9crit :
> > On Tue, 17 Nov 2009 20:03 -0500, "David VomLehn" <dvomlehn@cisco.com>
> >=20
> > wrote:
> > > On Tue, Nov 17, 2009 at 06:58:35PM -0600, myuboot@fastmail.fm wrote:
> > > > On Wed, 18 Nov 2009 01:39 +0100, "Florian Fainelli"
> > > >
> > > > <florian@openwrt.org> wrote:
> > > > > -------------------------------
> > > >
> > > > Actually I already got this patch for the board in little endian mo=
de,
> > > > and it is still there for the big endian mode. And this is one of t=
he
> > > > place I have been wondering if that needs to be changed for big end=
ian.
> > >
> > > It sounds like you've done a good job getting the bootloader and kern=
el
> > > to work, so this may be a silly suggestion, but are you sure your root
> > > filesystem and busybox are little-endian? It would be an easy mistake=
 to
> > > make...
> > >
> > > > thanks. Andrew
> > >
> > > David VL
> >=20
> > I have some clue on this issue now. It seems there is some problem with
> > the serial console operating in interrupt mode. If the 8250 is in
> > polling mode(set the IRQ for the 8250 serial port to 0), the output on
> > the console is fine. But with 8250 in interrupt mode, 8250 serial driver
> > does not receive any interrupt in serial8250_interrupt(). The same board
> > works just fine when operating in little endian mode with interruption.
> > I probably need to change something in IRQ initialization for big
> > endian. I will post my solution when I can get it to work. In the
> > meantime, any suggestion will be welcome.
>=20
> Do you need that patch to work in little-endian:=20
> https://dev.openwrt.org/browser/trunk/target/linux/ar7/patches-2.6.30/500-
> serial_kludge.patch ? If so, you are likely to need it in big-endian too
> since=20
> it works around a silicon issue.
> --=20
> Best regards, Florian Fainelli
> Email: florian@openwrt.org
> Web: http://openwrt.org
> IRC: [florian] on irc.freenode.net
> -------------------------------

--_----------=_125997230975970
MIME-Version: 1.0
Content-Disposition: attachment; filename="irq.patch"
Content-Id: Etia+ZiQISXr/wTo6yvX0zG3U5E@messagingengine.com
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="irq.patch"
X-Mailer: MIME::Lite 3.021 (F2.76; T1.24; A2.03; B3.07_01; Q3.07)
Date: Fri, 4 Dec 2009 19:18:29 -0500

LS0tIGlycS5jCTIwMDktMDktMjEgMTk6MjQ6MzAuMDAwMDAwMDAwIC0wNTAw
CisrKyBpcnEuYwkyMDA5LTEyLTA0IDE3OjUyOjU5LjAwMDAwMDAwMCAtMDYw
MApAQCAtNDUsNyArNDUsOCBAQAogCiAjZGVmaW5lIFJFRyhhZGRyKSAoKHUz
MiAqKShLU0VHMUFERFIoQVI3X1JFR1NfSVJRKSArIGFkZHIpKQogCi0jZGVm
aW5lIENITkxfT0ZGU0VUKGNobmwpIChDSE5MU19PRkZTRVQgKyAoY2hubCAq
IDQpKQorI2RlZmluZSBDSE5MX09GRlNFVChjaG5sKSAoQ0hOTFNfT0ZGU0VU
ICsgKGNobmwgKiA0KSkgIC8qIHByaW9yaXR5IGZvciBpbnRlcnJ1cHQgY2hu
bCAqLworI2RlZmluZSBMSVRUTEVfVE9fQklHX0VORElBTihpKSAgKDI0LShp
KS84KjggKyAoKGkpJTgpKSAgLyogY29udmVydCB0aGUgYml0IG51bWJlciBm
cm9tIGxpdHRsZSB0byBiaWcgZW5kaW4gd2l0aGluIDMyIGJpdCovCiAKIHN0
YXRpYyB2b2lkIGFyN191bm1hc2tfaXJxKHVuc2lnbmVkIGludCBpcnFfbnIp
Owogc3RhdGljIHZvaWQgYXI3X21hc2tfaXJxKHVuc2lnbmVkIGludCBpcnFf
bnIpOwpAQCAtNzgsMzUgKzc5LDM1IEBACiAKIHN0YXRpYyB2b2lkIGFyN191
bm1hc2tfaXJxKHVuc2lnbmVkIGludCBpcnEpCiB7Ci0Jd3JpdGVsKDEgPDwg
KChpcnEgLSBhcjdfaXJxX2Jhc2UpICUgMzIpLAorCXdyaXRlbCgxPDwgTElU
VExFX1RPX0JJR19FTkRJQU4oaXJxIC0gYXI3X2lycV9iYXNlKSwgCiAJICAg
ICAgIFJFRyhFU1JfT0ZGU0VUKGlycSAtIGFyN19pcnFfYmFzZSkpKTsKIH0K
IAogc3RhdGljIHZvaWQgYXI3X21hc2tfaXJxKHVuc2lnbmVkIGludCBpcnEp
CiB7Ci0Jd3JpdGVsKDEgPDwgKChpcnEgLSBhcjdfaXJxX2Jhc2UpICUgMzIp
LAorCXdyaXRlbCgxPDwgTElUVExFX1RPX0JJR19FTkRJQU4oaXJxIC0gYXI3
X2lycV9iYXNlKSwKIAkgICAgICAgUkVHKEVDUl9PRkZTRVQoaXJxIC0gYXI3
X2lycV9iYXNlKSkpOwogfQogCiBzdGF0aWMgdm9pZCBhcjdfYWNrX2lycSh1
bnNpZ25lZCBpbnQgaXJxKQogewotCXdyaXRlbCgxIDw8ICgoaXJxIC0gYXI3
X2lycV9iYXNlKSAlIDMyKSwKKwl3cml0ZWwoMTw8TElUVExFX1RPX0JJR19F
TkRJQU4oaXJxIC0gYXI3X2lycV9iYXNlKSwKIAkgICAgICAgUkVHKENSX09G
RlNFVChpcnEgLSBhcjdfaXJxX2Jhc2UpKSk7CiB9CiAKIHN0YXRpYyB2b2lk
IGFyN191bm1hc2tfc2VjX2lycSh1bnNpZ25lZCBpbnQgaXJxKQogewotCXdy
aXRlbCgxIDw8IChpcnEgLSBhcjdfaXJxX2Jhc2UgLSA0MCksIFJFRyhTRUNf
RVNSX09GRlNFVCkpOworCXdyaXRlbCgxIDw8IExJVFRMRV9UT19CSUdfRU5E
SUFOKGlycSAtIGFyN19pcnFfYmFzZSAtIDQwKSwgUkVHKFNFQ19FU1JfT0ZG
U0VUKSk7CiB9CiAKIHN0YXRpYyB2b2lkIGFyN19tYXNrX3NlY19pcnEodW5z
aWduZWQgaW50IGlycSkKIHsKLQl3cml0ZWwoMSA8PCAoaXJxIC0gYXI3X2ly
cV9iYXNlIC0gNDApLCBSRUcoU0VDX0VDUl9PRkZTRVQpKTsKKwl3cml0ZWwo
MSA8PCBMSVRUTEVfVE9fQklHX0VORElBTihpcnEgLSBhcjdfaXJxX2Jhc2Ug
LSA0MCksIFJFRyhTRUNfRUNSX09GRlNFVCkpOwogfQogCiBzdGF0aWMgdm9p
ZCBhcjdfYWNrX3NlY19pcnEodW5zaWduZWQgaW50IGlycSkKIHsKLQl3cml0
ZWwoMSA8PCAoaXJxIC0gYXI3X2lycV9iYXNlIC0gNDApLCBSRUcoU0VDX0NS
X09GRlNFVCkpOworCXdyaXRlbCgxIDw8IExJVFRMRV9UT19CSUdfRU5ESUFO
KGlycSAtIGFyN19pcnFfYmFzZSAtIDQwKSwgUkVHKFNFQ19DUl9PRkZTRVQp
KTsKIH0KIAogdm9pZCBfX2luaXQgYXJjaF9pbml0X2lycSh2b2lkKQpAQCAt
MTIzLDE2ICsxMjQsMTYgQEAKIAkgKiBEaXNhYmxlIGludGVycnVwdHMgYW5k
IGNsZWFyIHBlbmRpbmcKIAkgKi8KIAl3cml0ZWwoMHhmZmZmZmZmZiwgUkVH
KEVDUl9PRkZTRVQoMCkpKTsKLQl3cml0ZWwoMHhmZiwgUkVHKEVDUl9PRkZT
RVQoMzIpKSk7CisJd3JpdGVsKDB4ZmYwMDAwMDAsIFJFRyhFQ1JfT0ZGU0VU
KDMyKSkpOwogCXdyaXRlbCgweGZmZmZmZmZmLCBSRUcoU0VDX0VDUl9PRkZT
RVQpKTsKIAl3cml0ZWwoMHhmZmZmZmZmZiwgUkVHKENSX09GRlNFVCgwKSkp
OwotCXdyaXRlbCgweGZmLCBSRUcoQ1JfT0ZGU0VUKDMyKSkpOworCXdyaXRl
bCgweGZmMDAwMDAwLCBSRUcoQ1JfT0ZGU0VUKDMyKSkpOwogCXdyaXRlbCgw
eGZmZmZmZmZmLCBSRUcoU0VDX0NSX09GRlNFVCkpOwogCiAJYXI3X2lycV9i
YXNlID0gYmFzZTsKIAogCWZvciAoaSA9IDA7IGkgPCA0MDsgaSsrKSB7Ci0J
CXdyaXRlbChpLCBSRUcoQ0hOTF9PRkZTRVQoaSkpKTsKKwkJd3JpdGVsKGk8
PDI0LCBSRUcoQ0hOTF9PRkZTRVQoaSkpKTsKIAkJLyogUHJpbWFyeSBJUlEn
cyAqLwogCQlzZXRfaXJxX2NoaXBfYW5kX2hhbmRsZXIoYmFzZSArIGksICZh
cjdfaXJxX3R5cGUsCiAJCQkJCSBoYW5kbGVfZWRnZV9pcnEpOwpAQCAtMTU2
LDE4ICsxNTcsMTggQEAKIAlpbnQgaSwgaXJxOwogCiAJLyogUHJpbWFyeSBJ
UlEncyAqLwotCWlycSA9IHJlYWRsKFJFRyhQSVJfT0ZGU0VUKSkgJiAweDNm
OworCWlycSA9IChyZWFkbChSRUcoUElSX09GRlNFVCkpICYgMHgzZjAwMDAw
MCk+PjI0OwogCWlmIChpcnEpIHsKIAkJZG9fSVJRKGFyN19pcnFfYmFzZSAr
IGlycSk7CiAJCXJldHVybjsKIAl9CiAKIAkvKiBTZWNvbmRhcnkgSVJRJ3Mg
YXJlIGNhc2NhZGVkIHRocm91Z2ggcHJpbWFyeSAnMCcgKi8KLQl3cml0ZWwo
MSwgUkVHKENSX09GRlNFVChpcnEpKSk7CisJd3JpdGVsKDB4MDEwMDAwMDAs
IFJFRyhDUl9PRkZTRVQoaXJxKSkpOwogCXN0YXR1cyA9IHJlYWRsKFJFRyhT
RUNfU1JfT0ZGU0VUKSk7CiAJZm9yIChpID0gMDsgaSA8IDMyOyBpKyspIHsK
IAkJaWYgKHN0YXR1cyAmIDEpIHsKLQkJCWRvX0lSUShhcjdfaXJxX2Jhc2Ug
KyBpICsgNDApOworCQkJZG9fSVJRKGFyN19pcnFfYmFzZSArIExJVFRMRV9U
T19CSUdfRU5ESUFOKGkpICsgNDApOwogCQkJcmV0dXJuOwogCQl9CiAJCXN0
YXR1cyA+Pj0gMTsK

--_----------=_125997230975970--
