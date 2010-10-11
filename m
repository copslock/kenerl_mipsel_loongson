Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2010 18:34:30 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:50509 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491027Ab0JKQeX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Oct 2010 18:34:23 +0200
Received: by gyf1 with SMTP id 1so276965gyf.36
        for <multiple recipients>; Mon, 11 Oct 2010 09:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=stngk5WakoFPnjn8y3X/00TDAa05/13i7lHJBD6VKr0=;
        b=fKDLh0E3wJZDWaXvi/7CZlapk3igQQwTPYPRuuvh1ggmBA9jfnKIfedSpzmfOif/lF
         VXQ1KDsdoClGH2kQP+caYwbPckvVT6IfQXjT8v1Dg7JCZVWslJynPZaKivA3gcwydJNH
         Zsb6Z8AsR9EqDmm8MR/457oeTMVTgJ28n0zUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iPwsTJa0HDv4XGuo93PYYKDHZyKSew6PjjfJdiD6ZwajUzJvIR3Wk/YnfTYiRItOVO
         e/2tkYFsp7m0h3yeA1oWpkWRQSgJOKFlmEEwLDzQrl0dJtIWlMM8LLk3zJPk97Y1dund
         BQbU+51MxLkzWCcD4nS8yKfWWXUowyeySir5s=
MIME-Version: 1.0
Received: by 10.42.192.145 with SMTP id dq17mr2264401icb.253.1286814856803;
 Mon, 11 Oct 2010 09:34:16 -0700 (PDT)
Received: by 10.231.170.132 with HTTP; Mon, 11 Oct 2010 09:34:16 -0700 (PDT)
In-Reply-To: <1284212009-25708-1-git-send-email-andy.shevchenko@gmail.com>
References: <1284212009-25708-1-git-send-email-andy.shevchenko@gmail.com>
Date:   Mon, 11 Oct 2010 19:34:16 +0300
Message-ID: <AANLkTimRVNYMh923+5qS5mifDKgJRwCxeWGMXWYaJXr9@mail.gmail.com>
Subject: Re: [PATCH] arch: mips: use newly introduced hex_to_bin()
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-Path: <andy.shevchenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andy.shevchenko@gmail.com
Precedence: bulk
X-list: linux-mips

QW55IGNvbW1lbnRzIGhlcmU/CgpPbiBTYXQsIFNlcCAxMSwgMjAxMCBhdCA0OjMzIFBNLCBBbmR5
IFNoZXZjaGVua28KPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+IHdyb3RlOgo+IFJlbW92ZSBj
dXN0b20gaW1wbGVtZW50YXRpb24gb2YgaGV4X3RvX2JpbigpLgo+Cj4gU2lnbmVkLW9mZi1ieTog
QW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPgo+IENjOiBSYWxmIEJh
ZWNobGUgPHJhbGZAbGludXgtbWlwcy5vcmc+Cj4gQ2M6IGxpbnV4LW1pcHNAbGludXgtbWlwcy5v
cmcKPiAtLS0KPiDCoGFyY2gvbWlwcy9yYjUzMi9kZXZpY2VzLmMgfCDCoCAyNCArKysrKysrKyst
LS0tLS0tLS0tLS0tLS0KPiDCoDEgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxNSBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9hcmNoL21pcHMvcmI1MzIvZGV2aWNlcy5jIGIv
YXJjaC9taXBzL3JiNTMyL2RldmljZXMuYwo+IGluZGV4IDA0MWZjMWEuLmE5NjllYjggMTAwNjQ0
Cj4gLS0tIGEvYXJjaC9taXBzL3JiNTMyL2RldmljZXMuYwo+ICsrKyBiL2FyY2gvbWlwcy9yYjUz
Mi9kZXZpY2VzLmMKPiBAQCAtMjUxLDI4ICsyNTEsMjIgQEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnJiNTMyX2RldnNbXSA9IHsKPgo+IMKgc3RhdGljIHZvaWQgX19pbml0IHBhcnNl
X21hY19hZGRyKGNoYXIgKm1hY3N0cikKPiDCoHsKPiAtIMKgIMKgIMKgIGludCBpLCBqOwo+IC0g
wqAgwqAgwqAgdW5zaWduZWQgY2hhciByZXN1bHQsIHZhbHVlOwo+ICsgwqAgwqAgwqAgaW50IGks
IGgsIGw7Cj4KPiDCoCDCoCDCoCDCoGZvciAoaSA9IDA7IGkgPCA2OyBpKyspIHsKPiAtIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHJlc3VsdCA9IDA7Cj4gLQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
aWYgKGkgIT0gNSAmJiAqKG1hY3N0ciArIDIpICE9ICc6JykKPiDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHJldHVybjsKPgo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgZm9yIChq
ID0gMDsgaiA8IDI7IGorKykgewo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
aWYgKGlzeGRpZ2l0KCptYWNzdHIpCj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAmJiAodmFsdWUgPQo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgaXNkaWdpdCgqbWFjc3RyKSA/ICptYWNzdHIgLQo+IC0gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgJzAnIDogdG91cHBlcigqbWFjc3RyKSAt
ICdBJyArIDEwKSA8IDE2KSB7Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCByZXN1bHQgPSByZXN1bHQgKiAxNiArIHZhbHVlOwo+IC0gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbWFjc3RyKys7Cj4gLSDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9IGVsc2UKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybjsKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH0K
PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGggPSBoZXhfdG9fYmluKCptYWNzdHIrKyk7Cj4gKyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoaCA9PSAtMSkKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHJldHVybjsKPiArCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBsID0gaGV4
X3RvX2JpbigqbWFjc3RyKyspOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGwgPT0gLTEp
Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm47Cj4KPiDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoG1hY3N0cisrOwo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAga29yaW5h
X2RldjBfZGF0YS5tYWNbaV0gPSByZXN1bHQ7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBrb3Jp
bmFfZGV2MF9kYXRhLm1hY1tpXSA9IChoIDw8IDQpICsgbDsKPiDCoCDCoCDCoCDCoH0KPiDCoH0K
Pgo+IC0tCj4gMS43LjIuMgo+Cj4KCgoKLS0gCldpdGggQmVzdCBSZWdhcmRzLApBbmR5IFNoZXZj
aGVua28K
