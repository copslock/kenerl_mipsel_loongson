Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 11:42:51 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:35316 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491817Ab1FFJms (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 11:42:48 +0200
Received: by qyk32 with SMTP id 32so802471qyk.15
        for <linux-mips@linux-mips.org>; Mon, 06 Jun 2011 02:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LL7AhwOXkOYH36V8inupW+Yt1UYaiw8B1rWXKqN1fbo=;
        b=l6QIPjbzvA4Z7+tbVPZ69fzCT/mEf55X0QEvNk7AVKeIPzJ3jM7q9gj+HK9iN5/Mwu
         0bBxmFw90WX6OClBAg4vtk2Su36KxHo3t2YcuulTjGxZkHp7sFEkMh12KkuOR0t+KQRX
         G9mHimn95hykq71jnYrKWPD0Du/R8ltZix64Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YU/95zXs9bD9HNsuQ8EXKfuOt3XzrY4AvexMFoEcWrhjEdjo7UmJD1yLBjyjU8xhn1
         rxWgXI6aeuwKgxBeZZnQ7Sn0vbcGXRGeLFm120ab2UHlBvqA3IUoVvePsrhjQmiRfcwn
         8spO8vyd5Nw5wChxE+ttkQc3zhkUkFg/rMTk8=
MIME-Version: 1.0
Received: by 10.224.191.10 with SMTP id dk10mr1555889qab.170.1307353361789;
 Mon, 06 Jun 2011 02:42:41 -0700 (PDT)
Received: by 10.229.96.21 with HTTP; Mon, 6 Jun 2011 02:42:41 -0700 (PDT)
In-Reply-To: <1307311658-15853-2-git-send-email-hauke@hauke-m.de>
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
        <1307311658-15853-2-git-send-email-hauke@hauke-m.de>
Date:   Mon, 6 Jun 2011 11:42:41 +0200
Message-ID: <BANLkTimAPHPcqKKJ+Rphef_+1RB0aHR4ug@mail.gmail.com>
Subject: Re: [RFC][PATCH 01/10] bcma: Use array to store cores.
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <greg@kroah.com>
Cc:     linux-wireless@vger.kernel.org, linux-mips@linux-mips.org,
        mb@bu3sch.de, george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-archive-position: 30240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4019

R3JlZywgQXJuZDogY291bGQgeW91IHRha2UgYSBsb29rIGF0IHRoaXMgcGF0Y2gsIHBsZWFzZT8K
CldpdGggcHJvcG9zZWQgcGF0Y2ggd2UgYXJlIGdvaW5nIGJhY2sgdG8gdGhpcyB1Z2x5IGFycmF5
IGFuZCB3cmFwcGVycyBoYWNrcy4KCkkgd2FzIHJlYWxseSBoYXBweSB3aXRoIG91ciBmaW5hbCBz
b2x1dGlvbiwgYnV0IGl0IHNlZW1zIGl0J3Mgbm90CmRvYWJsZSBmb3IgZW1iZWRkZWQgc3lzdGVt
cy4uLj8gSXMgdGhlcmUgc29tZXRoaW5nIGJldHRlciB3ZSBjYW4gZG8KYWJvdXQgdGhpcz8KCjIw
MTEvNi82IEhhdWtlIE1laHJ0ZW5zIDxoYXVrZUBoYXVrZS1tLmRlPjoKPiBXaGVuIHVzaW5nIGJj
bWEgb24gYSBlbWJlZGRlZCBkZXZpY2UgaXQgaXMgaW5pdGlhbGl6ZWQgdmVyeSBlYXJseSBhdAo+
IGJvb3QuIFdlIGhhdmUgdG8gZG8gc28gYXMgdGhlIGNwdSBhbmQgaW50ZXJydXB0IG1hbmFnZW1l
bnQgYW5kIGFsbAo+IG90aGVyIGRldmljZXMgYXJlIGF0dGFjaGVkIHRvIHRoaXMgYnVzIGFuZCBp
dCBoYXMgdG8gYmUgaW5pdGlhbGl6ZWQgc28KPiBlYXJseS4gSW4gdGhhdCBzdGFnZSB3ZSBjYW4g
bm90IGFsbG9jYXRlIG1lbW9yeSBvciBzbGVlcCwganVzdCB1c2UgdGhlCj4gbWVtb3J5IG9uIHRo
ZSBzdGFjayBhbmQgaW4gdGhlIHRleHQgc2VnbWVudCBhcyB0aGUga2VybmVsIGlzIG5vdAo+IGlu
aXRpYWxpemVkIGZhciBlbm91Z2guIFRoaXMgcGF0Y2ggcmVtb3ZlZCB0aGUga3phbGxvY3MgZnJv
bSB0aGUgc2Nhbgo+IGNvZGUuIFNvbWUgZWFybGllciB2ZXJzaW9uIG9mIHRoZSBiY21hIGltcGxl
bWVudGF0aW9uIGFuZCB0aGUgbm9ybWFsCj4gc3NiIGltcGxlbWVudGF0aW9uIGFyZSBkb2luZyBp
dCBsaWtlIHRoaXMuCj4gVGhlIF9fYmNtYV9kZXZfd3JhcHBlciBzdHJ1Y3QgaXMgdXNlZCBhcyB0
aGUgY29udGFpbmVyIGZvciB0aGUgZGV2aWNlCj4gc3RydWN0IGFzIGJjbWFfZGV2aWNlIHdpbGwg
YmUgdG9vIGJpZyBpZiBpdCBpbmNsdWRlcyBzdHJ1Y3QgZGV2aWNlLgo+Cj4gU2lnbmVkLW9mZi1i
eTogSGF1a2UgTWVocnRlbnMgPGhhdWtlQGhhdWtlLW0uZGU+Cj4gLS0tCj4gwqBkcml2ZXJzL2Jj
bWEvbWFpbi5jIMKgIMKgIMKgIHwgwqAgODYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0KPiDCoGRyaXZlcnMvYmNtYS9zY2FuLmMgwqAgwqAgwqAgfCDCoCA1OCAr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0KPiDCoGluY2x1ZGUvbGludXgvYmNtYS9iY21h
LmggfCDCoCAxNiArKysrKystLQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCA4OSBpbnNlcnRpb25zKCsp
LCA3MSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JjbWEvbWFpbi5jIGIv
ZHJpdmVycy9iY21hL21haW4uYwo+IGluZGV4IGEyZjZiMTguLmIwZTdmNWUgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9iY21hL21haW4uYwo+ICsrKyBiL2RyaXZlcnMvYmNtYS9tYWluLmMKPiBAQCAt
MTcsMjMgKzE3LDI3IEBAIHN0YXRpYyBpbnQgYmNtYV9kZXZpY2VfcmVtb3ZlKHN0cnVjdCBkZXZp
Y2UgKmRldik7Cj4KPiDCoHN0YXRpYyBzc2l6ZV90IG1hbnVmX3Nob3coc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQo+IMKgewo+IC0g
wqAgwqAgwqAgc3RydWN0IGJjbWFfZGV2aWNlICpjb3JlID0gY29udGFpbmVyX29mKGRldiwgc3Ry
dWN0IGJjbWFfZGV2aWNlLCBkZXYpOwo+IC0gwqAgwqAgwqAgcmV0dXJuIHNwcmludGYoYnVmLCAi
MHglMDNYXG4iLCBjb3JlLT5pZC5tYW51Zik7Cj4gKyDCoCDCoCDCoCBzdHJ1Y3QgX19iY21hX2Rl
dl93cmFwcGVyICp3cmFwcGVyID0gY29udGFpbmVyX29mKGRldiwKPiArIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0
cnVjdCBfX2JjbWFfZGV2X3dyYXBwZXIsIGRldik7Cj4gKyDCoCDCoCDCoCByZXR1cm4gc3ByaW50
ZihidWYsICIweCUwM1hcbiIsIHdyYXBwZXItPmNvcmUtPmlkLm1hbnVmKTsKPiDCoH0KPiDCoHN0
YXRpYyBzc2l6ZV90IGlkX3Nob3coc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0
dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQo+IMKgewo+IC0gwqAgwqAgwqAgc3RydWN0IGJjbWFf
ZGV2aWNlICpjb3JlID0gY29udGFpbmVyX29mKGRldiwgc3RydWN0IGJjbWFfZGV2aWNlLCBkZXYp
Owo+IC0gwqAgwqAgwqAgcmV0dXJuIHNwcmludGYoYnVmLCAiMHglMDNYXG4iLCBjb3JlLT5pZC5p
ZCk7Cj4gKyDCoCDCoCDCoCBzdHJ1Y3QgX19iY21hX2Rldl93cmFwcGVyICp3cmFwcGVyID0gY29u
dGFpbmVyX29mKGRldiwKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBfX2JjbWFfZGV2X3dyYXBwZXIs
IGRldik7Cj4gKyDCoCDCoCDCoCByZXR1cm4gc3ByaW50ZihidWYsICIweCUwM1hcbiIsIHdyYXBw
ZXItPmNvcmUtPmlkLmlkKTsKPiDCoH0KPiDCoHN0YXRpYyBzc2l6ZV90IHJldl9zaG93KHN0cnVj
dCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsIGNoYXIgKmJ1ZikK
PiDCoHsKPiAtIMKgIMKgIMKgIHN0cnVjdCBiY21hX2RldmljZSAqY29yZSA9IGNvbnRhaW5lcl9v
ZihkZXYsIHN0cnVjdCBiY21hX2RldmljZSwgZGV2KTsKPiAtIMKgIMKgIMKgIHJldHVybiBzcHJp
bnRmKGJ1ZiwgIjB4JTAyWFxuIiwgY29yZS0+aWQucmV2KTsKPiArIMKgIMKgIMKgIHN0cnVjdCBf
X2JjbWFfZGV2X3dyYXBwZXIgKndyYXBwZXIgPSBjb250YWluZXJfb2YoZGV2LAo+ICsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgc3RydWN0IF9fYmNtYV9kZXZfd3JhcHBlciwgZGV2KTsKPiArIMKgIMKgIMKgIHJldHVy
biBzcHJpbnRmKGJ1ZiwgIjB4JTAyWFxuIiwgd3JhcHBlci0+Y29yZS0+aWQucmV2KTsKPiDCoH0K
PiDCoHN0YXRpYyBzc2l6ZV90IGNsYXNzX3Nob3coc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qg
ZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQo+IMKgewo+IC0gwqAgwqAgwqAgc3Ry
dWN0IGJjbWFfZGV2aWNlICpjb3JlID0gY29udGFpbmVyX29mKGRldiwgc3RydWN0IGJjbWFfZGV2
aWNlLCBkZXYpOwo+IC0gwqAgwqAgwqAgcmV0dXJuIHNwcmludGYoYnVmLCAiMHglWFxuIiwgY29y
ZS0+aWQuY2xhc3MpOwo+ICsgwqAgwqAgwqAgc3RydWN0IF9fYmNtYV9kZXZfd3JhcHBlciAqd3Jh
cHBlciA9IGNvbnRhaW5lcl9vZihkZXYsCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdHJ1Y3QgX19iY21hX2Rl
dl93cmFwcGVyLCBkZXYpOwo+ICsgwqAgwqAgwqAgcmV0dXJuIHNwcmludGYoYnVmLCAiMHglWFxu
Iiwgd3JhcHBlci0+Y29yZS0+aWQuY2xhc3MpOwo+IMKgfQo+IMKgc3RhdGljIHN0cnVjdCBkZXZp
Y2VfYXR0cmlidXRlIGJjbWFfZGV2aWNlX2F0dHJzW10gPSB7Cj4gwqAgwqAgwqAgwqBfX0FUVFJf
Uk8obWFudWYpLAo+IEBAIC01MywyNyArNTcsMzAgQEAgc3RhdGljIHN0cnVjdCBidXNfdHlwZSBi
Y21hX2J1c190eXBlID0gewo+Cj4gwqBzdGF0aWMgc3RydWN0IGJjbWFfZGV2aWNlICpiY21hX2Zp
bmRfY29yZShzdHJ1Y3QgYmNtYV9idXMgKmJ1cywgdTE2IGNvcmVpZCkKPiDCoHsKPiAtIMKgIMKg
IMKgIHN0cnVjdCBiY21hX2RldmljZSAqY29yZTsKPiAtCj4gLSDCoCDCoCDCoCBsaXN0X2Zvcl9l
YWNoX2VudHJ5KGNvcmUsICZidXMtPmNvcmVzLCBsaXN0KSB7Cj4gLSDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBpZiAoY29yZS0+aWQuaWQgPT0gY29yZWlkKQo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgcmV0dXJuIGNvcmU7Cj4gKyDCoCDCoCDCoCB1OCBpOwo+ICsgwqAgwqAgwqAg
Zm9yIChpID0gMDsgaSA8IGJ1cy0+bnJfY29yZXM7IGkrKykgewo+ICsgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgaWYgKGJ1cy0+Y29yZXNbaV0uaWQuaWQgPT0gY29yZWlkKQo+ICsgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuICZidXMtPmNvcmVzW2ldOwo+IMKgIMKgIMKgIMKg
fQo+IMKgIMKgIMKgIMKgcmV0dXJuIE5VTEw7Cj4gwqB9Cj4KPiDCoHN0YXRpYyB2b2lkIGJjbWFf
cmVsZWFzZV9jb3JlX2RldihzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gwqB7Cj4gLSDCoCDCoCDCoCBz
dHJ1Y3QgYmNtYV9kZXZpY2UgKmNvcmUgPSBjb250YWluZXJfb2YoZGV2LCBzdHJ1Y3QgYmNtYV9k
ZXZpY2UsIGRldik7Cj4gLSDCoCDCoCDCoCBrZnJlZShjb3JlKTsKPiArIMKgIMKgIMKgIHN0cnVj
dCBfX2JjbWFfZGV2X3dyYXBwZXIgKndyYXBwZXIgPSBjb250YWluZXJfb2YoZGV2LAo+ICsgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgc3RydWN0IF9fYmNtYV9kZXZfd3JhcHBlciwgZGV2KTsKPiArIMKgIMKgIMKgIGtm
cmVlKHdyYXBwZXIpOwo+IMKgfQo+Cj4gwqBzdGF0aWMgaW50IGJjbWFfcmVnaXN0ZXJfY29yZXMo
c3RydWN0IGJjbWFfYnVzICpidXMpCj4gwqB7Cj4gwqAgwqAgwqAgwqBzdHJ1Y3QgYmNtYV9kZXZp
Y2UgKmNvcmU7Cj4gLSDCoCDCoCDCoCBpbnQgZXJyLCBkZXZfaWQgPSAwOwo+ICsgwqAgwqAgwqAg
c3RydWN0IF9fYmNtYV9kZXZfd3JhcHBlciAqd3JhcHBlcjsKPiArIMKgIMKgIMKgIGludCBpLCBl
cnIsIGRldl9pZCA9IDA7Cj4gKwo+ICsgwqAgwqAgwqAgZm9yIChpID0gMDsgaSA8IGJ1cy0+bnJf
Y29yZXM7IGkrKykgewo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29yZSA9ICYoYnVzLT5jb3Jl
c1tpXSk7Cj4KPiAtIMKgIMKgIMKgIGxpc3RfZm9yX2VhY2hfZW50cnkoY29yZSwgJmJ1cy0+Y29y
ZXMsIGxpc3QpIHsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIFdlIHN1cHBvcnQgdGhhdCBj
b3JlcyBvdXJzZWxmICovCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzd2l0Y2ggKGNvcmUtPmlk
LmlkKSB7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIEJDTUFfQ09SRV9DSElQQ09NTU9O
Ogo+IEBAIC04MiwyOCArODksMzcgQEAgc3RhdGljIGludCBiY21hX3JlZ2lzdGVyX2NvcmVzKHN0
cnVjdCBiY21hX2J1cyAqYnVzKQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Y29udGludWU7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9Cj4KPiAtIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGNvcmUtPmRldi5yZWxlYXNlID0gYmNtYV9yZWxlYXNlX2NvcmVfZGV2Owo+IC0gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgY29yZS0+ZGV2LmJ1cyA9ICZiY21hX2J1c190eXBlOwo+IC0gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgZGV2X3NldF9uYW1lKCZjb3JlLT5kZXYsICJiY21hJWQ6JWQiLCAw
LypidXMtPm51bSovLCBkZXZfaWQpOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgd3JhcHBlciA9
IGt6YWxsb2Moc2l6ZW9mKCp3cmFwcGVyKSwgR0ZQX0tFUk5FTCk7Cj4gKyDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBpZiAoIXdyYXBwZXIpIHsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHByX2VycigiQ291bGQgbm90IGFsbG9jYXRlIHdyYXBwZXIgZm9yIGNvcmUgMHglMDNYXG4i
LAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb3JlLT5p
ZC5pZCk7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb250aW51ZTsKPiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIH0KPiArCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCB3cmFw
cGVyLT5jb3JlID0gY29yZTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHdyYXBwZXItPmRldi5y
ZWxlYXNlID0gYmNtYV9yZWxlYXNlX2NvcmVfZGV2Owo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
d3JhcHBlci0+ZGV2LmJ1cyA9ICZiY21hX2J1c190eXBlOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgZGV2X3NldF9uYW1lKCZ3cmFwcGVyLT5kZXYsICJiY21hJWQ6JWQiLCAwLypidXMtPm51bSov
LCBkZXZfaWQpOwo+Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzd2l0Y2ggKGJ1cy0+aG9zdHR5
cGUpIHsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgQkNNQV9IT1NUVFlQRV9QQ0k6Cj4g
LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb3JlLT5kZXYucGFyZW50ID0gJmJ1
cy0+aG9zdF9wY2ktPmRldjsKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNv
cmUtPmRtYV9kZXYgPSAmYnVzLT5ob3N0X3BjaS0+ZGV2Owo+IC0gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgY29yZS0+aXJxID0gYnVzLT5ob3N0X3BjaS0+aXJxOwo+ICsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgd3JhcHBlci0+ZGV2LnBhcmVudCA9ICZidXMtPmhv
c3RfcGNpLT5kZXY7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB3cmFwcGVy
LT5jb3JlLT5kbWFfZGV2ID0gJmJ1cy0+aG9zdF9wY2ktPmRldjsKPiArIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHdyYXBwZXItPmNvcmUtPmlycSA9IGJ1cy0+aG9zdF9wY2ktPmly
cTsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOwo+IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgY2FzZSBCQ01BX0hPU1RUWVBFX05PTkU6Cj4gwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBjYXNlIEJDTUFfSE9TVFRZUEVfU0RJTzoKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGJyZWFrOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfQo+Cj4gLSDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBlcnIgPSBkZXZpY2VfcmVnaXN0ZXIoJmNvcmUtPmRldik7Cj4gKyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBlcnIgPSBkZXZpY2VfcmVnaXN0ZXIoJndyYXBwZXItPmRldik7
Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZXJyKSB7Cj4gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBwcl9lcnIoIkNvdWxkIG5vdCByZWdpc3RlciBkZXYgZm9yIGNvcmUg
MHglMDNYXG4iLAo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGNvcmUtPmlkLmlkKTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGtmcmVl
KHdyYXBwZXIpOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY29udGludWU7
Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb3Jl
LT5kZXZfcmVnaXN0ZXJlZCA9IHRydWU7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb3JlLT5k
ZXYgPSAmd3JhcHBlci0+ZGV2Owo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGV2X2lkKys7Cj4g
wqAgwqAgwqAgwqB9Cj4KPiBAQCAtMTEzLDEwICsxMjksMTIgQEAgc3RhdGljIGludCBiY21hX3Jl
Z2lzdGVyX2NvcmVzKHN0cnVjdCBiY21hX2J1cyAqYnVzKQo+IMKgc3RhdGljIHZvaWQgYmNtYV91
bnJlZ2lzdGVyX2NvcmVzKHN0cnVjdCBiY21hX2J1cyAqYnVzKQo+IMKgewo+IMKgIMKgIMKgIMKg
c3RydWN0IGJjbWFfZGV2aWNlICpjb3JlOwo+ICsgwqAgwqAgwqAgaW50IGk7Cj4KPiAtIMKgIMKg
IMKgIGxpc3RfZm9yX2VhY2hfZW50cnkoY29yZSwgJmJ1cy0+Y29yZXMsIGxpc3QpIHsKPiAtIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGlmIChjb3JlLT5kZXZfcmVnaXN0ZXJlZCkKPiAtIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRldmljZV91bnJlZ2lzdGVyKCZjb3JlLT5kZXYpOwo+
ICsgwqAgwqAgwqAgZm9yIChpID0gMDsgaSA8IGJ1cy0+bnJfY29yZXM7IGkrKykgewo+ICsgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgY29yZSA9ICYoYnVzLT5jb3Jlc1tpXSk7Cj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBpZiAoY29yZS0+ZGV2KQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgZGV2aWNlX3VucmVnaXN0ZXIoY29yZS0+ZGV2KTsKPiDCoCDCoCDCoCDCoH0KPiDCoH0K
Pgo+IEBAIC0xNzksNyArMTk3LDkgQEAgRVhQT1JUX1NZTUJPTF9HUEwoYmNtYV9kcml2ZXJfdW5y
ZWdpc3Rlcik7Cj4KPiDCoHN0YXRpYyBpbnQgYmNtYV9idXNfbWF0Y2goc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3QgZGV2aWNlX2RyaXZlciAqZHJ2KQo+IMKgewo+IC0gwqAgwqAgwqAgc3RydWN0
IGJjbWFfZGV2aWNlICpjb3JlID0gY29udGFpbmVyX29mKGRldiwgc3RydWN0IGJjbWFfZGV2aWNl
LCBkZXYpOwo+ICsgwqAgwqAgwqAgc3RydWN0IF9fYmNtYV9kZXZfd3JhcHBlciAqd3JhcHBlciA9
IGNvbnRhaW5lcl9vZihkZXYsCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdHJ1Y3QgX19iY21hX2Rldl93cmFw
cGVyLCBkZXYpOwo+ICsgwqAgwqAgwqAgc3RydWN0IGJjbWFfZGV2aWNlICpjb3JlID0gd3JhcHBl
ci0+Y29yZTsKPiDCoCDCoCDCoCDCoHN0cnVjdCBiY21hX2RyaXZlciAqYWRydiA9IGNvbnRhaW5l
cl9vZihkcnYsIHN0cnVjdCBiY21hX2RyaXZlciwgZHJ2KTsKPiDCoCDCoCDCoCDCoGNvbnN0IHN0
cnVjdCBiY21hX2RldmljZV9pZCAqY2lkID0gJmNvcmUtPmlkOwo+IMKgIMKgIMKgIMKgY29uc3Qg
c3RydWN0IGJjbWFfZGV2aWNlX2lkICpkaWQ7Cj4gQEAgLTE5Niw3ICsyMTYsOSBAQCBzdGF0aWMg
aW50IGJjbWFfYnVzX21hdGNoKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9kcml2
ZXIgKmRydikKPgo+IMKgc3RhdGljIGludCBiY21hX2RldmljZV9wcm9iZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpCj4gwqB7Cj4gLSDCoCDCoCDCoCBzdHJ1Y3QgYmNtYV9kZXZpY2UgKmNvcmUgPSBjb250
YWluZXJfb2YoZGV2LCBzdHJ1Y3QgYmNtYV9kZXZpY2UsIGRldik7Cj4gKyDCoCDCoCDCoCBzdHJ1
Y3QgX19iY21hX2Rldl93cmFwcGVyICp3cmFwcGVyID0gY29udGFpbmVyX29mKGRldiwKPiArIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHN0cnVjdCBfX2JjbWFfZGV2X3dyYXBwZXIsIGRldik7Cj4gKyDCoCDCoCDCoCBz
dHJ1Y3QgYmNtYV9kZXZpY2UgKmNvcmUgPSB3cmFwcGVyLT5jb3JlOwo+IMKgIMKgIMKgIMKgc3Ry
dWN0IGJjbWFfZHJpdmVyICphZHJ2ID0gY29udGFpbmVyX29mKGRldi0+ZHJpdmVyLCBzdHJ1Y3Qg
YmNtYV9kcml2ZXIsCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZHJ2KTsKPiDCoCDCoCDCoCDCoGludCBlcnIgPSAw
Owo+IEBAIC0yMDksNyArMjMxLDkgQEAgc3RhdGljIGludCBiY21hX2RldmljZV9wcm9iZShzdHJ1
Y3QgZGV2aWNlICpkZXYpCj4KPiDCoHN0YXRpYyBpbnQgYmNtYV9kZXZpY2VfcmVtb3ZlKHN0cnVj
dCBkZXZpY2UgKmRldikKPiDCoHsKPiAtIMKgIMKgIMKgIHN0cnVjdCBiY21hX2RldmljZSAqY29y
ZSA9IGNvbnRhaW5lcl9vZihkZXYsIHN0cnVjdCBiY21hX2RldmljZSwgZGV2KTsKPiArIMKgIMKg
IMKgIHN0cnVjdCBfX2JjbWFfZGV2X3dyYXBwZXIgKndyYXBwZXIgPSBjb250YWluZXJfb2YoZGV2
LAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgc3RydWN0IF9fYmNtYV9kZXZfd3JhcHBlciwgZGV2KTsKPiArIMKg
IMKgIMKgIHN0cnVjdCBiY21hX2RldmljZSAqY29yZSA9IHdyYXBwZXItPmNvcmU7Cj4gwqAgwqAg
wqAgwqBzdHJ1Y3QgYmNtYV9kcml2ZXIgKmFkcnYgPSBjb250YWluZXJfb2YoZGV2LT5kcml2ZXIs
IHN0cnVjdCBiY21hX2RyaXZlciwKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkcnYpOwo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvYmNtYS9zY2FuLmMgYi9kcml2ZXJzL2JjbWEvc2Nhbi5jCj4gaW5kZXggNDBkN2Rj
Yy4uNzBiMzlmNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2JjbWEvc2Nhbi5jCj4gKysrIGIvZHJp
dmVycy9iY21hL3NjYW4uYwo+IEBAIC0yMTEsOSArMjExLDYgQEAgaW50IGJjbWFfYnVzX3NjYW4o
c3RydWN0IGJjbWFfYnVzICpidXMpCj4gwqAgwqAgwqAgwqBzMzIgdG1wOwo+IMKgIMKgIMKgIMKg
dTggaSwgajsKPgo+IC0gwqAgwqAgwqAgaW50IGVycjsKPiAtCj4gLSDCoCDCoCDCoCBJTklUX0xJ
U1RfSEVBRCgmYnVzLT5jb3Jlcyk7Cj4gwqAgwqAgwqAgwqBidXMtPm5yX2NvcmVzID0gMDsKPgo+
IMKgIMKgIMKgIMKgYmNtYV9zY2FuX3N3aXRjaF9jb3JlKGJ1cywgQkNNQV9BRERSX0JBU0UpOwo+
IEBAIC0yMzAsMTEgKzIyNyw4IEBAIGludCBiY21hX2J1c19zY2FuKHN0cnVjdCBiY21hX2J1cyAq
YnVzKQo+IMKgIMKgIMKgIMKgYmNtYV9zY2FuX3N3aXRjaF9jb3JlKGJ1cywgZXJvbWJhc2UpOwo+
Cj4gwqAgwqAgwqAgwqB3aGlsZSAoZXJvbXB0ciA8IGVyb21lbmQpIHsKPiAtIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHN0cnVjdCBiY21hX2RldmljZSAqY29yZSA9IGt6YWxsb2Moc2l6ZW9mKCpjb3Jl
KSwgR0ZQX0tFUk5FTCk7Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoIWNvcmUpCj4gLSDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gLUVOT01FTTsKPiAtIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIElOSVRfTElTVF9IRUFEKCZjb3JlLT5saXN0KTsKPiAtIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGNvcmUtPmJ1cyA9IGJ1czsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0
cnVjdCBiY21hX2RldmljZSBjb3JlID0geyB9Owo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29y
ZS5idXMgPSBidXM7Cj4KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIGdldCBDSXMgKi8KPiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNpYSA9IGJjbWFfZXJvbV9nZXRfY2koYnVzLCAmZXJvbXB0
cik7Cj4gQEAgLTI0MiwyNyArMjM2LDI0IEBAIGludCBiY21hX2J1c19zY2FuKHN0cnVjdCBiY21h
X2J1cyAqYnVzKQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYmNtYV9lcm9t
X3B1c2hfZW50KCZlcm9tcHRyKTsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmIChiY21hX2Vyb21faXNfZW5kKGJ1cywgJmVyb21wdHIpKQo+IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7Cj4gLSDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBlcnI9IC1FSUxTRVE7Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBnb3RvIG91dDsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHJldHVybiAtRUlMU0VROwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfQo+IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgY2liID0gYmNtYV9lcm9tX2dldF9jaShidXMsICZlcm9tcHRyKTsKPiAtIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGlmIChjaWIgPCAwKSB7Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBlcnI9IC1FSUxTRVE7Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBnb3RvIG91dDsKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH0KPiArIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGlmIChjaWIgPCAwKQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgcmV0dXJuIC1FSUxTRVE7Cj4KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC8qIHBhcnNl
IENJcyAqLwo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29yZS0+aWQuY2xhc3MgPSAoY2lhICYg
U0NBTl9DSUFfQ0xBU1MpID4+IFNDQU5fQ0lBX0NMQVNTX1NISUZUOwo+IC0gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgY29yZS0+aWQuaWQgPSAoY2lhICYgU0NBTl9DSUFfSUQpID4+IFNDQU5fQ0lBX0lE
X1NISUZUOwo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29yZS0+aWQubWFudWYgPSAoY2lhICYg
U0NBTl9DSUFfTUFOVUYpID4+IFNDQU5fQ0lBX01BTlVGX1NISUZUOwo+ICsgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgY29yZS5pZC5jbGFzcyA9IChjaWEgJiBTQ0FOX0NJQV9DTEFTUykgPj4gU0NBTl9D
SUFfQ0xBU1NfU0hJRlQ7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb3JlLmlkLmlkID0gKGNp
YSAmIFNDQU5fQ0lBX0lEKSA+PiBTQ0FOX0NJQV9JRF9TSElGVDsKPiArIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGNvcmUuaWQubWFudWYgPSAoY2lhICYgU0NBTl9DSUFfTUFOVUYpID4+IFNDQU5fQ0lB
X01BTlVGX1NISUZUOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcG9ydHNbMF0gPSAoY2liICYg
U0NBTl9DSUJfTk1QKSA+PiBTQ0FOX0NJQl9OTVBfU0hJRlQ7Cj4gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBwb3J0c1sxXSA9IChjaWIgJiBTQ0FOX0NJQl9OU1ApID4+IFNDQU5fQ0lCX05TUF9TSElG
VDsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHdyYXBwZXJzWzBdID0gKGNpYiAmIFNDQU5fQ0lC
X05NVykgPj4gU0NBTl9DSUJfTk1XX1NISUZUOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgd3Jh
cHBlcnNbMV0gPSAoY2liICYgU0NBTl9DSUJfTlNXKSA+PiBTQ0FOX0NJQl9OU1dfU0hJRlQ7Cj4g
LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb3JlLT5pZC5yZXYgPSAoY2liICYgU0NBTl9DSUJfUkVW
KSA+PiBTQ0FOX0NJQl9SRVZfU0hJRlQ7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb3JlLmlk
LnJldiA9IChjaWIgJiBTQ0FOX0NJQl9SRVYpID4+IFNDQU5fQ0lCX1JFVl9TSElGVDsKPgo+IC0g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCgoY29yZS0+aWQubWFudWYgPT0gQkNNQV9NQU5VRl9B
Uk0pICYmCj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoChjb3JlLT5pZC5pZCA9PSAw
eEZGRikpIHx8Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoKChjb3JlLmlkLm1hbnVmID09
IEJDTUFfTUFOVUZfQVJNKSAmJgo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAoY29y
ZS5pZC5pZCA9PSAweEZGRikpIHx8Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAocG9y
dHNbMV0gPT0gMCkpIHsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJjbWFf
ZXJvbV9za2lwX2NvbXBvbmVudChidXMsICZlcm9tcHRyKTsKPiDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGNvbnRpbnVlOwo+IEBAIC0yODUsMTAgKzI3Niw4IEBAIGludCBiY21h
X2J1c19zY2FuKHN0cnVjdCBiY21hX2J1cyAqYnVzKQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
LyogZ2V0ICYgcGFyc2UgbWFzdGVyIHBvcnRzICovCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBm
b3IgKGkgPSAwOyBpIDwgcG9ydHNbMF07IGkrKykgewo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgdTMyIG1zdF9wb3J0X2QgPSBiY21hX2Vyb21fZ2V0X21zdF9wb3J0KGJ1cywg
JmVyb21wdHIpOwo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKG1zdF9w
b3J0X2QgPCAwKSB7Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBlcnI9IC1FSUxTRVE7Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBnb3RvIG91dDsKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IH0KPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChtc3RfcG9ydF9kIDwg
MCkKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVy
biAtRUlMU0VROwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfQo+Cj4gwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAvKiBnZXQgJiBwYXJzZSBzbGF2ZSBwb3J0cyAqLwo+IEBAIC0zMDMsNyArMjkyLDcg
QEAgaW50IGJjbWFfYnVzX3NjYW4oc3RydWN0IGJjbWFfYnVzICpidXMpCj4gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazsKPiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gZWxzZSB7Cj4g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiAoaSA9PSAwICYmIGogPT0gMCkKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNvcmUtPmFkZHIgPSB0bXA7
Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBjb3JlLmFkZHIgPSB0bXA7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqB9Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9Cj4gQEAgLTMyMCw3ICszMDksNyBA
QCBpbnQgYmNtYV9idXNfc2NhbihzdHJ1Y3QgYmNtYV9idXMgKmJ1cykKPiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOwo+IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfSBlbHNlIHsKPiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGlmIChpID09IDAgJiYgaiA9PSAwKQo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29yZS0+d3JhcCA9IHRtcDsK
PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGNvcmUud3JhcCA9IHRtcDsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoH0KPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0KPiBAQCAtMzM4LDIyICszMjcsMTkg
QEAgaW50IGJjbWFfYnVzX3NjYW4oc3RydWN0IGJjbWFfYnVzICpidXMpCj4gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazsKPiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gZWxzZSB7Cj4g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiAod3JhcHBlcnNbMF0gPT0gMCAmJiAhaSAmJiAhaikKPiAtIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNvcmUt
PndyYXAgPSB0bXA7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb3JlLndyYXAgPSB0bXA7Cj4gwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9Cj4gwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqB9Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9Cj4KPiDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHByX2luZm8oIkNvcmUgJWQgZm91bmQ6ICVzICIKPiDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCIobWFudWYgMHglMDNYLCBpZCAweCUwM1gsIHJl
diAweCUwMlgsIGNsYXNzIDB4JVgpXG4iLAo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgYnVzLT5ucl9jb3JlcywgYmNtYV9kZXZpY2VfbmFtZSgmY29yZS0+aWQpLAo+IC0gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29yZS0+aWQubWFudWYsIGNvcmUtPmlkLmlk
LCBjb3JlLT5pZC5yZXYsCj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb3Jl
LT5pZC5jbGFzcyk7Cj4gLQo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29yZS0+Y29yZV9pbmRl
eCA9IGJ1cy0+bnJfY29yZXMrKzsKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGxpc3RfYWRkKCZj
b3JlLT5saXN0LCAmYnVzLT5jb3Jlcyk7Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb250aW51
ZTsKPiAtb3V0Ogo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIGVycjsKPiArIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJ1cy0+bnJfY29yZXMsIGJjbWFfZGV2aWNlX25h
bWUoJmNvcmUuaWQpLAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29yZS5p
ZC5tYW51ZiwgY29yZS5pZC5pZCwgY29yZS5pZC5yZXYsCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBjb3JlLmlkLmNsYXNzKTsKPiArCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBjb3JlLmNvcmVfaW5kZXggPSBidXMtPm5yX2NvcmVzOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgYnVzLT5jb3Jlc1tidXMtPm5yX2NvcmVzKytdID0gY29yZTsKPiDCoCDCoCDCoCDCoH0KPgo+
IMKgIMKgIMKgIMKgcmV0dXJuIDA7Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvYmNtYS9i
Y21hLmggYi9pbmNsdWRlL2xpbnV4L2JjbWEvYmNtYS5oCj4gaW5kZXggMjdhMjdhNy4uM2RjNTMw
MiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2JjbWEvYmNtYS5oCj4gKysrIGIvaW5jbHVk
ZS9saW51eC9iY21hL2JjbWEuaAo+IEBAIC0xMTgsMTQgKzExOCwyMyBAQCBzdHJ1Y3QgYmNtYV9o
b3N0X29wcyB7Cj4KPiDCoCNkZWZpbmUgQkNNQV9NQVhfTlJfQ09SRVMgwqAgwqAgwqAgwqAgwqAg
wqAgwqAxNgo+Cj4gKy8qIDEpIEl0IGlzIG5vdCBhbGxvd2VkIHRvIHB1dCBzdHJ1Y3QgZGV2aWNl
IHN0YXRpY2FsbHkgaW4gYmNtYV9kZXZpY2UKPiArICogMikgV2UgY2FuIG5vdCBqdXN0IHVzZSBw
b2ludGVyIHRvIHN0cnVjdCBkZXZpY2UgYmVjYXVzZSB3ZSB1c2UgY29udGFpbmVyX29mCj4gKyAq
IDMpIFdlIGRvIG5vdCBoYXZlIHBvaW50ZXIgdG8gc3RydWN0IGJjbWFfZGV2aWNlIGluIHN0cnVj
dCBkZXZpY2UKPiArICogU29sdXRpb246IHVzZSBzdWNoIGEgZHVtbXkgd3JhcHBlcgo+ICsgKi8K
PiArc3RydWN0IF9fYmNtYV9kZXZfd3JhcHBlciB7Cj4gKyDCoCDCoCDCoCBzdHJ1Y3QgZGV2aWNl
IGRldjsKPiArIMKgIMKgIMKgIHN0cnVjdCBiY21hX2RldmljZSAqY29yZTsKPiArfTsKPiArCj4g
wqBzdHJ1Y3QgYmNtYV9kZXZpY2Ugewo+IMKgIMKgIMKgIMKgc3RydWN0IGJjbWFfYnVzICpidXM7
Cj4gwqAgwqAgwqAgwqBzdHJ1Y3QgYmNtYV9kZXZpY2VfaWQgaWQ7Cj4KPiAtIMKgIMKgIMKgIHN0
cnVjdCBkZXZpY2UgZGV2Owo+ICsgwqAgwqAgwqAgc3RydWN0IGRldmljZSAqZGV2Owo+IMKgIMKg
IMKgIMKgc3RydWN0IGRldmljZSAqZG1hX2RldjsKPiDCoCDCoCDCoCDCoHVuc2lnbmVkIGludCBp
cnE7Cj4gLSDCoCDCoCDCoCBib29sIGRldl9yZWdpc3RlcmVkOwo+Cj4gwqAgwqAgwqAgwqB1OCBj
b3JlX2luZGV4Owo+Cj4gQEAgLTEzMyw3ICsxNDIsNiBAQCBzdHJ1Y3QgYmNtYV9kZXZpY2Ugewo+
IMKgIMKgIMKgIMKgdTMyIHdyYXA7Cj4KPiDCoCDCoCDCoCDCoHZvaWQgKmRydmRhdGE7Cj4gLSDC
oCDCoCDCoCBzdHJ1Y3QgbGlzdF9oZWFkIGxpc3Q7Cj4gwqB9Owo+Cj4gwqBzdGF0aWMgaW5saW5l
IHZvaWQgKmJjbWFfZ2V0X2RydmRhdGEoc3RydWN0IGJjbWFfZGV2aWNlICpjb3JlKQo+IEBAIC0x
ODIsNyArMTkwLDcgQEAgc3RydWN0IGJjbWFfYnVzIHsKPiDCoCDCoCDCoCDCoHN0cnVjdCBiY21h
X2NoaXBpbmZvIGNoaXBpbmZvOwo+Cj4gwqAgwqAgwqAgwqBzdHJ1Y3QgYmNtYV9kZXZpY2UgKm1h
cHBlZF9jb3JlOwo+IC0gwqAgwqAgwqAgc3RydWN0IGxpc3RfaGVhZCBjb3JlczsKPiArIMKgIMKg
IMKgIHN0cnVjdCBiY21hX2RldmljZSBjb3Jlc1tCQ01BX01BWF9OUl9DT1JFU107Cj4gwqAgwqAg
wqAgwqB1OCBucl9jb3JlczsKPgo+IMKgIMKgIMKgIMKgc3RydWN0IGJjbWFfZHJ2X2NjIGRydl9j
YzsKPiAtLQo+IDEuNy40LjEK
