Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g03MimZ30118
	for linux-mips-outgoing; Thu, 3 Jan 2002 14:44:48 -0800
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g03Micg30110;
	Thu, 3 Jan 2002 14:44:39 -0800
Received: from resel.enst-bretagne.fr (user15024@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g03LiTb11869;
	Thu, 3 Jan 2002 22:44:29 +0100
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id WAA20667;
	Thu, 3 Jan 2002 22:44:30 +0100
X-Authentication-Warning: maisel-gw.enst-bretagne.fr: Host mail@melkor.maisel.enst-bretagne.fr [172.16.20.65] claimed to be melkor
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.33 #1 (Debian))
	id 16MFf4-0002Lw-00; Thu, 03 Jan 2002 22:44:30 +0100
Date: Thu, 3 Jan 2002 22:44:30 +0100 (CET)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: binutils bug workaround
Message-ID: <Pine.LNX.4.21.0201032241030.8906-200000@melkor>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279724308-1446538874-1010094270=:8906"
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279724308-1446538874-1010094270=:8906
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hi,

	There is a binutils bug (as) which produces bad addresses when
getting the address of a struct member for initializing the same struct,
and when there is data or static functions declared before:
int test = 0xdeadbeef;

struct {
        int dummy;
        void *ptr;
} bug =
{
  ptr:  &bug.ptr
};

will produce bad value for bug.ptr.

	This patch move the declaration of kswapd_wait as a workaround to
this compiler bug. This probably affects all mips64 kernels.

Vivien Chappelier.

--279724308-1446538874-1010094270=:8906
Content-Type: TEXT/plain; name="linux-mips-binutils_bug_workaround.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0201032244300.8906@melkor>
Content-Description: 
Content-Disposition: attachment; filename="linux-mips-binutils_bug_workaround.diff"

ZGlmZiAtTmF1ciBsaW51eC9tbS92bXNjYW4uYyBsaW51eC5wYXRjaC9tbS92
bXNjYW4uYw0KLS0tIGxpbnV4L21tL3Ztc2Nhbi5jCVN1biBEZWMgIDkgMTU6
NTM6MTUgMjAwMQ0KKysrIGxpbnV4LnBhdGNoL21tL3Ztc2Nhbi5jCVdlZCBK
YW4gIDIgMjM6MTY6MjIgMjAwMg0KQEAgLTI0LDYgKzI0LDggQEANCiANCiAj
aW5jbHVkZSA8YXNtL3BnYWxsb2MuaD4NCiANCitERUNMQVJFX1dBSVRfUVVF
VUVfSEVBRChrc3dhcGRfd2FpdCk7DQorDQogLyoNCiAgKiBUaGUgInByaW9y
aXR5IiBvZiBWTSBzY2FubmluZyBpcyBob3cgbXVjaCBvZiB0aGUgcXVldWVz
IHdlDQogICogd2lsbCBzY2FuIGluIG9uZSBnby4gQSB2YWx1ZSBvZiA2IGZv
ciBERUZfUFJJT1JJVFkgaW1wbGllcw0KQEAgLTYwMSw4ICs2MDMsNiBAQA0K
IAlvdXRfb2ZfbWVtb3J5KCk7DQogCXJldHVybiAwOw0KIH0NCi0NCi1ERUNM
QVJFX1dBSVRfUVVFVUVfSEVBRChrc3dhcGRfd2FpdCk7DQogDQogc3RhdGlj
IGludCBjaGVja19jbGFzc3pvbmVfbmVlZF9iYWxhbmNlKHpvbmVfdCAqIGNs
YXNzem9uZSkNCiB7DQo=
--279724308-1446538874-1010094270=:8906--
