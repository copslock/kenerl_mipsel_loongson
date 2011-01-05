Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jan 2011 21:26:02 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:33670 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490979Ab1AEUZ7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 5 Jan 2011 21:25:59 +0100
Received: by fxm19 with SMTP id 19so14767651fxm.36
        for <multiple recipients>; Wed, 05 Jan 2011 12:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=rgCoHn9ottJC/apHZj75UFerThepRKdkm3GJLTmn60U=;
        b=LJKn+pUGpF2venGhjKITJBTlCkNwbbFqAhEzt2EGcFRNuyVcVg6khbWuI91Dmgp/9m
         KysY2d/67W4s3lFye2uvDIw8OGCGOUxZnjlpCEC2+su0a6zB3g56ZGRY6+iYGioAV7lA
         Gy0SeKJF2nHxkNEhXra1QtLqGo4fA6oE9RCcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=aphJcwVEMMkQXosih1Dvnye8tgNN+a6J7HJfEfLnH+b0yW/R7SI7Ws9wrwo8xoGsL1
         YlyS6mGwkNLo8AsafMM7y2vmpaDfOt3Aozw041KxFxxgkVhz3iUOripFPQJoze8kM2aF
         Kqubea1HGE9P+T0aISfmwnDKSKL85edupansE=
MIME-Version: 1.0
Received: by 10.223.85.204 with SMTP id p12mr3021114fal.146.1294259153781;
 Wed, 05 Jan 2011 12:25:53 -0800 (PST)
Received: by 10.223.75.194 with HTTP; Wed, 5 Jan 2011 12:25:53 -0800 (PST)
In-Reply-To: <1294257379-417-2-git-send-email-blogic@openwrt.org>
References: <1294257379-417-1-git-send-email-blogic@openwrt.org>
        <1294257379-417-2-git-send-email-blogic@openwrt.org>
Date:   Wed, 5 Jan 2011 21:25:53 +0100
X-Google-Sender-Auth: bauGJMuPnfhn2as24-itggZC6Bk
Message-ID: <AANLkTinoPugsZ0V9d8HgmSvKnTFNW6HhXBkeCidOFOYn@mail.gmail.com>
Subject: Re: [PATCH 01/10] MIPS: lantiq: add initial support for Lantiq SoCs
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

T24gV2VkLCBKYW4gNSwgMjAxMSBhdCAyMDo1NiwgSm9obiBDcmlzcGluIDxibG9naWNAb3Blbndy
dC5vcmc+IHdyb3RlOgo+IC0tLSAvZGV2L251bGwKPiArKysgYi9hcmNoL21pcHMvbGFudGlxL3By
b20uYwo+IEBAIC0wLDAgKzEsODQgQEAKCj4gK3N0YXRpYyB2b2lkIF9faW5pdAo+ICtwcm9tX2lu
aXRfY21kbGluZSh2b2lkKQo+ICt7Cj4gKyDCoCDCoCDCoCBpbnQgYXJnYyA9IGZ3X2FyZzA7Cj4g
KyDCoCDCoCDCoCBjaGFyICoqYXJndiA9IChjaGFyICoqKSBLU0VHMUFERFIoZndfYXJnMSk7Cj4g
KyDCoCDCoCDCoCBpbnQgaTsKPiArIMKgIMKgIMKgIGFyY3NfY21kbGluZVswXSA9ICdcMCc7Cj4g
KyDCoCDCoCDCoCBpZiAoYXJnYykKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZvciAoaSA9IDE7
IGkgPCBhcmdjOyBpKyspIHsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0
cmxjYXQoYXJjc19jbWRsaW5lLCAoY2hhciAqKUtTRUcxQUREUihhcmd2W2ldKSwKPiArIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIENPTU1BTkRfTElORV9TSVpF
KTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChpICsgMSAhPSBhcmdj
KQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3RybGNh
dChhcmNzX2NtZGxpbmUsICIgIiwgQ09NTUFORF9MSU5FX1NJWkUpOwo+ICsgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgfQo+ICsgwqAgwqAgwqAgaWYgKCEqYXJjc19jbWRsaW5lKQo+ICsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgc3RyY3B5KCYoYXJjc19jbWRsaW5lWzBdKSwKPiArIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgICJjb25zb2xlPXR0eVMxLDExNTIwMCByb290ZnN0eXBlPXNxdWFz
aGZzLGpmZnMyIik7CiAgICAgICAgICAgICAgICAgICAgICAgIF5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXgogICAgICAgICAgICAgICAgICAgICAgICBDT05G
SUdfQ01ETElORT8/PwoKPiArfQoKR3J7b2V0amUsZWV0aW5nfXMsCgrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBHZWVydAoKLS0KR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJl
J3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZwoKSW4g
cGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNl
bGYgYSBoYWNrZXIuIEJ1dAp3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBz
YXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgwqAgwqDCoCAtLSBMaW51cyBUb3J2YWxkcwo=
