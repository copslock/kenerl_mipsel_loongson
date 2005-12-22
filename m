Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Dec 2005 09:05:03 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.198]:45110 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133516AbVLVJEo (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 22 Dec 2005 09:04:44 +0000
Received: by wproxy.gmail.com with SMTP id 36so313712wra
        for <linux-mips@linux-mips.org>; Thu, 22 Dec 2005 01:05:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jqvFDav9dXEY4J/fhtbFRKOEYigbTWOR6lN7gPzFJABnn1+8iB0AHl1BT9wSPuG7MGDdRhLbEe/Z8UCymWq0C2S9Wz4cZkQ0l+MTysMvWgbPZZMSfkK7hfv6z2soxlb75WohOm0H8FurpJjsf91s42nBTZBABAB3tLFXOGcXnds=
Received: by 10.54.125.7 with SMTP id x7mr1825669wrc;
        Thu, 22 Dec 2005 01:05:58 -0800 (PST)
Received: by 10.54.156.5 with HTTP; Thu, 22 Dec 2005 01:05:58 -0800 (PST)
Message-ID: <50c9a2250512220105s190d7f72mde52616984f3fe88@mail.gmail.com>
Date:	Thu, 22 Dec 2005 17:05:58 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	zhuzhenhua <zzh.hust@gmail.com>,
	Matej Kupljen <matej.kupljen@ultra.si>,
	linux-mips@linux-mips.org
Subject: Re: does someone succeed in making the toolchain for 2.6 kernel?
In-Reply-To: <20051222085736.GD13985@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: base64
Content-Disposition: inline
References: <50c9a2250512210051q85f813fx27b0533fe66165e2@mail.gmail.com>
	 <20051221085539.GS13985@lug-owl.de>
	 <50c9a2250512210104j4a19e37cu30c795d4acc226d2@mail.gmail.com>
	 <20051221091852.GT13985@lug-owl.de>
	 <1135159354.5211.1.camel@localhost.localdomain>
	 <20051221100619.GW13985@lug-owl.de>
	 <1135161136.5211.8.camel@localhost.localdomain>
	 <50c9a2250512211843o469601e4p557f4645dd721949@mail.gmail.com>
	 <20051222085736.GD13985@lug-owl.de>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

T24gMTIvMjIvMDUsIEphbi1CZW5lZGljdCBHbGF3IDxqYmdsYXdAbHVnLW93bC5kZT4gd3JvdGU6
Cj4gT24gVGh1LCAyMDA1LTEyLTIyIDEwOjQzOjMxICswODAwLCB6aHV6aGVuaHVhIDx6emguaHVz
dEBnbWFpbC5jb20+IHdyb3RlOgo+ID4gT24gMTIvMjEvMDUsIE1hdGVqIEt1cGxqZW4gPG1hdGVq
Lmt1cGxqZW5AdWx0cmEuc2k+IHdyb3RlOgo+ID4gPiA+ID4gWWVzLCB3ZSB1c2UgY3Jvc3N0b29s
LCBidXQgdGhlIHJlc3VsdHMgbWF0cml4IGlzbid0IHJlbHkKPiA+ID4gPiA+IGVuY291cmFnaW5n
Ogo+ID4gPiA+ID4gaHR0cDovL3d3dy5rZWdlbC5jb20vY3Jvc3N0b29sL2Nyb3NzdG9vbC0wLjM4
L2J1aWxkbG9ncy8KPiA+Cj4gPiBpIGhhdmUgdXNlIHRoZSBjcm9zc3Rvb2wgdG8gdHJ5LGJ1dCBp
IGdldCBhCj4gPiAiI2Vycm9yICJnbGliYyBjYW5ub3QgYmUgY29tcGlsZWQgd2l0aG91dCBvcHRp
bWl6YXRpb24iCj4gPiB3aGF0IENGTEFHUyBhbmQgQ1hYRkxBR1Mgc2hvdWxkICB0byBzZXQgaW4g
ZGVtby1taXBzZWwuc2gKPgo+IEF0IGxlYXN0IC1PIEkgZ3Vlc3MsIG9yIC1PMi4KCmluIHRoZSBt
aXBzZWwuZGF0IGl0IGhhcyBkZWZpbmUgLU8yo6wKaSB0cnkgLU8gYW5kIC1PMixib3RoIGZhaWxl
ZAoKPgo+IE1mRywgSkJHCj4KPiAtLQo+IEphbi1CZW5lZGljdCBHbGF3ICAgICAgIGpiZ2xhd0Bs
dWctb3dsLmRlICAgIC4gKzQ5LTE3Mi03NjA4NDgxICAgICAgICAgICAgIF8gTyBfCj4gIkVpbmUg
RnJlaWUgTWVpbnVuZyBpbiAgZWluZW0gRnJlaWVuIEtvcGYgICAgfCBHZWdlbiBaZW5zdXIgfCBH
ZWdlbiBLcmllZyAgXyBfIE8KPiAgZqi5ciBlaW5lbiBGcmVpZW4gU3RhYXQgdm9sbCBGcmVpZXIg
Qqi5cmdlciIgIHwgaW0gSW50ZXJuZXQhIHwgICBpbSBJcmFrISAgIE8gTyBPCj4gcmV0ID0gZG9f
YWN0aW9ucygoY3VyciB8IEZSRUVfU1BFRUNIKSAmIH4oTkVXX0NPUFlSSUdIVF9MQVcgfCBEUk0g
fCBUQ1BBKSk7Cj4KPgo+IC0tLS0tQkVHSU4gUEdQIFNJR05BVFVSRS0tLS0tCj4gVmVyc2lvbjog
R251UEcgdjEuNC4xIChHTlUvTGludXgpCj4KPiBpRDhEQlFGRHFtcUFIYjFlZFlPWjRic1JBdDRm
QUo5S09ZUjcvMkg0a2JWV0pvMDc3ZGx0NWZWYVBRQ2ZkVFFUCj4gNWNLb0thOFBtNWVJZnZKQlBp
M2txOGM9Cj4gPWdmZDgKPiAtLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0KPgo+Cj4KQmVzdCBy
ZWdhcmRzCnpodXpoZW5odWEK
