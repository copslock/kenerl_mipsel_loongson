Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g04I8OL13349
	for linux-mips-outgoing; Fri, 4 Jan 2002 10:08:24 -0800
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g04I8Dg13346;
	Fri, 4 Jan 2002 10:08:14 -0800
Received: from resel.enst-bretagne.fr (maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g04H81b22909;
	Fri, 4 Jan 2002 18:08:01 +0100
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id SAA08775;
	Fri, 4 Jan 2002 18:08:02 +0100
X-Authentication-Warning: maisel-gw.enst-bretagne.fr: Host mail@melkor.maisel.enst-bretagne.fr [172.16.20.65] claimed to be melkor
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.33 #1 (Debian))
	id 16MTVn-0000K9-00; Fri, 04 Jan 2002 13:31:51 +0100
Date: Fri, 4 Jan 2002 13:30:55 +0100 (CET)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: aic7xxx (O2 scsi) DMA coherency
In-Reply-To: <E16MFrP-00018Z-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0201041324560.639-200000@melkor>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279724308-637116453-1010147455=:639"
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279724308-637116453-1010147455=:639
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello,

On Thu, 3 Jan 2002, Alan Cox wrote:

> > 	This tells the aic7xxx to use DMA safe memory for I/O.
> 
> That seems totally inappropriate. The unchecked dma option is for
> ancient ISA DMA controllers that didnt do the 16Mb check.
> 

Maybe this is more appropriate then :)
It tells the scsi scanner to always use DMA safe memory when doing its
INQUIRY commands...
On the O2, kernel is running in cacheable, non-coherent memory. kmalloc,
with GFP_DMA flag will return a piece of uncacheable memory which is safe
for I/O with devices.

regards,
Vivien Chappelier

--279724308-637116453-1010147455=:639
Content-Type: TEXT/plain; name="linux-scsi_scan.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0201041330550.639@melkor>
Content-Description: 
Content-Disposition: attachment; filename="linux-scsi_scan.diff"

LS0tIGxpbnV4L2RyaXZlcnMvc2NzaS9zY3NpX3NjYW4uYwlUaHUgRGVjIDIw
IDE4OjMxOjA5IDIwMDENCisrKyBsaW51eC5wYXRjaC9kcml2ZXJzL3Njc2kv
c2NzaV9zY2FuLmMJRnJpIEphbiAgNCAxMzoxNzozMSAyMDAyDQpAQCAtMjgz
LDcgKzI4Myw2IEBADQogCXVuc2lnbmVkIGludCBsdW47DQogCXVuc2lnbmVk
IGludCBtYXhfZGV2X2x1bjsNCiAJdW5zaWduZWQgY2hhciAqc2NzaV9yZXN1
bHQ7DQotCXVuc2lnbmVkIGNoYXIgc2NzaV9yZXN1bHQwWzI1Nl07DQogCVNj
c2lfRGV2aWNlICpTRHBudDsNCiAJU2NzaV9EZXZpY2UgKlNEdGFpbDsNCiAJ
dW5zaWduZWQgaW50IHNwYXJzZV9sdW47DQpAQCAtMzA1LDggKzMwNCw3IEBA
DQogCQlzY3NpX2luaXRpYWxpemVfcXVldWUoU0RwbnQsIHNocG50KTsNCiAJ
CVNEcG50LT5yZXF1ZXN0X3F1ZXVlLnF1ZXVlZGF0YSA9ICh2b2lkICopIFNE
cG50Ow0KIAkJLyogTWFrZSBzdXJlIHdlIGhhdmUgc29tZXRoaW5nIHRoYXQg
aXMgdmFsaWQgZm9yIERNQSBwdXJwb3NlcyAqLw0KLQkJc2NzaV9yZXN1bHQg
PSAoKCFzaHBudC0+dW5jaGVja2VkX2lzYV9kbWEpDQotCQkJICAgICAgID8g
JnNjc2lfcmVzdWx0MFswXSA6IGttYWxsb2MoNTEyLCBHRlBfRE1BKSk7DQor
CQlzY3NpX3Jlc3VsdCA9IGttYWxsb2MoNTEyLCBHRlBfRE1BKTsNCiAJfQ0K
IA0KIAlpZiAoc2NzaV9yZXN1bHQgPT0gTlVMTCkgew0KQEAgLTQ2Myw3ICs0
NjEsNyBAQA0KIAl9DQogDQogCS8qIElmIHdlIGFsbG9jYXRlZCBhIGJ1ZmZl
ciBzbyB3ZSBjb3VsZCBkbyBETUEsIGZyZWUgaXQgbm93ICovDQotCWlmIChz
Y3NpX3Jlc3VsdCAhPSAmc2NzaV9yZXN1bHQwWzBdICYmIHNjc2lfcmVzdWx0
ICE9IE5VTEwpIHsNCisJaWYgKHNjc2lfcmVzdWx0ICE9IE5VTEwpIHsNCiAJ
CWtmcmVlKHNjc2lfcmVzdWx0KTsNCiAJfSB7DQogCQlTY3NpX0RldmljZSAq
c2RldjsNCg==
--279724308-637116453-1010147455=:639--
