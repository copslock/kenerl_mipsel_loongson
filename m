Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g03MZ7k29618
	for linux-mips-outgoing; Thu, 3 Jan 2002 14:35:07 -0800
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g03MZ0g29608;
	Thu, 3 Jan 2002 14:35:00 -0800
Received: from resel.enst-bretagne.fr (user75578@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g03LYpb11383;
	Thu, 3 Jan 2002 22:34:51 +0100
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id WAA19909;
	Thu, 3 Jan 2002 22:34:52 +0100
X-Authentication-Warning: maisel-gw.enst-bretagne.fr: Host mail@melkor.maisel.enst-bretagne.fr [172.16.20.65] claimed to be melkor
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.33 #1 (Debian))
	id 16MFVk-0002KM-00; Thu, 03 Jan 2002 22:34:52 +0100
Date: Thu, 3 Jan 2002 22:34:52 +0100 (CET)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: linux-mips@oss.sgi.com
Subject: aic7xxx (O2 scsi) DMA coherency
Message-ID: <Pine.LNX.4.21.0201032233400.8906-200000@melkor>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279724308-593455239-1010093692=:8906"
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279724308-593455239-1010093692=:8906
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello,

	This tells the aic7xxx to use DMA safe memory for I/O.

Vivien Chappelier.

--279724308-593455239-1010093692=:8906
Content-Type: TEXT/plain; name="linux-aic7xxx.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0201032234520.8906@melkor>
Content-Description: 
Content-Disposition: attachment; filename="linux-aic7xxx.diff"

ZGlmZiAtTmF1ciBsaW51eC9kcml2ZXJzL3Njc2kvYWljN3h4eC9haWM3eHh4
X2xpbnV4X2hvc3QuaCBsaW51eC5wYXRjaC9kcml2ZXJzL3Njc2kvYWljN3h4
eC9haWM3eHh4X2xpbnV4X2hvc3QuaA0KLS0tIGxpbnV4L2RyaXZlcnMvc2Nz
aS9haWM3eHh4L2FpYzd4eHhfbGludXhfaG9zdC5oCVRodSBEZWMgMjAgMTg6
MzE6MTEgMjAwMQ0KKysrIGxpbnV4LnBhdGNoL2RyaXZlcnMvc2NzaS9haWM3
eHh4L2FpYzd4eHhfbGludXhfaG9zdC5oCVRodSBEZWMgMjAgMjE6NDM6MzEg
MjAwMQ0KQEAgLTg3LDcgKzg3LDcgQEANCiAJc2dfdGFibGVzaXplOiAwLAkv
KiBtYXggc2NhdHRlci1nYXRoZXIgY21kcyAgICAqL1wNCiAJY21kX3Blcl9s
dW46IDIsCQkvKiBjbWRzIHBlciBsdW4JCSAgICAgICovXA0KIAlwcmVzZW50
OiAwLAkJLyogbnVtYmVyIG9mIDd4eHgncyBwcmVzZW50ICAgKi9cDQotCXVu
Y2hlY2tlZF9pc2FfZG1hOiAwLAkvKiBubyBtZW1vcnkgRE1BIHJlc3RyaWN0
aW9ucyAqL1wNCisJdW5jaGVja2VkX2lzYV9kbWE6IDEsCQkJCQlcDQogCXVz
ZV9jbHVzdGVyaW5nOiBFTkFCTEVfQ0xVU1RFUklORywJCQlcDQogCWhpZ2ht
ZW1faW86IDEJCQkJCQlcDQogfQ0K
--279724308-593455239-1010093692=:8906--
