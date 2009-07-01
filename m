Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 19:34:01 +0200 (CEST)
Received: from mail-gx0-f222.google.com ([209.85.217.222]:38616 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491784AbZGARdy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 1 Jul 2009 19:33:54 +0200
Received: by gxk22 with SMTP id 22so1689310gxk.0
        for <multiple recipients>; Wed, 01 Jul 2009 10:28:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1yGL1iMICOo9aWRD4beDw7N8Qy0gRR1OBWXu+ibEYIw=;
        b=aXBNdFrmRY1q2oLl5e4bjX2ieqNYwQr9qdSXLETY6uAZBWHxm/fJZKCrTj8JIxwwxS
         b09Yv0vmotZAFdXa3VcD9DzRMSRH+LyhhPwdHxU1ZYo4DhASZirSTvyBi1NNh5ydm6sR
         quwwkEVQ6sgm8jUrPMReP+EO1jbFpgnfT/nsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Cmon2XDpjL6pdRFuUQIEgG6hQDUrNjeOuniWQeJrGe7ZoncVt5S+yg6QaCO75h72Ac
         ho/+jGz1fUAdUf6otrIV6JAi+Y1VOIeRTmjekS1kIDc1ETdvgZaEemmjQd2YbfrmGOS1
         CVgvWfx+G2mtNHzp3KE8Mq0naq0M1n8U4RYvA=
MIME-Version: 1.0
Received: by 10.90.55.3 with SMTP id d3mr8465973aga.100.1246469298890; Wed, 01 
	Jul 2009 10:28:18 -0700 (PDT)
In-Reply-To: <200907011829.16850.bzolnier@gmail.com>
References: <etTXaRqGgAC.A.SaE.6iASKB@chimera>
	 <1246459661.9660.40.camel@falcon>
	 <200907011821.26091.bzolnier@gmail.com>
	 <200907011829.16850.bzolnier@gmail.com>
Date:	Thu, 2 Jul 2009 01:28:18 +0800
Message-ID: <b6a2187b0907011028r27d35be4xc62c7ed4496dfb2f@mail.gmail.com>
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
From:	Jeff Chua <jeff.chua.linux@gmail.com>
To:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc:	wuzhangjin@gmail.com,
	Etienne Basset <etienne.basset@numericable.fr>,
	David Miller <davem@davemloft.net>, rjw@sisk.pl,
	linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-ide@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: base64
Return-Path: <jeff.chua.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23580
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jeff.chua.linux@gmail.com
Precedence: bulk
X-list: linux-mips

T24gVGh1LCBKdWwgMiwgMjAwOSBhdCAxMjoyOSBBTSwgQmFydGxvbWllagpab2xuaWVya2lld2lj
ejxiem9sbmllckBnbWFpbC5jb20+IHdyb3RlOgo+IEhlcmUgaXMgdGhlIG1vcmUgY29tcGxldGUg
dmVyc2lvbiwgYWxzbyB0YWtpbmcgaW50byB0aGUgYWNjb3VudCBjaGFuZ2VzCj4gaW4gaWRlX2lu
dHIoKSBhbmQgaWRlX3RpbWVyX2V4cGlyeSgpOgoKVGhpcyB3b3JrcyBncmVhdCBmb3IuIFN1cnZp
dmVkIFNUUiwgU1RELiBJIGp1c3QgYXBwbGllZCBvbiB0b3AgdmFuaWxsYQpsYXRlc3QgTGludXMn
cyBnaXQgcHVsbC4gTm90aGluZyBlbHNlIHRvIHJldmVydC4KClRoYW5rcywKSmVmZi4KCgo+IC0t
LQo+IKBkcml2ZXJzL2lkZS9pZGUtaW8uYyB8IKAgMTUgKysrKysrKysrKy0tLS0tCj4goDEgZmls
ZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Cj4gSW5kZXg6IGIv
ZHJpdmVycy9pZGUvaWRlLWlvLmMKPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gLS0tIGEvZHJpdmVycy9pZGUvaWRl
LWlvLmMKPiArKysgYi9kcml2ZXJzL2lkZS9pZGUtaW8uYwo+IEBAIC01MzIsNyArNTMyLDggQEAg
cmVwZWF0Ogo+Cj4goCCgIKAgoCCgIKAgoCCgaWYgKHN0YXJ0c3RvcCA9PSBpZGVfc3RvcHBlZCkg
ewo+IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgcnEgPSBod2lmLT5ycTsKPiAtIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCBod2lmLT5ycSA9IE5VTEw7Cj4gKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgaWYg
KChkcml2ZS0+ZGV2X2ZsYWdzICYgSURFX0RGTEFHX0JMT0NLRUQpID09IDApCj4gKyCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCBod2lmLT5ycSA9IE5VTEw7Cj4goCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKBnb3RvIHJlcGVhdDsKPiCgIKAgoCCgIKAgoCCgIKB9Cj4goCCgIKAgoH0gZWxzZQo+
IEBAIC02NzksOCArNjgwLDEwIEBAIHZvaWQgaWRlX3RpbWVyX2V4cGlyeSAodW5zaWduZWQgbG9u
ZyBkYXQKPiCgIKAgoCCgIKAgoCCgIKBzcGluX2xvY2tfaXJxKCZod2lmLT5sb2NrKTsKPiCgIKAg
oCCgIKAgoCCgIKBlbmFibGVfaXJxKGh3aWYtPmlycSk7Cj4goCCgIKAgoCCgIKAgoCCgaWYgKHN0
YXJ0c3RvcCA9PSBpZGVfc3RvcHBlZCAmJiBod2lmLT5wb2xsaW5nID09IDApIHsKPiAtIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCBycV9pbl9mbGlnaHQgPSBod2lmLT5ycTsKPiAtIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCBod2lmLT5ycSA9IE5VTEw7Cj4gKyCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgaWYg
KChkcml2ZS0+ZGV2X2ZsYWdzICYgSURFX0RGTEFHX0JMT0NLRUQpID09IDApIHsKPiArIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIHJxX2luX2ZsaWdodCA9IGh3aWYtPnJxOwo+ICsgoCCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgaHdpZi0+cnEgPSBOVUxMOwo+ICsgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIH0KPiCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoGlkZV91bmxvY2tfcG9ydCho
d2lmKTsKPiCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoHBsdWdfZGV2aWNlID0gMTsKPiCgIKAgoCCg
IKAgoCCgIKB9Cj4gQEAgLTg1Niw4ICs4NTksMTAgQEAgaXJxcmV0dXJuX3QgaWRlX2ludHIgKGlu
dCBpcnEsIHZvaWQgKmRldgo+IKAgoCCgIKAgKi8KPiCgIKAgoCCgaWYgKHN0YXJ0c3RvcCA9PSBp
ZGVfc3RvcHBlZCAmJiBod2lmLT5wb2xsaW5nID09IDApIHsKPiCgIKAgoCCgIKAgoCCgIKBCVUdf
T04oaHdpZi0+aGFuZGxlcik7Cj4gLSCgIKAgoCCgIKAgoCCgIHJxX2luX2ZsaWdodCA9IGh3aWYt
PnJxOwo+IC0goCCgIKAgoCCgIKAgoCBod2lmLT5ycSA9IE5VTEw7Cj4gKyCgIKAgoCCgIKAgoCCg
IGlmICgoZHJpdmUtPmRldl9mbGFncyAmIElERV9ERkxBR19CTE9DS0VEKSA9PSAwKSB7Cj4gKyCg
IKAgoCCgIKAgoCCgIKAgoCCgIKAgcnFfaW5fZmxpZ2h0ID0gaHdpZi0+cnE7Cj4gKyCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgaHdpZi0+cnEgPSBOVUxMOwo+ICsgoCCgIKAgoCCgIKAgoCB9Cj4goCCg
IKAgoCCgIKAgoCCgaWRlX3VubG9ja19wb3J0KGh3aWYpOwo+IKAgoCCgIKAgoCCgIKAgoHBsdWdf
ZGV2aWNlID0gMTsKPiCgIKAgoCCgfQo+Cg==
