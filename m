Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g04IXAL13933
	for linux-mips-outgoing; Fri, 4 Jan 2002 10:33:10 -0800
Received: from laposte.enst-bretagne.fr (laposte.enst-bretagne.fr [192.108.115.3])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g04IX1g13930;
	Fri, 4 Jan 2002 10:33:01 -0800
Received: from resel.enst-bretagne.fr (user92826@maisel-gw.enst-bretagne.fr [192.44.76.8])
	by laposte.enst-bretagne.fr (8.11.6/8.11.6) with ESMTP id g04HWqb30062;
	Fri, 4 Jan 2002 18:32:52 +0100
Received: from melkor (mail@melkor.maisel.enst-bretagne.fr [172.16.20.65])
	by resel.enst-bretagne.fr (8.9.3/8.9.3/Debian 8.9.3-21) with ESMTP id SAA15603;
	Fri, 4 Jan 2002 18:32:52 +0100
X-Authentication-Warning: maisel-gw.enst-bretagne.fr: Host mail@melkor.maisel.enst-bretagne.fr [172.16.20.65] claimed to be melkor
Received: from glaurung (helo=localhost)
	by melkor with local-esmtp (Exim 3.33 #1 (Debian))
	id 16MYD6-0000xh-00; Fri, 04 Jan 2002 18:32:52 +0100
Date: Fri, 4 Jan 2002 18:32:52 +0100 (CET)
From: Vivien Chappelier <vivien.chappelier@enst-bretagne.fr>
X-Sender: glaurung@melkor
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mips@oss.sgi.com
Subject: Re: aic7xxx (O2 scsi) DMA coherency
In-Reply-To: <20020103215215.A1186@dea.linux-mips.net>
Message-ID: <Pine.LNX.4.21.0201041830450.3669-200000@melkor>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="279724308-311915002-1010165488=:3669"
Content-ID: <Pine.LNX.4.21.0201041831480.3669@melkor>
X-Virus-Scanned: by amavisd-milter (http://amavis.org/) at enst-bretagne.fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--279724308-311915002-1010165488=:3669
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.21.0201041831481.3669@melkor>

On Thu, 3 Jan 2002, Ralf Baechle wrote:

> On Thu, Jan 03, 2002 at 10:51:51PM +0100, Vivien Chappelier wrote:
> 
> > > > 	This tells the aic7xxx to use DMA safe memory for I/O.
> > > 
> > > That seems totally inappropriate. The unchecked dma option is for
> > > ancient ISA DMA controllers that didnt do the 16Mb check. If you
> > > find you need it debug your pci remapper
> > 
> > This is used when scaning for devices (drivers/scsi/scsi_scan.c) . When
> > this flag is not set, the code uses memory from the stack (unsigned char
> > scsi_result0[256]; in scan_scsis) instead of kmallocating it DMA safe as
> > it should on non-coherent systems. Maybe this is the thing to change?
> 
> Indeed, it is.  I thought this one died ages ago.

Here is a patch to fix that then. It forces allocation of DMA safe
memory in any case. I've not looked at the PPC64 patch however.

regards,
Vivien Chappelier.

--279724308-311915002-1010165488=:3669
Content-Type: TEXT/PLAIN; NAME="linux-scsi_scan.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0201041831280.3669@melkor>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="linux-scsi_scan.diff"

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
--279724308-311915002-1010165488=:3669--
