Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6BKK8R19943
	for linux-mips-outgoing; Wed, 11 Jul 2001 13:20:08 -0700
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6BKK3V19925
	for <linux-mips@oss.sgi.com>; Wed, 11 Jul 2001 13:20:03 -0700
Received: from scotty.mgnet.de (pD9024645.dip.t-dialin.net [217.2.70.69])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id WAA25920
	for <linux-mips@oss.sgi.com>; Wed, 11 Jul 2001 22:20:01 +0200 (MET DST)
Received: (qmail 32679 invoked from network); 11 Jul 2001 20:19:59 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 11 Jul 2001 20:20:00 -0000
Date: Wed, 11 Jul 2001 22:19:54 +0200 (CEST)
From: Klaus Naumann <spock@mgnet.de>
To: "John D. Davis" <johnd@stanford.edu>
cc: debian-mips@lists.debian.org, linux-mips@oss.sgi.com
Subject: Re: Illegal Instruction with 2.4.2 and 2.4.3
In-Reply-To: <Pine.GSO.4.31.0107111049350.2834-100000@myth1.Stanford.EDU>
Message-ID: <Pine.LNX.4.21.0107112217590.11181-200000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811071-77193963-994882794=:11181"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1463811071-77193963-994882794=:11181
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 11 Jul 2001, John D. Davis wrote:

> I have been able to natively build kernels 2.4.0,2,3,4,5 on an Indy with
> without the CD-ROM support. I have only been able to boot 2.4.2 and 2.4.3.
> Previously, I was running 2.4.0-test9. 2.4.4 and 5 have ext2_fs inode
> problems. 2.4.0 hangs at cleaning the /tmp directory.
> 
> Extracting tar files causes an illegal instruction on 2.4.2 and 3.  Is
> there a patch for this.  Furthermore, are there patches available for all
> the various kernel versions and how do I get them for each version of the
> kernel.  Finally, I have read some email on stress tests.  Are those
> publicly available?

Hi,

the illigal instruction problem is known and a workaround has been
implemented by several ppl. Personally I'm using the patch which
lolo made (I have attached it to this mail). It should apply
cleanly against any 2.4.x kernel.
About the stress tests I don't know ...

	CU, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt

---1463811071-77193963-994882794=:11181
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sysmips-lolo.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0107112219540.11181@spock.mgnet.de>
Content-Description: 
Content-Disposition: attachment; filename="sysmips-lolo.patch"

ZGlmZiAtTnVyIGxpbnV4Lm9yaWcvYXJjaC9taXBzL2tlcm5lbC9NYWtlZmls
ZSBsaW51eC9hcmNoL21pcHMva2VybmVsL01ha2VmaWxlDQotLS0gbGludXgu
b3JpZy9hcmNoL21pcHMva2VybmVsL01ha2VmaWxlCU1vbiBBcHIgIDkgMDA6
MjM6MDggMjAwMQ0KKysrIGxpbnV4L2FyY2gvbWlwcy9rZXJuZWwvTWFrZWZp
bGUJTW9uIEFwciAgOSAwMDoyMzozNCAyMDAxDQpAQCAtMjAsNyArMjAsNyBA
QA0KIG9iai15CQkJCSs9IGJyYW5jaC5vIHByb2Nlc3MubyBzaWduYWwubyBl
bnRyeS5vIFwNCiAJCQkJICAgdHJhcHMubyBwdHJhY2UubyB2bTg2Lm8gaW9w
b3J0Lm8gcmVzZXQubyBcDQogCQkJCSAgIHNlbWFwaG9yZS5vIHNldHVwLm8g
c3lzY2FsbC5vIHN5c21pcHMubyBcDQotCQkJCSAgIGlwYy5vIHNjYWxsX28z
Mi5vIHVuYWxpZ25lZC5vDQorCQkJCSAgIGlwYy5vIHNjYWxsX28zMi5vIHVu
YWxpZ25lZC5vIGZhc3Qtc3lzbWlwcy5vDQogb2JqLSQoQ09ORklHX01PRFVM
RVMpCQkrPSBtaXBzX2tzeW1zLm8NCiANCiBpZmRlZiBDT05GSUdfQ1BVX1Iz
MDAwDQpAQCAtNjksNSArNjksNiBAQA0KIA0KIGVudHJ5Lm86IGVudHJ5LlMN
CiBoZWFkLm86IGhlYWQuUw0KK2Zhc3Qtc3lzbWlwcy5vOiBmYXN0LXN5c21p
cHMuUw0KIA0KIGluY2x1ZGUgJChUT1BESVIpL1J1bGVzLm1ha2UNCmRpZmYg
LU51ciBsaW51eC5vcmlnL2FyY2gvbWlwcy9rZXJuZWwvZmFzdC1zeXNtaXBz
LlMgbGludXgvYXJjaC9taXBzL2tlcm5lbC9mYXN0LXN5c21pcHMuUw0KLS0t
IGxpbnV4Lm9yaWcvYXJjaC9taXBzL2tlcm5lbC9mYXN0LXN5c21pcHMuUwlU
aHUgSmFuICAxIDAxOjAwOjAwIDE5NzANCisrKyBsaW51eC9hcmNoL21pcHMv
a2VybmVsL2Zhc3Qtc3lzbWlwcy5TCU1vbiBBcHIgIDkgMDA6Mjg6MjAgMjAw
MQ0KQEAgLTAsMCArMSw4NSBAQA0KKy8qDQorICogTUlQU19BVE9NSUNfU0VU
IGFzbSBpbXBsZW1lbnRhdGlvbiBmb3IgbGwvc2MgY2FwYWJsZSBjcHVzDQor
ICoNCisgKiBUaGlzIGZpbGUgaXMgc3ViamVjdCB0byB0aGUgdGVybXMgYW5k
IGNvbmRpdGlvbnMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYw0KKyAqIExp
Y2Vuc2UuICBTZWUgdGhlIGZpbGUgIkNPUFlJTkciIGluIHRoZSBtYWluIGRp
cmVjdG9yeSBvZiB0aGlzIGFyY2hpdmUNCisgKiBmb3IgbW9yZSBkZXRhaWxz
Lg0KKyAqDQorICogQ29weXJpZ2h0IChDKSAyMDAxIEZsb3JpYW4gTG9ob2Zm
IDxmbG9AcmZjODIyLm9yZz4NCisgKg0KKyAqLw0KKyNpbmNsdWRlIDxhc20v
YXNtLmg+DQorI2luY2x1ZGUgPGFzbS9taXBzcmVncy5oPg0KKyNpbmNsdWRl
IDxhc20vcmVnZGVmLmg+DQorI2luY2x1ZGUgPGFzbS9zdGFja2ZyYW1lLmg+
DQorI2luY2x1ZGUgPGFzbS9pc2FkZXAuaD4NCisjaW5jbHVkZSA8YXNtL3Vu
aXN0ZC5oPg0KKyNpbmNsdWRlIDxhc20vc3lzbWlwcy5oPg0KKyNpbmNsdWRl
IDxhc20vb2Zmc2V0Lmg+DQorI2luY2x1ZGUgPGFzbS9lcnJuby5oPg0KKw0K
KyNkZWZpbmUgUFRfVFJBQ0VTWVMgICAgIDB4MDAwMDAwMDINCisNCisJRVhQ
T1JUKGZhc3Rfc3lzbWlwcykNCisNCisJLnNldAlub3Jlb3JkZXINCisNCisJ
bGkJdDAsIE1JUFNfQVRPTUlDX1NFVA0KKwliZXEJYTAsIHQwLCAxZg0KKwkg
bm9wDQorCWoJc3lzX3N5c21pcHMNCisJIG5vcA0KKw0KKzE6DQorDQorCSMg
YTAgLSBNSVBTX0FUT01JQ19TRVQNCisJIyBhMSAtIG1lbSBwdHINCisJIyBh
MiAtIHZhbHVlDQorDQorCWFkZGl1CXNwLCBzcCwgLTgJCQkjIFJlc2VydmUg
c3BhY2UNCisJc3cJYTAsIChzcCkJCQkjIFNhdmUgYXJnMA0KKw0KKwlhZGRp
dQlhMCwgYTEsIDQJCQkjIGFkZHIrc2l6ZQ0KKwlvcmkJdjAsIGExLCA0CQkJ
IyBhZGRyIHwgc2l6ZQ0KKwlsdwl2MSwgVEhSRUFEX0NVUkRTKGdwKQkJIyBj
dXJyZW50LT50aHJlYWQuY3VycmVudF9kcw0KKwlvcgl2MCwgdjAsIGEwCQkJ
IyBhZGRyIHwgc2l6ZSB8IChhZGRyK3NpemUpDQorCWFuZAl2MSwgdjEsIHYw
CQkJIyAobWFzaykmKGFkZHIgfCBzaXplIHwgKGFkZHIrc2l6ZSkNCisJYmx0
egl2MSwgNWYNCisJIG5vcA0KKw0KKzI6DQorCWxsCXYwLCAoYTEpDQorCW1v
dmUJdDAsIGEyDQorCXNjCXQwLCAoYTEpDQorCWJlcXoJdDAsIDJiDQorCSBu
b3ANCisNCisJc3cJdjAsIFBUX1IyKzgoc3ApCQkJIyBSZXN1bHQgdmFsdWUN
CisJc3cJemVybywgUFRfUjcrOChzcCkJCSMgU3VjY2VzcyBpbmRpY2F0b3IN
CisNCisgICAgICAgIGx3ICAgICAgdDAsIFRBU0tfUFRSQUNFKGdwKQkJIyBz
eXNjYWxsIHRyYWNpbmcgZW5hYmxlZD8NCisJYW5kaSAgICB0MCwgUFRfVFJB
Q0VTWVMNCisJYm5leiAgICB0MCwgM2YNCisJIG5vcA0KKw0KKzQ6DQorCWx3
CWEwLCAoc3ApCQkJIyBSZXN0b3JlIGFyZzANCisJYWRkaXUJc3AsIHNwLCA4
CQkJIyBSZXN0b3JlIHNwDQorDQorCWoJbzMyX3JldF9mcm9tX3N5c19jYWxs
DQorCSBub3ANCisNCiszOg0KKwlzdwlyYSwgNChzcCkNCisJamFsCXN5c2Nh
bGxfdHJhY2UNCisJIG5vcA0KKwlsdwlyYSwgNChzcCkNCisJagk0Yg0KKwkg
bm9wDQorDQorNToNCisJbHcJYTAsIChzcCkJCQkjIFJlc3RvcmUgYXJnMA0K
KwlhZGRpdQlzcCwgc3AsIDgJCQkjIFJlc3RvcmUgc3ANCisJaglyYQ0KKwkg
bGkJdjAsIC1FRkFVTFQNCisNCmRpZmYgLU51ciBsaW51eC5vcmlnL2FyY2gv
bWlwcy9rZXJuZWwvaXJpeDVzeXMuaCBsaW51eC9hcmNoL21pcHMva2VybmVs
L2lyaXg1c3lzLmgNCi0tLSBsaW51eC5vcmlnL2FyY2gvbWlwcy9rZXJuZWwv
aXJpeDVzeXMuaAlNb24gQXByICA5IDAwOjE2OjI5IDIwMDENCisrKyBsaW51
eC9hcmNoL21pcHMva2VybmVsL2lyaXg1c3lzLmgJU3VuIEFwciAgOCAyMToy
MToxNiAyMDAxDQpAQCAtNjksNyArNjksNyBAQA0KIFNZUyhpcml4X2dldGdp
ZCwgMCkJCQkvKiAxMDQ3ICBnZXRnaWQoKQkgICAgICAgViovDQogU1lTKGly
aXhfdW5pbXAsIDApCQkJLyogMTA0OCAgKFhYWCBJUklYIDQgc3NpZykgICAg
IFYqLw0KIFNZUyhpcml4X21zZ3N5cywgNikJCQkvKiAxMDQ5ICBzeXNfbXNn
c3lzCSAgICAgICBWKi8NCi1TWVMoc3lzX3N5c21pcHMsIDQpCQkJLyogMTA1
MCAgc3lzbWlwcygpCSAgICAgIEhWKi8NCitTWVMoZmFzdF9zeXNtaXBzLCA0
KQkJCS8qIDEwNTAgIHN5c21pcHMoKQkgICAgICBIViovDQogU1lTKGlyaXhf
dW5pbXAsIDApCQkJLyogMTA1MQkgWFhYIHN5c2FjY3QoKQkgICAgICBJViov
DQogU1lTKGlyaXhfc2htc3lzLCA1KQkJCS8qIDEwNTIgIHN5c19zaG1zeXMJ
ICAgICAgIFYqLw0KIFNZUyhpcml4X3NlbXN5cywgMCkJCQkvKiAxMDUzICBz
eXNfc2Vtc3lzCSAgICAgICBWKi8NCmRpZmYgLU51ciBsaW51eC5vcmlnL2Fy
Y2gvbWlwcy9rZXJuZWwvc3lzY2FsbHMuaCBsaW51eC9hcmNoL21pcHMva2Vy
bmVsL3N5c2NhbGxzLmgNCi0tLSBsaW51eC5vcmlnL2FyY2gvbWlwcy9rZXJu
ZWwvc3lzY2FsbHMuaAlNb24gQXByICA5IDAwOjE2OjMwIDIwMDENCisrKyBs
aW51eC9hcmNoL21pcHMva2VybmVsL3N5c2NhbGxzLmgJU3VuIEFwciAgOCAy
MToyMTo0MyAyMDAxDQpAQCAtMTYzLDcgKzE2Myw3IEBADQogU1lTKHN5c193
cml0ZXYsIDMpDQogU1lTKHN5c19jYWNoZWZsdXNoLCAzKQ0KIFNZUyhzeXNf
Y2FjaGVjdGwsIDMpDQotU1lTKHN5c19zeXNtaXBzLCA0KQ0KK1NZUyhmYXN0
X3N5c21pcHMsIDQpDQogU1lTKHN5c19uaV9zeXNjYWxsLCAwKQkJCQkvKiA0
MTUwICovDQogU1lTKHN5c19nZXRzaWQsIDEpDQogU1lTKHN5c19mZGF0YXN5
bmMsIDApDQoNCg0K
---1463811071-77193963-994882794=:11181--
