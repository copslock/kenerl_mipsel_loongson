Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jul 2007 04:41:26 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.178]:38083 "EHLO
	wa-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20021483AbXGYDlY (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jul 2007 04:41:24 +0100
Received: by wa-out-1112.google.com with SMTP id m16so62129waf
        for <linux-mips@linux-mips.org>; Tue, 24 Jul 2007 20:41:21 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qk5ZIIqagsbh2vdC7nhcZ5wTI5cuaV1IaS2/0P019RoGSzSQtZsdlEVzD6BphAdsG5NUPxFdq/2NB4GYB2MzLVoSTHti1kfjgXpa3PVwCi4XKqztaif+paFmc1COpoqPP8vfGfaY+26O4me1D+TjLkuPJ8BUJoIl8QMyyD3BpOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t1XFkjgEJO9tRRZGDM31KNlgH0TCWDJcHAZLtiiqKJoZ96wvxfPsPWUMCX0KYhy74cU/UCUO5O+R7otAy0FAGnzN8GqI2aRzf1Mi91HgK0wLFsxCWDQcuKzM2iBGKniv0i3u7r7/YvKy5wfHuXSSh509jW8qFJa8toiMyNBoT4I=
Received: by 10.114.179.1 with SMTP id b1mr209546waf.1185334881868;
        Tue, 24 Jul 2007 20:41:21 -0700 (PDT)
Received: by 10.114.67.6 with HTTP; Tue, 24 Jul 2007 20:41:21 -0700 (PDT)
Message-ID: <5861a7880707242041w32811dal6e2765747cbada32@mail.gmail.com>
Date:	Wed, 25 Jul 2007 07:41:21 +0400
From:	"Dajie Tan" <jiankemeng@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [PATCH] Add support for profiling Loongson 2E
Cc:	inux-mips <linux-mips@linux-mips.org>, phil.el@wanadoo.fr,
	levon@movementarian.org, oprofile-list@lists.sourceforge.net
In-Reply-To: <20070724144051.GA17256@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Content-Disposition: inline
References: <5861a7880707240220g5d8129anc95e10bea833e323@mail.gmail.com>
	 <20070724144051.GA17256@linux-mips.org>
Return-Path: <jiankemeng@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiankemeng@gmail.com
Precedence: bulk
X-list: linux-mips

PiBXaHkgZG8geW91IG5lZWQgdGhpcyBjaGFuZ2U/ICBJdCBhbG1vc3QgbG9va3MgYXMgaWYgeW91
J3JlIHBhcGVyaW5nIG92ZXIKPiBhIGJ1ZyB3aGVyZSBhZGRfc2FtcGxlIHNob3VsZCBub3QgYmUg
Y2FsbGVkIGF0IGFsbC4KClllYWgsdGhpcyBjaGFuZ2UgaXMgdG8gZW5oYW5jZSB0aGUgcm9idXN0
IG9mIG9wcm9maWxlLiBXaGVuIHVzaW5nCnBlcmZvcm1hY2UgY291bnRlciBtYW51YWxseSh3cml0
dGluZyBjb250cm9sIHJlZ2lzdGVyIGluIGEgbW9kdWxlLCBubwpuZWVkIHRvIHVzZSB0aGUgb3By
b2ZpbGUpLEkgdXN1YWxseSBtYWtlIGtlcm5lbCBwYW5pYyBpZiBJIGRvIG5vdAppbml0aWFsaXpl
IHRoZSBvcHJvZmlsZSBhbmQgZW5hYmxlIHRoZSBvdmVyZmxvdyBpbnRlcnJ1cHQgY2FyZWxlc3Ns
eS4KU28sIHRoaXMgY2hhbmdlIGNhbiBhdm9pZCB0aGlzIHBhbmljLiA6RAoKMjAwNy83LzI0LCBS
YWxmIEJhZWNobGUgPHJhbGZAbGludXgtbWlwcy5vcmc+Ogo+IE9uIFR1ZSwgSnVsIDI0LCAyMDA3
IGF0IDAxOjIwOjI3UE0gKzA0MDAsIERhamllIFRhbiB3cm90ZToKPgo+ID4gVGhpcyBwYXRjaCBh
ZGRzIHN1cHBvcnQgZm9yIHByb2ZpbGluZyBMb29uZ3NvbiAyRS4gSXQncyBiZWVuIHRlc3RlZCBv
bgo+ID4gRnVMb25nIG1pbmkgUEMobG9vbmdzb24yZSBpbnNpZGUpLgo+Cj4gRmlyc3Qgb2YgYWxs
LCB5b3VyIHBhdGNoIGhhcyBiZWVuIGdhcmJsZWQgd2hlbiBtYWlsaW5nLgo+Cj4KPiBbLi4gTG90
cyBvZiBhcmNoL21pcHMgY29kZSBkZWxldGVkIC4uLl0KPgo+IE5vIGNvbXBsYWludHMgdXB0byB0
aGlzIHBvaW50LiAgQnV0Ogo+Cj4gPiBkaWZmIC11ck4gYi9kcml2ZXJzL29wcm9maWxlL2NwdV9i
dWZmZXIuYyBhL2RyaXZlcnMvb3Byb2ZpbGUvY3B1X2J1ZmZlci5jCj4gPiAtLS0gYi9kcml2ZXJz
L29wcm9maWxlL2NwdV9idWZmZXIuYyAgIDIwMDctMDctMjQgMTM6MDA6NTQuMDAwMDAwMDAwICsw
ODAwCj4gPiArKysgYS9kcml2ZXJzL29wcm9maWxlL2NwdV9idWZmZXIuYyAgIDIwMDctMDctMTkg
MDg6MjI6MTUuMDAwMDAwMDAwICswODAwCj4gPiBAQCAtMTQ4LDYgKzE0OCwxMCBAQAo+ID4gICAg
ICAgICAgICB1bnNpZ25lZCBsb25nIHBjLCB1bnNpZ25lZCBsb25nIGV2ZW50KQo+ID4gewo+ID4g
ICAgICAgc3RydWN0IG9wX3NhbXBsZSAqIGVudHJ5ID0gJmNwdV9idWYtPmJ1ZmZlcltjcHVfYnVm
LT5oZWFkX3Bvc107Cj4gPiArCj4gPiArICAgICBpZighZW50cnkpCj4gPiArICAgICAgICAgICAg
IHJldHVybjsKPiA+ICsKPiA+ICAgICAgIGVudHJ5LT5laXAgPSBwYzsKPiA+ICAgICAgIGVudHJ5
LT5ldmVudCA9IGV2ZW50Owo+ID4gICAgICAgaW5jcmVtZW50X2hlYWQoY3B1X2J1Zik7Cj4KPiBX
aHkgZG8geW91IG5lZWQgdGhpcyBjaGFuZ2U/ICBJdCBhbG1vc3QgbG9va3MgYXMgaWYgeW91J3Jl
IHBhcGVyaW5nIG92ZXIKPiBhIGJ1ZyB3aGVyZSBhZGRfc2FtcGxlIHNob3VsZCBub3QgYmUgY2Fs
bGVkIGF0IGFsbC4KPgo+ICAgUmFsZgo+CgoKLS0gCuS4uuWkqeWcsOeri+W/gwrkuLrnlJ/msJHn
q4vlkb0K5Li65b6A5Zyj57un57ud5a2mCuS4uuS4h+S4luW8gOWkquW5swo=
